/* Copyright (c) 2013, The Linux Foundation. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 and
 * only version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */
#include "msm_sensor.h"
#include <linux/proc_fs.h>
#include "msm_cci.h"
#define IMX135_SENSOR_NAME "imx135"
DEFINE_MSM_MUTEX(imx135_mut);

static struct msm_sensor_ctrl_t imx135_s_ctrl;

/* ZTE_MODIFY by yangchunni for cci error merger from A21 2014-02-26 */
static struct msm_sensor_power_setting imx135_power_setting[] = {
	{
		.seq_type = SENSOR_GPIO,
		.seq_val = SENSOR_GPIO_CTRDVDD,
		.config_val = GPIO_OUT_LOW,
		.delay = 10,
	},
	{
		.seq_type = SENSOR_VREG,
		.seq_val = CAM_VDIG,
		.config_val = 0,
		.delay = 0,
	},
	{
		.seq_type = SENSOR_GPIO,
		.seq_val = SENSOR_GPIO_CTRDVDD,
		.config_val = GPIO_OUT_HIGH,
		.delay = 10,
	},
	{
		.seq_type = SENSOR_VREG,
		.seq_val = CAM_VANA,
		.config_val = 0,
		.delay = 0,
	},
	{
		.seq_type = SENSOR_VREG,
		.seq_val = CAM_VIO,
		.config_val = 0,
		.delay = 0,
	},
	{
		.seq_type = SENSOR_VREG,
		.seq_val = CAM_VAF,
		.config_val = 0,
		.delay = 0,
	},
	{
		.seq_type = SENSOR_GPIO,
		.seq_val = SENSOR_GPIO_RESET,
		.config_val = GPIO_OUT_LOW,
		.delay = 1,
	},
	{
		.seq_type = SENSOR_GPIO,
		.seq_val = SENSOR_GPIO_RESET,
		.config_val = GPIO_OUT_HIGH,
		.delay = 30,
	},
	{
		.seq_type = SENSOR_GPIO,
		.seq_val = SENSOR_GPIO_STANDBY,
		.config_val = GPIO_OUT_LOW,
		.delay = 1,
	},
	{
		.seq_type = SENSOR_GPIO,
		.seq_val = SENSOR_GPIO_STANDBY,
		.config_val = GPIO_OUT_HIGH,
		.delay = 30,
	},
	{
		.seq_type = SENSOR_CLK,
		.seq_val = SENSOR_CAM_MCLK,
		.config_val = 24000000,
		.delay = 1,
	},
	{
		.seq_type = SENSOR_I2C_MUX,
		.seq_val = 0,
		.config_val = 0,
		.delay = 0,
	},
};
/* ZTE_MODIFY end */
static struct v4l2_subdev_info imx135_subdev_info[] = {
	{
		.code = V4L2_MBUS_FMT_SBGGR10_1X10,
		.colorspace = V4L2_COLORSPACE_JPEG,
		.fmt = 1,
		.order = 0,
	},
};

static const struct i2c_device_id imx135_i2c_id[] = {
	{IMX135_SENSOR_NAME, (kernel_ulong_t)&imx135_s_ctrl},
	{ }
};

static int32_t msm_imx135_i2c_probe(struct i2c_client *client,
	const struct i2c_device_id *id)
{
	return msm_sensor_i2c_probe(client, id, &imx135_s_ctrl);
}

static struct i2c_driver imx135_i2c_driver = {
	.id_table = imx135_i2c_id,
	.probe  = msm_imx135_i2c_probe,
	.driver = {
		.name = IMX135_SENSOR_NAME,
	},
};

static struct msm_camera_i2c_client imx135_sensor_i2c_client = {
	.addr_type = MSM_CAMERA_I2C_WORD_ADDR,
};

static const struct of_device_id imx135_dt_match[] = {
	{.compatible = "qcom,imx135", .data = &imx135_s_ctrl},
	{}
};

MODULE_DEVICE_TABLE(of, imx135_dt_match);

static struct platform_driver imx135_platform_driver = {
	.driver = {
		.name = "qcom,imx135",
		.owner = THIS_MODULE,
		.of_match_table = imx135_dt_match,
	},
};

static int32_t imx135_platform_probe(struct platform_device *pdev)
{
	int32_t rc = 0;
	const struct of_device_id *match;
	match = of_match_device(imx135_dt_match, &pdev->dev);
	rc = msm_sensor_platform_probe(pdev, match->data);
	return rc;
}
struct msm_eeprom_ctrl_t {
	struct platform_device *pdev;
	struct mutex *eeprom_mutex;

