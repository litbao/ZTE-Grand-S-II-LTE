#!/bin/bash

echo "in $0"
OUT_DIR=/media/ya0shen9/290a963a-1a45-4e8a-a273-333c15380e87/FlymeOS-5/devices/ZTE-Grand-S-II-LTE/out/merged_target_files
OTHER_DIR=/media/ya0shen9/290a963a-1a45-4e8a-a273-333c15380e87/FlymeOS-5/devices/ZTE-Grand-S-II-LTE/other

mkdir -vp $OUT_DIR/SYSTEM/data
mkdir -vp $OUT_DIR/SYSTEM/data/system_app
mkdir -vp $OUT_DIR/SYSTEM/data/system_priv-app
mkdir -vp $OUT_DIR/SYSTEM/system

mv -vf $OUT_DIR/SYSTEM/app/AlarmClock $OUT_DIR/SYSTEM/data/system_app
mv -vf $OUT_DIR/SYSTEM/app/AppCenter $OUT_DIR/SYSTEM/data/system_app
mv -vf $OUT_DIR/SYSTEM/app/Calculator $OUT_DIR/SYSTEM/data/system_app
mv -vf $OUT_DIR/SYSTEM/app/Calendar $OUT_DIR/SYSTEM/data/system_app
mv -vf $OUT_DIR/SYSTEM/app/Camera $OUT_DIR/SYSTEM/data/system_app
mv -vf $OUT_DIR/SYSTEM/app/FileManager $OUT_DIR/SYSTEM/data/system_app
mv -vf $OUT_DIR/SYSTEM/app/GameCenter $OUT_DIR/SYSTEM/data/system_app
mv -vf $OUT_DIR/SYSTEM/app/Life $OUT_DIR/SYSTEM/data/system_app
mv -vf $OUT_DIR/SYSTEM/app/Map $OUT_DIR/SYSTEM/data/system_app
mv -vf $OUT_DIR/SYSTEM/app/Painter $OUT_DIR/SYSTEM/data/system_app
mv -vf $OUT_DIR/SYSTEM/app/Reader $OUT_DIR/SYSTEM/data/system_app

mv -vf $OUT_DIR/SYSTEM/priv-app/Browser $OUT_DIR/SYSTEM/data/system_priv-app
mv -vf $OUT_DIR/SYSTEM/priv-app/EBook $OUT_DIR/SYSTEM/data/system_priv-app
mv -vf $OUT_DIR/SYSTEM/priv-app/Gallery $OUT_DIR/SYSTEM/data/system_priv-app
mv -vf $OUT_DIR/SYSTEM/priv-app/Music $OUT_DIR/SYSTEM/data/system_priv-app
mv -vf $OUT_DIR/SYSTEM/priv-app/Video $OUT_DIR/SYSTEM/data/system_priv-app

mv -vf $OUT_DIR/SYSTEM/addon.d $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/app $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/bin $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/customizecenter $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/etc $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/fonts $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/framework $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/lib $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/media $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/priv-app $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/tts $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/usr $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/vendor $OUT_DIR/SYSTEM/system
mv -vf $OUT_DIR/SYSTEM/xbin $OUT_DIR/SYSTEM/system
cp -r $OUT_DIR/SYSTEM/build.prop $OUT_DIR/SYSTEM/system

cp -r $OTHER_DIR/xposed/app $OUT_DIR/SYSTEM/data
cp -r $OTHER_DIR/data/app $OUT_DIR/SYSTEM/data
cp -r $OTHER_DIR/firmware $OUT_DIR/SYSTEM/
