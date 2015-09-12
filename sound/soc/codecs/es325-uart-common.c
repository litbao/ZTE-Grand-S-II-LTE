/*
 * es325-uart-common.c  --  Audience eS325 UART interface
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
#include <linux/delay.h>
#include <linux/platform_device.h>
#include <linux/slab.h>
#include <linux/err.h>
#include <linux/kthread.h>
#include <linux/i2c/esxxx.h>
#include <linux/serial_core.h>
#include <linux/tty.h>
#include <linux/fs.h>
#include <asm/segment.h>
#include <asm/uaccess.h>

#include "es325-uart-common.h"

int es325_uart_read(struct es325_priv *es325, void *buf, int len)
{
	int rc;
	mm_segment_t oldfs;

	/*
	 * we may call from user context via char dev, so allow
	 * read buffer in kernel address space
	 */
	oldfs = get_fs();
	set_fs(KERNEL_DS);

	rc = es325->uart_dev.ld->ops->read(es325->uart_dev.tty,
		es325->uart_dev.file, (char __user *)buf, len);

	/* restore old fs context */
	set_fs(oldfs);

	return rc;
}

int es325_uart_write(struct es325_priv *es325, const void *buf, int len)
{
	int rc = 0;
	int count_remain = len;
	int bytes_wr = 0;
	mm_segment_t oldfs;

	/*
	 * we may call from user context via char dev, so allow
	 * read buffer in kernel address space
	 */
	oldfs = get_fs();
	set_fs(KERNEL_DS);

	while (count_remain > 0) {
		/* block until tx buffer space is available */
		while (tty_write_room(es325->uart_dev.tty) < UART_TTY_WRITE_SZ)
			usleep_range(5000, 5000);
		rc = es325->uart_dev.ld->ops->write(es325->uart_dev.tty,
			es325->uart_dev.file, buf + bytes_wr,
				min(UART_TTY_WRITE_SZ, count_remain));

		if (rc < 0) {
			bytes_wr = rc;
			goto err_out;
		}

		bytes_wr += rc;
		count_remain -= rc;
	}

err_out:
	/* restore old fs context */
	set_fs(oldfs);
	return bytes_wr;
}

int es325_uart_write_then_read(struct es325_priv *es325, const void *buf,
			       int len, u32 *rspn, int match)
{
	int rc;
	rc = es325_uart_write(es325, buf, len);
	if (!rc)
		rc = es325_uart_read(es325, rspn, match);
	return rc;
}

int es325_uart_cmd(struct es325_priv *es325, u32 cmd, int sr, u32 *resp)
{
	int err;
	u32 rv;

	cmd = cpu_to_be32(cmd);
	err = es325_uart_write(es325, &cmd, sizeof(cmd));
	if (err < 0 || sr)
		return min(err, 0);
	else if (err > 0)
		err = 0;

	/* Maximum response time is 10ms */
	usleep_range(10000, 10500);

	err = es325_uart_read(es325, &rv, sizeof(rv));
	if (err > 0)
		*resp = be32_to_cpu(rv);
	err = err > 0 ? 0 : err;

	return err;
}

int es325_configure_tty(struct tty_struct *tty, u32 bps, int stop)
{
	int rc = 0;

	struct ktermios termios;
	termios = *tty->termios;

	termios.c_cflag &= ~(CBAUD | CSIZE | PARENB);   /* clear csize, baud */
	termios.c_cflag |= BOTHER;	      /* allow arbitrary baud */
	termios.c_cflag |= CS8;
	termios.c_cflag &= ~CRTSCTS;

	if (stop == 2)
		termios.c_cflag |= CSTOPB;

	/* set uart port to raw mode (see termios man page for flags) */
	termios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
		| INLCR | IGNCR | ICRNL | IXON);
	termios.c_oflag &= ~(OPOST);
	termios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);

	/* set baud rate */
	termios.c_ospeed = bps;
	termios.c_ispeed = bps;

	//es325_priv.uart_dev.ld->ops->flush_buffer(es325_priv.uart_dev.tty);
	tty_wait_until_sent(es325_priv.uart_dev.tty, 0);

	rc = tty_set_termios(tty, &termios);


	es325_priv.uart_dev.ld = tty_ldisc_ref(es325_priv.uart_dev.tty);
	es325_priv.uart_dev.ld->ops->flush_buffer(es325_priv.uart_dev.tty);//Richard 1.7
	return rc;
}

