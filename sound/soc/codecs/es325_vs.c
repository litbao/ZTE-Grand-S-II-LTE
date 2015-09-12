/*
 * es325.c  --	Audience eS325 ALSA SoC Audio driver
 *
 * Copyright 2011 Audience, Inc.
 *
 * Author: Greg Clemson  <gclemson@audience.com>
 *
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#define DEBUG

//#define ABORT_TEST//Richard 11.23
//#define MEASURE_FW_LOAD_TIME//Richard 11.23
//#define ES325_QCOM_V1
#define ES325_QCOM_V2
#define BUS_TRANSACTIONS

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#include <linux/firmware.h>
#include <linux/delay.h>
#include <linux/pm.h>
#include <linux/completion.h>
#include <linux/i2c.h>
#include <linux/slimbus/slimbus.h>
#include <linux/gpio.h>
#include <linux/platform_device.h>
#include <linux/regulator/consumer.h>
#include <linux/slab.h>
#include <linux/err.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>
#include <sound/initval.h>
#include <sound/tlv.h>
#include <linux/kthread.h>
#include <linux/i2c/esxxx.h> 
#include <linux/time.h>
#include "es325.h"
#include "es325-export.h"
#ifdef CONFIG_SND_SOC_ES325_UART
#include "es325-uart.h"
#endif
#include <linux/qpnp/clkdiv.h>
#include <linux/of_gpio.h>
#include <linux/clk.h>
#include <linux/pm_runtime.h>
#include <mach/gpiomux.h>
#include <linux/wakelock.h>


#if 1//Richard 2014.2.20
int need_report_hw_bug = 0;
int detected_hw_bug = 0;
#endif

#if defined(ES325_QCOM_V1)
#define ES325_DAI_ID_BASE	1
#define DAI_INDEX(xid)		(xid - 1)
#elif defined(ES325_QCOM_V2)
#define ES325_DAI_ID_BASE	0
#define DAI_INDEX(xid)		(xid)
#else
#error "no QCOM implementation specified"
#endif

//Richard new
#define VS_KEYWORD_DATA_SUB_BLOCK_SIZE 512
#define VS_KW_SYSFS_MAX_BUF_SIZE (PAGE_SIZE-4)
#define ES325_SLEEP_TIME 300

#ifdef VOICE_SENSE
#define AUTO_ABORT
#define THREE_STATE_POWER
#endif

#ifdef VOICE_SENSE
#define ES325_CMD_ACCESS_WR_MAX 8
#else
#define ES325_CMD_ACCESS_WR_MAX 4
#endif
#define ES325_CMD_ACCESS_RD_MAX 4

struct es325_cmd_access {
	u8 read_msg[ES325_CMD_ACCESS_RD_MAX];
	unsigned int read_msg_len;
	u8 write_msg[ES325_CMD_ACCESS_WR_MAX];
	unsigned int write_msg_len;
	unsigned int val_shift;
	unsigned int val_max;
};
#ifdef ABORT_TEST//Richard 11.23
static u32 g_sec_to_abort = 0;
#endif
#include "es325-access.h"

#define ES325_SLIM_CH_RX_OFFSET		152
#define ES325_SLIM_CH_TX_OFFSET		156
#ifndef CONFIG_SND_SOC_ES325_UART
#define ES325_SLIM_RX_PORTS		6
#define ES325_SLIM_TX_PORTS		6
#endif

enum {
	ES325_SLIM_1_PB = ES325_DAI_ID_BASE,
	ES325_SLIM_1_CAP,
	ES325_SLIM_2_PB,
	ES325_SLIM_2_CAP,
	ES325_SLIM_3_PB,
	ES325_SLIM_3_CAP,
};

#define ES325_SLIM_1_PB_MAX_CHANS	2
#define ES325_SLIM_1_CAP_MAX_CHANS	2
#define ES325_SLIM_2_PB_MAX_CHANS	2
#define ES325_SLIM_2_CAP_MAX_CHANS	2
#define ES325_SLIM_3_PB_MAX_CHANS	2
#define ES325_SLIM_3_CAP_MAX_CHANS	2
#define ES325_SLIM_1_PB_OFFSET	0
#define ES325_SLIM_2_PB_OFFSET	2
#define ES325_SLIM_3_PB_OFFSET	4
#define ES325_SLIM_1_CAP_OFFSET	0
#define ES325_SLIM_2_CAP_OFFSET	2
#define ES325_SLIM_3_CAP_OFFSET	4

enum es325_bootup_status {
	ES325_BOOTUP,
	ES325_BOOTUP_READY,
	ES325_BOOTUP_FAIL,
};
static unsigned int bootup_status=ES325_BOOTUP;

#undef CDBG
#if 0
#define CDBG(fmt, args...) pr_err(fmt, ##args)
#else
#define CDBG(fmt, args...) do { } while (0)
#endif

enum es325_power_state {
	//ES325_POWER_STATE_BOOT,
	ES325_POWER_STATE_SLEEP,
	ES325_POWER_STATE_ACTIVE,
	ES325_POWER_STATE_VS,
	ES325_POWER_STATE_SLEEP_PENDING,
	ES325_POWER_STATE_VS_DOWNLOADING,
};

struct es325_priv es325_priv;

enum es325_vreg_type {
	REG_LDO,
	REG_VS,
	REG_GPIO,
};

struct es325_vreg_t {
	const char *reg_name;
	enum es325_vreg_type type;
	int min_voltage;
	int max_voltage;
	int op_mode;
	uint32_t delay;
};

#ifdef BUS_TRANSACTIONS
#if defined(CONFIG_SND_SOC_ES325_I2C)
static int es325_i2c_read(struct es325_priv *es325, char *buf, int len);
static int es325_i2c_write(struct es325_priv *es325, char *buf, int len);
#define ES325_BUS_READ(x_es325, x_offset, x_width, x_buf, x_len, x_bus_order) \
	es325_i2c_read(x_es325, x_buf, x_len)
#define ES325_BUS_WRITE(x_es325, x_offset, x_width, x_buf, x_len, x_bus_order) \
	es325_i2c_write(x_es325, x_buf, x_len)
#elif defined(CONFIG_SND_SOC_ES325_SLIM)
static int es325_slim_read(struct es325_priv *es325, unsigned int offset,
			   unsigned int width, char *buf, int len, int bus_order);
static int es325_slim_write(struct es325_priv *es325, unsigned int offset,
			    unsigned int width, char *buf, int len, int bus_order);
#define ES325_BUS_READ(x_es325, x_offset, x_width, x_buf, x_len, x_bus_order) \
	es325_slim_read(x_es325, x_offset, x_width, x_buf, x_len, x_bus_order)
#define ES325_BUS_WRITE(x_es325, x_offset, x_width, x_buf, x_len, x_bus_order) \
	es325_slim_write(x_es325, x_offset, x_width, x_buf, x_len, x_bus_order)
#else
#error "es325.c - bus infrastructure not defined"
#endif
#else
/* Pretend all read and write operations on the bus are successful -
 * when no bus is available. */
#define ES325_BUS_READ(e, o, w, b, l, r) (0)
#define ES325_BUS_WRITE(e, o, w, b, l, r) (0)
#endif

static unsigned int es325_ap_tx1_ch_cnt = 2;
unsigned int es325_rx1_route_enable = 0;
unsigned int es325_rx2_route_enable = 0;
unsigned int es325_tx1_route_enable = 0;
static unsigned int es325_power_state= ES325_POWER_STATE_SLEEP;


#if defined(CONFIG_SND_SOC_WCD9310)
static int es325_slim_rx_port_to_ch[ES325_SLIM_RX_PORTS] = {
	152, 153, 154, 155, 134, 135
};
static int es325_slim_tx_port_to_ch[ES325_SLIM_TX_PORTS] = {
	156, 157, 138, 139, 143, 144
};
#elif defined(CONFIG_SND_SOC_WCD9320)
static int es325_slim_rx_port_to_ch[ES325_SLIM_RX_PORTS] = {
	152, 153, 154, 155, 134, 135
};
static int es325_slim_tx_port_to_ch[ES325_SLIM_TX_PORTS] = {
	156, 157, 144, 145, 146, 147
};
#else
#error "no CODEC port to channel map specified"
#endif

static int es325_slim_be_id[ES325_NUM_CODEC_SLIM_DAIS] = {
	ES325_SLIM_2_CAP, /* for ES325_SLIM_1_PB tx from es325 */
	ES325_SLIM_3_PB, /* for ES325_SLIM_1_CAP rx to es325 */
	ES325_SLIM_3_CAP, /* for ES325_SLIM_2_PB tx from es325 */
	-1, /* for ES325_SLIM_2_CAP */
	-1, /* for ES325_SLIM_3_PB */
	-1, /* for ES325_SLIM_3_CAP */
};
 
#define ES325_CUSTOMER_PROFILE_MAX 4
static u8 es325_audio_custom_profiles[ES325_CUSTOMER_PROFILE_MAX][100] = {
	{
		0x80, 0x2f, 0x00, 0x3e,
		0x04, 0x11, 0x00, 0x01,
		0x00, 0x05, 0x00, 0x00,
		0xb2, 0xb1, 0xb0, 0xb1,
		0xc0, 0xb6, 0xcd, 0xca,
		0xb2, 0xc4, 0xb4, 0xb0,
		0xba, 0xb7, 0xc3, 0xbc,
		0xcd, 0xc9, 0xd8, 0xd2,
		0xde, 0xdc, 0xe1, 0xe0,
		0xe0, 0xe0, 0xde, 0xe1,
		0xeb, 0xe3, 0xf8, 0xf3,
		0x00, 0xfb, 0x02, 0x01,
		0x06, 0x05, 0x11, 0x0a,
		0x1b, 0x16, 0x22, 0x20,
		0x20, 0x21, 0x1c, 0x1c,
		0x04, 0x12, 0x00, 0xf9,
		0xf6, 0xe4,
		0xff		/* terminate */
	},
	{
		0x80, 0x2f, 0x00, 0x3e,
		0x04, 0x11, 0x00, 0x01,
		0x00, 0x04, 0x00, 0x00,
		0x10, 0x08, 0x25, 0x1e,
		0x05, 0x1b, 0xe4, 0xf1,
		0xbe, 0xd6, 0xbc, 0xb4,
		0xce, 0xc8, 0xc9, 0xcc,
		0xc2, 0xc6, 0xdf, 0xcc,
		0xe6, 0xe8, 0xe0, 0xe3,
		0xd4, 0xdb, 0xcc, 0xcf,
		0xd7, 0xd0, 0xe8, 0xde,
		0xfa, 0xf1, 0x01, 0xfe,
		0x0a, 0x06, 0x21, 0x13,
		0x32, 0x2b, 0x3a, 0x38,
		0x3a, 0x3b, 0x3c, 0x39,
		0x06, 0x29, 0x00, 0xf2,
		0xc8, 0x38,
		0xff		/* terminate */
	},
	{
		0x80, 0x2f, 0x00, 0x3e,
		0x04, 0x11, 0x00, 0x01,
		0x00, 0x04, 0x00, 0x00,
		0x01, 0x02, 0xfd, 0xff,
		0xf4, 0xf9, 0xe7, 0xee,
		0xca, 0xda, 0xcb, 0xc3,
		0xe0, 0xd9, 0xdf, 0xdf,
		0xdf, 0xdf, 0xd3, 0xda,
		0xd0, 0xcf, 0xd2, 0xd1,
		0xd1, 0xd1, 0xd1, 0xd1,
		0xdb, 0xd4, 0xeb, 0xe3,
		0xfc, 0xf4, 0x05, 0x01,
		0x0e, 0x09, 0x22, 0x17,
		0x36, 0x2c, 0x42, 0x3f,
		0x3e, 0x41, 0x35, 0x3a,
		0x06, 0x22, 0x00, 0xf8,
		0x6e, 0x48,
		0xff		/* terminate */
	},
	{
		0x80, 0x2f, 0x00, 0x3e,
		0x04, 0x11, 0x00, 0x01,
		0x00, 0x04, 0x00, 0x00,
		0x2a, 0x2b, 0x29, 0x2a,
		0x2b, 0x2a, 0x2c, 0x2c,
		0x22, 0x29, 0x19, 0x1c,
		0x12, 0x16, 0x01, 0x0b,
		0xe9, 0xf6, 0xc0, 0xd6,
		0xb0, 0xb3, 0xad, 0xae,
		0xbd, 0xb2, 0xcf, 0xc8,
		0xd3, 0xd2, 0xd5, 0xd5,
		0xd6, 0xd5, 0xe6, 0xdb,
		0xfa, 0xf2, 0x04, 0xff,
		0x06, 0x06, 0x06, 0x06,
		0x06, 0x06, 0x06, 0x06,
		0x05, 0x06, 0x00, 0x05,
		0xa7, 0x5b,
		0xff		/* terminate */
	},
};
#define ES325_INTERNAL_ROUTE_MAX 33
static long es325_internal_route_num = ES325_INTERNAL_ROUTE_MAX;
static u8 es325_internal_route_configs[ES325_INTERNAL_ROUTE_MAX][50] = {
	/* Primary Modem Presets */
	/* [0]: 1-mic Headset */
	{
		0x90, 0x52, 0x00, 0x00,
		0x90, 0x5C, 0x00, 0x01,
		0xB0, 0x5A, 0x04, 0xA4,
		0xB0, 0x5A, 0x14, 0xA0,
		0xB0, 0x5A, 0x40, 0xAA,
		0xB0, 0x5A, 0x44, 0xAC,
		0x90, 0x5A, 0x48, 0xAD,
		0xff,
	},
	/* [1]: 1-mic CS Voice (DV) */
	{
		0x90, 0x31, 0x03, 0xE9,
		0xff,
	},
	/* [2]: 2-mic CS Voice (CT) */    
	{
		0x90, 0x31, 0x04, 0x1B,
		0xff,
	},
	/* [3]: 1-mic VOIP (CT) */
	{
		0x90, 0x31, 0x03, 0xEA,
		0xff,
	},
	/* [4]: 2-mic VOIP (CT) */
	{
		0x90, 0x31, 0x04, 0x1B,
		0xff,
	},
	/* [5]: Audio playback, 1 channel */
	{
		0x90, 0x31, 0x04, 0x7F,
		0xff,
	},
	/* [6]: Audio playback, 2 channels */
	{
		0x90, 0x31, 0x04, 0x97,
		0xff,
	},
	/* [7]: Audio record, 1 channel */
	{
		0xff,
	},
	/* [8]: Audio record, 2 channels */
	{
		0x90, 0x31, 0x04, 0x84,
		0xff,
	},
	/* [9]: 2-mic CT ASR */
	{
		0x90, 0x31, 0x04, 0xCA,
		0xff,
	},
	/* [10]: 2-mic FT ASR */
	{
		0x90, 0x31, 0x04, 0xCA,
		0xff,
	},
	 /* [11]: AudioZoom */
	{
		0x90, 0x31, 0x05, 0x4B,
		0xff,
	},
#ifndef VOICE_SENSE
	/* Secondary Modem Presets*/
	/* [12]: Enable PCM PORTA 8K Master Mode */
	{
		0x90, 0x31, 0x01, 0xF5,
		0xff,
	},
#else
	/* [12]: voice sense, PDM 0 */
	{
		0xb0, 0x5c, 0x00, 0x06, /* Set ALGO type: VoiceSense */
		0xb0, 0x15, 0x06, 0x0D, /* Set digital output gain */
		//0x90, 0x5a, 0x18, 0xc0, /*Set Path AUDIN1 = PDMI0 */
		0x90, 0x5a, 0x19, 0x20, /*Set Path AUDIN1 = PDMI3 */
		0xff			/* terminate */
	},
#endif
	/* [13]: Disable PCM PORTA 8K Master Mode */
	{
		0x90, 0x31, 0x01, 0xF6,
		0xff,
	},
#ifdef VOICE_SENSE//Richard 11.23
	/* [14]: voice sense, Analog mic */
	{
	0xb0, 0x5a, 0x18, 0xa4, /* Analog Mic -> Codec -> es325 */
	0x90, 0x5c, 0x00, 0x06, /* Set ALGO type: VoiceSense */
	0xff			/* terminate */
	},
#else
	/* [14]: 1-mic Headset */
	{
		0x90, 0x52, 0x00, 0x00,
		0x90, 0x5C, 0x00, 0x01,
		0xB0, 0X5A, 0X04, 0XA4,
		0xB0, 0X5A, 0X14, 0X00,
		0xB0, 0X5A, 0X40, 0X00,
		0xB0, 0X5A, 0X44, 0XAC,
		0xB0, 0X5A, 0X48, 0XAD,
		0x90, 0X5A, 0X28, 0XA0,
		0xff,
	},
#endif
	/*[15]: Detect Built in*/	
	{		
	0x80, 0x17, 0x50, 0x03,
	0x80, 0x18, 0x00, 0x00,
	0x80, 0x17, 0x50, 0x04,
	0x80, 0x18, 0x00, 0x0a, /*this byte is Detect value*/
	0xff,
	},
	/*[16]:Detect User Authentication*/
	{
	0x80, 0x17, 0x50, 0x03,
	0x80, 0x18, 0x00, 0x04,
	0x80, 0x17, 0x50, 0x04,
	0x80, 0x18, 0x00, 0x00,
	0xff,
	},

	/* [17]: 1-mic FT */    
	{
	       0x90, 0x31, 0x03, 0xF1,
	       0xff,
	},
	/* [18]: 2-mic FT */    
	{
	       0x90, 0x31, 0x04, 0x1F,
	       0xff,
	},
#if 0
 	/* [19]: Dual BB 1 MIC 2 FEIN 2 CSOUT 1 FEOUT BB1+BB2 */
	{
		0x90, 0x31, 0x0F, 0xA1,
		0xff,
	},
	/* [20]: Dual BB 2 MIC 2 FEIN 2 CSOUT 1 FEOUT BB1+BB2 */
	{
		0x90, 0x31, 0x0F, 0xAD,
		0xff,
	},
	/* [21]: Dual BB 2 MIC 2 FEIN 2 CSOUT 2 FEOUT BB1+BB2 */
	{
		0x90, 0x31, 0x0F, 0xAE,
		0xff,
	},
#else
         /* [19]: 1-mic FT *///Richard 3.6    
        {
        0xA0,0x52, 0x00, 0x00,// ; [C/R] SetDigitalPassThru, 0x0000: Disable
        0xA0,0x5C, 0x00, 0x04,// ; [C/R] SetAlgoType, 0x0004: Pass Through
        0xA0,0x5A, 0x19, 0x20,// ; [C/R] SetDataPath, 0x09: 
        0xA0,0x5A, 0x4C, 0xAA,//
        0xA0,0x4C, 0x00, 0x03,// ; [C/R] SetDataRate, 0x0003: 48kHz
        0xA0,0x1C, 0x00, 0x00,// ; [C/R] SetAlgoProcessing, 0x0000: Off
        0xA0,0x4E, 0x00, 0x00,// ; [C/R] SetSmoothRate, 0x0384: (900 dB/Sec)
        0xA0,0x15, 0x06, 0x12,// ; [C/R] SetDigitalOutputGain, 0x06: AUDIN1, 0x12: (18 dB)
        0x80,0x15, 0x13, 0x00,// ; [C/R] SetDigitalOutputGain, 0x13: AUDOUT1, 0x00: (0 dB)
        0xff,
        },

    	/* [20]: Dual BB 2 MIC 2 FEIN 2 CSOUT 1 FEOUT BB1+BB2 */
    	{
            0xA0,0x52, 0x00, 0x00,// ; [C/R] SetDigitalPassThru, 0x0000: Disable
            0xA0,0x5C, 0x00, 0x04,// ; [C/R] SetAlgoType, 0x0004: Pass Through
            0xA0,0x5A, 0x19, 0x20,// ; [C/R] SetDataPath, 0x09: 
            0xA0,0x5A, 0x4C, 0xAA,//
            0xA0,0x4C, 0x00, 0x03,// ; [C/R] SetDataRate, 0x0003: 48kHz
            0xA0,0x1C, 0x00, 0x00,// ; [C/R] SetAlgoProcessing, 0x0000: Off
            0xA0,0x4E, 0x0C, 0x80,// ; [C/R] SetSmoothRate, 0x0384: (900 dB/Sec)
            0xA0,0x15, 0x06, 0x12,// ; [C/R] SetDigitalOutputGain, 0x06: AUDIN1, 0x12: (18 dB)
            0x80,0x15, 0x13, 0x00,// ; [C/R] SetDigitalOutputGain, 0x13: AUDOUT1, 0x00: (0 dB)
            0xff,
        },
        
	/* [21]: Dual BB 2 MIC 2 FEIN 2 CSOUT 2 FEOUT BB1+BB2 */
	{//Riichard 3.13
		0x90, 0x4E, 0x03, 0x84,
		0xff,
	},
#endif

	 /* [22]: Bluetooth Voice Call */ 
	{
		0x80, 0x52, 0x00, 0x00,
		0x80, 0x5C, 0x00, 0x01,
		0xB0, 0x5A, 0x04, 0xA0, /* PRI from AP */
		0xB0, 0x5A, 0x40, 0x00, /* CSOUT to GSM */
		0xB0, 0x5A, 0x14, 0x00, /* FEIN from GSM */
		0x90, 0x5A, 0x44, 0xAA, /* FEOUT to AP */
		0xff,
	},
};

static struct snd_soc_dai_driver es325_dai[];
static struct q_clkdiv *codec_clk;
#define ES325_CLK_NAME "es325-mclk"
#define ES325_CLK_GET qpnp_clkdiv_get
#define ES325_CLK_ENALBE qpnp_clkdiv_enable
#define ES325_CLK_DISABLE qpnp_clkdiv_disable

static int es325_write_block_api(struct es325_priv *es325, u8 *cmd_blk);
static int es325_write_data_block_cmd(struct es325_priv *es325, u8 *cmd_blk);
static int es325_alloc_slim_rx_chan(struct slim_device *sbdev);
static int es325_alloc_slim_tx_chan(struct slim_device *sbdev);
static int es325_cfg_slim_rx(struct slim_device *sbdev, unsigned int *ch_num,
			     unsigned int ch_cnt, unsigned int rate);
static int es325_cfg_slim_tx(struct slim_device *sbdev, unsigned int *ch_num,
			     unsigned int ch_cnt, unsigned int rate);
static int es325_close_slim_rx(struct slim_device *sbdev, unsigned int *ch_num,
			       unsigned int ch_cnt);
static int es325_close_slim_tx(struct slim_device *sbdev, unsigned int *ch_num,
			       unsigned int ch_cnt);
static int es325_rx_ch_num_to_idx(int ch_num);
static int es325_tx_ch_num_to_idx(int ch_num);
static int es325_clk_ctl(int enable);
static int es325_wrapper_sleep(int dai_id);
static int es325_write(struct snd_soc_codec *codec, unsigned int reg,
		       unsigned int value);
static unsigned int es325_read(struct snd_soc_codec *codec,
			       unsigned int reg);
static void es325_switch_route(long route_index);
static int es325_schedule_sleep_workqueue(void);
int es325_wrapper_wakeup(void);
static int register_snd_soc(struct es325_priv *priv);

unsigned int es325_presets = 0;
int vs_auto_mode=0;//default do nothing
static int es325_rx_ch_num_to_idx(int ch_num)
{
	int i;
	int idx = -1;

	CDBG("GAC: %s(ch_num = %d)\n", __func__, ch_num);
	 for (i = 0; i < ES325_SLIM_RX_PORTS; i++) { 
		if (ch_num == es325_slim_rx_port_to_ch[i]) {
			idx = i;
			break;
		}
	}
	return idx;
}

static int es325_tx_ch_num_to_idx(int ch_num)
{
	int i;
	int idx = -1;

	CDBG("GAC: %s(ch_num = %d)\n", __func__, ch_num);
	for (i = 0; i < ES325_SLIM_TX_PORTS; i++) {
		if (ch_num == es325_slim_tx_port_to_ch[i]) {
			idx = i;
			break;
		}
	}
	return idx;
}

/* es325 -> codec - alsa playback function */
static int es325_codec_cfg_slim_tx(struct es325_priv *es325, int dai_id)
{
	int rc = 0;
	/* start slim channels associated with id */
	rc = es325_cfg_slim_tx(es325->gen0_client,
			       es325->dai[DAI_INDEX(dai_id)].ch_num,
			       es325->dai[DAI_INDEX(dai_id)].ch_tot,
			       es325->dai[DAI_INDEX(dai_id)].rate);
	return rc;
}

/* es325 <- codec - alsa capture function */
static int es325_codec_cfg_slim_rx(struct es325_priv *es325, int dai_id)
{
	int rc = 0;
	/* start slim channels associated with id */
	rc = es325_cfg_slim_rx(es325->gen0_client,
			       es325->dai[DAI_INDEX(dai_id)].ch_num,
			       es325->dai[DAI_INDEX(dai_id)].ch_tot,
			       es325->dai[DAI_INDEX(dai_id)].rate);
	return rc;
}

/* es325 -> codec - alsa playback function */
static int es325_codec_close_slim_tx(struct es325_priv *es325, int dai_id)
{
	int rc = 0;
	/* close slim channels associated with id */
	rc = es325_close_slim_tx(es325->gen0_client,
				 es325->dai[DAI_INDEX(dai_id)].ch_num,
				 es325->dai[DAI_INDEX(dai_id)].ch_tot);
	return rc;
}

/* es325 <- codec - alsa capture function */
static int es325_codec_close_slim_rx(struct es325_priv *es325, int dai_id)
{
	int rc = 0;
	/* close slim channels associated with id */
	rc = es325_close_slim_rx(es325->gen0_client,
				 es325->dai[DAI_INDEX(dai_id)].ch_num,
				 es325->dai[DAI_INDEX(dai_id)].ch_tot);
	return rc;
}

static int es325_alloc_slim_rx_chan(struct slim_device *sbdev)
{
	struct es325_priv *es325_priv = slim_get_devicedata(sbdev);
	struct es325_slim_ch *rx = es325_priv->slim_rx;
	int i;
	int port_id;
	int rc = 0;
	for (i = 0; i < ES325_SLIM_RX_PORTS; i++) {
		port_id = i;
		rx[i].ch_num = es325_slim_rx_port_to_ch[i];
		slim_get_slaveport(sbdev->laddr, port_id, &rx[i].sph,
				   SLIM_SINK);
		slim_query_ch(sbdev, rx[i].ch_num, &rx[i].ch_h);
		CDBG("%s(): port_id=%d,ch_num=%d,sph = 0x%08x\n", 
			__func__, port_id,rx[i].ch_num,rx[i].sph);
	}
	return rc;
}

static int es325_alloc_slim_tx_chan(struct slim_device *sbdev)
{
	struct es325_priv *es325_priv = slim_get_devicedata(sbdev);
	struct es325_slim_ch *tx = es325_priv->slim_tx;
	int i;
	int port_id;
	int rc = 0;
	for (i = 0; i < ES325_SLIM_TX_PORTS; i++) {
		port_id = i + 10; /* ES325_SLIM_RX_PORTS; */
		tx[i].ch_num = es325_slim_tx_port_to_ch[i];
		slim_get_slaveport(sbdev->laddr, port_id, &tx[i].sph,
				   SLIM_SRC);
		slim_query_ch(sbdev, tx[i].ch_num, &tx[i].ch_h);
		CDBG("%s(): port_id = %d,ch_num = %d,sph = 0x%08x\n", 
			__func__, port_id,tx[i].ch_num,tx[i].sph);
	}
	return rc;
}

static int es325_cfg_slim_rx(struct slim_device *sbdev, unsigned int *ch_num,
			     unsigned int ch_cnt, unsigned int rate)
{
	struct es325_priv *es325_priv = slim_get_devicedata(sbdev);
	struct es325_slim_ch *rx = es325_priv->slim_rx;
	u16 grph;
	u32 sph[ES325_SLIM_RX_PORTS] = {0};
	u16 ch_h[ES325_SLIM_RX_PORTS] = {0};
	struct slim_ch prop;
	int i;
	int idx = 0;
	int ret = 0;
	for (i = 0; i < ch_cnt; i++) {
		idx = es325_rx_ch_num_to_idx(ch_num[i]);
		ch_h[i] = rx[idx].ch_h;
		sph[i] = rx[idx].sph;
		CDBG("%s(): ch_num[i]=%d,ch_h[i] = %d,sph[i] = 0x%08x\n", 
			__func__, ch_num[i],ch_h[i],sph[i]);
	}

	prop.prot = SLIM_AUTO_ISO;
	prop.baser = SLIM_RATE_4000HZ;
	prop.dataf = SLIM_CH_DATAF_NOT_DEFINED;
	prop.auxf = SLIM_CH_AUXF_NOT_APPLICABLE;
	prop.ratem = (rate/4000);
	prop.sampleszbits = 16;

	ret = slim_define_ch(sbdev, &prop, ch_h, ch_cnt, true, &grph);
	if (ret < 0) {
		dev_err(&sbdev->dev, "%s(): slim_define_ch() failed: %d\n",
			__func__, ret);
		goto slim_define_ch_error;
	}
	for (i = 0; i < ch_cnt; i++) {
		ret = slim_connect_sink(sbdev, &sph[i], 1, ch_h[i]);
		if (ret < 0) {
			dev_err(&sbdev->dev,
				"%s(): slim_connect_sink() failed: %d\n",
				__func__, ret);
			goto slim_connect_sink_error;
		}
	}
	ret = slim_control_ch(sbdev, grph, SLIM_CH_ACTIVATE, true);
	if (ret < 0) {
		dev_err(&sbdev->dev,
			"%s(): slim_control_ch() failed: %d\n",
			__func__, ret);
		goto slim_control_ch_error;
	}
	for (i = 0; i < ch_cnt; i++) {
		idx = es325_rx_ch_num_to_idx(ch_num[i]);
		CDBG("GAC:%s(): idx = %d\n", __func__, idx);
		rx[idx].grph = grph;
	}
	return 0;
slim_control_ch_error:
slim_connect_sink_error:
	es325_close_slim_rx(sbdev, ch_num, ch_cnt);
slim_define_ch_error:
	return ret;
}

