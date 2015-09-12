/*
 * es325-uart.c  --  Audience eS325 UART interface
 *
 * Copyright 2013 Audience, Inc.
 *
 * Author: Matt Lupfer <mlupfer@cardinalpeak.com>
 *
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */
#define DEBUG
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#include <linux/firmware.h>
#include <linux/delay.h>
#include <linux/pm.h>
#include <linux/completion.h>
#include <linux/gpio.h>
#include <linux/platform_device.h>
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
#include <linux/serial_core.h>
#include <linux/tty.h>

#include "es325-uart-common.h" 


static int es325_uart_boot_setup(struct es325_priv *es325);
static int es325_uart_boot_finish(struct es325_priv *es325);
static int es325_uart_probe(struct platform_device *dev);
static int es325_uart_remove(struct platform_device *dev);
static inline void es325_uart_change_rate(struct es325_priv* es325, 
        int rate);


#ifdef ES325_FW_LOAD_BUF_SZ
#undef ES325_FW_LOAD_BUF_SZ
#endif
#define ES325_FW_LOAD_BUF_SZ 1024

#define UART_FW_IMAGE_1_SIZE	80

static u8 UARTFirstStageBoot_InputClk_19_200_Baud_3M[UART_FW_IMAGE_1_SIZE] = {
	0x41, 0x55, 0x44, 0x49, 0x45, 0x4E, 0x43, 0x45, 0x00, 0x00, 0x00, 0x00,
	    0x05, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x84, 0x00, 0x01, 0x20,
	    0x01, 0x00, 0x00, 0x00,
	0x01, 0x00, 0x00, 0x00, 0xC0, 0x00, 0x01, 0x20, 0x01, 0x00, 0x00, 0x00,
	    0x01, 0x00, 0x00, 0x00,
	0xC4, 0x00, 0x01, 0x20, 0x12, 0x00, 0x08, 0x00, 0x01, 0x00, 0x00, 0x00,
	    0xC8, 0x00, 0x01, 0x20,
	0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0xD0, 0x00, 0x01, 0x20,
//	    0xca, 0x2b, 0x00, 0x00
    0x05, 0x2F, 0x00, 0x00
//    0x85, 0x2A, 0x00, 0x00
};
static inline void es325_uart_change_rate(struct es325_priv* es325, int rate)
{
//    es325_uart_close(es325);
//    es325->uart_fw_rate = rate;
 es325_configure_tty(es325->uart_dev.tty, rate, UART_TTY_STOP_BITS);

 //   es325_uart_open(es325);
}

int es325_uart_check_sbl_mode(struct es325_priv *es325)
{
    int rc = 0, read_cnt;
  	u8 sbl_sync_cmd = ES325_SBL_SYNC_CMD;
	u8 sbl_boot_cmd = ES325_SBL_BOOT_CMD;
	char msg;
    
    /* SBL SYNC BYTE 0x00 */
	pr_debug( "%s: ES325_SBL_SYNC_CMD = 0x%02x\n",
		__func__, sbl_sync_cmd);
	msg = sbl_sync_cmd;
	rc = es325->uart_dev_write(es325, &msg, 1);
	if (rc < sizeof(sbl_sync_cmd)) {
		pr_err( "%s: firmware load failed sbl sync write\n",
			__func__);
		rc = rc < 0 ? rc : -EIO;
		goto es325_bootup_failed;
	}
    read_cnt = 0;
    msg = 0;
	msleep(1);
read_sbl_syn_again:
    rc = es325->uart_dev_read(es325, &msg, 1);
	if (read_cnt < 3 && msg != ES325_SBL_SYNC_ACK) {
        read_cnt++;
        goto read_sbl_syn_again; 
	}
	pr_debug( "%s: SBL_SYNC_ACK = 0x%02x\n", __func__, msg);

	/* SBL BOOT BYTE 0x01 */
	pr_debug( "%s: ES325_SBL_BOOT_CMD = 0x%02x\n",
		__func__, sbl_boot_cmd);
	msg = sbl_boot_cmd;
	rc = es325->uart_dev_write(es325, &msg, 1);
	if (rc < sizeof(sbl_boot_cmd)) {
		pr_err( "%s(): firmware load failed sbl boot write\n",
			__func__);
		rc = rc < 0 ? rc : -EIO;
		goto es325_bootup_failed;
	}
    read_cnt = 0;
    msg = 0;
	msleep(1);
read_boot_cmd_resp:    
	rc = es325->uart_dev_read(es325, &msg, 1);
	if (read_cnt < 3 && msg != ES325_SBL_BOOT_ACK) {
        read_cnt++;
        goto read_boot_cmd_resp;
	}
	pr_debug( "%s: ES325_SBL_BOOT_ACK = 0x%02x \n", 
            __func__, msg);
    rc = 0;

es325_bootup_failed:
    return rc;
}