int es325_uart_open(struct es325_priv *es325)
{
	long err = 0;
	struct file *fp = NULL;
	int attempt = 0;
	unsigned long timeout = jiffies + msecs_to_jiffies(60000);
	if(es325->uart_state){
		pr_err("%s es325 uart already open\n", __func__);
		if (es325->uart_state)//Richard 1.7
			es325_uart_close(es325);
	}
	pr_debug("%s: opening UART", __func__);
	/* try to probe tty node every 50 ms for 250 ms */ 
	do {
		dev_dbg(es325->dev,
			"%s(): probing for tty on %s (attempt %d)\n",
			 __func__, UART_TTY_DEVICE_NODE, ++attempt);

		fp = filp_open(UART_TTY_DEVICE_NODE,
			       O_RDWR | O_NONBLOCK | O_NOCTTY,
			       0);
		err = PTR_ERR(fp);
		msleep(100);	
	} while (time_before(jiffies, timeout) && err == -ENOENT);

	if (IS_ERR_OR_NULL(fp)) {
		pr_err("%s(): UART device node open failed\n", __func__);
		return -ENODEV;
	}

	/* device node found */
	/* set uart_dev members */
	es325_priv.uart_dev.file = fp;
	es325_priv.uart_dev.tty =
		((struct tty_file_private *)fp->private_data)->tty;
	es325_priv.uart_dev.ld = tty_ldisc_ref(
		es325_priv.uart_dev.tty);
//    pr_debug("%s: UART opened", __func__);

	/* set baudrate to FW baud (common case) */
    if(es325_priv.uart_fw_rate == UART_TTY_BAUD_RATE_BOOTLOADER|| 
            es325_priv.uart_fw_rate == UART_TTY_BAUD_RATE_FIRMWARE ) {

        es325_configure_tty(es325_priv.uart_dev.tty,
                es325_priv.uart_fw_rate, UART_TTY_STOP_BITS);
    } 
    else {
        es325_configure_tty(es325_priv.uart_dev.tty,
    		UART_TTY_BAUD_RATE_FIRMWARE, UART_TTY_STOP_BITS);
    }
	es325->uart_state =1;

    //pr_debug("%s: UART configured", __func__);
	return 0;
}

int es325_uart_close(struct es325_priv *es325)
{
	if(!es325->uart_state){
		pr_err("%s es325 uart already close\n", __func__);
		return 0;
	}
	tty_ldisc_deref(es325->uart_dev.ld);
	filp_close(es325->uart_dev.file, 0);
	es325->uart_state =0;
	pr_err("%s: UART closed", __func__);
	return 0;
}

int es325_uart_wait(struct es325_priv *es325)
{
	/* wait on tty read queue until awoken or for 50ms */
	return wait_event_interruptible_timeout(
		es325->uart_dev.tty->read_wait,
		es325->uart_dev.tty->read_cnt,
		msecs_to_jiffies(50));
}
#if 0
struct es_stream_device uart_streamdev = {
	.open = es325_uart_open,
	.read = es325_uart_read,
	.close = es325_uart_close,
	.wait = es325_uart_wait,
	.intf = ES325_UART_INTF,
};
#endif
MODULE_DESCRIPTION("ASoC ES325 driver");
MODULE_AUTHOR("Greg Clemson <gclemson@audience.com>");
MODULE_LICENSE("GPL v2");
MODULE_ALIAS("platform:es325-codec");