static int es325_cfg_slim_tx(struct slim_device *sbdev, unsigned int *ch_num,
			     unsigned int ch_cnt, unsigned int rate)
{
	struct es325_priv *es325_priv = slim_get_devicedata(sbdev);
	struct es325_slim_ch *tx = es325_priv->slim_tx;
	u16 grph;
	u32 sph[ES325_SLIM_TX_PORTS] = {0};
	u16 ch_h[ES325_SLIM_TX_PORTS] = {0};
	struct slim_ch prop;
	int i;
	int idx = 0;
	int ret = 0;

	for (i = 0; i < ch_cnt; i++) {
		idx = es325_tx_ch_num_to_idx(ch_num[i]);
		ch_h[i] = tx[idx].ch_h;
		sph[i] = tx[idx].sph;
		CDBG("%s(): ch_num[i] = %d,ch_h[i] = %d,sph[i] = 0x%08x\n", 
			__func__, ch_num[i],ch_h[i],sph[i]);
	}

	prop.prot = SLIM_AUTO_ISO;
	prop.baser = SLIM_RATE_4000HZ;
	prop.dataf = SLIM_CH_DATAF_NOT_DEFINED;
	prop.auxf = SLIM_CH_AUXF_NOT_APPLICABLE;
	prop.ratem = (rate/4000);
	prop.sampleszbits = 16;

	ret = slim_define_ch(sbdev, &prop, ch_h, ch_cnt, true, &grph);
	if (ret < 0) {
		dev_err(&sbdev->dev, "%s(): slim_define_ch() failed: %d\n",
			__func__, ret);
		goto slim_define_ch_error;
	}
	for (i = 0; i < ch_cnt; i++) {
		ret = slim_connect_src(sbdev, sph[i], ch_h[i]);
		if (ret < 0) {
			dev_err(&sbdev->dev,
				"%s(): slim_connect_src() failed: %d,ch_num[0] = %d\n",
				__func__, ret,ch_num[0]);
			goto slim_connect_src_error;
		}
	}
	ret = slim_control_ch(sbdev, grph, SLIM_CH_ACTIVATE, true);
	if (ret < 0) {
		dev_err(&sbdev->dev,
			"%s(): slim_control_ch() failed: %d\n",
			__func__, ret);
		goto slim_control_ch_error;
	}
	for (i = 0; i < ch_cnt; i++) {
		idx = es325_tx_ch_num_to_idx(ch_num[i]);
		CDBG("GAC:%s(): idx = %d\n", __func__, idx);
		tx[idx].grph = grph;
	}
	return 0;
slim_control_ch_error:
slim_connect_src_error:
	es325_close_slim_tx(sbdev, ch_num, ch_cnt);
slim_define_ch_error:
	return ret;
}

static int es325_close_slim_rx(struct slim_device *sbdev, unsigned int *ch_num,
			       unsigned int ch_cnt)
{
	struct es325_priv *es325_priv = slim_get_devicedata(sbdev);
	struct es325_slim_ch *rx = es325_priv->slim_rx;
	u16 grph = 0;
	u32 sph[ES325_SLIM_RX_PORTS] = {0};
	int i;
	int idx = 0;
	int ret = 0;

	for (i = 0; i < ch_cnt; i++) {
		idx = es325_rx_ch_num_to_idx(ch_num[i]);
		CDBG("GAC:%s(): idx = %d\n", __func__, idx);
		sph[i] = rx[idx].sph;
		grph = rx[idx].grph;
	}

	ret = slim_control_ch(sbdev, grph, SLIM_CH_REMOVE, true);
	if (ret < 0) {
		dev_err(&sbdev->dev,
			"%s(): slim_control_ch() failed: %d\n",
			__func__, ret);
		goto slim_control_ch_error;
	}
	for (i = 0; i < ch_cnt; i++) {
		idx = es325_rx_ch_num_to_idx(ch_num[i]);
		CDBG("GAC:%s(): idx = %d\n", __func__, idx);
		rx[idx].grph = 0;
	}
	ret = slim_disconnect_ports(sbdev, sph, ch_cnt);
	if (ret < 0) {
		dev_err(&sbdev->dev,
			"%s(): slim_disconnect_ports() failed: %d\n",
			__func__, ret);
	}
slim_control_ch_error:
	return ret;
}

static int es325_close_slim_tx(struct slim_device *sbdev, unsigned int *ch_num,
			       unsigned int ch_cnt)
{
	struct es325_priv *es325_priv = slim_get_devicedata(sbdev);
	struct es325_slim_ch *tx = es325_priv->slim_tx;
	u16 grph = 0;
	u32 sph[ES325_SLIM_TX_PORTS] = {0};
	int i;
	int idx = 0;
	int ret = 0;

	for (i = 0; i < ch_cnt; i++) {
		idx = es325_tx_ch_num_to_idx(ch_num[i]);
		CDBG("GAC:%s(): idx = %d\n", __func__, idx);
		sph[i] = tx[idx].sph;
		grph = tx[idx].grph;
	}

	ret = slim_control_ch(sbdev, grph, SLIM_CH_REMOVE, true);
	if (ret < 0) {
		dev_err(&sbdev->dev,
			"%s(): slim_connect_sink() failed: %d\n",
			__func__, ret);
		goto slim_control_ch_error;
	}
	for (i = 0; i < ch_cnt; i++) {
		idx = es325_tx_ch_num_to_idx(ch_num[i]);
		CDBG("GAC:%s(): idx = %d\n", __func__, idx);
		tx[idx].grph = 0;
	}
	ret = slim_disconnect_ports(sbdev, sph, ch_cnt);
	if (ret < 0) {
		dev_err(&sbdev->dev,
			"%s(): slim_disconnect_ports() failed: %d\n",
			__func__, ret);
	}
slim_control_ch_error:
	return ret;
}

int es325_remote_cfg_slim_rx(int dai_id)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	int be_id;
	int rc = 0;
	dev_info(&sbdev->dev, "GAC:%s(): dai_id =%d,ch_tot = %d\n", __func__,
		 dai_id,es325->dai[DAI_INDEX(dai_id)].ch_tot);
	
	if (dai_id != ES325_SLIM_1_PB&& dai_id != ES325_SLIM_2_PB)
		return 0;
	/* This is for defending ch_tot is not reset */
	if ((es325_rx1_route_enable == 0) && (es325_rx2_route_enable == 0)) {
		pr_info("-[ES325]=%s() rc = %d\n", __func__, rc);
		return rc;
	}
	if (es325->dai[DAI_INDEX(dai_id)].ch_tot != 0) {
		CDBG("%s: MDM ch_0=%d ch_1=%d\n", __func__, es325->dai[DAI_INDEX(dai_id)].ch_num[0], es325->dai[DAI_INDEX(dai_id)].ch_num[1]);
		/* start slim channels associated with id */
		rc = es325_cfg_slim_rx(es325->gen0_client,
				       es325->dai[DAI_INDEX(dai_id)].ch_num,
				       es325->dai[DAI_INDEX(dai_id)].ch_tot,
				       es325->dai[DAI_INDEX(dai_id)].rate);

		be_id = es325_slim_be_id[DAI_INDEX(dai_id)];
		es325->dai[DAI_INDEX(be_id)].ch_tot = es325->dai[DAI_INDEX(dai_id)].ch_tot;
		es325->dai[DAI_INDEX(be_id)].rate = es325->dai[DAI_INDEX(dai_id)].rate;
		CDBG("%s: WCD ch_0=%d ch_1=%d\n", __func__, es325->dai[DAI_INDEX(be_id)].ch_num[0], es325->dai[DAI_INDEX(be_id)].ch_num[1]);
		rc = es325_codec_cfg_slim_tx(es325, be_id);
	}

	return rc;
}
EXPORT_SYMBOL_GPL(es325_remote_cfg_slim_rx);

int es325_remote_cfg_slim_tx(int dai_id)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	int be_id;
	int ch_cnt;
	int rc = 0;

	dev_info(&sbdev->dev, "GAC:%s(): dai_id=%d,ch_tot = %d\n", __func__,
		dai_id, es325->dai[DAI_INDEX(dai_id)].ch_tot);
	if (dai_id != ES325_SLIM_1_CAP)
		return 0;
	/* This is for defending ch_tot is not reset */
	if (es325_tx1_route_enable == 0) {
		pr_info("-[ES325]=%s() rc = %d\n", __func__, rc);
		return rc;
	}
 
	if (es325->dai[DAI_INDEX(dai_id)].ch_tot != 0) {
		CDBG("%s: MDM ch_0=%d ch_1=%d\n", __func__, es325->dai[DAI_INDEX(dai_id)].ch_num[0], es325->dai[DAI_INDEX(dai_id)].ch_num[1]);
		/* start slim channels associated with id */
		if (dai_id == ES325_SLIM_1_CAP) {
			pr_info("GAC:%s(): overwrite ch_cnt = %d\n",
				__func__, es325_ap_tx1_ch_cnt);
			ch_cnt = es325_ap_tx1_ch_cnt;
		}
		rc = es325_cfg_slim_tx(es325->gen0_client,
				       es325->dai[DAI_INDEX(dai_id)].ch_num,
				       ch_cnt,
				       es325->dai[DAI_INDEX(dai_id)].rate);

		be_id = es325_slim_be_id[DAI_INDEX(dai_id)];
		es325->dai[DAI_INDEX(be_id)].ch_tot = es325->dai[DAI_INDEX(dai_id)].ch_tot;
		es325->dai[DAI_INDEX(be_id)].rate = es325->dai[DAI_INDEX(dai_id)].rate;
		CDBG("%s: WCD ch_0=%d ch_1=%d\n", __func__, es325->dai[DAI_INDEX(be_id)].ch_num[0], es325->dai[DAI_INDEX(be_id)].ch_num[1]);
		rc = es325_codec_cfg_slim_rx(es325, be_id);
	}

	return rc;
}
EXPORT_SYMBOL_GPL(es325_remote_cfg_slim_tx);

int es325_remote_close_slim_rx(int dai_id)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	int be_id;
	int rc = 0;
	dev_info(&sbdev->dev, "GAC:%s():,dai_id=%d,ch_tot = %d\n", __func__,
		dai_id,es325->dai[DAI_INDEX(dai_id)].ch_tot);
	
	if (dai_id != ES325_SLIM_1_PB
	    && dai_id != ES325_SLIM_2_PB)
		return 0;

	if (es325->dai[DAI_INDEX(dai_id)].ch_tot != 0) {
		es325_close_slim_rx(es325->gen0_client,
				    es325->dai[DAI_INDEX(dai_id)].ch_num,
				    es325->dai[DAI_INDEX(dai_id)].ch_tot);

		be_id = es325_slim_be_id[DAI_INDEX(dai_id)];
		rc = es325_codec_close_slim_tx(es325, be_id);

		es325->dai[DAI_INDEX(dai_id)].ch_tot = 0;
	}

	return rc;
}
EXPORT_SYMBOL_GPL(es325_remote_close_slim_rx);

int es325_remote_close_slim_tx(int dai_id)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	int be_id;
	int ch_cnt;
	int rc = 0;
	dev_info(&sbdev->dev, "GAC:%s(): dai_id=%d,ch_tot = %d\n", __func__,
		dai_id,es325->dai[DAI_INDEX(dai_id)].ch_tot);
	if (dai_id != ES325_SLIM_1_CAP)
		return 0;

	if (es325->dai[DAI_INDEX(dai_id)].ch_tot != 0) {
		if (dai_id == ES325_SLIM_1_CAP)
			ch_cnt = es325_ap_tx1_ch_cnt;
		es325_close_slim_tx(es325->gen0_client,
				    es325->dai[DAI_INDEX(dai_id)].ch_num,
				    ch_cnt);

		be_id = es325_slim_be_id[DAI_INDEX(dai_id)];
		rc = es325_codec_close_slim_rx(es325, be_id);

		es325->dai[DAI_INDEX(dai_id)].ch_tot = 0;
	}

	return rc;
}
EXPORT_SYMBOL_GPL(es325_remote_close_slim_tx);

static int es325_init_slim_slave(struct slim_device *sbdev)
{
	int rc = 0;
	dev_dbg(&sbdev->dev, "%s(): entry\n", __func__);
	rc = es325_alloc_slim_rx_chan(sbdev);
	rc = es325_alloc_slim_tx_chan(sbdev);
	return rc;
}

static void msg_to_bus_order(char *msg, int msg_len)
{
	char tmp;

	for (; msg_len > 0; msg_len -= 4, msg += 4) {
		tmp = *(msg + 3);
		*(msg + 3) = *(msg);
		*(msg) = tmp;
		tmp = *(msg + 2);
		*(msg + 2) = *(msg + 1);
		*(msg + 1) = tmp;
	}
}

#ifdef VOICE_SENSE
#define SMB_FRAME_SZ	4
#define MAX_TRIALS	20
#define SMB_DELAY	1000

#define AUDIENCE_FW_HEADER_SIZE 20 /*bytes*/
#define AUDIENCE_FW_SEC_HEADER_SIZE 8 /*bytes*/
#define AUDIENCE_FW_INDEX_OF_SECTIONS 3 /* After 3 32bit words */
#define AUDIENCE_RECOVERY_FW_SIZE   152
const u8 VSRecoveryApp[AUDIENCE_RECOVERY_FW_SIZE] = {
		0x41, 0x55, 0x44, 0x49, 0x45, 0x4E, 0x43, 0x45, 0x00, 0x33,
		0x32, 0x35, 0x04, 0x00, 0x00, 0x00, 0x00, 0x04, 0x08, 0x20,
		0x07, 0x00, 0x00, 0x00, 0x00, 0x68, 0x02, 0x20, 0x00, 0xFE,
		0xFF, 0x0F, 0x08, 0x01, 0x01, 0x20, 0x0C, 0x01, 0x01, 0x20,
		0x2C, 0x02, 0x01, 0x20, 0x00, 0xFE, 0x00, 0x20, 0xD4, 0x6D,
		0x18, 0x20, 0xD0, 0x6E, 0x05, 0x20, 0x04, 0x00, 0x00, 0x00,
		0x1C, 0x68, 0x02, 0x20, 0x30, 0x68, 0x02, 0x20, 0x30, 0x68,
		0x02, 0x20, 0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x40,
		0x0E, 0x00, 0x00, 0x00, 0x00, 0x04, 0x08, 0x20, 0x36, 0x41,
		0x00, 0x11, 0x06, 0x9A, 0x0C, 0x09, 0x0C, 0x1C, 0xD1, 0x00,
		0x9A, 0xC0, 0x20, 0x00, 0xC2, 0x6D, 0x8E, 0xB1, 0x01, 0x9A,
		0xC0, 0x20, 0x00, 0x99, 0x0B, 0xA1, 0x02, 0x9A, 0xC0, 0x20,
		0x00, 0x99, 0x0A, 0x81, 0x03, 0x9A, 0xA1, 0x04, 0x9A, 0x91,
		0x05, 0x9A, 0x88, 0x08, 0x92, 0x6A, 0x9A, 0xE0, 0x08, 0x00,
		0x06, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90, 0x6F,
		0xA8, 0xD8};
const unsigned int smb_frame_sz = SMB_FRAME_SZ;
enum {
	SBL,
	STANDARD,
	VOICESENSE,
};

static int es325_slim_read_block(struct es325_priv *es325, unsigned int offset,
			   unsigned int width, char *buf, int len)
{
	struct slim_device *sbdev = es325->gen0_client;
	DECLARE_COMPLETION_ONSTACK(read_done);
	struct slim_ele_access msg = {
		.start_offset = offset,
		.num_bytes = width,
		/*
		 * FIX SLIMBus API error:
		 * replace &read_done by NULL
		 * .comp = &read_done,
		 */
		.comp = NULL,
	};
	int rc;
	rc = slim_request_val_element(sbdev, &msg, buf, len);
#ifdef TRACE_SLIMBUS
	dev_dbg(&sbdev->dev, "%s(): SMB READ: 0x%02x 0x%02x 0x%02x 0x%02x\n",
		__func__, *buf, *(buf+1), *(buf+2), *(buf+3));
#endif
	return rc;
}

static int es325_slim_write_block(struct es325_priv *es325, unsigned int offset,
			    unsigned int width, char *buf, int len)
{
	struct slim_device *sbdev = es325->gen0_client;
	struct slim_ele_access msg = {
		.start_offset = offset,
		.num_bytes = width,
		.comp = NULL,
	};
	int rc;
	rc = slim_change_val_element(sbdev, &msg, buf, len);
#ifdef TRACE_SLIMBUS
	dev_dbg(&sbdev->dev, "%s(): SMB WRITE: 0x%02x 0x%02x 0x%02x 0x%02x\n",
		__func__, *buf, *(buf+1), *(buf+2), *(buf+3));
#endif
	return rc;
}

static int es325_slim_read_vs(struct es325_priv *es325,
				u32 *rspn, int match)
{
	int rc = 0;
	int i = 0;
	const u32 NOT_READY = 0;
	u32 tmp;
	struct slim_device *sbdev = es325->gen0_client;

	do {
		char msg[SMB_FRAME_SZ] = {0};
		usleep_range(SMB_DELAY, SMB_DELAY);
		rc = es325_slim_read_block(es325, ES325_READ_VE_OFFSET,
				ES325_READ_VE_WIDTH, msg, SMB_FRAME_SZ);
		if (!rc) {
			memcpy(&tmp, msg, SMB_FRAME_SZ);
			if (tmp != NOT_READY)
				break;
		}
		i++;
	} while (i < MAX_TRIALS);

	if (i == MAX_TRIALS) {
               if (need_report_hw_bug)//Richard 2014.2.20
			detected_hw_bug = 1;

		dev_err(&sbdev->dev, "%s(): reach MAX_TRIALS (%d)\n",
			__func__, MAX_TRIALS);
		rc = -EIO;
	} else {
		if (match && *rspn != tmp) {
			dev_err(&sbdev->dev, "%s(): unexpected response 0x%08x\n",
				__func__, tmp);
			rc = -EIO;
		}
		*rspn = tmp;
	}
	return rc;
}

static int es325_slim_write_vs(struct es325_priv *es325,
				u32 *rqst, unsigned int rqsts, int order)
{
	int rc = 0;
	int i = 0;
	int err= 0;
	struct slim_device *sbdev = es325->gen0_client;

	while (rqsts) {
		for (i = 0; rqsts && i < MAX_TRIALS; i++) {
			for (rc = 0; rqsts && rc == 0;
			     rqsts -= min(rqsts, smb_frame_sz), rqst++) {
				char msg[SMB_FRAME_SZ] = {0};
				memcpy(msg, (char *)rqst, SMB_FRAME_SZ);
				if (order)
					msg_to_bus_order(msg, SMB_FRAME_SZ);
				rc = es325_slim_write_block(es325,
					ES325_WRITE_VE_OFFSET,
					ES325_WRITE_VE_WIDTH, msg,
					min(rqsts, smb_frame_sz));
				if (rc < 0) {
					err++;
                                    	if (need_report_hw_bug)//Richard 2014.2.20
					    detected_hw_bug = 1;

					dev_err(&sbdev->dev, "%s(): Write 0x%08x error\n",
						__func__, *rqst);					
					usleep_range(SMB_DELAY, SMB_DELAY);
					if(err>5)
						return rc;					
				}
			}
		}
	}
	if (rqsts) {
		dev_err(&sbdev->dev, "%s(): reach MAX_TRIALS (%d)\n",
			__func__, MAX_TRIALS);
		rc = -EIO;
	}
	return rc;
}

static int es325_slim_write_then_read(struct es325_priv *es325,
				u32 *rqst, unsigned int rqsts,
				u32 *rspn, int match, int order)
{
	int rc;
	rc = es325_slim_write_vs(es325, rqst, rqsts, order);
	if (rc == 0){
		rc = es325_slim_read_vs(es325, rspn, match);
	}
	return rc;
}

static int es325_slim_read_segment(struct es325_priv *es325,
				u32 *rspn)
{
	int rc = 0;
	int i = 0;
	u32 tmp;
	struct slim_device *sbdev = es325->gen0_client;

	do {
		char msg[SMB_FRAME_SZ] = {0};
		usleep_range(SMB_DELAY, SMB_DELAY);
		rc = es325_slim_read_block(es325, ES325_READ_VE_OFFSET,
				ES325_READ_VE_WIDTH, msg, SMB_FRAME_SZ);
		if (!rc) {
			memcpy(&tmp, msg, SMB_FRAME_SZ);
			break;
		}
		i++;
	} while (i < MAX_TRIALS);

	if (i == MAX_TRIALS) {
		dev_err(&sbdev->dev, "%s(): reach MAX_TRIALS (%d)\n",
			__func__, MAX_TRIALS);
		rc = -EIO;
	} else {
		*rspn = tmp;
	}
	return rc;
}

//Richard new
/*
 * Note: this may only end up being called in a api locked context. In
 * that case the mutex locks need to be removed.
 */
int es325_read_vs_data_block(struct es325_priv *es325)
{
	u8 *block = &es325->vs_keyword_param[0];
	u32 cmd;
	u32 resp;
	int ret;
	unsigned size;
	unsigned rdcnt;
	unsigned blkcnt = 0;

	struct slim_device *sbdev = es325->gen0_client;

	mutex_lock(&es325->api_mutex);

	es325->vs_keyword_param_size = 0;

	do {
		/* Read voice sense keyword sub - data block request. */
		/* This is for User trained authentication RDB */
		cmd = 0x802e0007;
		/* Add sub block # into the byte 1 of command */
		cmd = cmd | (blkcnt << 8);
		ret = es325_slim_write_then_read(es325, &cmd,
					sizeof(cmd), &resp, 0, 0);
		if (ret < 0) {
			dev_err(&sbdev->dev, "%s(): fail\n",
				__func__);
			es325->vs_keyword_param_size = 0;
			goto es325_read_vs_data_block_exit;
		}

		size = resp & 0xffff;
		dev_dbg(&sbdev->dev, "%s(): resp=0x%08x size=%d\n",
			__func__, resp, size);

		if (size > 0) {
			BUG_ON((size + es325->vs_keyword_param_size)
					  > ES325_VS_KEYWORD_PARAM_MAX);
			BUG_ON(size % SMB_FRAME_SZ != 0);

			/* This assumes we need to transfer the block in
			*  SMB_FRAME_SZ byte increments.
			*  This is true on slimbus, but may not hold true
			*  for other buses.
			*/
			for (rdcnt = 0; rdcnt < size; rdcnt += SMB_FRAME_SZ) {
				ret = es325_slim_read_segment(es325, &resp);
				if (ret < 0) {
					dev_err(&sbdev->dev,
				"%s(): err reading sub-data blk at %d bytes\n",
						__func__, rdcnt);
					es325->vs_keyword_param_size = 0;
					goto es325_read_vs_data_block_exit;
				}
				memcpy(block+es325->vs_keyword_param_size+rdcnt,
				       &resp, SMB_FRAME_SZ);
			}

			es325->vs_keyword_param_size += rdcnt;
			dev_dbg(&sbdev->dev,
				"%s(): stored vskw subblk %d bytes,total %d\n",
				__func__, rdcnt, es325->vs_keyword_param_size);
		}
		blkcnt++;
	} while (size != 0);

es325_read_vs_data_block_exit:
	mutex_unlock(&es325->api_mutex);
	if (ret)
		dev_err(&sbdev->dev, "%s(): v-s read data block failure=%d\n",
			__func__, ret);
	return ret;
}

//Richard new
int es325_write_vs_data_block(struct es325_priv *es325)
{
	u32 cmd;
	u32 resp;
	int ret;
	u8 *dptr = es325->vs_keyword_param;
	u16 rem;
	u8 wdb[SMB_FRAME_SZ];
	u32 keyword_size_left = es325->vs_keyword_param_size;
	u32 keyword_sub_blk_size = 0;

	struct slim_device *sbdev = es325->gen0_client;

	if (es325->vs_keyword_param_size == 0) {
		dev_warn(&sbdev->dev,
			 "%s(): attempt to write empty keyword data block\n",
			__func__);
		return -ENOENT;
	}
	mutex_lock(&es325->api_mutex);
	while (keyword_size_left > 0) {
		keyword_sub_blk_size =
			min(((u32)VS_KEYWORD_DATA_SUB_BLOCK_SIZE),
					   keyword_size_left);
		BUG_ON(keyword_sub_blk_size % SMB_FRAME_SZ != 0);
		cmd = 0x802f0000 | (keyword_sub_blk_size & 0xffff);
		ret = es325_slim_write_then_read(es325,
					&cmd, sizeof(cmd), &resp, 0, 0);
		if (ret < 0) {
			dev_err(&sbdev->dev, "%s(): fail\n",
				__func__);
			goto es325_write_vs_data_block_exit;
		}
		dev_dbg(&sbdev->dev, "%s(): resp=0x%08x\n",
			__func__, resp);
		if ((resp & 0xffff0000) != 0x802f0000) {
			dev_err(&sbdev->dev,
				"%s(): invalid write data block 0x%08x\n",
				__func__, resp);
			goto es325_write_vs_data_block_exit;
		}
		for (rem = keyword_sub_blk_size; rem > 0;
				rem -= SMB_FRAME_SZ, dptr += SMB_FRAME_SZ) {
			u32 cmd;
			wdb[0] = dptr[3];
			wdb[1] = dptr[2];
			wdb[2] = dptr[1];
			wdb[3] = dptr[0];
			memcpy(&cmd, wdb, SMB_FRAME_SZ);
			ret = es325_slim_write_vs(es325, &cmd, sizeof(cmd), 0);
			if (ret < 0) {
				dev_err(&sbdev->dev,"%s(): v-s wdb error offset=%hu\n",
					__func__,dptr - es325->vs_keyword_param);
				goto es325_write_vs_data_block_exit;
			}
		}

		usleep_range(10000, 10000);
		memset(&resp, 0, SMB_FRAME_SZ);
		ret = es325_slim_read_vs(es325, &resp, 0);
		if (ret < 0) {
			dev_err(&sbdev->dev,"%s(): error sending request = %d\n",
				__func__, ret);
			goto es325_write_vs_data_block_exit;
		}

		dev_dbg(&sbdev->dev, "%s():resp=0x%08x\n",
			__func__, resp);
		if (resp & 0xffff) {
			dev_err(&sbdev->dev,"%s(): write data block error 0x%08x\n",
				__func__, resp);
			goto es325_write_vs_data_block_exit;
		}
		keyword_size_left -= keyword_sub_blk_size;
	}
	dev_info(&sbdev->dev, "%s(): v-s wdb success\n",
		 __func__);
es325_write_vs_data_block_exit:
	mutex_unlock(&es325->api_mutex);
	if (ret != 0)
		dev_err(&sbdev->dev, "%s(): v-s wdb failed ret=%d\n",
			__func__, ret);
	return ret;
}

static ssize_t es325_vs_keyword_parameter_size_show(struct device *dev,
						struct device_attribute *attr,
						char *buf)
{
	int ret = 0;
	mutex_lock(&es325_priv.api_mutex);//Richard 11.23
	memcpy(buf, &es325_priv.vs_keyword_param_size,
		sizeof es325_priv.vs_keyword_param_size);
	ret = sizeof es325_priv.vs_keyword_param_size;
	if (es325_priv.vs_keyword_param_size > 0)
		es325_priv.vs_keyword_param_next_index_read = 0;
	dev_err(dev, "%s(): keyword param size=%hu\n",
		__func__, es325_priv.vs_keyword_param_size);
	mutex_unlock(&es325_priv.api_mutex);//Richard 11.23
	return ret;
}

static ssize_t es325_vs_keyword_parameter_size_set(struct device *dev,
					       struct device_attribute *attr,
					       const char *buf, size_t count)
{
	int ret = 0;

	mutex_lock(&es325_priv.api_mutex);//Richard 11.23
	es325_priv.vs_keyword_param_size = 0;
	if (count >= sizeof es325_priv.vs_keyword_param_size)
		es325_priv.vs_keyword_param_size =
			(u16) (buf[0] | (buf[1] << 8));

	if (es325_priv.vs_keyword_param_size >=
		  ES325_VS_KEYWORD_PARAM_MAX) {
		dev_err(dev, "%s(): keyword param size invalid = %zi\n",
			__func__, es325_priv.vs_keyword_param_size);
		es325_priv.vs_keyword_param_size = 0;
		ret = -EINVAL;
	} else {
		dev_err(dev, "%s(): keyword param size_set = %zi\n",
			__func__, es325_priv.vs_keyword_param_size);
		if (es325_priv.vs_keyword_param_size > 0)
			es325_priv.vs_keyword_param_next_index_write = 0;
		ret = es325_priv.vs_keyword_param_size;
	}
	mutex_unlock(&es325_priv.api_mutex);//Richard 11.23
	return ret;
}

static DEVICE_ATTR(vs_keyword_parameter_size, 0644,
		   es325_vs_keyword_parameter_size_show,
		   es325_vs_keyword_parameter_size_set);

static int es325_switch_to_standard_mode(void)
{    //Richard 11.26
	int rc = 0;
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	u32 pwr_st_cmd = (ES325_SET_POWER_STATE_NO_RSP << 16);
	pwr_st_cmd |= ES325_SET_POWER_STATE_NORMAL;
	rc = es325_slim_write_vs(es325, &pwr_st_cmd, sizeof(pwr_st_cmd), 0);
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): FAIL rc %d\n", __func__, rc);
		return -EIO;
	}
	es325->mode = STANDARD;
	dev_dbg(&sbdev->dev, "%s: STANDARD Success\n",__func__);
	return 0;
}

static int es325_vs_fw_download_abort_recover(struct es325_priv *es325,
						int n_sec)
{
	struct slim_device *sbdev = es325->gen0_client;
	u32 *buf_ptr;
	u32 null_section[] = {0x00000000, 0x00000001};
	u32 sec_to_load = 0;
	u32 sbl_rspn = ES325_SBL_ACK;
	u32 sync_cmd = (ES325_SYNC_CMD << 16) | ES325_SYNC_POLLING;
	u32 boot_cmd = ES325_BOOT_CMD;
	u32 expected_rspn = ES325_BOOT_ACK;
	int rc = 0;

#ifdef MEASURE_FW_LOAD_TIME//Richard 11.23
	struct timeval tv0, tv1;
	
	memset(&tv0, 0, sizeof(struct timeval));
	memset(&tv1, 0, sizeof(struct timeval));
	do_gettimeofday(&tv0);
#endif
	//Richard 11.26
	if (n_sec == 0)	{
		rc = es325_switch_to_standard_mode();
		return rc;	
	}
	/*Assign dummy section to {00000000, 00000001}
	 * while (no_of_sections > 0)
	 *{
	 * Load Dummy Section;
	 * }
	 * Wait for delay
	 * Check if FW in SBL mode by sending sync
	 * Download Recovery.bin, after sending boot ack
	 */
	sec_to_load = n_sec;
	buf_ptr = null_section;
	while (sec_to_load > 0) {
#ifdef CONFIG_SND_SOC_ES325_UART//Richard 12.9
		rc = es325->uart_dev_write(es325, buf_ptr,
			AUDIENCE_FW_SEC_HEADER_SIZE);
		if (rc !=  AUDIENCE_FW_SEC_HEADER_SIZE) {
			dev_err(&sbdev->dev, "%s(): download null header fail\n",
				__func__);
			rc = -EIO;
			return rc;
		}
#else
		rc = es325_slim_write_vs(es325, buf_ptr,
				      AUDIENCE_FW_SEC_HEADER_SIZE, 0);
		if (rc < 0) {
			dev_err(&sbdev->dev,"%s(): download null header fail\n",
				__func__);
			rc = -EIO;
			return rc;
		}
#endif
		sec_to_load--;
	}
	/* Wait for few ms before sending sync to check SBL mode */
	msleep(20);
	rc = es325_slim_write_then_read(es325, &sync_cmd, sizeof(sync_cmd),
			      &sbl_rspn, 1, 0);
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): no SBL response\n",
				      __func__);
		rc = -EIO;
		return rc;
	} else
		dev_dbg(&sbdev->dev, "%s(): SBL Rsp Success\n",
			    __func__);

	dev_dbg(&sbdev->dev, "%s(): ES325_BOOT_CMD\n",
			__func__);
	rc = es325_slim_write_then_read(es325, &boot_cmd, sizeof(boot_cmd),
			&expected_rspn, 1, 0);
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): boot fail\n",
				__func__);
		rc = -EIO;
		return rc;
	}

	buf_ptr = (u32 *)VSRecoveryApp;
	rc = es325_slim_write_vs(es325, buf_ptr, AUDIENCE_RECOVERY_FW_SIZE, 0);
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): download recovery fail %d fail\n",
				__func__, rc);
		rc = -EIO;
		return rc;
	} else
		dev_dbg(&sbdev->dev, "%s(): Recovery FW download Success\n",
			    __func__);
