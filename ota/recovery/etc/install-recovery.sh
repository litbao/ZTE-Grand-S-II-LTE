#!/system/bin/sh
if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:14362624:40795dc50021bae9c4452d4cf4b256f6bb910035; then
  log -t recovery "Installing new recovery image"
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:12703744:580bc99070fb8fa7d53314ae218382238ed925c7 EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery 40795dc50021bae9c4452d4cf4b256f6bb910035 14362624 580bc99070fb8fa7d53314ae218382238ed925c7:/system/recovery-from-boot.p
else
  log -t recovery "Recovery image already installed"
fi