	struct v4l2_subdev sdev;
	struct v4l2_subdev_ops *eeprom_v4l2_subdev_ops;
	enum msm_camera_device_type_t eeprom_device_type;
	struct msm_sd_subdev msm_sd;
	enum cci_i2c_master_t cci_master;

	struct msm_camera_i2c_client i2c_client;
	uint32_t num_bytes;
	uint8_t *memory_data;
	uint8_t is_supported;
	struct msm_eeprom_board_info *eboard_info;
	uint32_t subdev_id;
};

static const struct of_device_id msm_eeprom_dt_match[] = {
	{ .compatible = "qcom,eeprom0" },
	{ }
};
MODULE_DEVICE_TABLE(of, msm_eeprom_dt_match);

static int32_t msm_eeprom_platform_remove(struct platform_device *pdev)
{
	return 0;
}

static struct platform_driver msm_eeprom_platform_driver = {
	.driver = {
		.name = "qcom,eeprom",
		.owner = THIS_MODULE,
		.of_match_table = msm_eeprom_dt_match,
	},
	.remove = __devexit_p(msm_eeprom_platform_remove),
};

static int32_t msm_eeprom_config(struct msm_eeprom_ctrl_t *e_ctrl,
	void __user *argp)
{
	struct msm_eeprom_cfg_data *cdata =
		(struct msm_eeprom_cfg_data *)argp;
	int32_t rc = 0;
	int j = 0;

	pr_info("%s E\n", __func__);
	switch (cdata->cfgtype) {
	case CFG_EEPROM_GET_INFO:
	       pr_info("%s E CFG_EEPROM_GET_INFO\n", __func__);
		cdata->is_supported = e_ctrl->is_supported;
		memcpy(cdata->cfg.eeprom_name,
			e_ctrl->eboard_info->eeprom_name,
			sizeof(cdata->cfg.eeprom_name));
		break;
	case CFG_EEPROM_GET_CAL_DATA:
		pr_info("%s E CFG_EEPROM_GET_CAL_DATA\n", __func__);
		cdata->cfg.get_data.num_bytes =
			e_ctrl->num_bytes;
		pr_info("chengjiatest: number bytes = %d\n", cdata->cfg.get_data.num_bytes);
		break;
	case CFG_EEPROM_READ_CAL_DATA:
		pr_info("%s E CFG_EEPROM_READ_CAL_DATA\n", __func__);
		rc = copy_to_user(cdata->cfg.read_data.dbuffer,
			e_ctrl->memory_data,
			cdata->cfg.read_data.num_bytes);
             if(0) {
	  	for (j = 0; j < cdata->cfg.read_data.num_bytes; j++)
		printk("memory_data[%d] = 0x%X\n", j, e_ctrl->memory_data[j]);
             	}
		break;
	default:
		break;
	}

	pr_info("%s X\n", __func__);
	return rc;
}
static int32_t msm_eeprom_get_subdev_id(
	struct msm_eeprom_ctrl_t *e_ctrl, void *arg)
{
	uint32_t *subdev_id = (uint32_t *)arg;
	pr_info("%s E\n", __func__);
	if (!subdev_id) {
		pr_err("%s failed\n", __func__);
		return -EINVAL;
	}
	*subdev_id = e_ctrl->subdev_id;
	pr_info("subdev_id %d\n", *subdev_id);
	pr_info("%s X\n", __func__);
	return 0;
}



static long msm_eeprom_subdev_ioctl(struct v4l2_subdev *sd,
		unsigned int cmd, void *arg)
{
	struct msm_eeprom_ctrl_t *e_ctrl = v4l2_get_subdevdata(sd);
	void __user *argp = (void __user *)arg;
	pr_info("%s E\n", __func__);
	pr_info("%s:%d a_ctrl %p argp %p\n", __func__, __LINE__, e_ctrl, argp);
	switch (cmd) {
	case VIDIOC_MSM_SENSOR_GET_SUBDEV_ID:
		return msm_eeprom_get_subdev_id(e_ctrl, argp);
	case VIDIOC_MSM_EEPROM_CFG:
		return msm_eeprom_config(e_ctrl, argp);
	default:
		return -ENOIOCTLCMD;
	}

	pr_info("%s X\n", __func__);
}

static struct v4l2_subdev_core_ops msm_eeprom_subdev_core_ops = {
	.ioctl = msm_eeprom_subdev_ioctl,
};