#ifdef MEASURE_FW_LOAD_TIME//Richard 11.23
		do_gettimeofday(&tv1);
			dev_dbg(&sbdev->dev, "%s(): timetaken by VS Fw Abort :%ld msec\n",
			__func__, (tv1.tv_sec - tv0.tv_sec)*1000 + (tv1.tv_usec - tv0.tv_usec)/1000);
#endif
	return rc;
}

#ifndef CONFIG_SND_SOC_ES325_UART
static int es325_vs_segmented_firmware_download(struct es325_priv *es325,
					     u32 *fw_data,
					     u32 fw_size)
{
	/*
	 * Parse and get the number of sections
	 * Load the header, adjust fw_ptr to first section
	 * Assign no_of_sections to n_sec
	 * While (n_sec is not zero)
	 * {
	 * Read the size of next section;
	 * Load the next section;
	 * Adjust the pointer to next section;
	 * On mutex lock, check if abort_requested
	 * not means - continue while
	 * If abort_requested,
	 * get out of while..
	 * }
	 * if abort requested {
	 * Handle abort and do recovery()
	 * }
	 */
	struct slim_device *sbdev = es325->gen0_client;
	u32 *buf_ptr;
	u32 n_sec = 0;
	u32 sec_to_load = 0;
	u32 sec_size = 0;
	int rc;

#ifdef MEASURE_FW_LOAD_TIME//Richard 11.23
	struct timeval tv0, tv1, tv2, tv3;
		
	memset(&tv0, 0, sizeof(struct timeval));
	memset(&tv1, 0, sizeof(struct timeval));
	memset(&tv2, 0, sizeof(struct timeval));
	memset(&tv3, 0, sizeof(struct timeval));
	do_gettimeofday(&tv0);
#endif

	buf_ptr = fw_data;
	/* Num of sections is present at 12th byte in fw */
	n_sec = buf_ptr[AUDIENCE_FW_INDEX_OF_SECTIONS];
	sec_to_load = n_sec;

	dev_dbg(&sbdev->dev, "%s(): Vs fw Sections : %d\n",
			__func__, n_sec);

	/*Send the fw header first , this is of fixed size */
	rc = es325_slim_write_vs(es325, buf_ptr, AUDIENCE_FW_HEADER_SIZE, 0);
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): download header fail\n",
			__func__);
		rc = -EIO;
	}
	buf_ptr += (AUDIENCE_FW_HEADER_SIZE/4);
	/* down load fw image section by section */
	while (sec_to_load > 0) {
		msleep(1);
		sec_size = *buf_ptr; /* In DWords - 4 bytes */
		CDBG("%s(): Load Section %d size : %d\n",
			__func__, (n_sec-sec_to_load)+1, (sec_size*4));
#ifdef MEASURE_FW_LOAD_TIME//Richard 11.23
		do_gettimeofday(&tv2);
#endif
		rc = es325_slim_write_vs(es325, buf_ptr,
				      (sec_size*4)+AUDIENCE_FW_SEC_HEADER_SIZE,0);
		if (rc < 0) {
			dev_err(&sbdev->dev,
				"%s(): download section %d fail\n",
				__func__, (n_sec - sec_to_load));
			rc = -EIO;
		}
		sec_to_load--;
		buf_ptr += (sec_size+(AUDIENCE_FW_SEC_HEADER_SIZE/4));
#ifdef ABORT_TEST//Richard 11.23
		if ((es325->vs_abort_req == 1) && ((g_sec_to_abort < n_sec) &&
				  ((n_sec - sec_to_load) == g_sec_to_abort))) {
				  dev_dbg(&sbdev->dev,
				"%s(): VS_Fw abort requested\n",
				__func__);
			break;
		}
#else
		if (es325->vs_abort_req == 1) {
			dev_dbg(&sbdev->dev,
				"%s(): VS_Fw abort requested\n",
				__func__);
			break;
		}
#endif
#ifdef MEASURE_FW_LOAD_TIME//Richard 11.23
				do_gettimeofday(&tv3);
				dev_dbg(&sbdev->dev, "%s(): timetaken by prev Section :%ld msec\n",
					__func__, (tv3.tv_sec - tv2.tv_sec)*1000 + (tv3.tv_usec - tv2.tv_usec)/1000);
#endif
	}
	if (es325->vs_abort_req == 1)
		rc = es325_vs_fw_download_abort_recover(es325, sec_to_load);

#ifdef MEASURE_FW_LOAD_TIME//Richard 11.23
			do_gettimeofday(&tv3);
			dev_dbg(&sbdev->dev, "%s(): timetaken by prev Section :%ld msec\n",
				__func__, (tv3.tv_sec - tv2.tv_sec)*1000 + (tv3.tv_usec - tv2.tv_usec)/1000);
#endif
	return rc;
}

static int es325_firmware_download(struct es325_priv *es325,
				   int mode,
				   const struct firmware *fw,
				   const char *fw_name)
{
	struct slim_device *sbdev = es325->gen0_client;
	u32 boot_cmd = ES325_BOOT_CMD;
	u32 expected_rspn = ES325_BOOT_ACK;
	u32 *buf_ptr;
	int rc;

	rc = es325_slim_write_then_read(es325, &boot_cmd, sizeof(boot_cmd),
			&expected_rspn, 1, 0);
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): boot fail\n",
			__func__);
		goto es325_firmware_download_exit;
	}
	rc = request_firmware((const struct firmware **)&fw,
			      fw_name, &sbdev->dev);
	if (rc) {
		dev_err(&sbdev->dev,"%s(): request_firmware(%s) fail. Error: %d\n",
			__func__, fw_name, rc);
		goto es325_firmware_download_exit;
	}

	pr_err("%s():request %s buf_frames = %d OK,begin download!!!!!!!!!\n",
		 __func__, fw_name,fw->size / SMB_FRAME_SZ);
	buf_ptr = (u32 *)fw->data;

	if (mode == STANDARD) {
		/* down load fw image */
		rc = es325_slim_write_vs(es325, buf_ptr, fw->size, 0);
	} else {
		rc = es325_vs_segmented_firmware_download(es325,
							buf_ptr, fw->size);
	}
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): %s download fail\n",
			__func__, fw_name);
		rc = -EIO;
	}
	release_firmware(fw);

es325_firmware_download_exit:
	return rc;
}

static int es325_firmware(struct es325_priv *es325, int mode)
{
	const char *standard_fw = "audience-es325-fw.bin";
	const char *voicesense_fw = "audience-es325-vs.bin";
	struct slim_device *sbdev = es325->gen0_client;
	u32 sync_cmd = (ES325_SYNC_CMD << 16) | ES325_SYNC_POLLING;
	u32 vs_sync_cmd = (ES325_SYNC_CMD << 16) | ES325_SYNC_INTR_FALLING_EDGE;
	u32 sbl_rspn = ES325_SBL_ACK;
	int rc;

	rc = es325_slim_write_then_read(es325, &sync_cmd, sizeof(sync_cmd),
			      &sbl_rspn, 1, 0);
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): no SBL response\n",
			__func__);
		goto es325_firmware_exit;
	}

	if (mode == STANDARD){
		rc = es325_firmware_download(es325, mode,
						     es325_priv.standard, standard_fw);
	}else
		rc = es325_firmware_download(es325, mode,
					     es325_priv.vs, voicesense_fw);
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): firmware download fail\n",
			__func__);
		goto es325_firmware_exit;
	}
	if ((mode == STANDARD) || (es325->vs_abort_req == 1))
		rc = es325_slim_write_then_read(es325, &sync_cmd,
					sizeof(sync_cmd), &sync_cmd, 1, 0);
	else{
		msleep(30);
		rc = es325_slim_write_then_read(es325, &vs_sync_cmd,
		sizeof(vs_sync_cmd), &vs_sync_cmd, 1, 0);
	}
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): %s download fail\n",
 			__func__, (mode == STANDARD) ? "STANDARD" : "VOICE SENSE");
		rc = -EIO;
		goto es325_firmware_exit;
	} else
		dev_dbg(&sbdev->dev, "%s(): firmware download done\n",
			__func__);
	if (es325->vs_abort_req == 1) {
		mutex_lock(&es325->abort_mutex);
		es325->vs_abort_req = 0;
#ifdef ABORT_TEST//Richard 11.23
		g_sec_to_abort = 0;
#endif
		mutex_unlock(&es325->abort_mutex);
		es325->mode = STANDARD;
	} else
		es325->mode = mode;

es325_firmware_exit:
	return rc;
}
#endif
//Richard new
static ssize_t es325_vs_keyword_parameters_show(struct device *dev,
						struct device_attribute *attr,
						char *buf)
{
	int ret = 0;
	int index = es325_priv.vs_keyword_param_next_index_read;
	int size = es325_priv.vs_keyword_param_size;

	mutex_lock(&es325_priv.api_mutex);//Richard 11.23
	if (es325_priv.vs_keyword_param_size > 0) {
		if (es325_priv.vs_keyword_param_size <=
			VS_KW_SYSFS_MAX_BUF_SIZE) {
			memcpy(buf, es325_priv.vs_keyword_param,
			      es325_priv.vs_keyword_param_size);
			ret = es325_priv.vs_keyword_param_size;
			dev_err(dev, "%s(): keyword param size=%hu\n",
				__func__, ret);
		} else if (es325_priv.vs_keyword_param_next_index_read <
				es325_priv.vs_keyword_param_size) {
			size = min((u16)VS_KW_SYSFS_MAX_BUF_SIZE,
				   (u16)(es325_priv.vs_keyword_param_size- index));
			memcpy(buf, &es325_priv.vs_keyword_param[index],
			      size);
			ret = size;
			es325_priv.vs_keyword_param_next_index_read += size;
			if (es325_priv.vs_keyword_param_next_index_read >=
			  es325_priv.vs_keyword_param_size)
				es325_priv.vs_keyword_param_next_index_read =0;
			dev_err(dev, "%s(): keyword param size=%hu\n",
				__func__, ret);
		}
	} else
		dev_dbg(dev, "%s(): keyword param not set\n",
			__func__);
	mutex_unlock(&es325_priv.api_mutex);//Richard 11.23
	return ret;
}

static ssize_t es325_vs_keyword_parameters_set(struct device *dev,
					       struct device_attribute *attr,
					       const char *buf, size_t count)
{
	int ret = 0;
	int index = es325_priv.vs_keyword_param_next_index_write;

	if (es325_priv.vs_keyword_param_size == 0) {
		dev_err(dev, "%s(): keyword param size not set\n",
			__func__);
		return -EINVAL;
	}

	mutex_lock(&es325_priv.api_mutex);//Richard 11.23
	if (es325_priv.vs_keyword_param_size < VS_KW_SYSFS_MAX_BUF_SIZE) {
		if (count <= ES325_VS_KEYWORD_PARAM_MAX) {
			memcpy(es325_priv.vs_keyword_param, buf, count);
			es325_priv.vs_keyword_param_size = count;
			dev_err(dev, "%s(): keyword param block set size = %zi\n",
				__func__, count);
			ret = count;
		} else {
			dev_err(dev, "%s(): keyword param block too big = %zi\n",
				__func__, count);
			ret = -ENOMEM;
		}
	} else {
		//if ((index + count) <= es325_priv.vs_keyword_param_size) {
		if (((index + count) <= es325_priv.vs_keyword_param_size) &&
		    ((index + count) <= ES325_VS_KEYWORD_PARAM_MAX)) {//Richard 11.23
			memcpy(&es325_priv.vs_keyword_param[index], buf, count);
			es325_priv.vs_keyword_param_next_index_write += count;
			if (es325_priv.vs_keyword_param_next_index_write >=
			  es325_priv.vs_keyword_param_size)
				es325_priv.vs_keyword_param_next_index_write =0;
			dev_err(dev,"%s(): keyword param block set size = %zi\n",
				__func__, count);
			ret = count;
		}
		else {
			dev_err(dev, "%s(): keyword param subblock too big = %zi\n",
				__func__, count);
			ret = -ENOMEM;
		}


	}
	mutex_unlock(&es325_priv.api_mutex);//Richard 11.23
	return ret;
}

static DEVICE_ATTR(vs_keyword_parameters, 0644,
		   es325_vs_keyword_parameters_show,
		   es325_vs_keyword_parameters_set);
/* /sys/bus/slimbus/devices/
   es325-codec-gen0/vs_keyword_parameters */

static u32 es325_vs_status(struct es325_priv *es325)
{
	struct slim_device *sbdev = es325->gen0_client;
	u32 vs_get_key_word_status = 0x806D0000;
	u32 expected_status = 0x806D0002;
	int ret;

	ret = es325_slim_write_then_read(es325, &vs_get_key_word_status,
				sizeof(vs_get_key_word_status),
				&expected_status, 1, 0);
	if (ret < 0)
		dev_err(&sbdev->dev, "%s(): unexpected return\n",
			__func__);
	return ret;
}

static ssize_t es325_vs_status_show(struct device *dev,
					struct device_attribute *attr,
					char *buf)
{
	int ret = 0;
//Richard 11.23
	unsigned int value = 0;
	char *status_name = "Voice Sense Status";
	/* Disable vs status read for interrupt to work */
	struct es325_priv *es325 = &es325_priv;
	mutex_lock(&es325->api_mutex);
	value = es325->vs_get_event;
	/* Reset the detection status after read */
	es325->vs_get_event = NO_EVENT;
	mutex_unlock(&es325->api_mutex);
	ret = snprintf(buf, PAGE_SIZE,
		       "%s=0x%04x\n",
		       status_name, value);
	return ret;
}

static DEVICE_ATTR(vs_status, 0444, es325_vs_status_show, NULL);
/* /sys/bus/slimbus/devices/es325-codec-gen0/vs_status */

//Richard 11.23
static ssize_t es325_vs_fw_load_status_show(struct device *dev,
					struct device_attribute *attr,
					char *buf)
{
	int ret = 0;
	unsigned int value = 0;
	char *status_name = "Voice Sense Fw Load Status";
	struct es325_priv *es325 = &es325_priv;

	/* Check if we are in SBL, if so send fw load in progress */
	if (es325->mode == SBL)
		value = 1;
	ret = snprintf(buf, PAGE_SIZE,
		       "%s=%d\n",
		       status_name, value);

	return ret;
}

static
DEVICE_ATTR(vs_fw_load_status, 0444, es325_vs_fw_load_status_show, NULL);
/* /sys/bus/slimbus/devices/es325-codec-gen0/vs_fw_load_status */


static ssize_t es325_ping_status_show(struct device *dev,
					struct device_attribute *attr,
					char *buf)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	int rc = 0;
	u32 sync_cmd = (ES325_SYNC_CMD << 16) | ES325_SYNC_POLLING;
	u32 sync_ack;

	rc = es325_slim_write_then_read(es325, &sync_cmd, sizeof(sync_cmd),
				   &sync_ack, 0, 0);
	if (!rc) {
		dev_dbg(&sbdev->dev, "%s(): sync_ack = 0x%08x\n",
			__func__, sync_ack);
		rc = snprintf(buf, PAGE_SIZE, "Ping=0x%08x\n", sync_ack);
	}
	return rc;
}

static DEVICE_ATTR(ping_status, 0444, es325_ping_status_show, NULL);
/* /sys/bus/slimbus/devices/es325-codec-gen0/ping_status */

static int es325_get_vs_enable(struct snd_kcontrol *kcontrol,
			       struct snd_ctl_elem_value *ucontrol)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;

	ucontrol->value.enumerated.item[0] = es325_priv.vs_enable;
	dev_dbg(&sbdev->dev, "%s(): voice sense mode: %s\n",
		__func__, (es325_priv.vs_enable > 0) ? "enable" : "disable");

	return 0;
}
static int es325_put_vs_enable(struct snd_kcontrol *kcontrol,
			       struct snd_ctl_elem_value *ucontrol)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;

	es325_priv.vs_enable = ucontrol->value.enumerated.item[0];
	dev_dbg(&sbdev->dev, "%s(): voice sense mode: %s\n",
		__func__, (es325_priv.vs_enable > 0) ? "enable" : "disable");

	return 0;
}

static int es325_get_vs_wakeup_keyword(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value *ucontrol)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;

	ucontrol->value.enumerated.item[0] = es325_priv.vs_wakeup_keyword;
	dev_dbg(&sbdev->dev, "%s(): voice sense wakeup keyword: %s\n",
		__func__, (es325_priv.vs_wakeup_keyword > 0) ? "set" : "unset");

	return 0;
}

static int es325_put_vs_wakeup_keyword(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value *ucontrol)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;

	es325_priv.vs_wakeup_keyword = ucontrol->value.enumerated.item[0];
	dev_dbg(&sbdev->dev, "%s(): voice sense wakeup keyword: %s\n",
		__func__, (es325_priv.vs_wakeup_keyword > 0) ? "set" : "unset");

	return 0;
}

static int es325_put_vs_stored_keyword(struct snd_kcontrol *kcontrol,
				      struct snd_ctl_elem_value *ucontrol)
{
	int op;
	int ret;
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;

	op = ucontrol->value.enumerated.item[0];
	dev_dbg(&sbdev->dev, "%s(): op=%d\n",
		__func__, op);

	ret = 0;
	switch (op) {
	case 0:
		dev_dbg(&sbdev->dev, "%s(): keyword params put...\n",
			__func__);
		ret = es325_write_vs_data_block(&es325_priv);
		break;
	case 1:
		dev_dbg(&sbdev->dev, "%s(): keyword params get...\n",
			__func__);
		ret = es325_read_vs_data_block(&es325_priv);
		break;
	case 2:
		dev_dbg(&sbdev->dev, "%s(): keyword params clear...\n",
			__func__);
		es325_priv.vs_keyword_param_size = 0;
		break;
	default:
		BUG_ON(0);
	};

	return ret;
}

/* Voice Sense Detection Sensitivity */
static
int es325_put_vs_detection_sensitivity_value(struct snd_kcontrol *kcontrol,
					 struct snd_ctl_elem_value *ucontrol)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int value;
	int rc = 0;

	if (ucontrol->value.integer.value[0] <= 10) {
		value = ucontrol->value.integer.value[0];
		dev_info(&sbdev->dev, "%s(): ucontrol = %ld value = %d\n",
			 __func__, ucontrol->value.integer.value[0], value);
		rc = es325_write(NULL, reg, value);
	}

	return 0;
}

static
int es325_get_vs_detection_sensitivity_value(struct snd_kcontrol *kcontrol,
					 struct snd_ctl_elem_value *ucontrol)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int value;

	value = es325_read(NULL, reg);
	ucontrol->value.integer.value[0] = value;
	dev_info(&sbdev->dev, "%s(): value = %d ucontrol = %ld\n",
		 __func__, value, ucontrol->value.integer.value[0]);

	return 0;
}
 
static void es325_hw_reset(struct es325_priv *es325)
{
	gpio_set_value(es325->pdata->reset_gpio, 0);
	usleep_range(10000, 10000);
	gpio_set_value(es325->pdata->reset_gpio, 1);
	usleep_range(15000, 15000);
	/* wait extra 100 ms */
	//msleep(10);
}

#ifdef CONFIG_SND_SOC_ES325_UART
static int es325_uart_vs_segmented_firmware_download(struct es325_priv *es325,
					u32 *fw_data,   u32 fw_size, u32 *sec_to_load_ret)//Richard 12.12
{
	/*	 * Parse and get the number of sections
	  * Load the header, adjust fw_ptr to first section
	  * Assign no_of_sections to n_sec
	  * While (n_sec is not zero)
	  * {	 * Read the size of next section;
	  * Load the next section;
	  * Adjust the pointer to next section;
	  * On mutex lock, check if abort_requested
	  * not means - continue while
	  * If abort_requested,
	  * get out of while..
	  * }
	  * if abort requested {
	  * Handle abort and do recovery()
	  * }
	  */
	//	struct slim_device *sbdev = es325->gen0_client;
	u32 *buf_ptr;	u32 n_sec = 0;
	u32 sec_to_load = 0;
	u32 sec_size = 0;
	int rc=0;
	int ret_val;
	buf_ptr = fw_data;
	/* Num of sections is present at 12th byte in fw */
	n_sec = buf_ptr[AUDIENCE_FW_INDEX_OF_SECTIONS];
	sec_to_load = n_sec;
	pr_debug("%s(): Vs fw Sections : %d\n",	__func__, n_sec);
	/*Send the fw header first , this is of fixed size */
	ret_val = es325->uart_dev_write(es325, buf_ptr,
	AUDIENCE_FW_HEADER_SIZE);
	if(ret_val != AUDIENCE_FW_HEADER_SIZE )	{
		pr_err("%s(): download header fail\n",
			__func__);
		rc = -EIO;
		return rc;
	}
	buf_ptr += (AUDIENCE_FW_HEADER_SIZE/4);
	/* down load fw image section by section */
	while (sec_to_load > 0) {
		sec_size = *buf_ptr;	/* In DWords - 4 bytes */
//		pr_debug("%s(): Load Section %d size : %d\n",
//				__func__, (n_sec-sec_to_load)+1, (sec_size*4));
		ret_val = es325->uart_dev_write(es325, buf_ptr,(sec_size*4)+AUDIENCE_FW_SEC_HEADER_SIZE);
	//	pr_info("====%s block size = %d , retun value = %d====\n",__func__,(sec_size*4)+AUDIENCE_FW_SEC_HEADER_SIZE,ret_val);
		if(ret_val != (sec_size*4)+AUDIENCE_FW_SEC_HEADER_SIZE ){
			pr_err("%s(): download Block : %d fail\n",
				__func__,(n_sec-sec_to_load)+1);
			rc = -EIO;
			return rc;
		}
		sec_to_load--;
		buf_ptr += (sec_size+(AUDIENCE_FW_SEC_HEADER_SIZE/4));
		if (es325->vs_abort_req == 1) {
			pr_info("%s(): VS_Fw abort requested\n",
				__func__);
			break;
		}
	}
	*sec_to_load_ret = sec_to_load;
	return rc;
}

static int es325_uart_fw_download(struct es325_priv *es325, int mode)//Richard 12.11
{
	int rc = 0;
	u32 sec_to_load_ret = 0;//Richard 12.12
	const char *voicesense_fw = "audience-es325-vs.bin";
	const char *standard_fw = "audience-es325-fw.bin";
	
#ifdef CONFIG_SND_SOC_ES325_UART
	es325->uart_open(es325); // uart opt
	if (mode==STANDARD){  //Richard 1.7 
		es325_hw_reset(es325);
	}
#endif
	/* Request VS firmware */
	if (mode==VOICESENSE){
		rc = request_firmware((const struct firmware **)&es325_priv.vs,
			      voicesense_fw, es325_priv.dev);
		if (rc) {
			pr_err("%s(): request_firmware(%s) failed %d\n",
				__func__, voicesense_fw, rc);
			return rc;
		}
	}else{
		rc = request_firmware((const struct firmware **)&es325_priv.standard,
			      standard_fw, es325_priv.dev);
		if (rc) {
			pr_err("%s(): request_firmware(%s) failed %d\n",
				__func__, standard_fw, rc);
			return rc;
		}
	}

	rc = es325->uart_boot_setup(es325);
	if (rc) {
		pr_err("%s(): uart boot setup error\n",__func__);
		goto es325_uart_fw_download_exit;
	}

	pr_info("%s(): Start write firmware image\n", __func__);
	if (mode==VOICESENSE){
		rc = es325_uart_vs_segmented_firmware_download(es325,(u32 *)es325->vs->data,
			es325->vs->size, &sec_to_load_ret);//Richard 12.12
		if(rc < 0){
			pr_err("%s(): VS firmware image write error return with rc : %d\n",
					__func__,rc);
			rc = -EIO;
			goto es325_uart_fw_download_exit;
		}
		mutex_lock(&es325->abort_mutex);
		if (es325->vs_abort_req == 1) {
			rc = es325_vs_fw_download_abort_recover(es325, sec_to_load_ret);
			es325->vs_abort_req = 0;
			es325->mode = STANDARD;
		}else{
			es325->mode = VOICESENSE;
			pr_info("%s(): VS firmware image write Success\n",__func__);
		}
		mutex_unlock(&es325->abort_mutex);
		if (es325->mode == VOICESENSE){  //Richard 12.16
			u32 vs_sync_cmd = (ES325_SYNC_CMD << 16) | ES325_SYNC_INTR_FALLING_EDGE;
			msleep(30);
			rc = es325_slim_write_then_read(es325, &vs_sync_cmd,
						sizeof(vs_sync_cmd), &vs_sync_cmd, 1, 0);
			if (rc < 0) {
				pr_err("%s(): Voice Sense download fail\n",__func__);
				rc = -EIO;
			} else
				pr_info("%s(): firmware download done\n",__func__);
		}
		goto es325_uart_fw_download_exit;
	}else{
		//usleep(50000);   //c by wangtao 
		pr_debug("%s(): write NS firmware image\n", __func__);
		rc = es325->uart_dev_write(es325, (char *)es325->standard->data,
				es325->standard->size);
		if (rc != es325->standard->size) {
			pr_err("%s(): firmware image write error\n",
				__func__);
			rc = -EIO;
			goto es325_uart_fw_download_exit;
		}
		else{  //Richard 1.7 Sync check after NS download
			u32 vs_sync_cmd = (ES325_SYNC_CMD << 16) | ES325_SYNC_POLLING;
			msleep(30);
			rc = es325_slim_write_then_read(es325, &vs_sync_cmd,
						sizeof(vs_sync_cmd), &vs_sync_cmd, 1, 0);
			if (rc < 0) {
				pr_err("%s(): NS firmware download fail\n",__func__);
				rc = -EIO;
				goto es325_uart_fw_download_exit;
			} else
				pr_info("%s(): NS firmware download done\n",__func__);
		}
		rc=0;
	}
	
es325_uart_fw_download_exit:
	if (mode==VOICESENSE)
		release_firmware(es325->vs);
	else
		release_firmware(es325->standard);

#ifdef CONFIG_SND_SOC_ES325_UART
	es325->uart_close(es325);// uart opt 
#endif	
	return rc;
}
#endif
static int es325_switch_firmware(int mode)
{
	int rc = 0;
	int retryCount = 3;//Richard
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	u32 pwr_st_cmd = (ES325_SET_POWER_STATE_NO_RSP << 16);
	u32 smooth_rate_cmd = 0x904e0000;
	static char sync_ok[] = { 0x80, 0, 0, 0 };
	char msg[16];
	
	mutex_lock(&es325->api_mutex);
	if ((es325->mode == mode) && (mode != SBL) && (detected_hw_bug!=1)) {//Richard 2014.220
		dev_dbg(&sbdev->dev, "%s: Chip already in requested mode\n",
			__func__);
		goto es325_switch_firmware_exit;
	}
	if (mode == VOICESENSE) {
		rc = es325_slim_write_vs(es325, &smooth_rate_cmd,
				      sizeof(smooth_rate_cmd), 0);
		if (rc < 0)
			dev_err(&sbdev->dev,
				"%s(): Set Smooth Mute 0 Fail rc %d\n",
				__func__, rc);
		pwr_st_cmd |= ES325_SET_POWER_STATE_VS_OVERLAY;
		rc = es325_slim_write_vs(es325, &pwr_st_cmd,
				      sizeof(pwr_st_cmd), 0);
		if (rc < 0) {
			dev_err(&sbdev->dev, "%s(): to mode %d FAIL rc %d\n",
				__func__, mode, rc);
			goto es325_switch_firmware_exit;
		}
	}else if (mode == STANDARD) {
		rc = es325_switch_to_standard_mode();
		if (rc < 0) {
			dev_err(&sbdev->dev, "%s(): to mode %d FAIL rc %d\n",
				__func__, mode, rc);
		}
		do {
			msleep(30);
			memset(msg, 0, 16);
			msg[0] = ES325_SYNC_CMD >> 8;
			msg[1] = ES325_SYNC_CMD & 0x00ff;
			msg[2] = ES325_SYNC_POLLING >> 8;
			msg[3] = ES325_SYNC_POLLING & 0x00ff;
			pr_info("%s(): write msg[0] = 0x%02x\n", __func__, msg[0]);
			pr_info("%s(): write msg[1] = 0x%02x\n", __func__, msg[1]);
			pr_info("%s(): write msg[2] = 0x%02x\n", __func__, msg[2]);
			pr_info("%s(): write msg[3] = 0x%02x\n", __func__, msg[3]);
			rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
					ES325_WRITE_VE_WIDTH, msg, 4, 1);
			if (rc < 0) {
				pr_err("%s(): firmware sync write failed\n", __func__);
				continue;
			}

			msleep(30);
			pr_info("%s(): read sync cmd ack\n", __func__);
			memset(msg, 0, 16);
			rc = ES325_BUS_READ(es325, ES325_READ_VE_OFFSET, ES325_READ_VE_WIDTH,
							msg, 4, 1);
			if (rc < 0) {
				pr_err("%s(): error reading firmware sync ack rc=%d\n",
							__func__, rc);
				continue;
			}
			pr_info("%s(): read msg[0] = 0x%02x\n", __func__, msg[0]);
			pr_info("%s(): read msg[1] = 0x%02x\n", __func__, msg[1]);
			pr_info("%s(): read msg[2] = 0x%02x\n", __func__, msg[2]);
			pr_info("%s(): read msg[3] = 0x%02x\n", __func__, msg[3]);

			if (memcmp(msg, sync_ok, 4) == 0) {
				pr_info("%s() %d time: firmware sync ack good,now is STANDARD mode!!!\n",
							__func__, 3-retryCount);
				break;
			} else {
				pr_err("%s(): firmware sync ack failed=0x%02x%02x%02x%02x\n",
							__func__, msg[0], msg[1], msg[2], msg[3]);
			}
		} while (--retryCount);
		if (retryCount)  //if sync ok break,else download FW again
			goto es325_switch_firmware_exit;
	}
	/* set power state 5 puts the device in SBL Mode.*/
	/* Wait for es325 to be in SBL mode */
	msleep(100);
	es325->mode = SBL;
	do {
#ifdef CONFIG_SND_SOC_ES325_UART
		rc = es325_uart_fw_download(es325, mode);/* Request VS firmware */
#else
		rc = es325_firmware(es325, mode);
#endif
		if (rc < 0) {
			dev_err(&sbdev->dev, "%s(): FAIL rc %d\n",
				__func__, rc);
			es325_hw_reset(es325);
		}
	} while (rc < 0);

	if (es325->mode == VOICESENSE)
		dev_dbg(&sbdev->dev, "%s: VOICE SENSE Success\n",
			__func__);
	if (es325->mode == STANDARD)
		dev_dbg(&sbdev->dev, "%s: STANDARD redownload Success\n",
			__func__);
	
es325_switch_firmware_exit:
	mutex_unlock(&es325->api_mutex);
	return rc;
}

static void es325_vs_route_macro(void)
{
	pr_debug("%s():\n", __func__);
	es325_switch_route(12);
}

static int es325_put_vs_demo_enable(struct snd_kcontrol *kcontrol,
				    struct snd_ctl_elem_value *ucontrol)
{
	int rc;
	struct es325_priv *es325 = &es325_priv;
	if (ucontrol->value.integer.value[0]) {
		rc = es325_switch_firmware(VOICESENSE);
		if (es325->mode == VOICESENSE)
			es325_vs_route_macro();
	} else{
		rc = es325_switch_firmware(STANDARD);
	}

