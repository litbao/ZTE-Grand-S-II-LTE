/*
 * es325-uart.h  --  Audience eS325 UART interface
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

#ifndef _ES325_UART_H
#define _ES325_UART_H

//struct es325_priv;
#if 0
struct es325_uart_dev{
	struct tty_struct *tty;
	struct file *file;
	struct tty_ldisc *ld;
};
#endif
extern struct platform_driver es325_uart_driver;
extern struct platform_device es325_uart_device;

//int es325_uart_bus_init(struct es325_priv *es325);

#endif