static struct v4l2_subdev_ops msm_eeprom_subdev_ops1 = {
	.core = &msm_eeprom_subdev_core_ops,
};
DEFINE_MSM_MUTEX(msm_eeprom_mutex);
static struct msm_camera_i2c_fn_t msm_eeprom_cci_func_tbl = {
	.i2c_read = msm_camera_cci_i2c_read,
	.i2c_read_seq = msm_camera_cci_i2c_read_seq,
	.i2c_write = msm_camera_cci_i2c_write,
	.i2c_write_table = msm_camera_cci_i2c_write_table,
	.i2c_write_seq_table = msm_camera_cci_i2c_write_seq_table,
	.i2c_write_table_w_microdelay =
	msm_camera_cci_i2c_write_table_w_microdelay,
	.i2c_util = msm_sensor_cci_i2c_util,
	.i2c_poll = msm_camera_cci_i2c_poll,
};

static int msm_eeprom_open(struct v4l2_subdev *sd,
	struct v4l2_subdev_fh *fh) {
	int rc = 0;
	struct msm_eeprom_ctrl_t *e_ctrl =  v4l2_get_subdevdata(sd);
	pr_info("%s E\n", __func__);
	if (!e_ctrl) {
		pr_err("%s failed e_ctrl is NULL\n", __func__);
		return -EINVAL;
	}
	pr_info("%s X\n", __func__);
	return rc;
}

static int msm_eeprom_close(struct v4l2_subdev *sd,
	struct v4l2_subdev_fh *fh) {
	int rc = 0;
	struct msm_eeprom_ctrl_t *e_ctrl =  v4l2_get_subdevdata(sd);
	pr_info("%s E\n", __func__);
	if (!e_ctrl) {
		pr_err("%s failed e_ctrl is NULL\n", __func__);
		return -EINVAL;
	}
	pr_info("%s X\n", __func__);
	return rc;
}

static const struct v4l2_subdev_internal_ops msm_eeprom_internal_ops = {
	.open = msm_eeprom_open,
	.close = msm_eeprom_close,
};

struct eeprom_block_info {
	int slave_id;
	uint32_t start_addr;
	int valid_size;
	enum msm_camera_i2c_reg_addr_type addr_t;
	enum msm_camera_i2c_data_type data_t;
	int delay;
};

static struct eeprom_block_info imx135_block_info[] = {
	{0x50, 0x6, 12, MSM_CAMERA_I2C_BYTE_ADDR, MSM_CAMERA_I2C_BYTE_DATA, 0},
	{0x50, 0x12, 4, MSM_CAMERA_I2C_BYTE_ADDR, MSM_CAMERA_I2C_BYTE_DATA, 0},
	{0x52, 0x0, 255, MSM_CAMERA_I2C_BYTE_ADDR, MSM_CAMERA_I2C_BYTE_DATA, 0},
	{0x53, 0x0, 255, MSM_CAMERA_I2C_BYTE_ADDR, MSM_CAMERA_I2C_BYTE_DATA, 0},
	{0x54, 0x0, 255, MSM_CAMERA_I2C_BYTE_ADDR, MSM_CAMERA_I2C_BYTE_DATA, 0},
	{0x55, 0x0, 255, MSM_CAMERA_I2C_BYTE_ADDR, MSM_CAMERA_I2C_BYTE_DATA, 0},
	{0x56, 0x0, 85, MSM_CAMERA_I2C_BYTE_ADDR, MSM_CAMERA_I2C_BYTE_DATA, 0},
};
static int msm_eeprom_alloc_memory_map(struct msm_eeprom_ctrl_t *e_ctrl,
				       struct device_node *of)
{
	int rc = 0;
	int i = 0;
	struct msm_eeprom_board_info *eb = e_ctrl->eboard_info;

	e_ctrl->num_bytes = 0;
	eb->num_blocks = ARRAY_SIZE(imx135_block_info);
	eb->eeprom_map = kzalloc((sizeof(struct eeprom_memory_map_t)
				 * eb->num_blocks), GFP_KERNEL);
	if (!eb->eeprom_map) {
		pr_err("%s failed line %d\n", __func__, __LINE__);
		return -ENOMEM;
	}

	for(i = 0; i < eb->num_blocks; i++) {
		eb->eeprom_map[i].mem.valid_size = imx135_block_info[i].valid_size;
		eb->eeprom_map[i].mem.addr = imx135_block_info[i].start_addr;
		eb->eeprom_map[i].mem.addr_t = imx135_block_info[i].addr_t;
		eb->eeprom_map[i].mem.data = 0;
		eb->eeprom_map[i].mem.data_t = imx135_block_info[i].data_t;
		eb->eeprom_map[i].mem.delay = imx135_block_info[i].delay;
		e_ctrl->num_bytes += eb->eeprom_map[i].mem.valid_size;
	}
	e_ctrl->memory_data = kzalloc(e_ctrl->num_bytes, GFP_KERNEL);
	if (!e_ctrl->memory_data) {
		pr_err("%s failed line %d\n", __func__, __LINE__);
		rc = -ENOMEM;
		goto out;
	}
	return rc;

out:
	kfree(eb->eeprom_map);
	return rc;
}