	return rc;
}

static int es325_get_vs_demo_enable(struct snd_kcontrol *kcontrol,
				    struct snd_ctl_elem_value *ucontrol)
{
	pr_debug("%s(): es325_get_vs_demo_enable\n", __func__);
	return 0;
}

static int es325_put_vs_abort_req(struct snd_kcontrol *kcontrol,
				    struct snd_ctl_elem_value *ucontrol)
{
	struct es325_priv *es325 = &es325_priv;

	mutex_lock(&es325->abort_mutex);
	if (ucontrol->value.integer.value[0])
		es325->vs_abort_req = 1;
	else
		es325->vs_abort_req = 0;
	mutex_unlock(&es325->abort_mutex);
	pr_debug("%s(): vs_abort_req %d\n", __func__, es325->vs_abort_req);
	return 0;
}

static int es325_get_vs_abort_req(struct snd_kcontrol *kcontrol,
				    struct snd_ctl_elem_value *ucontrol)
{
	struct es325_priv *es325 = &es325_priv;

	pr_debug("%s():\n", __func__);
	return es325->vs_abort_req;
}

#ifdef AUTO_ABORT
static int es325_put_vs_abort_req_clone(int abort_req)
{
	struct es325_priv *es325 = &es325_priv;

	mutex_lock(&es325->abort_mutex);
	if (abort_req)
		es325->vs_abort_req = 1;
	else
		es325->vs_abort_req = 0;
	mutex_unlock(&es325->abort_mutex);
	pr_debug("%s(): vs_abort_req %d\n", __func__, es325->vs_abort_req);
	return 0;
}
#endif

static int es325_vs_power_state(unsigned int state)
{
	int rc;
	struct es325_priv *es325 = &es325_priv;
	if (state) {
		rc = es325_switch_firmware(VOICESENSE);
		if (es325->mode == VOICESENSE){
			es325_vs_route_macro();
			switch (vs_auto_mode)
			{
			case 1: //Detect built in
				es325_switch_route(15);
				pr_info("%s vs auto mode: Detect built in", __func__);
				break;
			case 2://Detect user authentication
				es325_switch_route(16);
				pr_info("%s vs auto mode: Detect user authentication", __func__);
				break;
			default:
				pr_info("%s vs auto mode: %d", __func__, vs_auto_mode);
				break;
			}
			es325_power_state = ES325_POWER_STATE_VS;
			pr_info("vs download successfully after %s %d", __func__, state);
		}else if(es325->mode == STANDARD){
			es325_power_state = ES325_POWER_STATE_ACTIVE;
			pr_info("must be aborted after %s %d", __func__, state);
		}else{
			pr_info("unknown state after %s %d", __func__, state);
		}

	} else{
		rc = es325_switch_firmware(STANDARD);
		es325_power_state = ES325_POWER_STATE_ACTIVE;
		pr_info("standard download successfully after %s %d", __func__, state);
	}
	return rc;
}

static int es325_vs_download_thread(void *priv)//Richard 11.19
{
	struct es325_priv *es325=priv;
	int ch_tot = 0;
	int port_active = 0;

	ch_tot += es325->dai[ES325_SLIM_1_PB - ES325_DAI_ID_BASE].ch_tot;
	ch_tot += es325->dai[ES325_SLIM_2_PB - ES325_DAI_ID_BASE].ch_tot;
	ch_tot += es325->dai[ES325_SLIM_1_CAP - ES325_DAI_ID_BASE].ch_tot;

	port_active = es325_rx1_route_enable || es325_rx2_route_enable || es325_tx1_route_enable;
	if(!((ch_tot <= 0) && (port_active == 0))) {
	                pr_info("%s():Still active can not switch to VS mode,ch_tot=%d, port_active=%d\n", 
	                                __func__,ch_tot, port_active);
	es325_power_state= ES325_POWER_STATE_ACTIVE;
	                return 0;
	}
	mutex_lock(&es325->pm_mutex);
	if (es325_power_state== ES325_POWER_STATE_VS_DOWNLOADING)//Richard 11.26
		es325_vs_power_state(1);
	else
		pr_info("%s():Something strange, current state=%d\n", __func__,es325_power_state);
	mutex_unlock(&es325->pm_mutex);
	return 0;
}

static int es325_update_power_state(struct es325_priv *es325, int state)
{
	int ret = 0;
#ifdef AUTO_ABORT
	if (state==ES325_POWER_STATE_ACTIVE){
		es325_put_vs_abort_req_clone(1);
		pr_info("%s():abort anyway, try to abort vs download, previous state=%d\n", __func__, es325_power_state);
	}
#endif
	mutex_lock(&es325->pm_mutex);
	switch(state){
		case 0:
			if ( es325_power_state== ES325_POWER_STATE_ACTIVE){
				pr_info("%s():previous power state is Active\n", __func__);
				es325_schedule_sleep_workqueue();
			}
		break;

		case 1:
			if ((es325_power_state == ES325_POWER_STATE_SLEEP)||(es325_power_state == ES325_POWER_STATE_SLEEP_PENDING)){
				pr_info("%s():previous power state is Sleep\n", __func__);
				ret = es325_wrapper_wakeup();
			}else if ((es325_power_state == ES325_POWER_STATE_VS)||(es325_power_state == ES325_POWER_STATE_VS_DOWNLOADING)){
				pr_info("%s():previous power state is VS\n", __func__);
				ret = es325_vs_power_state(0);
			}else if (es325_power_state == ES325_POWER_STATE_ACTIVE){
				pr_info("%s():previous power state is Active,do nothing\n", __func__);
                             if (detected_hw_bug)
                                ret = es325_vs_power_state(0);
				//es325_wakeup(es325);//Richard 11.27
			}
#ifdef AUTO_ABORT
			es325_put_vs_abort_req_clone(0);
			pr_info("%s():whatever clear abort req, current state=%d\n", __func__,es325_power_state);
#endif
		break;

		case 2:
		if (es325_power_state == ES325_POWER_STATE_ACTIVE){
#ifdef AUTO_ABORT
			es325_power_state= ES325_POWER_STATE_VS_DOWNLOADING;//by Richard abort
#endif
			pr_info("%s():previous power state is Active\n", __func__);
#ifdef VOICE_SENSE
			kthread_run( es325_vs_download_thread, &es325_priv, "vs thread");
#endif
		}
		break;
	}
	mutex_unlock(&es325->pm_mutex);
	return ret;
}

//Richard 11.19
static int es325_put_voice_sense_auto_mode(struct snd_kcontrol *kcontrol,	
	struct snd_ctl_elem_value *ucontrol){
	pr_debug("GAC:%s():ucontrol = %d\n", __func__,
		ucontrol->value.enumerated.item[0]);
	vs_auto_mode= ucontrol->value.enumerated.item[0];
	return 0;
}

static int es325_get_voice_sense_auto_mode(struct snd_kcontrol *kcontrol,
	struct snd_ctl_elem_value *ucontrol){
	ucontrol->value.enumerated.item[0]=vs_auto_mode;
	pr_debug("GAC:%s():current vs auto mode = %d\n", __func__,
		ucontrol->value.enumerated.item[0]);
	return 0;
}


//Richard 11.22
static int es325_get_bootup_status(struct snd_kcontrol *kcontrol,
				    struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.enumerated.item[0]=bootup_status;
	pr_debug("GAC:%s():current bootup_status = %d\n", __func__,
		ucontrol->value.enumerated.item[0]);
	return 0;
}


static const char * const es325_vs_wakeup_keyword_texts[] = {
	"Default", "One", "Two", "Three", "Four"
};
static const struct soc_enum es325_vs_wakeup_keyword_enum =
	SOC_ENUM_SINGLE(ES325_VOICE_SENSE_SET_KEYWORD, 0,
			ARRAY_SIZE(es325_vs_wakeup_keyword_texts),
			es325_vs_wakeup_keyword_texts);

static const char * const es325_vs_event_texts[] = {
	"No Event", "Codec Event", "VS Keyword Event",
};
static const struct soc_enum es325_vs_event_enum =
	SOC_ENUM_SINGLE(ES325_VOICE_SENSE_EVENT, 0,
			ARRAY_SIZE(es325_vs_event_texts),
			es325_vs_event_texts);

//Richard new
static const char * const es325_vs_training_status_texts[] = {
	"Training Not done", "Done and Success", "Utterance long",
	"Utterance short", "Utterance fail"
};

static const struct soc_enum es325_vs_training_status_enum =
	SOC_ENUM_SINGLE(ES325_VOICE_SENSE_TRAINING_STATUS, 0,
			ARRAY_SIZE(es325_vs_training_status_texts),
			es325_vs_training_status_texts);

//Richard new
static const char * const es325_vs_training_record_texts[] = {
	"Invalid", "Start",
};

static const char * const es325_vs_stored_keyword_texts[] = {
	"Put", "Get", "Clear"
};

static const struct soc_enum es325_vs_stored_keyword_enum =
	SOC_ENUM_SINGLE(ES325_VS_STORED_KEYWORD, 0,
			ARRAY_SIZE(es325_vs_stored_keyword_texts),
			es325_vs_stored_keyword_texts);

static const struct soc_enum es325_vs_training_record_enum =
	SOC_ENUM_SINGLE(ES325_VOICE_SENSE_TRAINING_RECORD, 0,
			ARRAY_SIZE(es325_vs_training_record_texts),
			es325_vs_training_record_texts);

//Richard new
static const char * const es325_vs_training_mode_texts[] = {
	"Detect builtin keyword", "Not Supported1", "Not Supported2",
	"Train user authentication", "Detect user authentication"
};

static const struct soc_enum es325_vs_training_mode_enum =
	SOC_ENUM_SINGLE(ES325_VOICE_SENSE_TRAINING_MODE, 0,
			ARRAY_SIZE(es325_vs_training_mode_texts),
			es325_vs_training_mode_texts);

static const char * const es325_vs_auto_mode_texts[] = {
	"Do Nothing", "Detect builtin", "Detect uesr authentication",
	"Train user authentication"
};

static const struct soc_enum es325_vs_auto_mode_enum =
	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0,
	ARRAY_SIZE(es325_vs_auto_mode_texts),
	es325_vs_auto_mode_texts);


static struct wake_lock  es325_VS_lock;
static irqreturn_t es325_irq_work(int irq, void *irq_data)
{
	int ret = 0;
	struct es325_priv *es325 = (struct es325_priv *)irq_data;
	struct slim_device *sbdev = es325->gen0_client;
	pr_err("[ES325]=%s in******************* irq =%d\n", __func__,irq);
       if (es325_power_state != ES325_POWER_STATE_VS)
            return IRQ_HANDLED;
	mutex_lock(&es325->api_mutex);
	if (es325->mode == SBL)
		dev_dbg(&sbdev->dev, "%s(): current mode : SBL\n",
			__func__);
	else if (es325->mode == STANDARD)
		dev_dbg(&sbdev->dev, "%s(): current mode : STANDARD\n",
			__func__);
	else if (es325->mode == VOICESENSE) {
		dev_dbg(&sbdev->dev, "%s(): current mode : VOICESENSE\n",
			__func__);
		/* Get VS detection status. Reset Interrupt */
           	need_report_hw_bug = 1;//Richard 2014.2.20

		ret = es325_vs_status(es325);
		if (ret < 0) {
			dev_dbg(&sbdev->dev, "%s(): VS Detection Intr. Wrong status\n",
				__func__);
                    	{  //if (detected_hw_bug){//Richard 2014.2.20//Richard 2014.4.23
			    u32 sync_ok=0x80000003;
			    int rc;
			    rc = es325_slim_write_then_read(es325, &sync_ok,
				sizeof(sync_ok), &sync_ok, 1, 0);
			    pr_info("sync after hw error reported rc=%d\n", rc);
			    if (rc){//Really error, reset and redownload vs firmware 
			        es325_power_state= ES325_POWER_STATE_VS_DOWNLOADING;//by Richard abort
			        //ret = es325_vs_power_state(1);
			        kthread_run( es325_vs_download_thread, &es325_priv, "vs thread");
			    }else{
                              pr_info("sync after hw error reported2 rc=%d\n", rc);
                          }
			}

		} else {
			es325->vs_get_event = KW_DETECTED;//Richard 11.23
			/* Generate UEvent to User space. */
			wake_lock_timeout(&es325_VS_lock,3*HZ);
			kobject_uevent(&sbdev->dev.kobj, KOBJ_CHANGE);
			dev_info(&sbdev->dev, "%s():VS Detection Intr. Detected Report the irq Uevent\n",
				__func__);
		}
               need_report_hw_bug = 0;//Richard 2014.2.20
	}


	mutex_unlock(&es325->api_mutex);
	return IRQ_HANDLED;
}

#endif

/* Maximum number of attempts to read a VE in the presence of a "not
 * ready" response. */
#define ES325_RD_POLL_MAX 30
/* Interval between attemps to read a VE in milliseconds. */
#define ES325_RD_POLL_INTV 5

//Richard 11.19
static int es325_write_block_api(struct es325_priv *es325, u8 *cmd_blk)//Richard 11.19
{
	int rc = 0;
	int need_read=0;
	mutex_lock(&es325->api_mutex);//Richard 11.26a
	while (*cmd_blk != 0xff) {
		u8 msg[4];
		memcpy(msg, cmd_blk, 4);
		pr_info("%s(): msg = %02x%02x%02x%02x\n", __func__,
			msg[0], msg[1], msg[2], msg[3]);
		if (msg[0]&0x10)
			need_read=0;
		else
			need_read=1;
		es325_slim_write(es325, ES325_WRITE_VE_OFFSET,
			ES325_WRITE_VE_WIDTH, msg, 4, 1);
		if (need_read){
			memset(msg, 0, 4);
			rc = ES325_BUS_READ(es325, ES325_READ_VE_OFFSET, ES325_READ_VE_WIDTH,
				msg, 4, 1);
			pr_info("%s(): read msg = %02x%02x%02x%02x\n", __func__,
				msg[0], msg[1], msg[2], msg[3]);
		}
		cmd_blk += 4;
	}
	msleep(20);
	mutex_unlock(&es325->api_mutex);//Richard 11.26a
	return rc;
}


static int es325_write_block_len(struct es325_priv *es325, u8 *cmd_blk,
				 unsigned int len)
{
	int rc = 0;
	pr_info("GAC:%s(len = %d); entry\n", __func__, len);
	while (len > 0) {
		u8 msg[4];
		memcpy(msg, cmd_blk, 4);
		es325_slim_write(es325, ES325_WRITE_VE_OFFSET,
				 ES325_WRITE_VE_WIDTH, msg, 4, 1);
		pr_info("%s(): msg = %02x%02x%02x%02x\n", __func__,
			msg[0], msg[1], msg[2], msg[3]);
		cmd_blk += 4;
		len -= 4;
		usleep_range(5000, 5000);
	}

	return rc;
}

static int es325_write_data_block_cmd(struct es325_priv *es325, u8 *cmd_blk)
{
	int rc = 0;
	u16 len;
	u8 msg[4];
	u8 ack_msg[4];

	pr_info("GAC:%s(); entry\n", __func__);
	if (*cmd_blk == 0xff) {
		pr_err("%s(): empty block\n", __func__);
		return -EINVAL;
	}

	memcpy(msg, cmd_blk, 4);
	memcpy((char *)&len, cmd_blk + 2, 2);
	len = be16_to_cpu(len);
	pr_info("GAC:%s(); len = 0x%04x\n", __func__, len);
	es325_slim_write(es325, ES325_WRITE_VE_OFFSET,
			 ES325_WRITE_VE_WIDTH, msg, 4, 1);
	usleep_range(10000, 10000);
	es325_slim_read(es325, ES325_READ_VE_OFFSET,
			ES325_READ_VE_WIDTH, ack_msg, 4, 1);
	if (memcmp(ack_msg, cmd_blk, 4) != 0) {
		pr_err("%s(): ack failed = 0x%02x%02x%02x%02x\n",
		       __func__, ack_msg[0], ack_msg[1], ack_msg[2],
		       ack_msg[3]);
		return -EIO;
	}
	cmd_blk += 4;

	es325_write_block_len(es325, cmd_blk, len);

	usleep_range(10000, 10000);

	es325_slim_read(es325, ES325_READ_VE_OFFSET,
			ES325_READ_VE_WIDTH, ack_msg, 4, 1);
	pr_info("%s(): ack = 0x%02x%02x%02x%02x\n",
		__func__, ack_msg[0], ack_msg[1], ack_msg[2],ack_msg[3]);
	switch (ack_msg[3]) {
	case 0x00:
		rc = 0;
		break;
	case 0x02:
		rc = -EINVAL;
		pr_err("%s(): write data block - destination error\n",
		       __func__);
		break;
	case 0x03:
		rc = -EINVAL;
		pr_err("%s(): write data block - version error\n",
		       __func__);
		break;
	case 0x04:
		rc = -EINVAL;
		pr_err("%s(): write data block - type error\n",
		       __func__);
		break;
	case 0x06:
		rc = -EINVAL;
		pr_err("%s(): write data block - length error\n",
		       __func__);
		break;
	case 0x0e:
		rc = -EINVAL;
		pr_err("%s(): write data block - checksum error\n",
		       __func__);
		break;
	default:
		rc = -EINVAL;
		pr_err("%s(): write data block - invalid ack\n",
		       __func__);
		break;
	}

	return rc;
}

#if defined(CONFIG_SND_SOC_ES325_I2C)
static int es325_i2c_read(struct es325_priv *es325, char *buf, int len)
{
	struct i2c_msg msg[] = {
		{
			.addr = es325->this_client->addr,
			.flags = I2C_M_RD,
			.len = len,
			.buf = buf,
		},
	};
	int rc = 0;

	pr_info("%s(): entry\n", __func__);

	return rc;
}

static int es325_i2c_write(struct es325_priv *es325, char *buf, int len)
{
	struct i2c_msg msg[] = {
		{
			.addr = es325->this_client->addr,
			.flags = 0,
			.len = len,
			.buf = buf,
		},
	};
	int rc = 0;

	return rc;
}
#else
static int es325_slim_read(struct es325_priv *es325, unsigned int offset,
			   unsigned int width, char *buf, int len,
			   int bus_order)
{
	char notready[] = { 0, 0, 0, 0 };
	struct slim_device *sbdev = es325->gen0_client;
	DECLARE_COMPLETION_ONSTACK(read_done);
	struct slim_ele_access msg = {
		.start_offset = offset,
		.num_bytes = width,
		/* .comp = &read_done, */
		.comp = NULL,
	};
	int rc = 0;
	int try = 0;

	for (try = 0; try < ES325_RD_POLL_MAX; try++) {
		rc = slim_request_val_element(sbdev, &msg, buf, len);
		if (rc != 0)
			break;
		if (memcmp(buf, notready, 4) != 0)
			break;
		msleep(ES325_RD_POLL_INTV);
	}
	if (try >= ES325_RD_POLL_MAX && memcmp(buf, notready, 4) == 0) {
		pr_err("%s: failed not ready after %d tries\n", __func__, try);
		rc = -EIO;
	}

	if (bus_order)
		msg_to_bus_order(buf, len);
	if (rc != 0)
		pr_err("%s: read failed rc=%d\n", __func__, rc);

	return rc;
}

static int es325_slim_write(struct es325_priv *es325, unsigned int offset,
			    unsigned int width, char *buf, int len, int bus_order)
{
	struct slim_device *sbdev = es325->gen0_client;
	struct slim_ele_access msg = {
		.start_offset = offset,
		.num_bytes = width,
		.comp = NULL,
	};
	int rc = 0;

	if (bus_order)
		msg_to_bus_order(buf, len);

	rc = slim_change_val_element(sbdev, &msg, buf, len);

	return rc;
}
#endif

static int es325_build_algo_read_msg(char *msg, int *msg_len,
				     unsigned int reg)
{
	unsigned int index = reg & ES325_ADDR_MASK;
	unsigned int paramid;

	if (index > ARRAY_SIZE(es325_algo_paramid))
		return -EINVAL;

	paramid = es325_algo_paramid[index];

	/* ES325_GET_ALGO_PARAM */
	*msg++ = (ES325_GET_ALGO_PARAM >> 8) & 0x00ff;
	*msg++ = ES325_GET_ALGO_PARAM & 0x00ff;

	/* PARAM ID */
	*msg++ = (paramid >> 8) & 0x00ff;
	*msg++ = paramid & 0x00ff;
	*msg_len = 4;

	return 0;
}

static int es325_build_algo_write_msg(char *msg, int *msg_len,
				      unsigned int reg, unsigned int value)
{
	unsigned int index = reg & ES325_ADDR_MASK;
	unsigned int cmd;
	unsigned int paramid;

	if (index > ARRAY_SIZE(es325_algo_paramid))
		return -EINVAL;

	paramid = es325_algo_paramid[index];

	/* ES325_SET_ALGO_PARAMID */
	cmd = ES325_SET_ALGO_PARAMID;
	if (reg & ES325_STAGED_CMD)
		cmd |= ES325_STAGED_MSG_BIT;
	*msg++ = (cmd >> 8) & 0x00ff;
	*msg++ = cmd & 0x00ff;

	/* PARAM ID */
	*msg++ = (paramid >> 8) & 0x00ff;
	*msg++ = paramid & 0x00ff;

	/* ES325_SET_ALGO_PARAM */
	cmd = ES325_SET_ALGO_PARAM;
	if (reg & ES325_STAGED_CMD)
		cmd |= ES325_STAGED_MSG_BIT;
	*msg++ = (cmd >> 8) & 0x00ff;
	*msg++ = cmd & 0x00ff;

	/* value */
	*msg++ = (value >> 8) & 0x00ff;
	*msg++ = value & 0x00ff;
	*msg_len = 8;

	return 0;
}

static int es325_build_dev_read_msg(char *msg, int *msg_len,
				    unsigned int reg)
{
	unsigned int index = reg & ES325_ADDR_MASK;
	unsigned int paramid;

	if (index > ARRAY_SIZE(es325_dev_paramid))
		return -EINVAL;

	paramid = es325_dev_paramid[index];

	/* ES325_GET_DEV_PARAM */
	*msg++ = (ES325_GET_DEV_PARAM >> 8) & 0x00ff;
	*msg++ = ES325_GET_DEV_PARAM & 0x00ff;

	/* PARAM ID */
	*msg++ = (paramid >> 8) & 0x00ff;
	*msg++ = paramid & 0x00ff;
	*msg_len = 4;

	return 0;
}

static int es325_build_dev_write_msg(char *msg, int *msg_len,
				     unsigned int reg, unsigned int value)
{
	unsigned int index = reg & ES325_ADDR_MASK;
	unsigned int cmd;
	unsigned int paramid;

	if (index > ARRAY_SIZE(es325_dev_paramid))
		return -EINVAL;

	paramid = es325_dev_paramid[index];

	/* ES325_SET_DEV_PARAMID */
	cmd = ES325_SET_DEV_PARAMID;
	if (reg & ES325_STAGED_CMD)
		cmd |= ES325_STAGED_MSG_BIT;
	*msg++ = (cmd >> 8) & 0x00ff;
	*msg++ = cmd & 0x00ff;

	/* PARAM ID */
	*msg++ = (paramid >> 8) & 0x00ff;
	*msg++ = paramid & 0x00ff;

	/* ES325_SET_DEV_PARAM */
	cmd = ES325_SET_DEV_PARAM;
	if (reg & ES325_STAGED_CMD)
		cmd |= ES325_STAGED_MSG_BIT;
	*msg++ = (cmd >> 8) & 0x00ff;
	*msg++ = cmd & 0x00ff;

	/* value */
	*msg++ = (value >> 8) & 0x00ff;
	*msg++ = value & 0x00ff;
	*msg_len = 8;

	return 0;
}

static int es325_build_cmd_read_msg(char *msg, int *msg_len,
				    unsigned int reg)
{
	unsigned int index = reg & ES325_ADDR_MASK;
	struct es325_cmd_access *cmd_access;

	if (index > ARRAY_SIZE(es325_cmd_access))
		return -EINVAL;
	cmd_access = es325_cmd_access + index;

	*msg_len = cmd_access->read_msg_len;
	memcpy(msg, &cmd_access->read_msg, *msg_len);

	return 0;
}

static int es325_build_cmd_write_msg(char *msg, int *msg_len,
				     unsigned int reg, unsigned int value)
{
	unsigned int index = reg & ES325_ADDR_MASK;
	struct es325_cmd_access *cmd_access;

	if (index > ARRAY_SIZE(es325_cmd_access))
		return -EINVAL;
	cmd_access = es325_cmd_access + index;

	*msg_len = cmd_access->write_msg_len;
	memcpy(msg, &cmd_access->write_msg, *msg_len);
	if (reg & ES325_STAGED_CMD)
		*msg |= (1 << 5);

#ifdef VOICE_SENSE
	/* add value */
	msg[*msg_len - 2] = (value >> 8) & 0x00ff;
	msg[*msg_len - 1] = value & 0x00ff;
#endif
	return 0;
}

static int es325_build_preset_write_msg(char *msg, int *msg_len,
				     unsigned int reg, unsigned int value)
{
	unsigned int index = reg & ES325_ADDR_MASK;
	struct es325_cmd_access *cmd_access;

	if (index > ARRAY_SIZE(es325_cmd_access))
		return -EINVAL;
	cmd_access = es325_cmd_access + index;

	*msg_len = cmd_access->write_msg_len;
	memcpy(msg, &cmd_access->write_msg, *msg_len);
	if (reg & ES325_STAGED_CMD)
		*msg |= (1 << 5);

	msg[2] = (value >> 8) & 0xFF;
	msg[3] = value & 0xFF;
	return 0;
}

static int current_gain_item=0;
static int es325_build_digital_item_read_msg(char *msg, int *msg_len,
						 unsigned int reg, unsigned int value)
	{
		unsigned int index = reg & ES325_ADDR_MASK;
		struct es325_cmd_access *cmd_access;
	
		if (index > ARRAY_SIZE(es325_cmd_access))
			return -EINVAL;
		cmd_access = es325_cmd_access + index;
	
		*msg_len = cmd_access->read_msg_len;
		memcpy(msg, &cmd_access->read_msg, *msg_len);
		if (reg & ES325_STAGED_CMD)
			*msg |= (1 << 5);
	
		msg[3] = current_gain_item & 0xFF;
		return 0;
	}



static unsigned int es325_read(struct snd_soc_codec *codec,
			       unsigned int reg)
{
	struct es325_priv *es325 = &es325_priv;
	unsigned int access = reg & ES325_ACCESS_MASK;
	char req_msg[16];
	char ack_msg[16];
	unsigned int msg_len;
	unsigned int value;
	int rc;

	switch (access) {
	case ES325_ALGO_ACCESS:
		rc = es325_build_algo_read_msg(req_msg, &msg_len, reg);
		break;
	case ES325_DEV_ACCESS:
		rc = es325_build_dev_read_msg(req_msg, &msg_len, reg);
		break;
	case ES325_CMD_ACCESS:
		rc = es325_build_cmd_read_msg(req_msg, &msg_len, reg);
		break;
	case ES325_OTHER_ACCESS:
		return 0;
	default:
		rc = -EINVAL;
		break;
	}
	if (rc) {
		pr_err("%s(): failed to build read message for address = 0x%04x\n",
			__func__, reg);
		return rc;
	}

	pr_info("%s(): write msg[0] = 0x%02x\n", __func__, req_msg[0]);
	pr_info("%s(): write msg[1] = 0x%02x\n", __func__, req_msg[1]);
	pr_info("%s(): write msg[2] = 0x%02x\n", __func__, req_msg[2]);
	pr_info("%s(): write msg[3] = 0x%02x\n", __func__, req_msg[3]);
		

	rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
			     ES325_WRITE_VE_WIDTH, req_msg, msg_len, 1);
	if (rc < 0) {
		pr_err("%s(): es325_xxxx_write()", __func__);
		return rc;
	}
	msleep(20);
	rc = ES325_BUS_READ(es325, ES325_READ_VE_OFFSET,
			    ES325_READ_VE_WIDTH, ack_msg, 4, 1);
	if (rc < 0) {
		pr_err("%s(): es325_xxxx_read()", __func__);
		return rc;
	}

	pr_info("%s(): read msg[0] = 0x%02x\n", __func__, ack_msg[0]);
	pr_info("%s(): read msg[1] = 0x%02x\n", __func__, ack_msg[1]);
	pr_info("%s(): read msg[2] = 0x%02x\n", __func__, ack_msg[2]);
	pr_info("%s(): read msg[3] = 0x%02x\n", __func__, ack_msg[3]);
	
	value = ack_msg[2] << 8 | ack_msg[3];

	return value;
}

static int es325_write(struct snd_soc_codec *codec, unsigned int reg,
		       unsigned int value)
{
	struct es325_priv *es325 = &es325_priv;
	unsigned int access = reg & ES325_ACCESS_MASK;
	char msg[16];
	char *msg_ptr;
	int msg_len;
	int i;
	int rc;

	switch (access) {
	case ES325_ALGO_ACCESS:
		rc = es325_build_algo_write_msg(msg, &msg_len, reg, value);
		break;
	case ES325_DEV_ACCESS:
		rc = es325_build_dev_write_msg(msg, &msg_len, reg, value);
		break;
	case ES325_CMD_ACCESS:
		rc = es325_build_cmd_write_msg(msg, &msg_len, reg, value);
		break;
	case ES325_OTHER_ACCESS:
		return 0;
	default:
		rc = -EINVAL;
		break;
	}
	if (rc) {
		pr_err("%s(): failed to build write message for address = 0x%04x\n",
			__func__, reg);
		return rc;
	}

	msg_ptr = msg;
	for (i = 0; i < msg_len; i++)
	{
		pr_info("%s(): write msg[%d] = 0x%02x\n", __func__,i, msg[i]);
	}

	for (i = msg_len; i > 0; i -= 4) {
		rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
				     ES325_WRITE_VE_WIDTH, msg_ptr, 4, 1);
		if (rc < 0) {
			pr_err("%s(): es325_xxxx_write()", __func__);
			return rc;
		}
		msleep(20);
		rc = ES325_BUS_READ(es325, ES325_READ_VE_OFFSET,
				    ES325_READ_VE_WIDTH, msg_ptr, 4, 1);
		if (rc < 0) {
			pr_err("%s(): es325_xxxx_read()", __func__);
			return rc;
		}
		msg_ptr += 4;
	}
	return rc;
}