int es325_uart_boot_setup(struct es325_priv *es325)
{
	int rc;

	/* Request VS firmware */
	/* set speed to bootloader baud */
	es325_uart_change_rate(es325, UART_TTY_BAUD_RATE_BOOTLOADER);
	es325_uart_check_sbl_mode(es325);

	/* 1stage fw */
	pr_debug("%s: VS firmware 1st stage start...\n", __func__);
	/* Write the first firmware image */
	rc = es325->uart_dev_write(es325,
			UARTFirstStageBoot_InputClk_19_200_Baud_3M,
			UART_FW_IMAGE_1_SIZE);
	if (rc < 0) {
		pr_err("\n%s(): tty_write failed with %d for fw image 1\n",
				__func__, rc);
		goto es325_bootup_failed;
	}

	pr_debug("%s: VS 1st stage download finished", __func__);
	//	usleep_range(1000, 1000);
	es325_uart_change_rate(es325, UART_TTY_BAUD_RATE_FIRMWARE);
	//	usleep_range(1000, 1000);

	rc = es325_uart_check_sbl_mode(es325);

es325_bootup_failed:
	return rc;
}

int es325_uart_boot_finish(struct es325_priv *es325)
{
	es325_uart_change_rate(es325, UART_TTY_BAUD_RATE_BOOTLOADER);//Richard 12.9
    	return 0;
}

int es325_uart_probe_thread(void *ptr)
{
	int rc = 0;
	struct device *dev = (struct device *) ptr;

	/*rc = es325_uart_open(&es325_priv);
	if (rc) {
		dev_err(dev, "%s(): es325_uart_open() failed %d\n",
			__func__, rc);
		return rc;
	}*/

	/* set es325 function pointers */
	es325_priv.uart_dev_read = es325_uart_read;
	es325_priv.uart_dev_write = es325_uart_write;
	es325_priv.uart_cmd = es325_uart_cmd;
	es325_priv.uart_boot_setup = es325_uart_boot_setup;
	es325_priv.uart_boot_finish = es325_uart_boot_finish;
	es325_priv.uart_open = es325_uart_open;//Richard 12.24
	es325_priv.uart_close = es325_uart_close;//Richard 12.24
	es325_priv.uart_state = 0;//Richard 1.7
	es325_priv.dev = dev;
	return rc;

}

static int es325_uart_probe(struct platform_device *dev)
{
	int rc = 0;
	struct task_struct *uart_probe_thread = NULL;

	uart_probe_thread = kthread_run(es325_uart_probe_thread,
					(void *) &dev->dev,
					"es325 uart thread");
	if (IS_ERR_OR_NULL(uart_probe_thread)) {
		dev_err(&dev->dev, "%s(): can't create es325 UART probe thread = %p\n",
			__func__, uart_probe_thread);
		rc = -ENOMEM;
	}

	return rc;
}

static int es325_uart_remove(struct platform_device *dev)
{
	int rc = 0;
	/*
	 * ML: GPIO pins are not connected
	 * 
	 * struct esxxx_platform_data *pdata = es325_priv.pdata;
	 *
	 * gpio_free(pdata->reset_gpio);
	 * gpio_free(pdata->wakeup_gpio);
	 * gpio_free(pdata->gpioa_gpio);
	 */

	if (es325_priv.uart_dev.ld)
		tty_ldisc_deref(es325_priv.uart_dev.ld);

	if (es325_priv.uart_dev.file)
		rc = filp_close(es325_priv.uart_dev.file, 0);

	es325_priv.uart_dev.tty = NULL;
	es325_priv.uart_dev.file = NULL;

	snd_soc_unregister_codec(es325_priv.dev);

	return rc;
}

struct platform_driver es325_uart_driver = {
	.driver = {
		.name = "es325-codec",
		.owner = THIS_MODULE,
	},
	.probe = es325_uart_probe,
	.remove = es325_uart_remove,
};

static struct esxxx_platform_data esxxx_platform_data = {
	.irq_base       = 0,
	.reset_gpio     = -1,
	.wakeup_gpio    = -1,
	.gpioa_gpio     = -1,
	.gpiob_gpio     = -1,
	.es325_clk_cb   = NULL,
};

struct platform_device es325_uart_device = {
	.name	   = "es325-codec",
	.resource       = NULL,
	.num_resources  = 0,
	.dev = {
		.platform_data = &esxxx_platform_data,
	}
};

/* FIXME: Kludge for es325_bus_init abstraction */
int es325_uart_bus_init(struct es325_priv *es325)
{
	int rc;
    es325->uart_fw_rate = UART_TTY_BAUD_RATE_FIRMWARE;
	rc = platform_driver_register(&es325_uart_driver);
	if (rc) {
		pr_err( "%s(): platform_driver_register() failure", __func__);
		return rc;
	}

	rc = platform_device_register(&es325_uart_device);
	if (rc) {
		pr_err( "[SK]%s(): platform_device_register() failure", __func__);
		return rc;
	}

	return rc;
}

MODULE_DESCRIPTION("ASoC ES325 driver");
MODULE_AUTHOR("Greg Clemson <gclemson@audience.com>");
MODULE_LICENSE("GPL v2");
MODULE_ALIAS("platform:es325-codec");