static int32_t read_eeprom_memory(struct msm_eeprom_ctrl_t *e_ctrl)
{
	int rc = 0;
	int i = 0;
	uint8_t *memptr = NULL;
	struct msm_eeprom_board_info *eb_info = NULL;
	struct eeprom_memory_map_t *emap = NULL;

	if (!e_ctrl) {
		pr_err("%s e_ctrl is NULL", __func__);
		rc = -1;
		return rc;
	}
	memptr = e_ctrl->memory_data;
	eb_info = e_ctrl->eboard_info;
	emap = eb_info->eeprom_map;
	pr_info("%s : number blocks = %d\n", __func__,eb_info->num_blocks);

	for(i = 0; i < eb_info->num_blocks; i++) {
		e_ctrl->i2c_client.cci_client->sid = imx135_block_info[i].slave_id;
		if (emap[i].mem.valid_size) {
			e_ctrl->i2c_client.addr_type = emap[i].mem.addr_t;
			rc = e_ctrl->i2c_client.i2c_func_tbl->i2c_read_seq(
				&(e_ctrl->i2c_client), emap[i].mem.addr,
				memptr, emap[i].mem.valid_size);
			if (rc < 0) {
				pr_err("%s: read failed\n", __func__);
				return rc;
			}
			memptr += emap[i].mem.valid_size;
		}
	
	}
	
	return rc;
}

static int check_eeprom_id(struct msm_eeprom_ctrl_t *e_ctrl)
{
	int rc = 0;
	uint8_t data[4] = {0};

	e_ctrl->i2c_client.cci_client->sid = 0x50;
	e_ctrl->i2c_client.addr_type = MSM_CAMERA_I2C_BYTE_ADDR;
	rc = e_ctrl->i2c_client.i2c_func_tbl->i2c_read_seq(
				&(e_ctrl->i2c_client), 0,
				&data[0], 4);
	if(rc) {
		pr_err("%s: imx135 read eeprom id error!\n", __func__);
	}
	else {
		pr_info("%s: module id low=0x%x, high=0x%x****" 
			    "lens id low=0x%x high=0x%x\n", __func__, data[0], data[1], data[2], data[3]);
	}

	return rc;
	
}