#define VERIDIAN 1
static ssize_t es325_route_status_show(struct device *dev,
				       struct device_attribute *attr,
				       char *buf)
{
	int i = 0;
	int name_id = 0;
	ssize_t ret = 0;
	struct es325_priv *es325 = &es325_priv;
	char *status_name[] = {
		"Route Status",
#if VERIDIAN
		"Rx ChnMgr[16] Run State",
		"Rx ChnMgr[17] Run State",
		"Rx ChnMgr[18] Run State",
		"Rx ChnMgr[19] Run State",
		"Rx ChnMgr[20] Run State",
		"Rx ChnMgr[21] Run State",
		"Rx ChnMgr[22] Run State",
		"Rx ChnMgr[23] Run State",
		"Rx ChnMgr[24] Run State",
		"Rx ChnMgr[25] Run State",
		"Tx ChnMgr[26] Run State",
		"Tx ChnMgr[27] Run State",
		"Tx ChnMgr[28] Run State",
		"Tx ChnMgr[29] Run State",
		"Tx ChnMgr[30] Run State",
		"Tx ChnMgr[31] Run State",
#else
		"Rx Stream Mgr[32] Run State",
		"Rx Stream Mgr[33] Run State",
		"Rx Stream Mgr[34] Run State",
		"Rx Stream Mgr[35] Run State",
		"Rx Stream Mgr[36] Run State",
		"Rx Stream Mgr[37] Run State",
		"Rx Stream Mgr[38] Run State",
		"Rx Stream Mgr[39] Run State",
		"Rx Stream Mgr[40] Run State",
		"Rx Stream Mgr[41] Run State",
		"Tx Stream Mgr[42] Run State",
		"Tx Stream Mgr[43] Run State",
		"Tx Stream Mgr[44] Run State",
		"Tx Stream Mgr[45] Run State",
		"Tx Stream Mgr[46] Run State",
		"Tx Stream Mgr[47] Run State",
		"Rx ChnMgr[16] Run State",
		"Rx ChnMgr[16] Path Id",
		"Rx ChnMgr[17] Run State",
		"Rx ChnMgr[17] Path Id",
		"Rx ChnMgr[18] Run State",
		"Rx ChnMgr[18] Path Id",
		"Rx ChnMgr[19] Run State",
		"Rx ChnMgr[19] Path Id",
		"Rx ChnMgr[20] Run State",
		"Rx ChnMgr[20] Path Id",
		"Rx ChnMgr[21] Run State",
		"Rx ChnMgr[21] Path Id",
		"Rx ChnMgr[22] Run State",
		"Rx ChnMgr[22] Path Id",
		"Rx ChnMgr[23] Run State",
		"Rx ChnMgr[23] Path Id",
		"Rx ChnMgr[24] Run State",
		"Rx ChnMgr[24] Path Id",
		"Rx ChnMgr[25] Run State",
		"Rx ChnMgr[25] Path Id",
		"Tx ChnMgr[26] Run State",
		"Tx ChnMgr[26] Path Id",
		"Tx ChnMgr[27] Run State",
		"Tx ChnMgr[27] Path Id",
		"Tx ChnMgr[28] Run State",
		"Tx ChnMgr[28] Path Id",
		"Tx ChnMgr[29] Run State",
		"Tx ChnMgr[29] Path Id",
		"Tx ChnMgr[30] Run State",
		"Tx ChnMgr[30] Path Id",
		"Tx ChnMgr[31] Run State",
		"Tx ChnMgr[31] Path Id",
		"Rx ChnMgr[16] Num Packs",
		"Rx ChnMgr[17] Num Packs",
		"Rx ChnMgr[18] Num Packs",
		"Rx ChnMgr[19] Num Packs",
		"Rx ChnMgr[20] Num Packs",
		"Rx ChnMgr[21] Num Packs",
		"Rx ChnMgr[22] Num Packs",
		"Rx ChnMgr[23] Num Packs",
		"Rx ChnMgr[24] Num Packs",
		"Rx ChnMgr[25] Num Packs",
		"Rx ChnMgr[26] Num Packs",
		"Rx ChnMgr[27] Num Packs",
		"Rx ChnMgr[28] Num Packs",
		"Rx ChnMgr[29] Num Packs",
		"Rx ChnMgr[30] Num Packs",
		"Rx ChnMgr[31] Num Packs",
#endif
	};
	u8 req_msg[] = {
		/* 0x80, 0x00, 0x00, 0x00, */
		/* Route Status */
		0x80, 0x4f, 0x00, 0x00,
		0xff,

#if VERIDIAN
		/* Rx ChnMgr[16] Run State */
		0x90, 0x73, 0x20, 0x06,
		0x90, 0x72, 0x51, 0xfc,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[17] Run State */
		0x90, 0x72, 0x53, 0x2c,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[18] Run State */
		0x90, 0x72, 0x54, 0x5c,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[19] Run State */
		0x90, 0x72, 0x55, 0x8c,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[20] Run State */
		0x90, 0x72, 0x56, 0xbc,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[21] Run State */
		0x90, 0x72, 0x57, 0xec,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[22] Run State */
		0x90, 0x72, 0x59, 0x1c,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[23] Run State */
		0x90, 0x72, 0x5a, 0x4c,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[24] Run State */
		0x90, 0x72, 0x5b, 0x7c,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[25] Run State */
		0x90, 0x72, 0x5c, 0xac,
		0x80, 0x75, 0x00, 0x00,
		0xff,

		/* Tx ChnMgr[26] Run State */
		0x90, 0x72, 0x5d, 0xdc,
		0x80, 0x75, 0x00, 0x00,
		0xff,

		/* -----SK---- updated for build 16204 - few address bits */
		/* Tx ChnMgr[27] Run State */
		0x90, 0x72, 0x5f, 0x10,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[28] Run State */
		0x90, 0x72, 0x60, 0x44,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[29] Run State */
		0x90, 0x72, 0x61, 0x78,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[30] Run State */
		0x90, 0x72, 0x62, 0xac,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[31] Run State */
		0x90, 0x72, 0x63, 0xe0,
		0x80, 0x75, 0x00, 0x00,
		0xff,
#else
		/* Rx Stream Mgr[32] Run State */
		0x90, 0x73, 0x20, 0x06,
		0x90, 0x72, 0x03, 0xe0,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx Stream Mgr[33] Run State */
		0x90, 0x72, 0x04, 0xd8,
		0x80, 0x75, 0x00, 0x00,
		0xff,

		/* Rx Stream Mgr[34] Run State */
		0x90, 0x72, 0x05, 0xd0,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx Stream Mgr[35] Run State */
		0x90, 0x72, 0x06, 0xc8,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx Stream Mgr[36] Run State */
		0x90, 0x72, 0x07, 0xc0,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx Stream Mgr[37] Run State */
		0x90, 0x72, 0x08, 0xb8,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx Stream Mgr[38] Run State */
		0x90, 0x72, 0x09, 0xb0,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx Stream Mgr[39] Run State */
		0x90, 0x72, 0x0a, 0xa8,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx Stream Mgr[40] Run State */
		0x90, 0x72, 0x0b, 0xa0,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx Stream Mgr[41] Run State */
		0x90, 0x72, 0x0c, 0x98,
		0x80, 0x75, 0x00, 0x00,
		0xff,

		/* Tx Stream Mgr[42] Run State */
		0x90, 0x72, 0x0d, 0x90,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx Stream Mgr[43] Run State */
		0x90, 0x72, 0x0e, 0x88,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx Stream Mgr[44] Run State */
		0x90, 0x72, 0x0f, 0x80,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx Stream Mgr[45] Run State */
		0x90, 0x72, 0x10, 0x78,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx Stream Mgr[46] Run State */
		0x90, 0x72, 0x11, 0x70,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx Stream Mgr[47] Run State */
		0x90, 0x72, 0x12, 0x68,
		0x80, 0x75, 0x00, 0x00,
		0xff,

		/* Rx ChnMgr[16] Run State */
		0x90, 0x73, 0x20, 0x05,
		0x90, 0x72, 0xf2, 0x00,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[16] Path Id */
		0x90, 0x72, 0xf2, 0x04,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[17] Run State */
		0x90, 0x72, 0xf3, 0x20,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[17] Path Id */
		0x90, 0x72, 0xf3, 0x24,
		0x80, 0x75, 0x00, 0x00,
		0xff,

		/* Rx ChnMgr[18] Run State */
		0x90, 0x72, 0xf4, 0x40,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[18] Path Id */
		0x90, 0x72, 0xf4, 0x44,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[19] Run State */
		0x90, 0x72, 0xf5, 0x60,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[19] Path Id */
		0x90, 0x72, 0xf5, 0x64,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[20] Run State */
		0x90, 0x72, 0xf6, 0x80,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[20] Path Id */
		0x90, 0x72, 0xf6, 0x84,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[21] Run State */
		0x90, 0x72, 0xf7, 0xa0,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[21] Path Id */
		0x90, 0x72, 0xf7, 0xa4,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[22] Run State */
		0x90, 0x72, 0xf8, 0xc0,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[22] Path Id */
		0x90, 0x72, 0xf8, 0xc4,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[23] Run State */
		0x90, 0x72, 0xf9, 0xe0,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[23] Path Id */
		0x90, 0x72, 0xf9, 0xe4,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[24] Run State */
		0x90, 0x72, 0xfb, 0x00,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[24] Path Id */
		0x90, 0x72, 0xfb, 0x04,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[25] Run State */
		0x90, 0x72, 0xfc, 0x20,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[25] Path Id */
		0x90, 0x72, 0xfc, 0x24,
		0x80, 0x75, 0x00, 0x00,
		0xff,

		/* Tx ChnMgr[26] Run State */
		0x90, 0x72, 0xfd, 0x40,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[26] Path Id */
		0x90, 0x72, 0xfd, 0x44,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[27] Run State */
		0x90, 0x72, 0xfe, 0x68,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[27] Path Id */
		0x90, 0x72, 0xfe, 0x6c,
		0x80, 0x75, 0x00, 0x00,
		0xff,

		/* Tx ChnMgr[28] Run State */
		0x90, 0x72, 0xff, 0x90,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[28] Path Id */
		0x90, 0x72, 0xff, 0x94,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[29] Run State */
		0x90, 0x73, 0x20, 0x06,
		0x90, 0x72, 0x00, 0xb8,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[29] Path Id */
		0x90, 0x72, 0x00, 0xbc,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[30] Run State */
		0x90, 0x72, 0x01, 0xe0,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[30] Path Id */
		0x90, 0x72, 0x01, 0xe4,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[31] Run State */
		0x90, 0x72, 0x03, 0x08,
		0x80, 0x75, 0x00, 0x00,
		0xff,
		/* Tx ChnMgr[31] Path Id */
		0x90, 0x72, 0x03, 0x0c,
		0x80, 0x75, 0x00, 0x00,
		0xff,


		/* Rx ChnMgr[16] Num Packs */
		0x90, 0x73, 0x20, 0x05,
		0x90, 0x72, 0xf1, 0xb8,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[17] Num Packs */
		0x90, 0x72, 0xf2, 0xd8,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[18] Num Packs */
		0x90, 0x72, 0xf3, 0xf8,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[19] Num Packs */
		0x90, 0x72, 0xf5, 0x18,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[20] Num Packs */
		0x90, 0x72, 0xf6, 0x38,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[21] Num Packs */
		0x90, 0x72, 0xf7, 0x58,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[22] Num Packs */
		0x90, 0x72, 0xf8, 0x78,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[23] Num Packs */
		0x90, 0x72, 0xf9, 0x98,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[24] Num Packs */
		0x90, 0x72, 0xfa, 0xb8,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[25] Num Packs */
		0x90, 0x72, 0xfb, 0xd8,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[26] Num Packs */
		0x90, 0x72, 0xfc, 0xf8,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[27] Num Packs */
		0x90, 0x72, 0xfe, 0x20,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[28] Num Packs */
		0x90, 0x72, 0xff, 0x48,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[29] Num Packs */
		0x90, 0x73, 0x20, 0x06,
		0x90, 0x72, 0x00, 0x70,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[30] Num Packs */
		0x90, 0x72, 0x01, 0x98,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
		/* Rx ChnMgr[31] Num Packs */
		0x90, 0x72, 0x02, 0xc0,
/*	0x80, 0x75, 0x00, 0x00, */
		0x80, 0x74, 0x00, 0x00,
		0xff,
#endif
		0xff
	};

	while (*(req_msg + i) != 0xff) {
		u8 ack_msg[4] = {
			0x00, 0x00, 0x00, 0x00,
		};

		while (*(req_msg+i) != 0xff) {
			es325_slim_write(es325, ES325_WRITE_VE_OFFSET,
					 ES325_WRITE_VE_WIDTH, req_msg+i, 4, 1);
			i = i + 4;
		}
		msleep(20);

		es325_slim_read(es325, ES325_READ_VE_OFFSET,
				ES325_READ_VE_WIDTH, ack_msg, 4, 1);

		pr_info("GAC:%s(): ping ack = %02x%02x%02x%02x\n", __func__,
			ack_msg[0], ack_msg[1], ack_msg[2], ack_msg[3]);

		ret = ret + snprintf(buf+ret, PAGE_SIZE - ret,
				     "%s=0x%02x%02x%02x%02x\n",
				     status_name[name_id],
				     ack_msg[0], ack_msg[1],
				     ack_msg[2], ack_msg[3]);
		i++;
		name_id++;
	}
	return ret;
}
static DEVICE_ATTR(route_status, 0644, es325_route_status_show, NULL);
/* /sys/bus/slimbus/devices/es325-codec-gen0/route_status */

static ssize_t es325_route_config_show(struct device *dev,
				       struct device_attribute *attr,
				       char *buf)
{
	pr_info("GAC:%s(): route=%ld\n", __func__,
		es325_internal_route_num);
	return snprintf(buf, PAGE_SIZE, "route=%ld\n",
		       es325_internal_route_num);
}

static void es325_switch_route(long route_index)
{
	struct es325_priv *es325 = &es325_priv;
	int ret;

	if (route_index > ES325_INTERNAL_ROUTE_MAX) {
		pr_info("%s(): new es325_internal_route = %ld is out of range\n",
			__func__, route_index);
		return;
	}

	pr_info("GAC:%s():**switch current es325_internal_route = %ld to new route = %ld\n",
		__func__, es325_internal_route_num, route_index);
	es325_internal_route_num = route_index;
	ret = es325_write_block_api(es325,
		&es325_internal_route_configs[es325_internal_route_num][0]);
}

static ssize_t es325_route_config_set(struct device *dev,
				      struct device_attribute *attr,
				      const char *buf, size_t count)
{
	long route_index;
	int rc;

	pr_info("GAC:%s():buf = %s\n", __func__, buf);
	rc = kstrtol(buf, 10, &route_index);
	es325_switch_route(route_index);
	return count;
}

static DEVICE_ATTR(route_config, 0644, es325_route_config_show,
		   es325_route_config_set);
/* /sys/bus/slimbus/devices/es325-codec-gen0/route_config */


static long esxxx_clk_enable=0;
static ssize_t esxxx_test_show(struct device *dev,
				       struct device_attribute *attr,
				       char *buf)
{
	pr_info("GAC:%s(): route=%ld\n", __func__,
		esxxx_clk_enable);
	return snprintf(buf, PAGE_SIZE, "clk=%ld\n",
		       esxxx_clk_enable);
}

static ssize_t esxxx_test_set(struct device *dev,
				      struct device_attribute *attr,
				      const char *buf, size_t count)
{
	int rc;

	pr_info("GAC:%s():buf = %s\n", __func__, buf);
	rc = kstrtol(buf, 10, &esxxx_clk_enable);
	es325_clk_ctl(esxxx_clk_enable);
	return count;
}
static DEVICE_ATTR(esxxx_test, 0644, esxxx_test_show,
		   esxxx_test_set);

#ifdef ABORT_TEST//Richard 11.23
static ssize_t es325_abort_sec_set(struct device *dev,
				      struct device_attribute *attr,
				      const char *buf, size_t count)
{
	long sec_index;
	int rc;

	pr_err("GAC:%s():buf = %s\n", __func__, buf);
	dev_dbg(dev, "%s(): buf = %s\n", __func__, buf);
	rc = kstrtol(buf, 10, &sec_index);
	g_sec_to_abort = sec_index;
	return count;
}

static DEVICE_ATTR(abort_sec, 0644, NULL,
		   es325_abort_sec_set);
/* /sys/bus/slimbus/devices/es325-codec-gen0/abort_sec */
#endif

static u8 resp[4];
static ssize_t es325_txhex_show(struct device *dev,
				struct device_attribute *attr,
				char *buf)
{
	pr_info("%s called\n", __func__);

	
	pr_info("%s: %02x%02x%02x%02x\n", __func__, resp[0], resp[1], resp[2], resp[3]);
	return snprintf(buf, PAGE_SIZE, "%02x%02x%02x%02x\n",	resp[0], resp[1], resp[2], resp[3] );
}

static ssize_t es325_txhex_set(struct device *dev,
			       struct device_attribute *attr,
			       const char *buf, size_t count)
{
	struct es325_priv *es325 = &es325_priv;
	u8 cmd[128];
	int cmdlen;
	int offset;
	//u8 resp[4];
	int rc = 0;

	pr_info("%s called\n", __func__);
	pr_info("%s count=%i\n", __func__, count);

	/* No command sequences larger than 128 bytes. */
	BUG_ON(count > (128 * 2) + 1);
	/* Expect a even number of hexadecimal digits terminated by a
	 * newline. */
	BUG_ON(!(count & 1));

	rc = hex2bin(cmd, buf, count / 2);
	BUG_ON(rc != 0);
	pr_info("%s rc==%i\n", __func__, rc);
	cmdlen = count / 2;
	offset = 0;
	pr_info("%s cmdlen=%i\n", __func__, cmdlen);
	while (offset < cmdlen) {
		/* Commands must be written in 4 byte blocks. */
		int wrsize = (cmdlen - offset > 4) ? 4 : cmdlen - offset;
		es325_slim_write(es325, ES325_WRITE_VE_OFFSET,
				 ES325_WRITE_VE_WIDTH, &cmd[offset], wrsize, 1);

		usleep_range(10000, 10000);
		es325_slim_read(es325, ES325_READ_VE_OFFSET,
				ES325_READ_VE_WIDTH, resp, 4, 1);
		pr_info("%s read: %02x%02x%02x%02x\n", __func__, resp[0], resp[1], resp[2], resp[3]);

		offset += wrsize;
	}

	return count;
}

static DEVICE_ATTR(txhex, 0644, es325_txhex_show, es325_txhex_set);

#define ES325_FW_LOAD_BUF_SZ 4
static int es325_bootup(struct es325_priv *es325)
{
	static char sync_ok[] = { 0x80, 0, 0, 0 };
	char msg[16];
#ifndef CONFIG_SND_SOC_ES325_UART	// wangtao  boot download use uart 
	unsigned int buf_frames;
	char *buf_ptr;
#endif
	int rc;
	pr_info("%s(): entry\n", __func__);

	gpio_set_value(es325->pdata->reset_gpio, 0); 
	mdelay(1); 
	gpio_set_value(es325->pdata->reset_gpio, 1); 
	
	//msleep(500); //wait for uart stable 
#ifdef CONFIG_SND_SOC_ES325_UART  // wangtao  boot download use uart 
	rc=es325_uart_fw_download(es325, STANDARD);
	if (rc!=0)
		return -EIO;
#else
	pr_info("%s(): write ES325_BOOT_CMD\n", __func__);
	memset(msg, 0, 16);
	msg[0] = ES325_BOOT_CMD & 0x00ff;
	msg[1] = ES325_BOOT_CMD >> 8;
	pr_info("%s(): msg[0] = 0x%02x\n", __func__, msg[0]);
	pr_info("%s(): msg[1] = 0x%02x\n", __func__, msg[1]);
	pr_info("%s(): msg[2] = 0x%02x\n", __func__, msg[2]);
	pr_info("%s(): msg[3] = 0x%02x\n", __func__, msg[3]);
	rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
			     ES325_WRITE_VE_WIDTH, msg, 4, 0);
	if (rc < 0) {
		pr_err("%s(): firmware load failed boot write\n", __func__);
		return	0;
	}
	msleep(50);
	pr_info("%s(): read boot cmd ack\n", __func__);
	memset(msg, 0, 16);
	rc = ES325_BUS_READ(es325, ES325_READ_VE_OFFSET, ES325_READ_VE_WIDTH,
			    msg, 4, 0);
	pr_info("%s(): msg[0] = 0x%02x\n", __func__, msg[0]);
	pr_info("%s(): msg[1] = 0x%02x\n", __func__, msg[1]);
	pr_info("%s(): msg[2] = 0x%02x\n", __func__, msg[2]);
	pr_info("%s(): msg[3] = 0x%02x\n", __func__, msg[3]);
	if (rc < 0) {
		pr_err("%s(): firmware load failed boot ack\n", __func__);
		return	rc;
	}
	if ((msg[0] != ((ES325_BOOT_ACK >> 8) & 0x00ff)) || (msg[1] != (ES325_BOOT_ACK & 0x00ff))) {
		pr_err("%s(): firmware load failed boot ack pattern", __func__);
		return	-EIO;
	}
	msleep(50);

	pr_info("%s(): write firmware image\n", __func__);
	/* send image */
#ifdef VOICE_SENSE
	buf_frames = es325->standard->size / ES325_FW_LOAD_BUF_SZ;
	pr_info("%s(): buf_frames = %d", __func__, buf_frames);
	buf_ptr = (char *)es325->standard->data;
#else
	buf_frames = es325->fw->size / ES325_FW_LOAD_BUF_SZ;
	pr_info("%s(): buf_frames = %d", __func__, buf_frames);
	buf_ptr = (char *)es325->fw->data;
#endif
	for ( ; buf_frames; --buf_frames, buf_ptr += ES325_FW_LOAD_BUF_SZ) {		
		rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
				     ES325_WRITE_VE_WIDTH, buf_ptr,
				     ES325_FW_LOAD_BUF_SZ, 0);
		if (rc < 0) {
			pr_err("%s(): firmware load failed\n", __func__);
			return -EIO;
		}
	}
#ifdef VOICE_SENSE
	if (es325->standard->size % ES325_FW_LOAD_BUF_SZ) {
		rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
				     ES325_WRITE_VE_WIDTH, buf_ptr,
				     es325->standard->size % ES325_FW_LOAD_BUF_SZ, 0);
		if (rc < 0) {
			pr_err("%s(): firmware load failed\n", __func__);
			return -EIO;
		}
	}	
#else
	if (es325->fw->size % ES325_FW_LOAD_BUF_SZ) {
		rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
				     ES325_WRITE_VE_WIDTH, buf_ptr,
				     es325->fw->size % ES325_FW_LOAD_BUF_SZ, 0);
		if (rc < 0) {
			pr_err("%s(): firmware load failed\n", __func__);
			return -EIO;
		}
	}
#endif
#endif
	/* Give the chip some time to become ready after firmware
	 * download. */
	msleep(50);

	pr_info("%s(): write ES325_SYNC_CMD\n", __func__);
	memset(msg, 0, 16);
	msg[0] = ES325_SYNC_CMD >> 8;
	msg[1] = ES325_SYNC_CMD & 0x00ff;
	msg[2] = ES325_SYNC_POLLING >> 8;
	msg[3] = ES325_SYNC_POLLING & 0x00ff;
	pr_info("%s(): msg[0] = 0x%02x\n", __func__, msg[0]);
	pr_info("%s(): msg[1] = 0x%02x\n", __func__, msg[1]);
	pr_info("%s(): msg[2] = 0x%02x\n", __func__, msg[2]);
	pr_info("%s(): msg[3] = 0x%02x\n", __func__, msg[3]);
	rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
			     ES325_WRITE_VE_WIDTH, msg, 4, 1);
	if (rc < 0) {
		pr_err("%s(): firmware load failed sync write\n", __func__);
		return rc;
	}
	msleep(50);
	pr_info("%s(): read sync cmd ack\n", __func__);
	memset(msg, 0, 16);
	rc = ES325_BUS_READ(es325, ES325_READ_VE_OFFSET, ES325_READ_VE_WIDTH,
			    msg, 4, 1);
	pr_info("%s(): msg[0] = 0x%02x\n", __func__, msg[0]);
	pr_info("%s(): msg[1] = 0x%02x\n", __func__, msg[1]);
	pr_info("%s(): msg[2] = 0x%02x\n", __func__, msg[2]);
	pr_info("%s(): msg[3] = 0x%02x\n", __func__, msg[3]);
	if (rc < 0) {
		pr_err("%s(): error reading firmware sync ack rc=%d\n",
		       __func__, rc);
		return rc;
	}
	if (memcmp(msg, sync_ok, 4) == 0) {
		pr_info("%s(): firmware sync ack good=0x%02x%02x%02x%02x\n",
			__func__, msg[0], msg[1], msg[2], msg[3]);
		bootup_status=ES325_BOOTUP_READY;//Richard 11.22
	} else {
		pr_err("%s(): firmware sync ack failed=0x%02x%02x%02x%02x\n",
		       __func__, msg[0], msg[1], msg[2], msg[3]);
		bootup_status=ES325_BOOTUP_FAIL;//Richard 11.22;
		return -EIO;
	}	
	return 0;
}

static int fw_download(void *arg)
{
	struct es325_priv *priv = (struct es325_priv *)arg;
	int rc;
	char err_num=0;
	do {
#ifdef BUS_TRANSACTIONS
		rc = es325_bootup(priv);
#endif
		pr_info("%s(): bootup rc=%d,err_num=%d\n", 
				__func__, rc,err_num++);
	}while((rc!=0)&&(err_num<6));
	
	
#ifdef VOICE_SENSE
#ifndef CONFIG_SND_SOC_ES325_UART // wangtao  boot download use uart
	release_firmware(priv->standard);
#endif
#else 
	pr_info("%s(): would release firmware here...\n", __func__);
	release_firmware(priv->fw);
#endif
	rc = register_snd_soc(priv);
	pr_info("%s(): register_snd_soc rc=%d\n", __func__, rc);

	rc = es325_wrapper_sleep(0);
	es325_power_state= ES325_POWER_STATE_SLEEP;

	module_put(THIS_MODULE);
	pr_info("%s(): exiting fw_download\n", __func__);
	return 0;
} 

static int es325_sleep(struct es325_priv *es325)
{
	char msg[16];
	int rc;
	int retry=0;
	memset(msg, 0, 16);
	msg[0] = 0x90;
	msg[1] = 0x4E;
	msg[2] = 0x00;
	msg[3] = 0x00;
	rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
			     ES325_WRITE_VE_WIDTH, msg, 4, 1);
	if (rc < 0) {
		pr_err("%s(): es325_i2c_write()", __func__);
		return rc;
	}
	pr_info("%s(): entry\n", __func__);

	/* write 0x8000_0001
	 * sleep 20 ms
	 * clocks off
	 */
	memset(msg, 0, 16);
	msg[0] = ES325_SET_POWER_STATE >> 8;
	msg[1] = ES325_SET_POWER_STATE & 0x00ff;
	msg[2] = ES325_SET_POWER_STATE_SLEEP >> 8;
	msg[3] = ES325_SET_POWER_STATE_SLEEP & 0x00ff;
	rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
			     ES325_WRITE_VE_WIDTH, msg, 4, 1);
	if (rc < 0) {
		pr_err("%s(): es325_i2c_write()", __func__);
		return rc;
	}

	msleep(25);
	while(1){		
		memset(msg, 0, 16);		
		msg[0] = ES325_SYNC_CMD >> 8;		
		msg[1] = ES325_SYNC_CMD & 0x00ff;		
		msg[2] = ES325_SYNC_POLLING >> 8;		
		msg[3] = ES325_SYNC_POLLING & 0x00ff;		
		pr_info("%s(): write msg[0] = 0x%02x\n", __func__, msg[0]);		
		pr_info("%s(): write msg[1] = 0x%02x\n", __func__, msg[1]);		
		pr_info("%s(): write msg[2] = 0x%02x\n", __func__, msg[2]);		
		pr_info("%s(): write msg[3] = 0x%02x\n", __func__, msg[3]);		
		
		rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
				ES325_WRITE_VE_WIDTH, msg, 4, 1);		
		if (rc<0){			
			pr_info("%s(): can not write sync rc=%d\n",	__func__, rc);			
			break;			
		}
		
		memset(msg, 0, 16);		
		rc = ES325_BUS_READ(es325, ES325_READ_VE_OFFSET, 
				ES325_READ_VE_WIDTH, msg, 4, 1);				
		if (rc < 0) {			
			pr_info("%s(): can not read any sync ack rc=%d\n", __func__, rc);			
			break;			
		}		
		pr_info("%s(): msg[0] = 0x%02x\n", __func__, msg[0]);		
		pr_info("%s(): msg[1] = 0x%02x\n", __func__, msg[1]);		
		pr_info("%s(): msg[2] = 0x%02x\n", __func__, msg[2]);		
		pr_info("%s(): msg[3] = 0x%02x\n", __func__, msg[3]);
		msleep(30);
		if (retry++>20)	{			
			pr_err("%s(): sleep error, retry=%d\n",	__func__, retry);			
			break;			
		}	
	}
	/* clocks off */
	es325->pdata->es325_clk_cb(0);
	if ((&es325->gen0_client->dev != NULL) &&  (es325->gen0_client->dev.parent != NULL))
	{
		pr_debug("%s pm_runtime\n", __func__);
		pm_runtime_mark_last_busy(es325->gen0_client->dev.parent);
		pm_runtime_put(es325->gen0_client->dev.parent);
	}
	pr_info("%s(): exit\n", __func__);
	return 0;

}

static int es325_wakeup(struct es325_priv *es325)
{
	int rc;
	static char sync_ok[] = { 0x80, 0, 0, 0 };
	char msg[16];
	int retryCount = 10;

	pr_info("%s(): entry\n", __func__);
	if ((&es325->gen0_client->dev != NULL) &&  (es325->gen0_client->dev.parent != NULL))
	{
		pr_debug("%s pm_runtime\n", __func__);
		pm_runtime_get_sync(es325->gen0_client->dev.parent);
	}
	msleep(1);
	/* 1 - clocks on
	 * 2 - wakeup 1 -> 0
	 * 3 - sleep 30 ms
	 * 4 - Send sync command (0x8000, 0x0001)
	 * 5 - Read sync ack
	 * 6 - wakeup 0 -> 1
	 */

#ifdef CONFIG_SND_SOC_ES325_UART
	{
		char wakeup_char = 'A';	
		rc = es325->uart_open(es325);//  uart opt
		if(!rc){
			es325->uart_dev_write(es325, (char *)&wakeup_char,
						sizeof(wakeup_char));
		}else{
			pr_info("%s(): uart open error!!! cannot wakeup es325!!!\n", __func__);
			return -1;
		}
	}
#else
	gpio_direction_output(es325->pdata->wakeup_gpio, 1);
	gpio_set_value(es325->pdata->wakeup_gpio, 1);
	msleep(1);
	gpio_direction_output(es325->pdata->wakeup_gpio, 0);
	gpio_set_value(es325->pdata->wakeup_gpio, 0);
#endif


	do {
		msleep(5);
		memset(msg, 0, 16);
		msg[0] = ES325_SYNC_CMD >> 8;
		msg[1] = ES325_SYNC_CMD & 0x00ff;
		msg[2] = ES325_SYNC_POLLING >> 8;
		msg[3] = ES325_SYNC_POLLING & 0x00ff;
		pr_info("%s(): write msg[0] = 0x%02x\n", __func__, msg[0]);
		pr_info("%s(): write msg[1] = 0x%02x\n", __func__, msg[1]);
		pr_info("%s(): write msg[2] = 0x%02x\n", __func__, msg[2]);
		pr_info("%s(): write msg[3] = 0x%02x\n", __func__, msg[3]);
		rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
				ES325_WRITE_VE_WIDTH, msg, 4, 1);		
		if (rc < 0) {
			pr_err("%s(): firmware sync write failed\n", __func__);
			continue;
		}
		pr_info("%s(): read sync cmd ack\n", __func__);
		memset(msg, 0, 16);
		rc = ES325_BUS_READ(es325, ES325_READ_VE_OFFSET, ES325_READ_VE_WIDTH,
				msg, 4, 1);	
		if (rc < 0) {
			pr_err("%s(): error reading firmware sync ack rc=%d\n",
					__func__, rc);
			continue;
		}
		pr_info("%s(): read msg[0] = 0x%02x\n", __func__, msg[0]);
		pr_info("%s(): read msg[1] = 0x%02x\n", __func__, msg[1]);
		pr_info("%s(): read msg[2] = 0x%02x\n", __func__, msg[2]);
		pr_info("%s(): read msg[3] = 0x%02x\n", __func__, msg[3]);
		
		if (memcmp(msg, sync_ok, 4) == 0) {
			pr_info("%s() the %d time: firmware sync ack good=0x%02x%02x%02x%02x\n",
					__func__, 10-retryCount, msg[0], msg[1], msg[2], msg[3]);
			break;
		} else {
			pr_err("%s(): firmware sync ack failed=0x%02x%02x%02x%02x\n",
					__func__, msg[0], msg[1], msg[2], msg[3]);
			if (retryCount==1)
				pr_err("%s():after 10 times es325 wakeup failed  !!!\n",__func__);
		}
	} while (--retryCount);

				
