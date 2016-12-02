#!/bin/bash

echo "in $0"
OUT_DIR=/media/ya0shen9/290a963a-1a45-4e8a-a273-333c15380e87/FlymeOS-5/devices/ZTE-Grand-S-II-LTE/out/merged_target_files
OTHER_DIR=/media/ya0shen9/290a963a-1a45-4e8a-a273-333c15380e87/FlymeOS-5/devices/ZTE-Grand-S-II-LTE/other

rm -rf $OUT_DIR/DATA
mkdir -vp $OUT_DIR/DATA
#mkdir -vp $OUT_DIR/DATA/app
mkdir -vp $OUT_DIR/DATA/system_app
mkdir -vp $OUT_DIR/DATA/system_priv-app
#mkdir -vp $OUT_DIR/META-INF/com/google/android

#cp -r $OUT_DIR/firmware $OUT_DIR
#cp -r $OTHER_DIR/xposed/app $OUT_DIR/DATA
#cp -r $OTHER_DIR/data/app $OUT_DIR/DATA
#cp -r $OTHER_DIR/updater-script $OUT_DIR/META-INF/com/google/android/updater-script

#touch $OUT_DIR/A1
#cp -r $OTHER_DIR/shuajidashi/* $OUT_DIR/SYSTEM/app

#touch $OUT_DIR/A2
#cp -r $OTHER_DIR/qitu/* $OUT_DIR/SYSTEM/app

mv -vf $OUT_DIR/SYSTEM/app/AlarmClock $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app/AppCenter $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app/Calculator $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app/Calendar $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app/Camera $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app/FileManager $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app/GameCenter $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app/Life $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app/Map $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app/Painter $OUT_DIR/DATA/system_app
mv -vf $OUT_DIR/SYSTEM/app/Reader $OUT_DIR/DATA/system_app

mv -vf $OUT_DIR/SYSTEM/priv-app/Browser $OUT_DIR/DATA/system_priv-app
mv -vf $OUT_DIR/SYSTEM/priv-app/EBook $OUT_DIR/DATA/system_priv-app
mv -vf $OUT_DIR/SYSTEM/priv-app/Gallery $OUT_DIR/DATA/system_priv-app
mv -vf $OUT_DIR/SYSTEM/priv-app/Music $OUT_DIR/DATA/system_priv-app
mv -vf $OUT_DIR/SYSTEM/priv-app/Video $OUT_DIR/DATA/system_priv-app