static int32_t msm_eeprom_platform_probe(struct platform_device *pdev)
{
	int32_t rc = 0;
	struct msm_camera_cci_client *cci_client = NULL;
	struct msm_eeprom_ctrl_t *e_ctrl = NULL;
	struct msm_eeprom_board_info *eb_info = NULL;
	struct device_node *of_node = pdev->dev.of_node;

	pr_info("%s: eeprom probe!!!\n", __func__);
	e_ctrl = kzalloc(sizeof(struct msm_eeprom_ctrl_t), GFP_KERNEL);
	if (!e_ctrl) {
		pr_err("%s:%d kzalloc failed\n", __func__, __LINE__);
		return -ENOMEM;
	}
	e_ctrl->eeprom_v4l2_subdev_ops = &msm_eeprom_subdev_ops1;
	e_ctrl->eeprom_mutex = &msm_eeprom_mutex;

	e_ctrl->is_supported = 0;
	if (!of_node) {
		pr_err("%s dev.of_node NULL\n", __func__);
		return -EINVAL;
	}

	pdev->id = 0;
	e_ctrl->subdev_id = pdev->id;
	e_ctrl->cci_master = 0;
	
	/* Set platform device handle */
	e_ctrl->pdev = pdev;
	/* Set device type as platform device */
	e_ctrl->eeprom_device_type = MSM_CAMERA_PLATFORM_DEVICE;
	e_ctrl->i2c_client.i2c_func_tbl = &msm_eeprom_cci_func_tbl;
	e_ctrl->i2c_client.cci_client = kzalloc(sizeof(
		struct msm_camera_cci_client), GFP_KERNEL);
	if (!e_ctrl->i2c_client.cci_client) {
		pr_err("%s failed no memory\n", __func__);
		return -ENOMEM;
	}
	e_ctrl->eboard_info = kzalloc(sizeof(
		struct msm_eeprom_board_info), GFP_KERNEL);
	if (!e_ctrl->eboard_info) {
		pr_err("%s failed line %d\n", __func__, __LINE__);
		rc = -ENOMEM;
		goto cciclient_free;
	}
	eb_info = e_ctrl->eboard_info;
	cci_client = e_ctrl->i2c_client.cci_client;
	cci_client->cci_subdev = msm_cci_get_subdev();
	cci_client->cci_i2c_master = e_ctrl->cci_master;
	cci_client->retries = 3;
	cci_client->id_map = 0;
	rc = of_property_read_string(of_node, "qcom,eeprom-name",
		&eb_info->eeprom_name);
	pr_info("%s qcom,eeprom-name %s, rc %d\n", __func__,
		eb_info->eeprom_name, rc);
	if (rc < 0) {
		pr_err("%s failed %d\n", __func__, __LINE__);
		goto board_free;
	}
	check_eeprom_id(e_ctrl);
	rc = msm_eeprom_alloc_memory_map(e_ctrl, of_node);
	if (rc)
		goto board_free;

	rc = read_eeprom_memory(e_ctrl);
	if (rc < 0) {
		pr_err("%s read_eeprom_memory failed\n", __func__);
		goto power_down;
	}
		pr_err("%s line %d\n", __func__, __LINE__);

	v4l2_subdev_init(&e_ctrl->msm_sd.sd,
		e_ctrl->eeprom_v4l2_subdev_ops);
	v4l2_set_subdevdata(&e_ctrl->msm_sd.sd, e_ctrl);
	platform_set_drvdata(pdev, &e_ctrl->msm_sd.sd);
	e_ctrl->msm_sd.sd.internal_ops = &msm_eeprom_internal_ops;
	e_ctrl->msm_sd.sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
	snprintf(e_ctrl->msm_sd.sd.name,
		ARRAY_SIZE(e_ctrl->msm_sd.sd.name), "imx135_eeprom");
	media_entity_init(&e_ctrl->msm_sd.sd.entity, 0, NULL, 0);
	e_ctrl->msm_sd.sd.entity.type = MEDIA_ENT_T_V4L2_SUBDEV;
	e_ctrl->msm_sd.sd.entity.group_id = MSM_CAMERA_SUBDEV_EEPROM;
	msm_sd_register(&e_ctrl->msm_sd);

	e_ctrl->is_supported = 1;

	return rc;

power_down:
	kfree(e_ctrl->memory_data);
	kfree(eb_info->eeprom_map);
board_free:
	kfree(e_ctrl->eboard_info);
cciclient_free:
	kfree(e_ctrl->i2c_client.cci_client);
	return rc;
}
static int imx135_read_proc_info(char *page, char ** start, off_t offset,
	int count, int *eof, void * data)
{
	*eof = 1;
	return sprintf(page, "ID: 0x135\n" "Name: imx135\n");
}

static int create_proc_camera_entity(void)
{
	if (create_proc_read_entry("back_camera_info", 0, NULL,
	  	      imx135_read_proc_info, NULL) == NULL) {
	  	pr_err("%s:%d unable to create back camera proc info\n", __func__, __LINE__);
	}
	return 0;
}
static int __init imx135_init_module(void)
{
	int32_t rc = 0;
	pr_info("%s:%d\n", __func__, __LINE__);
	rc = platform_driver_probe(&imx135_platform_driver,
		imx135_platform_probe);
	if (!rc) {
       if(1) {
	rc = platform_driver_probe(&msm_eeprom_platform_driver,
		msm_eeprom_platform_probe);
       }
	imx135_s_ctrl.func_tbl->sensor_power_down(&imx135_s_ctrl);
		create_proc_camera_entity();
		return rc;
	}
	pr_err("%s:%d rc %d\n", __func__, __LINE__, rc);
	return i2c_add_driver(&imx135_i2c_driver);
}

static void __exit imx135_exit_module(void)
{
	pr_info("%s:%d\n", __func__, __LINE__);
	if (imx135_s_ctrl.pdev) {
		msm_sensor_free_sensor_data(&imx135_s_ctrl);
		platform_driver_unregister(&imx135_platform_driver);
	} else
		i2c_del_driver(&imx135_i2c_driver);
	return;
}

static struct msm_sensor_ctrl_t imx135_s_ctrl = {
	.sensor_i2c_client = &imx135_sensor_i2c_client,
	.power_setting_array.power_setting = imx135_power_setting,
	.power_setting_array.size = ARRAY_SIZE(imx135_power_setting),
	.msm_sensor_mutex = &imx135_mut,
	.sensor_v4l2_subdev_info = imx135_subdev_info,
	.sensor_v4l2_subdev_info_size = ARRAY_SIZE(imx135_subdev_info),
};

module_init(imx135_init_module);
module_exit(imx135_exit_module);
MODULE_DESCRIPTION("imx135");
MODULE_LICENSE("GPL v2");