#ifdef CONFIG_SND_SOC_ES325_UART
	es325->uart_close(es325);// uart opt 
#else
	gpio_set_value(es325->pdata->wakeup_gpio, 1);
	gpio_direction_input(es325->pdata->wakeup_gpio);
#endif
	pr_info("%s(): exit\n", __func__);
	return 0;
}

static int es325_put_control_value(struct snd_kcontrol *kcontrol,
				   struct snd_ctl_elem_value *ucontrol)
{
	/* struct snd_soc_codec *codec = es325_priv.codec; */
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int value;
	int rc = 0;

	value = ucontrol->value.integer.value[0];
	rc = es325_write(NULL, reg, value);

	return 0;
}

static int es325_get_control_value(struct snd_kcontrol *kcontrol,
				   struct snd_ctl_elem_value *ucontrol)
{
	/* struct snd_soc_codec *codec = es325_priv.codec; */
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int value;

	value = es325_read(NULL, reg);
	ucontrol->value.integer.value[0] = value;

	return 0;
}

static int es325_preset_put_control_value(struct snd_kcontrol *kcontrol,
				   struct snd_ctl_elem_value *ucontrol)
{
	struct es325_priv *es325 = &es325_priv;
	unsigned int reg = ES325_PRESET;
	unsigned int value = 0;
	int rc = 0;
	char msg[16];
	int msg_len = 0;
	char *msg_ptr;
	int i;
	 if (es325_power_state!= ES325_POWER_STATE_ACTIVE)
	 	return -EINVAL;
	 mutex_lock(&es325->api_mutex);
	value = ucontrol->value.integer.value[0]; 
	pr_err("%s(): [--preset ID--] value = 0x%X\n", __func__,value);
	rc = es325_build_preset_write_msg(msg, &msg_len, reg, value);
	if (rc) 
		pr_err("%s(): failed to build write message for address = 0x%04x\n",
				__func__, reg);

	msg_ptr = msg;
	pr_info("%s(): msg[0] = 0x%02x\n", __func__, msg[0]);
	pr_info("%s(): msg[1] = 0x%02x\n", __func__, msg[1]);
	pr_info("%s(): msg[2] = 0x%02x\n", __func__, msg[2]);
	pr_info("%s(): msg[3] = 0x%02x\n", __func__, msg[3]);

	for (i = msg_len; i > 0; i -= 4) {
		rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
		ES325_WRITE_VE_WIDTH, msg_ptr, 4, 1);
		if (rc < 0) {
			pr_err("%s(): es325_xxxx_write()", __func__);
			mutex_unlock(&es325->api_mutex);//Richard 11.26a
			return rc;
		}
		msg_ptr += 4;
	} 

	memset(msg, 0, 16);
	rc = ES325_BUS_READ(es325, ES325_READ_VE_OFFSET, ES325_READ_VE_WIDTH,
			msg, 4, 1);
	if (rc < 0) 
		pr_info("%s(): can not read any sync ack rc=%d\n",
			__func__, rc);

	pr_info("%s(): read msg[0] = 0x%02x\n", __func__, msg[0]);
	pr_info("%s(): read msg[1] = 0x%02x\n", __func__, msg[1]);
	pr_info("%s(): read msg[2] = 0x%02x\n", __func__, msg[2]);
	pr_info("%s(): read msg[3] = 0x%02x\n", __func__, msg[3]);
	es325_presets = value;
	mutex_unlock(&es325->api_mutex);//Richard 11.26a
	return 0;
}

static int es325_preset_get_control_value(struct snd_kcontrol *kcontrol,
				   struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.integer.value[0] = es325_presets;
	return 0;
}

static int es325_digital_gain_iterm_put_control_value(struct snd_kcontrol *kcontrol,
					   struct snd_ctl_elem_value *ucontrol)
{
	pr_info("GAC:%s():new digital gain item index = %ld\n", __func__, ucontrol->value.integer.value[0]);
	current_gain_item=ucontrol->value.integer.value[0]&0xff;
	return 0;
}

static int es325_digital_gain_iterm_get_control_value(struct snd_kcontrol *kcontrol,
					   struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.integer.value[0] = current_gain_item;
	pr_info("%s(): internal_route_num = %d\n", __func__,
		current_gain_item);
	return 0;
}

static int es325_send_command_put(struct snd_kcontrol *kcontrol,
					   struct snd_ctl_elem_value *ucontrol)
{
	unsigned long value,value0,value1;
	struct es325_priv *es325 = &es325_priv;
	u8 cmd[128];
	int cmdlen;
	int offset;
	
	value0=ucontrol->value.integer.value[0];
	value1=ucontrol->value.integer.value[1];
	value= value0<<16 | value1;
	pr_info("GAC:%s():nes325_send_command_put = 0x%lx\n", __func__, value);

	cmd[0]=(value>>24)&0xff;
	cmd[1]=(value>>16)&0xff;
	cmd[2]=(value>>8)&0xff;
	cmd[3]=(value>>0)&0xff;
	cmdlen=4;
	offset=0;
	while (offset < cmdlen) {
		/* Commands must be written in 4 byte blocks. */
		int wrsize = (cmdlen - offset > 4) ? 4 : cmdlen - offset;
		es325_slim_write(es325, ES325_WRITE_VE_OFFSET,
				 ES325_WRITE_VE_WIDTH, &cmd[offset], wrsize, 1);
		pr_info("%s write: %02x%02x%02x%02x\n", __func__, cmd[0], cmd[1], cmd[2], cmd[3]);
		usleep_range(10000, 10000);
		es325_slim_read(es325, ES325_READ_VE_OFFSET,
				ES325_READ_VE_WIDTH, resp, 4, 1);
		pr_info("%s read: %02x%02x%02x%02x\n", __func__, resp[0], resp[1], resp[2], resp[3]);
		offset += wrsize;
	}
	return 0;
}

static int es325_send_command_get(struct snd_kcontrol *kcontrol,
					   struct snd_ctl_elem_value *ucontrol)
{
		
	pr_info("%s: %02x%02x%02x%02x\n", __func__, resp[0], resp[1], resp[2], resp[3]);
	ucontrol->value.integer.value[0] = (resp[0]<<8)|resp[1];
	ucontrol->value.integer.value[1] = (resp[2]<<8)|resp[3];
	pr_info("%s(): es325_send_command_get =0x%04x%04x\n", __func__,
		(unsigned int)ucontrol->value.integer.value[0],(unsigned int)ucontrol->value.integer.value[1]);
	return 0;
}

static int es325_digital_gain_get_control_value(struct snd_kcontrol *kcontrol,
				   struct snd_ctl_elem_value *ucontrol)
{
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	struct es325_priv *es325 = &es325_priv;
	unsigned int reg = mc->reg;
	unsigned int value = 0;
	int rc = 0;
	char msg[16];
	char ack_msg[16];
	int msg_len = 0;
	char *msg_ptr;
	int i;

	rc = es325_build_digital_item_read_msg(msg, &msg_len, reg, value);
	 if (rc) {
		pr_err("%s(): failed to build read message for address = 0x%04x\n",
			__func__, reg);
	}        
    
	msg_ptr = msg;
	for (i = msg_len; i > 0; i -= 4) {
		rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
		ES325_WRITE_VE_WIDTH, msg_ptr, 4, 1);
		if (rc < 0) {
			pr_err("%s(): es325_xxxx_write()", __func__);
			return rc;
		}
		msg_ptr += 4;
	} 

	msleep(20);
	rc = ES325_BUS_READ(es325, ES325_READ_VE_OFFSET,
			    ES325_READ_VE_WIDTH, ack_msg, 4, 1);
	if (rc < 0) {
		pr_err("%s(): es325_xxxx_read()", __func__);
		return rc;
	}
	value = ack_msg[2] << 8 | ack_msg[3];
	ucontrol->value.integer.value[0]=value;
	return 0;	
}

static int es325_digital_gain_put_control_value(struct snd_kcontrol *kcontrol,
				   struct snd_ctl_elem_value *ucontrol)
{
	/* struct snd_soc_codec *codec = es325_priv.codec; */
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	struct es325_priv *es325 = &es325_priv;
	unsigned int reg = mc->reg;
	unsigned int value = 0;
	int rc = 0;
	char msg[16];
	int msg_len = 0;
	char *msg_ptr;
	int i;

	value = ucontrol->value.integer.value[0]; 

	if (value<0x100)
		value |=current_gain_item<<8;//means cowork wirth digital gain item control
	else
		current_gain_item=(value>>8)&0xff;

	rc = es325_build_preset_write_msg(msg, &msg_len, reg, value);
 	if (rc) {
		pr_err("%s(): failed to build write message for address = 0x%04x\n",
			__func__, reg);
	}        
    
	msg_ptr = msg;
	for (i = msg_len; i > 0; i -= 4) {
		rc = ES325_BUS_WRITE(es325, ES325_WRITE_VE_OFFSET,
				     ES325_WRITE_VE_WIDTH, msg_ptr, 4, 1);
		if (rc < 0) {
			pr_err("%s(): es325_xxxx_write()", __func__);
			return rc;
		}
		msg_ptr += 4;
	} 
	return 0;
}


static int es325_put_control_enum(struct snd_kcontrol *kcontrol,
				  struct snd_ctl_elem_value *ucontrol)
{
	struct soc_enum *e =
		(struct soc_enum *)kcontrol->private_value;
	struct es325_priv *es325 = &es325_priv;

	unsigned int reg = e->reg;
	unsigned int value;
	int rc = 0;

	mutex_lock(&es325->api_mutex);//Richard 11.26a
	value = ucontrol->value.enumerated.item[0];
	pr_debug("%s(): set reg=%d to value=%d\n", __func__, reg,value);
	rc = es325_write(NULL, reg, value);
	mutex_unlock(&es325->api_mutex);//Richard 11.26a
	return 0;
}

static int es325_get_control_enum(struct snd_kcontrol *kcontrol,
				  struct snd_ctl_elem_value *ucontrol)
{
	struct soc_enum *e =
		(struct soc_enum *)kcontrol->private_value;
	unsigned int reg = e->reg;
	unsigned int value;

	value = es325_read(NULL, reg);
	pr_debug("%s(): reg = %d value is %d\n", __func__, reg,value);
	ucontrol->value.enumerated.item[0] = value;
	return 0;
}

static int es325_get_rx1_route_enable_value(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.integer.value[0] = es325_rx1_route_enable;
	pr_info("%s(): es325_rx1_route_enable = %d\n", __func__,
		es325_rx1_route_enable);
	return 0;
}

static int es325_put_rx1_route_enable_value(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value *ucontrol)
{
	 if ((es325_power_state!=ES325_POWER_STATE_ACTIVE)&&(ucontrol->value.integer.value[0]!=0))//Richard 11.28
                                {
                                pr_err("%s(): fail, power state=%d, set value=%ld\n", __func__,es325_power_state, 
                                ucontrol->value.integer.value[0]);
                                return 0;
                                }
	es325_rx1_route_enable = ucontrol->value.integer.value[0];
	pr_info("%s(): es325_rx1_route_enable = %d\n", __func__,
		es325_rx1_route_enable);
	return 0;
}

static int es325_get_tx1_route_enable_value(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.integer.value[0] = es325_tx1_route_enable;
	pr_info("%s(): es325_tx1_route_enable = %d\n", __func__,
		es325_tx1_route_enable);
	return 0;
}

static int es325_put_tx1_route_enable_value(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value *ucontrol)
{
 if ((es325_power_state!=ES325_POWER_STATE_ACTIVE)&&(ucontrol->value.integer.value[0]!=0))//Richard 11.28
                                {
                                pr_err("%s(): fail, power state=%d, set value=%ld\n", __func__,es325_power_state, 
                                ucontrol->value.integer.value[0]);
                                return 0;
                                }
	es325_tx1_route_enable = ucontrol->value.integer.value[0];
	pr_info("%s(): es325_tx1_route_enable = %d\n", __func__,
		es325_tx1_route_enable);

	return 0;
}

static int es325_get_rx2_route_enable_value(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.integer.value[0] = es325_rx2_route_enable;
	pr_info("%s(): es325_rx2_route_enable = %d\n", __func__,
		es325_rx2_route_enable);

	return 0;
}

static int es325_put_rx2_route_enable_value(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value *ucontrol)
{
 if ((es325_power_state!=ES325_POWER_STATE_ACTIVE)&&(ucontrol->value.integer.value[0]!=0))//Richard 11.28
                                {
                                pr_err("%s(): fail, power state=%d, set value=%ld\n", __func__,es325_power_state, 
                                ucontrol->value.integer.value[0]);
                                return 0;
                                }
	es325_rx2_route_enable = ucontrol->value.integer.value[0];
	pr_info("%s(): es325_rx2_route_enable = %d\n", __func__,
		es325_rx2_route_enable);

	return 0;
}

int es325_remote_route_enable(struct snd_soc_dai *dai)
{
	switch (dai->id) {
	case ES325_SLIM_1_PB:
		return es325_rx1_route_enable;
	case ES325_SLIM_1_CAP:
		return es325_tx1_route_enable;
	case ES325_SLIM_2_PB:
		return es325_rx2_route_enable;
	default:
		return 0;
	}	
}
EXPORT_SYMBOL_GPL(es325_remote_route_enable);

static int es325_put_internal_route_config(struct snd_kcontrol *kcontrol,
					   struct snd_ctl_elem_value *ucontrol)
{
	pr_info("GAC:%s():new route index = %ld\n", __func__, ucontrol->value.integer.value[0]);
	es325_switch_route(ucontrol->value.integer.value[0]);
	return 0;
}

static int es325_get_internal_route_config(struct snd_kcontrol *kcontrol,
					   struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.integer.value[0] = es325_internal_route_num;
	pr_info("%s(): internal_route_num = %ld\n", __func__,
		ucontrol->value.integer.value[0]);
	return 0;
}

static int es325_get_audio_custom_profile(struct snd_kcontrol *kcontrol,
					  struct snd_ctl_elem_value *ucontrol)
{
	return 0;
}

static int es325_put_audio_custom_profile(struct snd_kcontrol *kcontrol,
					  struct snd_ctl_elem_value *ucontrol)
{
	int index = ucontrol->value.integer.value[0];

	if (index < ES325_CUSTOMER_PROFILE_MAX)
		es325_write_data_block_cmd(&es325_priv,
			&es325_audio_custom_profiles[index][0]);
	return 0;
}

static int es325_ap_put_tx1_ch_cnt(struct snd_kcontrol *kcontrol,
				   struct snd_ctl_elem_value *ucontrol)
{
	es325_ap_tx1_ch_cnt = ucontrol->value.enumerated.item[0] + 1;
	pr_info("GAC:%s():tx1 ch cnt = %d\n", __func__,
		es325_ap_tx1_ch_cnt);
	return 0;
}

static int es325_ap_get_tx1_ch_cnt(struct snd_kcontrol *kcontrol,
				   struct snd_ctl_elem_value *ucontrol)
{
	ucontrol->value.enumerated.item[0] = es325_internal_route_num - 1;
	pr_info("%s(): ucontrol = %d\n", __func__,
		ucontrol->value.enumerated.item[0]);
	return 0;
}


/* generic gain translation */
static int es325_index_to_gain(int min, int step, int index)
{
	return	min + (step * index);
}
static int es325_gain_to_index(int min, int step, int gain)
{
	return	(gain - min) / step;
}

/* dereverb gain */
static int es325_put_dereverb_gain_value(struct snd_kcontrol *kcontrol,
					 struct snd_ctl_elem_value *ucontrol)
{
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int value;
	int rc = 0;

	if (ucontrol->value.integer.value[0] <= 12) {
		pr_info("GAC:%s() ucontrol = %ld\n", __func__,
			ucontrol->value.integer.value[0]);
		value = es325_index_to_gain(-12, 1, ucontrol->value.integer.value[0]);
		pr_info("GAC:%s() value = %d\n", __func__, value);
		rc = es325_write(NULL, reg, value);
	}

	return 0;
}

static int es325_get_dereverb_gain_value(struct snd_kcontrol *kcontrol,
					 struct snd_ctl_elem_value *ucontrol)
{
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int value;

	value = es325_read(NULL, reg);
	pr_info("GAC:%s() value = %d\n", __func__, value);
	ucontrol->value.integer.value[0] = es325_gain_to_index(-12, 1, value);
	pr_info("GAC:%s() ucontrol = %ld\n", __func__,
		ucontrol->value.integer.value[0]);

	return 0;
}

/* bwe high band gain */
static int es325_put_bwe_high_band_gain_value(struct snd_kcontrol *kcontrol,
					      struct snd_ctl_elem_value *ucontrol)
{
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int value;
	int rc = 0;

	if (ucontrol->value.integer.value[0] <= 30) {
		pr_info("GAC:%s() ucontrol = %ld\n", __func__,
			ucontrol->value.integer.value[0]);
		value = es325_index_to_gain(-10, 1, ucontrol->value.integer.value[0]);
		pr_info("GAC:%s() value = %d\n", __func__,
			value);
		rc = es325_write(NULL, reg, value);
	}

	return 0;
}

static int es325_get_bwe_high_band_gain_value(struct snd_kcontrol *kcontrol,
					      struct snd_ctl_elem_value *ucontrol)
{
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int value;

	value = es325_read(NULL, reg);
	pr_info("GAC:%s() value = %d\n", __func__, value);
	ucontrol->value.integer.value[0] = es325_gain_to_index(-10, 1, value);
	pr_info("GAC:%s() ucontrol = %ld\n", __func__,
		ucontrol->value.integer.value[0]);

	return 0;
}

/* bwe max snr */
static int es325_put_bwe_max_snr_value(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value *ucontrol)
{
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int value;
	int rc = 0;

	if (ucontrol->value.integer.value[0] <= 70) {
		pr_info("GAC:%s() ucontrol = %ld\n", __func__,
			ucontrol->value.integer.value[0]);
		value = es325_index_to_gain(-20, 1, ucontrol->value.integer.value[0]);
		pr_info("GAC:%s() value = %d\n", __func__,
			value);
		rc = es325_write(NULL, reg, value);
	}

	return 0;
}

static int es325_get_bwe_max_snr_value(struct snd_kcontrol *kcontrol,
				       struct snd_ctl_elem_value *ucontrol)
{
	struct soc_mixer_control *mc =
		(struct soc_mixer_control *)kcontrol->private_value;
	unsigned int reg = mc->reg;
	unsigned int value;

	value = es325_read(NULL, reg);
	pr_info("GAC:%s() value = %d\n", __func__, value);
	ucontrol->value.integer.value[0] = es325_gain_to_index(-20, 1, value);
	pr_info("GAC:%s() ucontrol = %ld\n", __func__,
		ucontrol->value.integer.value[0]);

	return 0;
}

static const char * const es325_ap_tx1_ch_cnt_texts[] = {
	"One", "Two"
};
static const struct soc_enum es325_ap_tx1_ch_cnt_enum =
	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0,
			ARRAY_SIZE(es325_ap_tx1_ch_cnt_texts),
			es325_ap_tx1_ch_cnt_texts);

static const char * const es325_mic_config_texts[] = {
	"CT 2-mic", "FT 2-mic", "DV 1-mic", "EXT 1-mic", "BT 1-mic",
	"CT ASR 2-mic", "FT ASR 2-mic", "EXT ASR 1-mic", "FT ASR 1-mic",
};
static const struct soc_enum es325_mic_config_enum =
	SOC_ENUM_SINGLE(ES325_MIC_CONFIG, 0,
			ARRAY_SIZE(es325_mic_config_texts),
			es325_mic_config_texts);

static const char * const es325_aec_mode_texts[] = {
	"Off", "On", "rsvrd2", "rsvrd3", "rsvrd4", "On half-duplex"
};
static const struct soc_enum es325_aec_mode_enum =
	SOC_ENUM_SINGLE(ES325_AEC_MODE, 0, ARRAY_SIZE(es325_aec_mode_texts),
			es325_aec_mode_texts);

static const char * const es325_algo_rates_text[] = {
	"fs=8khz", "fs=16khz", "fs=24khz", "fs=48khz", "fs=96khz", "fs=192khz"
};
static const struct soc_enum es325_algo_sample_rate_enum =
	SOC_ENUM_SINGLE(ES325_ALGO_SAMPLE_RATE, 0,
			ARRAY_SIZE(es325_algo_rates_text),
			es325_algo_rates_text);
static const struct soc_enum es325_algo_mix_rate_enum =
	SOC_ENUM_SINGLE(ES325_MIX_SAMPLE_RATE, 0,
			ARRAY_SIZE(es325_algo_rates_text),
			es325_algo_rates_text);

static const char * const es325_algorithms_text[] = {
	"None", "VP", "Two CHREC", "AUDIO", "Four CHPASS"
};
static const struct soc_enum es325_algorithms_enum =
	SOC_ENUM_SINGLE(ES325_ALGO_SAMPLE_RATE, 0,
			ARRAY_SIZE(es325_algorithms_text),
			es325_algorithms_text);

static const char * const es325_off_on_texts[] = {
	"Off", "On"
};
static const struct soc_enum es325_veq_enable_enum =
	SOC_ENUM_SINGLE(ES325_VEQ_ENABLE, 0, ARRAY_SIZE(es325_off_on_texts),
			es325_off_on_texts);
static const struct soc_enum es325_dereverb_enable_enum =
	SOC_ENUM_SINGLE(ES325_DEREVERB_ENABLE, 0,
			ARRAY_SIZE(es325_off_on_texts),
			es325_off_on_texts);
static const struct soc_enum es325_bwe_enable_enum =
	SOC_ENUM_SINGLE(ES325_BWE_ENABLE, 0, ARRAY_SIZE(es325_off_on_texts),
			es325_off_on_texts);
static const struct soc_enum es325_bwe_post_eq_enable_enum =
	SOC_ENUM_SINGLE(ES325_BWE_POST_EQ_ENABLE, 0,
			ARRAY_SIZE(es325_off_on_texts),
			es325_off_on_texts);
static const struct soc_enum es325_algo_processing_enable_enum =
	SOC_ENUM_SINGLE(ES325_ALGO_PROCESSING, 0,
			ARRAY_SIZE(es325_off_on_texts),
			es325_off_on_texts);

 static const char *es325_change_status_texts[] = { 
	"Active", "Muting", "Switching", "Unmuting", "Inactive" 
 }; 
 static const struct soc_enum es325_change_status_enum = 
	SOC_ENUM_SINGLE(ES325_CHANGE_STATUS, 0, 
			ARRAY_SIZE(es325_change_status_texts), 
			es325_change_status_texts); 

struct delayed_work es325_work;
struct workqueue_struct *es325_workqueue;
static int es325_schedule_sleep_workqueue(void)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	int rc = 0;
	
	rc = queue_delayed_work(es325_workqueue, &es325_work, msecs_to_jiffies(ES325_SLEEP_TIME));
	if (!rc) {
		dev_err(&sbdev->dev, "=[ES325]=%s delayed work queue failed\n", __func__);
		return -1;
	}

	es325_power_state = ES325_POWER_STATE_SLEEP_PENDING;

	return rc;
}

int es325_wrapper_wakeup(void)
{
	struct es325_priv *es325 = &es325_priv;
	struct slim_device *sbdev = es325->gen0_client;
	int rc = 0;

	dev_dbg(&sbdev->dev, "+[ES325]=%s()\n", __func__);
	ES325_CLK_ENALBE(codec_clk);

	/* When there is sleep pending delayed_work will be pending */
	if (delayed_work_pending(&es325_work)) {
		rc = cancel_delayed_work_sync(&es325_work);
		dev_dbg(&sbdev->dev, "=[ES325]=%s cancel work queue rc=%d\n", __func__, rc);
		if (rc>0){
			es325_power_state = ES325_POWER_STATE_ACTIVE;
			return 0;
                }
	}
	if ((es325_power_state == ES325_POWER_STATE_SLEEP)
		||(es325_power_state == ES325_POWER_STATE_SLEEP_PENDING)) {
		
		//es325_update_gpio_configs(es325->pdata, UPDATE_GPIO_CONFIG);
		rc = es325_wakeup(es325);  
		es325_power_state = ES325_POWER_STATE_ACTIVE;
	}

	return rc;
}
EXPORT_SYMBOL_GPL(es325_wrapper_wakeup);

void es325_wrapper_sleep_internal(struct work_struct *dummy)
{
	struct es325_priv *es325 = &es325_priv;
	int ch_tot = 0;
	int port_active = 0;

	ch_tot += es325->dai[ES325_SLIM_1_PB - ES325_DAI_ID_BASE].ch_tot;
	ch_tot += es325->dai[ES325_SLIM_2_PB - ES325_DAI_ID_BASE].ch_tot;
	ch_tot += es325->dai[ES325_SLIM_1_CAP - ES325_DAI_ID_BASE].ch_tot;

	port_active = es325_rx1_route_enable || es325_rx2_route_enable || es325_tx1_route_enable;

	pr_info("GAC:%s(): ch_tot=%d, port_active=%d\n", __func__, ch_tot, port_active);
	if (port_active)
		pr_info("GAC:%s():, es325_rx1_route_enable=%d, es325_rx2_route_enable=%d, es325_tx1_route_enable=%d",
		__func__, es325_rx1_route_enable, es325_rx2_route_enable, es325_tx1_route_enable);
	if((ch_tot <= 0) && (port_active == 0)) {
		mutex_lock(&es325_priv.pm_mutex);//Richard 11.19
		es325_sleep(es325);
		es325_power_state = ES325_POWER_STATE_SLEEP;
		mutex_unlock(&es325_priv.pm_mutex);//Richard 11.19
	}
	es325_internal_route_num = ES325_INTERNAL_ROUTE_MAX;
}

static int es325_wrapper_sleep(int dai_id)
{
	int rc = 0;
	pr_info("GAC:%s():begin\n", __func__);
	mutex_lock(&es325_priv.pm_mutex);
	rc = es325_schedule_sleep_workqueue();
	mutex_unlock(&es325_priv.pm_mutex);
	return rc;
}
EXPORT_SYMBOL_GPL(es325_wrapper_sleep);

static int es325_put_power_state_enum(struct snd_kcontrol *kcontrol,
				      struct snd_ctl_elem_value *ucontrol)
{
	int es325_power_state_req;
	int rc = 0;
	pr_debug("GAC:%s():now power state= %d to ucontrol = %d\n", __func__,
		es325_power_state,ucontrol->value.enumerated.item[0]);
//Richard 11.22
	if(bootup_status!=ES325_BOOTUP_READY){
			pr_err("%s():ES325 Firmware is not ready\n", __func__);
			return rc;
	}
	es325_power_state_req = ucontrol->value.enumerated.item[0];
	rc = es325_update_power_state(&es325_priv, es325_power_state_req);
	return rc;
}

static int es325_get_power_state_enum(struct snd_kcontrol *kcontrol,
				      struct snd_ctl_elem_value *ucontrol)
{
	pr_debug("GAC:%s(): power state = %d\n", __func__,
		es325_power_state);
	ucontrol->value.enumerated.item[0] = es325_power_state;
	return 0;
}

static const char * const es325_power_state_texts[] = {
	"Sleep", "Active", "VS"
};

static const struct soc_enum es325_power_state_enum =
	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0,
			ARRAY_SIZE(es325_power_state_texts),
			es325_power_state_texts);

static int es325_Reset_Get(struct snd_kcontrol *kcontrol,
	struct snd_ctl_elem_value *ucontrol){
	ucontrol->value.enumerated.item[0]=0;
	pr_debug("GAC:%s():reset mode = %d\n", __func__,
		ucontrol->value.enumerated.item[0]);
	return 0;
}
static int es325_Reset_Put(struct snd_kcontrol *kcontrol,
                       struct snd_ctl_elem_value *ucontrol)
                       
{
    struct es325_priv *es325 = &es325_priv;
	 if (ucontrol->value.integer.value[0])
        {
    	es325_hw_reset(es325);
	 pr_info("%s():Reset Done!\n",__func__);
	 }
	 else
	 	 {
        	pr_info("%s():Noooo Reset!\n",__func__);
        	}
    return 0;
}

