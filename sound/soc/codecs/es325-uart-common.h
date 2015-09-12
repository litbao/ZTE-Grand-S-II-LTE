/*
 * es325-uart-common.h  --  Audience eS325 UART interface
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

#ifndef _ES325_UART_COMMON_H
#define _ES325_UART_COMMON_H

#include "es325.h"

#define UART_TTY_DEVICE_NODE		"/dev/ttyHS2" 

//#define UART_TTY_BAUD_RATE_BOOTLOADER
#define UART_TTY_BAUD_RATE_BOOTLOADER	28800  /*3000000 	460800*/
//#define UART_TTY_BAUD_RATE_BOOTLOADER	460800
#define UART_TTY_BAUD_RATE_FIRMWARE	3000000
#define UART_TTY_STOP_BITS		2
#define UART_TTY_WRITE_SZ		1024

#define ES325_SBL_SYNC_CMD		0x00
#define ES325_SBL_SYNC_ACK		ES325_SBL_SYNC_CMD
#define ES325_SBL_BOOT_CMD		0x01
#define ES325_SBL_BOOT_ACK		ES325_SBL_BOOT_CMD
#define ES325_SBL_FW_ACK		0x02


int es325_uart_read(struct es325_priv *es325, void *buf, int len);
int es325_uart_write(struct es325_priv *es325, const void *buf, int len);
int es325_uart_write_then_read(struct es325_priv *es325, const void *buf,
			       int len, u32 *rspn, int match);
int es325_uart_cmd(struct es325_priv *es325, u32 cmd, int sr, u32 *resp);
int es325_configure_tty(struct tty_struct *tty, u32 bps, int stop);
int es325_uart_open(struct es325_priv *es325);
int es325_uart_close(struct es325_priv *es325);
int es325_uart_wait(struct es325_priv *es325);

int es325_uart_bus_init(struct es325_priv *es325);
//extern struct es_stream_device uart_streamdev;

#endif
