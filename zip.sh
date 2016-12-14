######## A1、刷机大师 ########
######## A2、奇兔软件 ########
######## A3、刷机精灵 ########
######## A4、亿智蘑菇 ########

######## B1、速推 ########
######## B2、络云 ########
######## B3、王牌手机联盟 ########

#!/bin/bash

echo "in $0"
OUT_DIR=/media/ya0shen9/290a963a-1a45-4e8a-a273-333c15380e87/FlymeOS-5/devices/ZTE-Grand-S-II-LTE/out
OTHER_DIR=/media/ya0shen9/290a963a-1a45-4e8a-a273-333c15380e87/FlymeOS-5/devices/ZTE-Grand-S-II-LTE/other

rm -rf $OUT_DIR/temp
mkdir $OUT_DIR/temp
unzip -n $OUT_DIR/flyme_ZTE-Grand-S-II-LTE_ya0shen9_5.1.12.9R.zip -d $OUT_DIR/temp

cp -r $OTHER_DIR/xposed/app $OUT_DIR/temp/data
cp -r $OTHER_DIR/data/app $OUT_DIR/temp/data
cp -r $OTHER_DIR/firmware $OUT_DIR/temp
#cp -r $OTHER_DIR/supersu ./out/temp
cp -r $OTHER_DIR/updater-script $OUT_DIR/temp/META-INF/com/google/android/updater-script

if [ -e $OUT_DIR/merged_target_files/A1 ];then
cd $OUT_DIR/temp
zip -r ../A1-flyme_ZTE-Grand-S-II-LTE_ya0shen9_5.1.12.9R.zip *

elif [ -e $OUT_DIR/merged_target_files/A2 ];then
cd $OUT_DIR/temp
zip -r ../A2-flyme_ZTE-Grand-S-II-LTE_ya0shen9_5.1.12.9R.zip *

else
cd $OUT_DIR/temp
zip -r ../full-flyme_ZTE-Grand-S-II-LTE_ya0shen9_5.1.12.9R.zip *
fi