static struct snd_kcontrol_new es325_digital_ext_snd_controls[] = {
	/* commit controls */
	SOC_SINGLE_EXT("ES325 RX1 Enable", SND_SOC_NOPM, 0, 1, 0,
		       es325_get_rx1_route_enable_value,
		       es325_put_rx1_route_enable_value),
	SOC_SINGLE_EXT("ES325 TX1 Enable", SND_SOC_NOPM, 0, 1, 0,
		       es325_get_tx1_route_enable_value,
		       es325_put_tx1_route_enable_value),
	SOC_SINGLE_EXT("ES325 RX2 Enable", SND_SOC_NOPM, 0, 1, 0,
		       es325_get_rx2_route_enable_value,
		       es325_put_rx2_route_enable_value),
	SOC_ENUM_EXT("Mic Config", es325_mic_config_enum,
		     es325_get_control_enum, es325_put_control_enum),
	SOC_ENUM_EXT("AEC Mode", es325_aec_mode_enum,
		     es325_get_control_enum, es325_put_control_enum),
	SOC_ENUM_EXT("VEQ Enable", es325_veq_enable_enum,
		     es325_get_control_enum, es325_put_control_enum),
	SOC_ENUM_EXT("Dereverb Enable", es325_dereverb_enable_enum,
		     es325_get_control_enum, es325_put_control_enum),
	SOC_SINGLE_EXT("Dereverb Gain",
		       ES325_DEREVERB_GAIN, 0, 100, 0,
		       es325_get_dereverb_gain_value, es325_put_dereverb_gain_value),
	SOC_ENUM_EXT("BWE Enable", es325_bwe_enable_enum,
		     es325_get_control_enum, es325_put_control_enum),
	SOC_SINGLE_EXT("BWE High Band Gain",
		       ES325_BWE_HIGH_BAND_GAIN, 0, 100, 0,
		       es325_get_bwe_high_band_gain_value,
		       es325_put_bwe_high_band_gain_value),
	SOC_SINGLE_EXT("BWE Max SNR",
		       ES325_BWE_MAX_SNR, 0, 100, 0,
		       es325_get_bwe_max_snr_value, es325_put_bwe_max_snr_value),
	SOC_ENUM_EXT("BWE Post EQ Enable", es325_bwe_post_eq_enable_enum,
		     es325_get_control_enum, es325_put_control_enum),
	SOC_SINGLE_EXT("SLIMbus Link Multi Channel",
		       ES325_SLIMBUS_LINK_MULTI_CHANNEL, 0, 65535, 0,
		       es325_get_control_value, es325_put_control_value),
	SOC_ENUM_EXT("Set Power State", es325_power_state_enum,
		       es325_get_power_state_enum, es325_put_power_state_enum),
	SOC_ENUM_EXT("Algorithm Processing", es325_algo_processing_enable_enum,
		     es325_get_control_enum, es325_put_control_enum),
	SOC_ENUM_EXT("Algorithm Sample Rate", es325_algo_sample_rate_enum,
		     es325_get_control_enum, es325_put_control_enum),
	SOC_ENUM_EXT("Algorithm", es325_algorithms_enum,
		     es325_get_control_enum, es325_put_control_enum),
	SOC_ENUM_EXT("Mix Sample Rate", es325_algo_mix_rate_enum,
		     es325_get_control_enum, es325_put_control_enum),
	SOC_SINGLE_EXT("Internal Route Config",
		       SND_SOC_NOPM, 0, 100, 0, es325_get_internal_route_config,
		       es325_put_internal_route_config),
	SOC_SINGLE_EXT("Audio Custom Profile",
		       SND_SOC_NOPM, 0, 100, 0, es325_get_audio_custom_profile,
		       es325_put_audio_custom_profile),
	SOC_ENUM_EXT("ES325-AP Tx Channels", es325_ap_tx1_ch_cnt_enum,
		     es325_ap_get_tx1_ch_cnt, es325_ap_put_tx1_ch_cnt),
	SOC_SINGLE_EXT("ES325 Presets",ES325_PRESET, 0, 65535, 0,
		       es325_preset_get_control_value, es325_preset_put_control_value),
	SOC_SINGLE_EXT("ES325 Digital Gain",ES325_DIGITAL_GAIN, 0, 65535, 0,
		       es325_digital_gain_get_control_value, es325_digital_gain_put_control_value),
	SOC_SINGLE_EXT("ES325 Digital Gain Item",SND_SOC_NOPM, 0,0x20,0,
		       es325_digital_gain_iterm_get_control_value, es325_digital_gain_iterm_put_control_value),
	SOC_ENUM_EXT("ES325 Get Route Change Status",es325_change_status_enum,
		       es325_get_control_enum,
		       es325_put_control_enum),
	SOC_SINGLE_MULTI_EXT("ESCHIP Set Command",SND_SOC_NOPM, 0, 65535, 0,2,
		       es325_send_command_get, es325_send_command_put),
#ifdef VOICE_SENSE
	SOC_SINGLE_EXT("Voice Sense Enable",
			   ES325_VOICE_SENSE_ENABLE, 0, 1, 0,
			   es325_get_vs_enable, es325_put_vs_enable),
	SOC_ENUM_EXT("Voice Sense Set Wakeup Word",
			 es325_vs_wakeup_keyword_enum,
			 es325_get_vs_wakeup_keyword, es325_put_vs_wakeup_keyword),
	SOC_ENUM_EXT("Voice Sense Status",
			 es325_vs_event_enum,
			 es325_get_control_enum, NULL),
	SOC_ENUM_EXT("Voice Sense Training Mode",
			 es325_vs_training_mode_enum,
			 es325_get_control_enum, es325_put_control_enum),
	SOC_ENUM_EXT("Voice Sense Training Status",
			 es325_vs_training_status_enum,
			 es325_get_control_enum, NULL),
	SOC_ENUM_EXT("Voice Sense Training Record",
			 es325_vs_training_record_enum,
			 NULL, es325_put_control_enum),
	SOC_SINGLE_EXT("Voice Sense Demo Enable",
			   ES325_VOICE_SENSE_DEMO_ENABLE, 0, 1, 0,
			   es325_get_vs_demo_enable, es325_put_vs_demo_enable),
	SOC_ENUM_EXT("Voice Sense Stored Keyword",
			 es325_vs_stored_keyword_enum,
			 NULL, es325_put_vs_stored_keyword),
	SOC_SINGLE_EXT("Voice Sense Abort",
			   ES325_VOICE_SENSE_ABORT, 0, 1, 0,
			   es325_get_vs_abort_req, es325_put_vs_abort_req),
	SOC_SINGLE_EXT("Voice Sense Detect Sensitivity",
			   ES325_VOICE_SENSE_DETECTION_SENSITIVITY, 0, 10, 0,
			   es325_get_vs_detection_sensitivity_value,
			   es325_put_vs_detection_sensitivity_value),
	SOC_ENUM_EXT("Voice Sense Auto Mode",es325_vs_auto_mode_enum,
			es325_get_voice_sense_auto_mode, es325_put_voice_sense_auto_mode),
	SOC_SINGLE_EXT("ES325 Bootup Status", SND_SOC_NOPM, 0, 2, 0,
		       es325_get_bootup_status, NULL),
	 SOC_SINGLE_EXT("ESCHIP Reset",SND_SOC_NOPM, 0, 1, 0,
               es325_Reset_Get, es325_Reset_Put),
#endif
};

static int es325_set_bias_level(struct snd_soc_codec *codec,
				enum snd_soc_bias_level level)
{
	int ret = 0;
	switch (level) {
	case SND_SOC_BIAS_ON:
		break;

	case SND_SOC_BIAS_PREPARE:
		break;

	case SND_SOC_BIAS_STANDBY:
		break;

	case SND_SOC_BIAS_OFF:
		break;
	}
	codec->dapm.bias_level = level ;
	return ret;
}

#if defined(CONFIG_SND_SOC_ES325_I2S)
static int es325_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
				unsigned int freq, int dir)
{
	struct snd_soc_codec *codec = dai->codec;
	int ret=0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	return ret;
}

static int es325_i2s_set_pll(struct snd_soc_dai *dai, int pll_id,
			     int source, unsigned int freq_in, unsigned int freq_out)
{
	struct snd_soc_codec *codec = dai->codec;
	int ret = 0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	return ret;
}

static int es325_i2s_set_clkdiv(struct snd_soc_dai *dai, int div_id,
				int div)
{
	struct snd_soc_codec *codec = dai->codec;
	int ret = 0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	return ret;
}

static int es325_i2s_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
{
	struct snd_soc_codec *codec = dai->codec;
	int ret = 0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	return ret;
}

static int es325_i2s_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
				  unsigned int rx_mask, int slots, int slot_width)
{
	struct snd_soc_codec *codec = dai->codec;
	int ret = 0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	return ret;
}

static int es325_i2s_set_channel_map(struct snd_soc_dai *dai, unsigned int tx_num,
				     unsigned int *tx_slot, unsigned int rx_num, unsigned int *rx_slot)
{
	struct snd_soc_codec *codec = dai->codec;
	int ret = 0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	return ret;
}

static int es325_i2s_set_tristate(struct snd_soc_dai *dai, int tristate)
{
	struct snd_soc_codec *codec = dai->codec;
	unsigned int paramid = 0;
	unsigned int val = 0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);

	switch (dai->id) {
	case 0:
		break;
	case 1:
		break;
	default:
		return -EINVAL;
	}

	if (tristate)
		val = 0x0001;
	else
		val = 0x0000;
	return snd_soc_write(codec, paramid, val);
}

static int es325_i2s_port_mute(struct snd_soc_dai *dai, int mute)
{
	struct snd_soc_codec *codec = dai->codec;
	unsigned int paramid = 0;
	unsigned int val = 0;

	/* Is this valid since DACs are not statically mapped to DAIs? */
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	switch (dai->id) {
	case 0:
		break;
	case 1:
		break;
	default:
		return -EINVAL;
	}

	if (mute)
		val = 0x0000;
	else
		val = 0x0001;
	return snd_soc_write(codec, paramid, val);
}

static int es325_i2s_startup(struct snd_pcm_substream *substream,
			     struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	int ret = 0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	return ret;
}

static void es325_i2s_shutdown(struct snd_pcm_substream *substream,
			       struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
}

static int es325_i2s_hw_params(struct snd_pcm_substream *substream,
			       struct snd_pcm_hw_params *params,
			       struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	/* struct es325_priv *es325 = snd_soc_codec_get_drvdata(codec); */
	int bits_per_sample = 0;
	int ret = 0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	switch (dai->id) {
	case 0:
		dev_dbg(codec->dev, "%s(): ES325_PORTA_PARAMID\n", __func__);
		break;
	case 1:
		dev_dbg(codec->dev, "%s(): ES325_PORTB_PARAMID\n", __func__);
		break;
	default:
		dev_dbg(codec->dev, "%s(): unknown port\n", __func__);
		dev_dbg(codec->dev, "%s(): exit\n", __func__);
		return -EINVAL;
	}

	dev_dbg(codec->dev, "%s(): params_channels(params) = %d\n", __func__,
		params_channels(params));
	switch (params_channels(params)) {
	case 1:
		dev_dbg(codec->dev, "%s(): 1 channel\n", __func__);
		break;
	case 2:
		dev_dbg(codec->dev, "%s(): 2 channels\n", __func__);
		break;
	case 4:
		dev_dbg(codec->dev, "%s(): 4 channels\n", __func__);
		break;
	default:
		dev_dbg(codec->dev, "%s(): unsupported number of channels\n",
			__func__);
		dev_dbg(codec->dev, "%s(): exit\n", __func__);
		return -EINVAL;
	}

	dev_dbg(codec->dev, "%s(): params_rate(params) = %d\n", __func__,
		params_rate(params));
	switch (params_rate(params)) {
	case 8000:
		dev_dbg(codec->dev, "%s(): 8000Hz\n", __func__);
		break;
	case 11025:
		dev_dbg(codec->dev, "%s(): 11025\n", __func__);
		break;
	case 16000:
		dev_dbg(codec->dev, "%s(): 16000\n", __func__);
		break;
	case 22050:
		dev_dbg(codec->dev, "%s(): 22050\n", __func__);
		break;
	case 32000:
		dev_dbg(codec->dev, "%s(): 32000\n", __func__);
		break;
	case 48000:
		dev_dbg(codec->dev, "%s(): 48000\n", __func__);
		break;
	case 96000:
		dev_dbg(codec->dev, "%s(): 96000\n", __func__);
		break;
	case 192000:
		dev_dbg(codec->dev, "%s(): 96000\n", __func__);
		break;
	default:
		dev_dbg(codec->dev, "%s(): unsupported rate = %d\n", __func__,
			params_rate(params));
		dev_dbg(codec->dev, "%s(): exit\n", __func__);
		return -EINVAL;
	}

	switch (params_format(params)) {
	case SNDRV_PCM_FORMAT_S16_LE:
		dev_dbg(codec->dev, "%s(): S16_LE\n", __func__);
		bits_per_sample = 16;
		break;
	case SNDRV_PCM_FORMAT_S16_BE:
		dev_dbg(codec->dev, "%s(): S16_BE\n", __func__);
		bits_per_sample = 16;
		break;
	case SNDRV_PCM_FORMAT_S20_3LE:
		dev_dbg(codec->dev, "%s(): S20_3LE\n", __func__);
		bits_per_sample = 20;
		break;
	case SNDRV_PCM_FORMAT_S20_3BE:
		dev_dbg(codec->dev, "%s(): S20_3BE\n", __func__);
		bits_per_sample = 20;
		break;
	case SNDRV_PCM_FORMAT_S24_LE:
		dev_dbg(codec->dev, "%s(): S24_LE\n", __func__);
		bits_per_sample = 24;
		break;
	case SNDRV_PCM_FORMAT_S24_BE:
		dev_dbg(codec->dev, "%s(): S24_BE\n", __func__);
		bits_per_sample = 24;
		break;
	case SNDRV_PCM_FORMAT_S32_LE:
		dev_dbg(codec->dev, "%s(): S32_LE\n", __func__);
		bits_per_sample = 32;
		break;
	case SNDRV_PCM_FORMAT_S32_BE:
		dev_dbg(codec->dev, "%s(): S32_BE\n", __func__);
		bits_per_sample = 32;
		break;
	default:
		dev_dbg(codec->dev, "%s(): unknown format\n", __func__);
		dev_dbg(codec->dev, "%s(): exit\n", __func__);
		return -EINVAL;
	}
	if (ret) {
		dev_dbg(codec->dev, "%s(): snd_soc_update_bits() failed\n",
			__func__);
		dev_dbg(codec->dev, "%s(): exit\n", __func__);
		return ret;
	}

	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
		dev_dbg(codec->dev, "%s(): PLAYBACK\n", __func__);
	else
		dev_dbg(codec->dev, "%s(): CAPTURE\n", __func__);

	dev_dbg(codec->dev, "%s(): exit\n", __func__);
	return ret;
}

static int es325_i2s_hw_free(struct snd_pcm_substream *substream,
			     struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	int ret = 0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);

	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
		dev_dbg(codec->dev, "%s(): PLAYBACK\n", __func__);
	else
		dev_dbg(codec->dev, "%s(): CAPTURE\n", __func__);
	return ret;
}

static int es325_i2s_prepare(struct snd_pcm_substream *substream,
			     struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	int ret = 0;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	return ret;
}

static int es325_i2s_trigger(struct snd_pcm_substream *substream,
			     int cmd, struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	int ret;
	dev_dbg(codec->dev, "%s(): entry dai->id = %d\n", __func__, dai->id);
	dev_dbg(codec->dev, "%s(): cmd = %d\n", __func__, cmd);
	return ret;
}
#endif

static int es325_slim_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
{
	return 0;
}

int es325_slim_set_channel_map(struct snd_soc_dai *dai, unsigned int tx_num,
			       unsigned int *tx_slot, unsigned int rx_num, unsigned int *rx_slot)
{
	struct es325_priv *es325 = &es325_priv;
	int id = dai->id;
	int i;
	int ret = 0;
	CDBG("%s(): entry dai->id = %d\n", __func__, dai->id);

	if (id == ES325_SLIM_1_PB ||
	    id == ES325_SLIM_2_PB ||
	    id == ES325_SLIM_3_PB) {
		es325->dai[DAI_INDEX(id)].ch_tot = rx_num;
		es325->dai[DAI_INDEX(id)].ch_act = 0;
		for (i = 0; i < rx_num; i++)
			es325->dai[DAI_INDEX(id)].ch_num[i] = rx_slot[i];
	} else if (id == ES325_SLIM_1_CAP ||
		 id == ES325_SLIM_2_CAP ||
		 id == ES325_SLIM_3_CAP) {
		es325->dai[DAI_INDEX(id)].ch_tot = tx_num;
		es325->dai[DAI_INDEX(id)].ch_act = 0;
		CDBG("GAC:%s() id = %d\n", __func__, id);
		CDBG("GAC:%s() ch_tot = %d\n", __func__, tx_num);
		for (i = 0; i < tx_num; i++) {
			es325->dai[DAI_INDEX(id)].ch_num[i] = tx_slot[i];
			CDBG("GAC:%s() tx_slot[] = %d\n", __func__, tx_slot[i]);
		}
	}
	return ret;
}
EXPORT_SYMBOL_GPL(es325_slim_set_channel_map);

int es325_slim_get_channel_map(struct snd_soc_dai *dai,
			       unsigned int *tx_num, unsigned int *tx_slot,
			       unsigned int *rx_num, unsigned int *rx_slot)
{
	struct es325_priv *es325 = &es325_priv;
	struct es325_slim_ch *rx = es325->slim_rx;
	struct es325_slim_ch *tx = es325->slim_tx;
	int id = dai->id;
	int i;
	int ret = 0;

	CDBG("GAC:%s(): dai->id = %d\n", __func__, dai->id);

	if (id == ES325_SLIM_1_PB) {
		*rx_num = es325_dai[DAI_INDEX(id)].playback.channels_max;
		CDBG("GAC:%s(): *rx_num = %d\n", __func__, *rx_num);
		for (i = 0; i < *rx_num; i++) {
			rx_slot[i] = rx[ES325_SLIM_1_PB_OFFSET + i].ch_num;
			CDBG("GAC:%s(): rx_slot[] = %d\n", __func__, rx_slot[i]);
		}
	} else if (id == ES325_SLIM_2_PB) {
		*rx_num = es325_dai[DAI_INDEX(id)].playback.channels_max;
		CDBG("GAC:%s(): *rx_num = %d\n", __func__, *rx_num);
		for (i = 0; i < *rx_num; i++) {
			rx_slot[i] = rx[ES325_SLIM_2_PB_OFFSET + i].ch_num;
			CDBG("GAC:%s(): rx_slot[] = %d\n", __func__, rx_slot[i]);
		}
	} else if (id == ES325_SLIM_3_PB) {
		*rx_num = es325_dai[DAI_INDEX(id)].playback.channels_max;
		CDBG("GAC:%s(): *rx_num = %d\n", __func__, *rx_num);
		for (i = 0; i < *rx_num; i++) {
			rx_slot[i] = rx[ES325_SLIM_3_PB_OFFSET + i].ch_num;
			CDBG("GAC:%s(): rx_slot[] = %d\n", __func__, rx_slot[i]);
		}
	} else if (id == ES325_SLIM_1_CAP) {
		*tx_num = es325_dai[DAI_INDEX(id)].capture.channels_max;
		CDBG("GAC:%s(): *tx_num = %d\n", __func__, *tx_num);
		for (i = 0; i < *tx_num; i++) {
			tx_slot[i] = tx[ES325_SLIM_1_CAP_OFFSET + i].ch_num;
			CDBG("GAC:%s(): tx_slot[] = %d\n", __func__, tx_slot[i]);
		}
	} else if (id == ES325_SLIM_2_CAP) {
		*tx_num = es325_dai[DAI_INDEX(id)].capture.channels_max;
		CDBG("GAC:%s(): *tx_num = %d\n", __func__, *tx_num);
		for (i = 0; i < *tx_num; i++) {
			tx_slot[i] = tx[ES325_SLIM_2_CAP_OFFSET + i].ch_num;
			CDBG("GAC:%s(): tx_slot[] = %d\n", __func__, tx_slot[i]);
		}
	} else if (id == ES325_SLIM_3_CAP) {
		*tx_num = es325_dai[DAI_INDEX(id)].capture.channels_max;
		for (i = 0; i < *tx_num; i++) {
			tx_slot[i] = tx[ES325_SLIM_3_CAP_OFFSET + i].ch_num;
			CDBG("GAC:%s(): tx_slot[] = %d\n", __func__, tx_slot[i]);
		}
	}
	return ret;
}
EXPORT_SYMBOL_GPL(es325_slim_get_channel_map);

static int es325_slim_set_tristate(struct snd_soc_dai *dai, int tristate)
{
	return 0;
}

static int es325_slim_port_mute(struct snd_soc_dai *dai, int mute)
{
	return 0;
}

static int es325_slim_startup(struct snd_pcm_substream *substream,
			      struct snd_soc_dai *dai)
{
	printk("es325_slim_startup*************\n");
	return 0;
}

static void es325_slim_shutdown(struct snd_pcm_substream *substream,
				struct snd_soc_dai *dai)
{
	printk("es325_slim_shutdown************* \n");
}

int es325_slim_hw_params(struct snd_pcm_substream *substream,
			 struct snd_pcm_hw_params *params,
			 struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	/* local codec access */
	/* struct es325_priv *es325 = snd_soc_codec_get_drvdata(codec); */
	/* remote codec access */
	struct es325_priv *es325 = &es325_priv;
	int id = dai->id;
	int channels;
	int rate;
	int ret = 0;
	dev_info(codec->dev, "GAC:%s(): stream_name playback= %s, capture=%s,id = %d \n", __func__,
		 es325_dai[DAI_INDEX(id)].playback.stream_name,
		 es325_dai[DAI_INDEX(id)].capture.stream_name,es325_dai[DAI_INDEX(id)].id);

	channels = params_channels(params);
	switch (channels) {
	case 1:
	case 2:
	case 3:
	case 4:
	case 5:
	case 6:
		es325->dai[DAI_INDEX(id)].ch_tot = channels;
		break;
	default:
		dev_err(codec->dev,
			"%s(): unsupported number of channels, %d\n",
			__func__, channels);
		return -EINVAL;
	}
	rate = params_rate(params);
	switch (rate) {
	case 8000:
	case 16000:
	case 32000:
	case 48000:
		es325->dai[DAI_INDEX(id)].rate = rate;
		break;
	default:
		dev_err(codec->dev,
			"%s(): unsupported rate, %d\n",
			__func__, rate);
		return -EINVAL;
	}

	return ret;
}
EXPORT_SYMBOL_GPL(es325_slim_hw_params);

static int es325_slim_hw_free(struct snd_pcm_substream *substream,
			      struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	int rc = 0;
	dev_dbg(codec->dev, "%s(): entry\n", __func__);
	return rc;
}

static int es325_slim_prepare(struct snd_pcm_substream *substream,
			      struct snd_soc_dai *dai)
{
	return 0;
}

int es325_slim_trigger(struct snd_pcm_substream *substream,
		       int cmd, struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	int id = dai->id;
	int ret = 0;
	dev_info(codec->dev, "GAC:%s(): stream_name = %s\n",
		 __func__,
		 es325_dai[DAI_INDEX(id)].playback.stream_name);
	dev_info(codec->dev, "GAC:%s(): id = %d\n",
		 __func__, es325_dai[DAI_INDEX(id)].id);
	dev_info(codec->dev, "GAC:%s(): cmd = %d\n",
		 __func__, cmd);

	return ret;
}
EXPORT_SYMBOL_GPL(es325_slim_trigger);

#define ES325_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |	\
		     SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |	\
		     SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |	\
		     SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
#define ES325_SLIMBUS_RATES (SNDRV_PCM_RATE_48000)

#define ES325_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE | \
		       SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S20_3BE | \
		       SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE | \
		       SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_BE)
#define ES325_SLIMBUS_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE)

#if defined(CONFIG_SND_SOC_ES325_I2S)
static struct snd_soc_dai_ops es325_portx_dai_ops = {
	.set_sysclk	= es325_i2s_set_sysclk,
	.set_pll	= es325_i2s_set_pll,
	.set_clkdiv	= es325_i2s_set_clkdiv,
	.set_fmt	= es325_i2s_set_dai_fmt,
	.set_tdm_slot	= es325_i2s_set_tdm_slot,
	.set_channel_map	= es325_i2s_set_channel_map,
	.set_tristate	= es325_i2s_set_tristate,
	.digital_mute	= es325_i2s_port_mute,
	.startup	= es325_i2s_startup,
	.shutdown	= es325_i2s_shutdown,
	.hw_params	= es325_i2s_hw_params,
	.hw_free	= es325_i2s_hw_free,
	.prepare	= es325_i2s_prepare,
	.trigger	= es325_i2s_trigger,
};
#endif

#if defined(CONFIG_SND_SOC_ES325_SLIM)
static struct snd_soc_dai_ops es325_slim_port_dai_ops = {
	.set_fmt	= es325_slim_set_dai_fmt,
	.set_channel_map	= es325_slim_set_channel_map,
	.get_channel_map	= es325_slim_get_channel_map,
	.set_tristate	= es325_slim_set_tristate,
	.digital_mute	= es325_slim_port_mute,
	.startup	= es325_slim_startup,
	.shutdown	= es325_slim_shutdown,
	.hw_params	= es325_slim_hw_params,
	.hw_free	= es325_slim_hw_free,
	.prepare	= es325_slim_prepare,
	.trigger	= es325_slim_trigger,
};
#endif

static struct snd_soc_dai_driver es325_dai[] = {
#if defined(CONFIG_SND_SOC_ES325_I2S)
/* initial support is for slimbus, not i2s */
	{
		.name = "es325-porta",
		.playback = {
			.stream_name = "PORTA Playback",
			.channels_min = 2,
			.channels_max = 2,
			.rates = ES325_RATES,
			.formats = ES325_FORMATS,
		},
		.capture = {
			.stream_name = "PORTA Capture",
			.channels_min = 2,
			.channels_max = 2,
			.rates = ES325_RATES,
			.formats = ES325_FORMATS,
		},
		.ops = &es325_portx_dai_ops,
	},
	{
		.name = "es325-portb",
		.playback = {
			.stream_name = "PORTB Playback",
			.channels_min = 2,
			.channels_max = 2,
			.rates = ES325_RATES,
			.formats = ES325_FORMATS,
		},
		.capture = {
			.stream_name = "PORTB Capture",
			.channels_min = 2,
			.channels_max = 2,
			.rates = ES325_RATES,
			.formats = ES325_FORMATS,
		},
		.ops = &es325_portx_dai_ops,
	},
	{
		.name = "es325-portc",
		.playback = {
			.stream_name = "PORTC Playback",
			.channels_min = 2,
			.channels_max = 2,
			.rates = ES325_RATES,
			.formats = ES325_FORMATS,
		},
		.capture = {
			.stream_name = "PORTC Capture",
			.channels_min = 2,
			.channels_max = 2,
			.rates = ES325_RATES,
			.formats = ES325_FORMATS,
		},
		.ops = &es325_portx_dai_ops,
	},
#endif
#if defined(CONFIG_SND_SOC_ES325_SLIM)
	{
		.name = "es325-slim-rx1",
		.id = ES325_SLIM_1_PB,
		.playback = {
			.stream_name = "SLIM_PORT-1 Playback",
			.channels_min = 1,
			.channels_max = 2,
			.rates = ES325_SLIMBUS_RATES,
			.formats = ES325_SLIMBUS_FORMATS,
		},
		.ops = &es325_slim_port_dai_ops,
	},
	{
		.name = "es325-slim-tx1",
		.id = ES325_SLIM_1_CAP,
		.capture = {
			.stream_name = "SLIM_PORT-1 Capture",
			.channels_min = 1,
			.channels_max = 2,
			.rates = ES325_SLIMBUS_RATES,
			.formats = ES325_SLIMBUS_FORMATS,
		},
		.ops = &es325_slim_port_dai_ops,
	},
	{
		.name = "es325-slim-rx2",
		.id = ES325_SLIM_2_PB,
		.playback = {
			.stream_name = "SLIM_PORT-2 Playback",
			.channels_min = 1,
			.channels_max = 2,
			.rates = ES325_SLIMBUS_RATES,
			.formats = ES325_SLIMBUS_FORMATS,
		},
		.ops = &es325_slim_port_dai_ops,
	},
	{
		.name = "es325-slim-tx2",
		.id = ES325_SLIM_2_CAP,
		.capture = {
			.stream_name = "SLIM_PORT-2 Capture",
			.channels_min = 1,
			.channels_max = 2,
			.rates = ES325_SLIMBUS_RATES,
			.formats = ES325_SLIMBUS_FORMATS,
		},
		.ops = &es325_slim_port_dai_ops,
	},
	{
		.name = "es325-slim-rx3",
		.id = ES325_SLIM_3_PB,
		.playback = {
			.stream_name = "SLIM_PORT-3 Playback",
			.channels_min = 1,
			.channels_max = 2,
			.rates = ES325_SLIMBUS_RATES,
			.formats = ES325_SLIMBUS_FORMATS,
		},
		.ops = &es325_slim_port_dai_ops,
	},
	{
		.name = "es325-slim-tx3",
		.id = ES325_SLIM_3_CAP,
		.capture = {
			.stream_name = "SLIM_PORT-3 Capture",
			.channels_min = 1,
			.channels_max = 2,
			.rates = ES325_SLIMBUS_RATES,
			.formats = ES325_SLIMBUS_FORMATS,
		},
		.ops = &es325_slim_port_dai_ops,
	},
#endif
};

#ifdef CONFIG_PM
static int es325_codec_suspend(struct snd_soc_codec *codec)
{
	struct es325_priv *es325 = snd_soc_codec_get_drvdata(codec);

	es325_set_bias_level(codec, SND_SOC_BIAS_OFF);

	es325_sleep(es325);

	return 0;
}

static int es325_codec_resume(struct snd_soc_codec *codec)
{
	struct es325_priv *es325 = snd_soc_codec_get_drvdata(codec);

	es325_wakeup(es325);

	es325_set_bias_level(codec, SND_SOC_BIAS_STANDBY);

	return 0;
}

#else
#define es325_codec_suspend NULL
#define es325_codec_resume NULL
#endif

int es325_remote_add_codec_controls(struct snd_soc_codec *codec)
{
	int rc;
	dev_info(codec->dev, "%s(): entry codec->name = %s\n", __func__, codec->name);

	rc = snd_soc_add_codec_controls(codec, es325_digital_ext_snd_controls,
					ARRAY_SIZE(es325_digital_ext_snd_controls));
	if (rc)
		dev_err(codec->dev, "%s(): es325_digital_ext_snd_controls failed\n", __func__);
	return rc;
}

static int es325_codec_probe(struct snd_soc_codec *codec)
{
	struct es325_priv *es325 = snd_soc_codec_get_drvdata(codec);
	dev_info(codec->dev, "%s(): entry codec->name = %s\n", __func__, codec->name);
	dev_info(codec->dev, "%s(): codec = 0x%08x\n", __func__,
		 (unsigned int)codec);
	dev_info(codec->dev, "%s(): es325 = 0x%08x\n", __func__,
		 (unsigned int)es325);
	es325->codec = codec;

	codec->control_data = snd_soc_codec_get_drvdata(codec);
	dev_info(codec->dev, "%s(): codec->control_data = 0x%08x\n", __func__, (unsigned int)codec->control_data);

	es325_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
	return 0;
}

static int  es325_codec_remove(struct snd_soc_codec *codec)
{
	struct es325_priv *es325 = snd_soc_codec_get_drvdata(codec);
	es325_set_bias_level(codec, SND_SOC_BIAS_OFF);
	kfree(es325);
	return 0;
}

static struct snd_soc_codec_driver soc_codec_dev_es325 = {
	.probe =	es325_codec_probe,
	.remove =	es325_codec_remove,
	.suspend =	es325_codec_suspend,
	.resume =	es325_codec_resume,
	.read =		es325_read,
	.write =	es325_write,
	.set_bias_level =	es325_set_bias_level,
};

#if defined(CONFIG_SND_SOC_ES325_I2C)
static int es325_i2c_probe(struct i2c_client *i2c,
			   const struct i2c_device_id *id)
{
	struct esxxx_platform_data *pdata = i2c->dev.platform_data;
	struct es325_priv *es325;
	const char *filename = "audience-es325-fw.bin";
	int rc;

	dev_dbg(&i2c->dev, "%s(): entry\n", __func__);
	if (pdata == NULL) {
		dev_err(&i2c->dev, "%s(): pdata is NULL", __func__);
		rc = -EIO;
		goto pdata_error;
	}

	es325 = kzalloc(sizeof(struct es325_priv), GFP_KERNEL);
	if (es325 == NULL) {
		dev_err(&i2c->dev, "%s(): kzalloc failed", __func__);
		return -ENOMEM;
	}
	i2c_set_clientdata(i2c, es325);
	es325->this_client = i2c;

	rc = gpio_request(pdata->reset_gpio, "es325_reset");
	if (rc < 0) {
		dev_err(&i2c->dev, "%s(): es325_reset request failed",
			__func__);
		goto reset_gpio_request_error;
	}
	rc = gpio_direction_output(pdata->reset_gpio, 1);
	if (rc < 0) {
		dev_err(&i2c->dev, "%s(): es325_reset direction failed",
			__func__);
		goto reset_gpio_direction_error;
	}

	rc = gpio_request(pdata->wakeup_gpio, "es325_wakeup");
	if (rc < 0) {
		dev_err(&i2c->dev, "%s(): es325_wakeup request failed",
			__func__);
		goto wakeup_gpio_request_error;
	}
	rc = gpio_direction_output(pdata->wakeup_gpio, 1);
	if (rc < 0) {
		dev_err(&i2c->dev, "%s(): es325_wakeup direction failed",
			__func__);
		goto wakeup_gpio_direction_error;
	}

	dev_dbg(&i2c->dev, "%s(): initialize interrupt\n", __func__);
	dev_dbg(&i2c->dev, "%s(): TODO: interrupts\n", __func__);

	rc = gpio_request(pdata->gpioa_gpio, "es325_gpioa");
	if (rc < 0) {
		dev_err(&i2c->dev, "%s(): es325_gpioa request failed",
			__func__);
		goto gpioa_gpio_request_error;
	}
	rc = gpio_direction_input(pdata->gpioa_gpio);
	if (rc < 0) {
		dev_err(&i2c->dev, "%s(): es325_gpioa direction failed",
			__func__);
		goto gpioa_gpio_direction_error;
	}

	rc = gpio_request(pdata->gpiob_gpio, "es325_gpiob");
	if (rc < 0) {
		dev_err(&i2c->dev, "%s(): es325_gpiob request failed",
			__func__);
		goto gpiob_gpio_request_error;
	}
	rc = gpio_direction_input(pdata->gpiob_gpio);
	if (rc < 0) {
		dev_err(&i2c->dev, "%s(): es325_gpiob direction failed",
			__func__);
		goto gpiob_gpio_direction_error;
	}

	gpio_set_value(pdata->reset_gpio, 0);
	gpio_set_value(pdata->wakeup_gpio, 1);

	es325->pdata = pdata;
#ifdef VOICE_SENSE
            rc = request_firmware(&es325->standard, filename, &i2c->dev);
            dev_dbg(&sbdev->dev, "%s(): request_firmware %s\n", __func__, filename);
#else
            rc = request_firmware(&es325->fw, filename, &i2c->dev);
            dev_dbg(&sbdev->dev, "%s(): request_firmware %s\n", __func__, filename);
#endif	
	if (rc) {
		dev_err(&i2c->dev, "%s(): request_firmware(%s) failed %d\n",
			__func__, filename, rc);
		goto request_firmware_error;
	}
	rc = es325_bootup(es325);
	if (rc) {
		dev_err(&i2c->dev, "%s(): es325_bootup failed %d\n",
			__func__, rc);
		goto bootup_error;
	}
#ifdef VOICE_SENSE
	release_firmware(es325->standard);
#else
	release_firmware(es325->fw);
#endif
	rc = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_es325, es325_dai,
				    ARRAY_SIZE(es325_dai));
	dev_dbg(&i2c->dev, "%s():exit  rc = snd_soc_regsiter_codec() = %d\n", __func__, rc);
	return rc;

bootup_error:
request_firmware_error:
gpiob_request_irq_error:
gpiob_gpio_direction_error:
	gpio_free(pdata->gpiob_gpio);
gpiob_gpio_request_error:
gpioa_request_irq_error:
gpioa_gpio_direction_error:
	gpio_free(pdata->gpioa_gpio);
gpioa_gpio_request_error:
wakeup_gpio_direction_error:
	gpio_free(pdata->wakeup_gpio);
wakeup_gpio_request_error:
reset_gpio_direction_error:
	gpio_free(pdata->reset_gpio);
reset_gpio_request_error:
pdata_error:
	dev_dbg(&i2c->dev, "%s(): exit with error\n", __func__);
	return rc;
}

static int es325_i2c_remove(struct i2c_client *i2c)
{
	struct esxxx_platform_data *pdata = i2c->dev.platform_data;
	gpio_free(pdata->reset_gpio);
	gpio_free(pdata->wakeup_gpio);
	gpio_free(pdata->gpioa_gpio);
	snd_soc_unregister_codec(&i2c->dev);
	kfree(i2c_get_clientdata(i2c));
	return 0;
}

static const struct i2c_device_id es325_i2c_id[] = {
	{ "es325", 0},
	{ }
};
MODULE_DEVICE_TABLE(i2c, es325_i2c_id);

static struct i2c_driver es325_i2c_driver = {
	.driver = {
		.name = "es325-codec",
		.owner = THIS_MODULE,
	},
	.probe = es325_i2c_probe,
	.remove = es325_i2c_remove,
	.id_table = es325_i2c_id,
};
#else
static int es325_slim_device_up(struct slim_device *sbdev);
static int es325_fw_thread(void *priv)
{
	struct es325_priv *es325 = (struct es325_priv *)priv;

	do {
		slim_get_logical_addr(es325->gen0_client,
				      es325->gen0_client->e_addr,
				      6, &(es325->gen0_client->laddr));
		usleep_range(1000, 2000);
	} while (es325->gen0_client->laddr == 0xf0);
	dev_dbg(&es325->gen0_client->dev, "%s(): gen0_client LA = %d\n",
		__func__, es325->gen0_client->laddr);
	do {
		slim_get_logical_addr(es325->intf_client,
				      es325->intf_client->e_addr,
				      6, &(es325->intf_client->laddr));
		usleep_range(1000, 2000);
	} while (es325->intf_client->laddr == 0xf0);
	dev_dbg(&es325->intf_client->dev, "%s(): intf_client LA = %d\n",
		__func__, es325->intf_client->laddr);
	es325_slim_device_up(es325->gen0_client);
	return 0;
}
static int es325_dt_parse_slim_interface_dev_info(struct device *dev,
						struct slim_device *slim_ifd)
{
	struct property *prop;
	u8* e_addr;

	prop = of_find_property(dev->of_node,
			"elemental-addr", NULL);
	if (!prop) {
		dev_err(dev, "Looking up %s property in node %s failed",
			"elemental-addr",
			dev->of_node->full_name);
		return -ENODEV;
	} else if (prop->length != 6) {
		dev_err(dev, "invalid codec slim ifd addr. addr length = %d\n",
			      prop->length);
		return -ENODEV;
	}
	memcpy(slim_ifd->e_addr, prop->value, 6);

	e_addr = (u8*)prop->value;
	dev_dbg(dev, "eaddr:%02x %02x %02x %02x %02x %02x\n", 
		e_addr[0], e_addr[1], e_addr[2], e_addr[3], e_addr[4], e_addr[5]);

	return 0;
}

static int es325_clk_ctl(int enable)
{
	int ret = 0;
	
	if(enable)
		ret = ES325_CLK_ENALBE(codec_clk);
	else
		ret = ES325_CLK_DISABLE(codec_clk);
	
	if(EINVAL!=ret)
		ret = 0;
	return ret;
}

static struct esxxx_platform_data *es325_populate_dt_pdata(struct device *dev, struct slim_device *slim_ifd)
{
	struct esxxx_platform_data *pdata;

	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
	if (!pdata) {
		dev_err(dev, "could not allocate memory for platform data\n");
		return NULL;
	}

	es325_dt_parse_slim_interface_dev_info(dev, slim_ifd);

	pdata->reset_gpio = of_get_named_gpio(dev->of_node,
				"adnc,reset-gpio", 0);
	if (pdata->reset_gpio < 0) {
		dev_err(dev, "Looking up %s property in node %s failed %d\n",
			"adnc,reset-gpio", dev->of_node->full_name,
			pdata->reset_gpio);
		goto err;
	}
#ifndef CONFIG_SND_SOC_ES325_UART
	pdata->wakeup_gpio= of_get_named_gpio(dev->of_node,
				"adnc,wakeup-gpio", 0);
	if (pdata->wakeup_gpio < 0) {
		dev_err(dev, "Looking up %s property in node %s failed %d\n",
			"adnc,wakeup-gpio", dev->of_node->full_name,
			pdata->wakeup_gpio);
		goto err;
	}
#endif

#ifdef VOICE_SENSE
	pdata->int_gpio= of_get_named_gpio(dev->of_node,
				"adnc,int-gpio", 0);
	if (pdata->int_gpio < 0) {
		dev_err(dev, "Looking up %s property in node %s failed %d\n",
			"adnc,int-gpio", dev->of_node->full_name,
			pdata->int_gpio);
		goto err;
	}
#endif

	CDBG("%s: int gpio %d,reset gpio %d", __func__, 
			pdata->int_gpio,pdata->reset_gpio);

	codec_clk = ES325_CLK_GET(dev, ES325_CLK_NAME);
	if (IS_ERR(codec_clk)) {
		dev_err(dev,
			"%s: Failed to request es325 mclk from pmic %ld\n",
			__func__, PTR_ERR(codec_clk));
		goto err;
	}else
		pdata->es325_clk_cb = es325_clk_ctl;

	return pdata;
err:
	devm_kfree(dev, pdata);
	return NULL;
}

int32_t es325_get_dt_vreg_data(struct device_node *of_node,
	struct es325_vreg_t **es325_vreg, int *num_vreg)
{
	int32_t rc = 0, i = 0;
	uint32_t count = 0;
	uint32_t *vreg_array = NULL;
	struct es325_vreg_t *vreg = NULL;

	count = of_property_count_strings(of_node, "adnc,es325-vreg-name");
	CDBG("%s adnc,es325-vreg-name count %d\n", __func__, count);

	if (!count)
		return 0;

	vreg = kzalloc(sizeof(struct es325_vreg_t) * count,
		GFP_KERNEL);
	if (!vreg) {
		pr_err("%s failed %d\n", __func__, __LINE__);
		return -ENOMEM;
	}
	*es325_vreg = vreg;
	*num_vreg = count;
	
	for (i = 0; i < count; i++) {
		rc = of_property_read_string_index(of_node,
			"adnc,es325-vreg-name", i,
			&vreg[i].reg_name);
		CDBG("%s reg_name[%d] = %s\n", __func__, i,
			vreg[i].reg_name);
		if (rc < 0) {
			pr_err("%s failed %d\n", __func__, __LINE__);
			goto ERROR1;
		}
	}

	vreg_array = kzalloc(sizeof(uint32_t) * count, GFP_KERNEL);
	if (!vreg_array) {
		pr_err("%s failed %d\n", __func__, __LINE__);
		rc = -ENOMEM;
		goto ERROR1;
	}

	rc = of_property_read_u32_array(of_node, "adnc,es325-vreg-type",
		vreg_array, count);
	if (rc < 0) {
		pr_err("%s failed %d\n", __func__, __LINE__);
		goto ERROR2;
	}
	for (i = 0; i < count; i++) {
		vreg[i].type = vreg_array[i];
		CDBG("%s es325_vreg[%d].type = %d\n", __func__, i,
			vreg[i].type);
	}

	rc = of_property_read_u32_array(of_node, "adnc,es325-vreg-min-voltage",
		vreg_array, count);
	if (rc < 0) {
		pr_err("%s failed %d\n", __func__, __LINE__);
		goto ERROR2;
	}
	for (i = 0; i < count; i++) {
		vreg[i].min_voltage = vreg_array[i];
		CDBG("%s es325_vreg[%d].min_voltage = %d\n", __func__,
			i, vreg[i].min_voltage);
	}

	rc = of_property_read_u32_array(of_node, "adnc,es325-vreg-max-voltage",
		vreg_array, count);
	if (rc < 0) {
		pr_err("%s failed %d\n", __func__, __LINE__);
		goto ERROR2;
	}
	for (i = 0; i < count; i++) {
		vreg[i].max_voltage = vreg_array[i];
		CDBG("%s es325_vreg[%d].max_voltage = %d\n", __func__,
			i, vreg[i].max_voltage);
	}

	rc = of_property_read_u32_array(of_node, "adnc,es325-vreg-op-mode",
		vreg_array, count);
	if (rc < 0) {
		pr_err("%s failed %d\n", __func__, __LINE__);
		goto ERROR2;
	}
	for (i = 0; i < count; i++) {
		vreg[i].op_mode = vreg_array[i];
		CDBG("%s es325_vreg[%d].op_mode = %d\n", __func__, i,
			vreg[i].op_mode);
	}

	kfree(vreg_array);
	return rc;
ERROR2:
	kfree(vreg_array);
ERROR1:
	kfree(vreg);
	*num_vreg = 0;
	return rc;
}

int es325_config_single_vreg(struct device *dev,
	struct es325_vreg_t *es325_vreg, struct regulator **reg_ptr, int config)
{
	int rc = 0;
	if (config) {
		CDBG("%s enable %s\n", __func__, es325_vreg->reg_name);
		*reg_ptr = regulator_get(dev, es325_vreg->reg_name);
		if (IS_ERR(*reg_ptr)) {
			pr_err("%s: %s get failed\n", __func__,
				es325_vreg->reg_name);
			*reg_ptr = NULL;
			goto vreg_get_fail;
		}
		if (es325_vreg->type == REG_LDO) {
			rc = regulator_set_voltage(
				*reg_ptr, es325_vreg->min_voltage,
				es325_vreg->max_voltage);
			if (rc < 0) {
				pr_err("%s: %s set voltage failed\n",
					__func__, es325_vreg->reg_name);
				goto vreg_set_voltage_fail;
			}
			if (es325_vreg->op_mode >= 0) {
				rc = regulator_set_optimum_mode(*reg_ptr,
					es325_vreg->op_mode);
				CDBG("regulator_set_optimum_mode\n");
				if (rc < 0) {
					pr_err(
					"%s: %s set optimum mode failed\n",
					__func__, es325_vreg->reg_name);
					goto vreg_set_opt_mode_fail;
				}
			}
		}
		rc = regulator_enable(*reg_ptr);
		if (rc < 0) {
			pr_err("%s: %s enable failed\n",
				__func__, es325_vreg->reg_name);
			goto vreg_unconfig;
		}
	} else {
		if (*reg_ptr) {
			CDBG("%s disable %s\n", __func__, es325_vreg->reg_name);
			regulator_disable(*reg_ptr);
			if (es325_vreg->type == REG_LDO) {
				if (es325_vreg->op_mode >= 0)
					regulator_set_optimum_mode(*reg_ptr, 0);
				regulator_set_voltage(
					*reg_ptr, 0, es325_vreg->max_voltage);
			}
			regulator_put(*reg_ptr);
			*reg_ptr = NULL;
		}
	}
	return 0;

vreg_unconfig:
if (es325_vreg->type == REG_LDO)
	regulator_set_optimum_mode(*reg_ptr, 0);

vreg_set_opt_mode_fail:
if (es325_vreg->type == REG_LDO)
	regulator_set_voltage(*reg_ptr, 0, es325_vreg->max_voltage);

vreg_set_voltage_fail:
	regulator_put(*reg_ptr);
	*reg_ptr = NULL;

vreg_get_fail:
	return -ENODEV;
}



static int es325_slim_probe(struct slim_device *sbdev)
{
	struct es325_vreg_t *es325_vreg;
	int num_vreg;
	struct regulator *reg_ptr = reg_ptr;
	struct esxxx_platform_data *pdata;
#ifndef CONFIG_SND_SOC_ES325_UART // wangtao  boot download use uart   
	const char *filename = "audience-es325-fw.bin";
#endif		
	int rc;
	struct task_struct *thread = NULL;

       thread = thread;
	dev_dbg(&sbdev->dev, "%s(): entry sbdev->name = %s\n", __func__, sbdev->name);

	if (sbdev->dev.of_node) {
		dev_info(&sbdev->dev, "Platform data from device tree\n");
		pdata = es325_populate_dt_pdata(&sbdev->dev, sbdev);
		sbdev->dev.platform_data = pdata;
	} else {
		dev_info(&sbdev->dev, "Platform data from board file\n");
		pdata = sbdev->dev.platform_data;
	}

	if (pdata == NULL) {
		dev_err(&sbdev->dev, "%s(): pdata is NULL", __func__);
		rc = -EIO;
		goto pdata_error;
	}

	rc = device_create_file(&sbdev->dev, &dev_attr_route_status);
	if (rc)
		dev_err(&sbdev->dev, "%s(): error file sysfs create\n", __func__);
	rc = device_create_file(&sbdev->dev, &dev_attr_route_config);
	if (rc)
		dev_err(&sbdev->dev, "%s(): error file sysfs create\n", __func__);
	rc = device_create_file(&sbdev->dev, &dev_attr_txhex);
	if (rc)
		dev_err(&sbdev->dev, "%s(): error file sysfs create\n", __func__);
	
	rc = device_create_file(&sbdev->dev, &dev_attr_esxxx_test);
	if (rc)
		dev_err(&sbdev->dev, "%s(): error file sysfs create\n", __func__);
#ifdef VOICE_SENSE

#ifdef ABORT_TEST//Richard 11.23
	g_sec_to_abort = 0;
#endif	

#ifdef ABORT_TEST//Richard 11.23
	rc = device_create_file(&sbdev->dev, &dev_attr_abort_sec);
		if (rc)
			dev_err(&sbdev->dev, "%s(): error abort_sec sysfs create\n",
				__func__);
	pr_err("%s(): abort_sec sysfs create rc=%d\n", __func__, rc);	
#endif
	rc = device_create_file(&sbdev->dev, &dev_attr_vs_keyword_parameters);
	if (rc)
		dev_err(&sbdev->dev, "%s(): vs_keyword_parameters sysfs create\n",
			__func__);
	
	rc = device_create_file(&sbdev->dev, &dev_attr_vs_status);
	if (rc)
		dev_err(&sbdev->dev, "%s(): vs_status sysfs create\n",
			__func__);	
	
	rc = device_create_file(&sbdev->dev, &dev_attr_vs_fw_load_status);
	if (rc)
		dev_err(&sbdev->dev, "%s(): vs_fw_load_status sysfs create\n",
			__func__);

	rc = device_create_file(&sbdev->dev, &dev_attr_ping_status);
	if (rc)
		dev_err(&sbdev->dev, "%s(): ping_status sysfs create\n",
			__func__);
	
	rc = device_create_file(&sbdev->dev,
				&dev_attr_vs_keyword_parameter_size);
	if (rc)
		dev_err(&sbdev->dev, "%s(): vs_keyword_parameter_Size sysfs create\n",
			__func__);
#endif

	slim_set_clientdata(sbdev, &es325_priv);
	if (strcmp(sbdev->name, "es325-codec-intf") == 0) {
		dev_dbg(&sbdev->dev, "%s(): interface device probe\n", __func__);
		es325_priv.intf_client = sbdev;
	}
	if (strcmp(sbdev->name, "es325-codec-gen0") == 0) {
		dev_dbg(&sbdev->dev, "%s(): generic device probe\n", __func__);
		es325_priv.gen0_client = sbdev;
	}

	if (es325_priv.intf_client == NULL ||
	    es325_priv.gen0_client == NULL) {
		dev_dbg(&sbdev->dev, "%s() incomplete initialization\n",
			__func__);
		return 0;
	}

	es325_get_dt_vreg_data(sbdev->dev.of_node, &es325_vreg, &num_vreg);
	es325_config_single_vreg(&sbdev->dev, es325_vreg, &reg_ptr, 1);

	if (pdata->es325_clk_cb)
		pdata->es325_clk_cb(1);
	
	rc = gpio_request(pdata->reset_gpio, "es325_reset");
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): es325_reset request failed",
			__func__);
		goto reset_gpio_request_error;
	}
	rc = gpio_direction_output(pdata->reset_gpio, 0);
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): es325_reset direction failed",
			__func__);
		goto reset_gpio_direction_error;
	}
	gpio_set_value(pdata->reset_gpio, 0);
	dev_dbg(&sbdev->dev, "%s(): after set the reset gpio level is %d\n", __func__, __gpio_get_value(pdata->reset_gpio));	

#ifndef CONFIG_SND_SOC_ES325_UART
	rc = gpio_request(pdata->wakeup_gpio, "es325_wakeup");
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): es325_wakeup request failed",
			__func__);
		goto wakeup_gpio_request_error;
	}
	rc = gpio_direction_output(pdata->wakeup_gpio, 1);
	if (rc < 0) {
		dev_err(&sbdev->dev, "%s(): es325_wakeup direction failed",
			__func__);
		goto wakeup_gpio_direction_error;
	}
	gpio_set_value(pdata->wakeup_gpio, 1);
	gpio_direction_input(pdata->wakeup_gpio);
	dev_dbg(&sbdev->dev, "%s(): after set the wakeup gpio level is %d\n", __func__, __gpio_get_value(pdata->wakeup_gpio));
#endif

	gpio_set_value(pdata->reset_gpio, 0);
	mdelay(1);
	gpio_set_value(pdata->reset_gpio, 1);
	mdelay(50);

	es325_priv.pdata = pdata;

	mutex_init(&es325_priv.pm_mutex);
#ifdef VOICE_SENSE
	mutex_init(&es325_priv.api_mutex);
	mutex_init(&es325_priv.abort_mutex);
	es325_priv.vs_abort_req=0;
#ifndef CONFIG_SND_SOC_ES325_UART // wangtao  boot download use uart 
	rc = request_firmware((const struct firmware **)&es325_priv.standard,
	      			filename, &sbdev->dev);
	if (rc) {
		dev_err(&sbdev->dev, "%s(): request_firmware(%s) failed %d\n", __func__, filename, rc);
		goto request_firmware_error;
	}
#endif
#else
	rc = request_firmware((const struct firmware **)&es325_priv.fw,
			      filename, &sbdev->dev);
	if (rc) {
		dev_err(&sbdev->dev, "%s(): request_firmware(%s) failed %d\n", __func__, filename, rc);
		goto request_firmware_error;
	}
#endif		 
	
#if !defined(ES325_DEVICE_UP)
	thread = kthread_run(es325_fw_thread, &es325_priv, "audience thread");
	if (IS_ERR(thread)) {
		dev_err(&sbdev->dev, "%s(): can't create es325 firmware thread = %p\n", __func__, thread);
		return -1;
	}
#endif
	return 0;
#ifndef CONFIG_SND_SOC_ES325_UART // wangtao  boot download use uart 
request_firmware_error:
wakeup_gpio_direction_error:
	gpio_free(pdata->wakeup_gpio);
wakeup_gpio_request_error:
#endif	
reset_gpio_direction_error:
	gpio_free(pdata->reset_gpio);
reset_gpio_request_error:
	gpio_free(pdata->reset_gpio);
pdata_error:
	dev_dbg(&sbdev->dev, "%s(): exit with error\n", __func__);
	return rc;
}

static int register_snd_soc(struct es325_priv *priv)
{
	int rc;
	int i;
	int ch_cnt;
	struct slim_device *sbdev = priv->gen0_client;
#ifdef VOICE_SENSE
	struct esxxx_platform_data *pdata = sbdev->dev.platform_data;
#endif

	rc = es325_init_slim_slave(sbdev);

	dev_dbg(&sbdev->dev, "%s(): name = %s\n", __func__, sbdev->name);
	rc = snd_soc_register_codec(&sbdev->dev, &soc_codec_dev_es325, es325_dai,
				    ARRAY_SIZE(es325_dai));
	if(rc<0)
		dev_err(&sbdev->dev, "%s(): rc = snd_soc_regsiter_codec() = %d\n", __func__, rc);

	/* allocate ch_num array for each DAI */
	for (i = 0; i < ARRAY_SIZE(es325_dai); i++) {
		switch (es325_dai[i].id) {
		case ES325_SLIM_1_PB:
		case ES325_SLIM_2_PB:
		case ES325_SLIM_3_PB:
			ch_cnt = es325_dai[i].playback.channels_max;
			break;
		case ES325_SLIM_1_CAP:
		case ES325_SLIM_2_CAP:
		case ES325_SLIM_3_CAP:
			ch_cnt = es325_dai[i].capture.channels_max;
			break;
		default:
			continue;
		}
		es325_priv.dai[i].ch_num =
			kzalloc((ch_cnt * sizeof(unsigned int)), GFP_KERNEL);
	}
#if defined(CONFIG_SND_SOC_WCD9310)
	/* front end for RX1 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_1_PB)].ch_num[0] = 152;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_1_PB)].ch_num[1] = 153;
	/* back end for RX1 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_2_CAP)].ch_num[0] = 138;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_2_CAP)].ch_num[1] = 139;
	/* front end for TX1 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_1_CAP)].ch_num[0] = 156;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_1_CAP)].ch_num[1] = 157;
	/* back end for TX1 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_3_PB)].ch_num[0] = 134;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_3_PB)].ch_num[1] = 135;
	/* front end for RX2 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_2_PB)].ch_num[0] = 154;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_2_PB)].ch_num[1] = 155;
	/* back end for RX2 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_3_CAP)].ch_num[0] = 143;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_3_CAP)].ch_num[1] = 144;
#elif defined(CONFIG_SND_SOC_WCD9320)
	/* front end for RX1 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_1_PB)].ch_num[0] = 152;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_1_PB)].ch_num[1] = 153;
	/* back end for RX1 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_2_CAP)].ch_num[0] = 144;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_2_CAP)].ch_num[1] = 145;
	/* front end for TX1 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_1_CAP)].ch_num[0] = 156;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_1_CAP)].ch_num[1] = 157;
	/* back end for TX1 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_3_PB)].ch_num[0] = 134;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_3_PB)].ch_num[1] = 135;
	/* front end for RX2 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_2_PB)].ch_num[0] = 154;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_2_PB)].ch_num[1] = 155;
	/* back end for RX2 */
	es325_priv.dai[DAI_INDEX(ES325_SLIM_3_CAP)].ch_num[0] = 146;
	es325_priv.dai[DAI_INDEX(ES325_SLIM_3_CAP)].ch_num[1] = 147;
#else
#error "no CODEC port to channel map specified"
#endif

#ifdef VOICE_SENSE
//Richard new
	/* No keyword parameters available until set. */
	es325_priv.vs_keyword_param_size = 0;
	es325_priv.vs_keyword_param_next_index_write = 0;
	es325_priv.vs_keyword_param_next_index_read = 0;

	/* No keyword parameters available until set. */
 	if (pdata->int_gpio) {
		rc = gpio_request(pdata->int_gpio, "es325_int");
		if (rc < 0) {
			dev_err(&sbdev->dev, "%s(): es325 int_gpio request failed",
				__func__);
		}else{
			rc = gpio_direction_input(pdata->int_gpio);
			if (rc < 0) {
				dev_err(&sbdev->dev, "%s(): es325 int_gpio direction failed",
					__func__);
			}else{	
				rc = request_threaded_irq(gpio_to_irq(pdata->int_gpio), NULL,
						es325_irq_work, IRQF_TRIGGER_FALLING,
						"es325-irq-work", &es325_priv);
				if (rc) {
					dev_err(&sbdev->dev, "%s(): request_irq() failed\n",
						__func__);
				} else {
					rc = irq_set_irq_wake(gpio_to_irq(pdata->int_gpio), 1);
					if (rc < 0)
						dev_err(&sbdev->dev, "%s(): set irq wake failed\n",
							__func__);
					enable_irq(gpio_to_irq(pdata->int_gpio));
				}
				dev_info(&sbdev->dev, "%s(): set irq wake OK\n",__func__);
			}
		}
	}
	if (pdata->irq_base) {
		rc = request_threaded_irq(pdata->irq_base, NULL,
					  es325_irq_work, IRQF_TRIGGER_FALLING,
					  "es325-irq-work", &es325_priv);
		if (rc) {
			dev_err(&sbdev->dev, "%s(): request_irq() failed\n",
				__func__);
		} else {
			rc = irq_set_irq_wake(pdata->irq_base, 1);
			if (rc < 0)
				dev_err(&sbdev->dev, "%s(): set irq wake failed\n",
					__func__);
		}
	}
	wake_lock_init(&es325_VS_lock, WAKE_LOCK_SUSPEND, "es325_VS_lock");
#endif
	return rc;
}

static int es325_slim_remove(struct slim_device *sbdev)
{
	struct esxxx_platform_data *pdata = sbdev->dev.platform_data;
	dev_dbg(&sbdev->dev, "%s(): entry sbdev->name = %s\n", __func__, sbdev->name);
	gpio_free(pdata->reset_gpio);
#ifndef CONFIG_SND_SOC_ES325_UART
	gpio_free(pdata->wakeup_gpio);
#endif	
	gpio_free(pdata->gpioa_gpio);
	snd_soc_unregister_codec(&sbdev->dev);
	return 0;
}

static int es325_slim_device_up(struct slim_device *sbdev)
{
	struct es325_priv *priv;
	int rc;
	CDBG( "%s: name=%s\n", __func__, sbdev->name);
	CDBG("%s: laddr=%d\n", __func__, sbdev->laddr);
	/* Start the firmware download in the workqueue context. */
	priv = slim_get_devicedata(sbdev);
	CDBG("%s: priv=%p\n", __func__, priv);
	if (strcmp(sbdev->name, "es325-codec-intf") == 0)
		return 0;
	rc = fw_download(priv);
	BUG_ON(rc != 0);
	return rc;
}

static const struct slim_device_id es325_slim_id[] = {
	{ "es325-codec-gen0", 0 },
	{ "es325-codec-intf", 0 },
	{  }
};

MODULE_DEVICE_TABLE(slim, es325_slim_id);

static struct slim_driver es325_slim_driver = {
	.driver = {
		.name = "es325-codec",
		.owner = THIS_MODULE,
	},
	.probe = es325_slim_probe,
	.remove = es325_slim_remove,
#if defined(ES325_DEVICE_UP)
	.device_up = es325_slim_device_up,
#endif
	.id_table = es325_slim_id,
};
#endif

static __init int es325_init(void)
{
	int ret = 0;

	pr_info("%s(): entry", __func__);
	es325_workqueue = create_workqueue("ES325");
	if (!es325_workqueue) {
		pr_err("=[ES325]=%s(): can't create workqueue\n", __func__);
		return -1;
	}
	INIT_DELAYED_WORK(&es325_work, es325_wrapper_sleep_internal);
#if defined(CONFIG_SND_SOC_ES325_I2C)
	ret = i2c_add_driver(&es325_i2c_driver);
	if (ret)
		pr_err("Failed to register Audience eS325 I2C driver: %d\n",
		       ret);
#else
	pr_info("%s(): slim_driver_register()", __func__);
	ret = slim_driver_register(&es325_slim_driver);
	if (ret)
		pr_err("Error registering Audience eS325 SLIMbus driver: %d\n",
		       ret);
#if defined(CONFIG_SND_SOC_ES325_UART)
	if(!ret) {
		pr_info("%s(): call bus_init()", __func__);
		ret = es325_uart_bus_init(&es325_priv);
		if (ret)
			pr_err("Error uart bus initialization: %d\n", ret);
	}
#endif
#endif

	pr_info("%s(): exit\n", __func__);
	return ret;
}
module_init(es325_init);

static __exit void es325_exit(void)
{
	pr_info("%s(): entry\n", __func__);
#if defined(CONFIG_SND_SOC_ES325_I2C)
	i2c_del_driver(&es325_i2c_driver);
#else
	/* no support from QCOM to unregister
	 * slim_driver_unregister(&es325_slim_driver);
	 */
#endif
	wake_lock_destroy(&es325_VS_lock);

	pr_info("%s(): exit\n", __func__);
}
module_exit(es325_exit);


MODULE_DESCRIPTION("ASoC ES325 driver");
MODULE_AUTHOR("Greg Clemson <gclemson@audience.com>");
MODULE_LICENSE("GPL");
MODULE_ALIAS("platform:es325-codec");
MODULE_FIRMWARE("audience-es325-fw.bin");
