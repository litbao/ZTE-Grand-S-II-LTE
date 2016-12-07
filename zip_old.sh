######## A1、刷机大师 ########
######## A2、奇兔软件 ########
######## A3、刷机精灵 ########
######## A4、亿智蘑菇 ########

######## B1、速推 ########
######## B2、络云 ########
######## B3、王牌手机联盟 ########

#!/bin/bash

unzip -n ./out/flyme_ZTE-Grand-S-II-LTE_ya0shen9_5.1.11.25R.zip -d ./out/temp

echo "准备打包"
cp -r ./other/firmware ./out/temp
cp -r ./other/data ./out/temp
cp -r ./other/supersu ./out/temp
cp ./other/xposed/app/DisableFlagSecure.apk ./out/temp/data/app
cp ./other/xposed/app/MeiHua.apk ./out/temp/data/app
cp ./other/xposed/app/MeiHuaUI.apk ./out/temp/data/app
cp ./other/updater-script ./out/temp/META-INF/com/google/android/updater-script

mv -f ./out/temp/system/app/AlarmClock ./out/temp/data/system_app
mv -f ./out/temp/system/app/AppCenter ./out/temp/data/system_app
mv -f ./out/temp/system/app/Calculator ./out/temp/data/system_app
mv -f ./out/temp/system/app/Calendar ./out/temp/data/system_app
mv -f ./out/temp/system/app/Camera ./out/temp/data/system_app
mv -f ./out/temp/system/app/FileManager ./out/temp/data/system_app
mv -f ./out/temp/system/app/GameCenter ./out/temp/data/system_app
mv -f ./out/temp/system/app/Life ./out/temp/data/system_app
mv -f ./out/temp/system/app/Map ./out/temp/data/system_app
mv -f ./out/temp/system/app/Painter ./out/temp/data/system_app
mv -f ./out/temp/system/app/Reader ./out/temp/data/system_app

mv -f ./out/temp/system/priv-app/Browser ./out/temp/data/system_priv-app
mv -f ./out/temp/system/priv-app/EBook ./out/temp/data/system_priv-app
mv -f ./out/temp/system/priv-app/Gallery ./out/temp/data/system_priv-app
mv -f ./out/temp/system/priv-app/Music ./out/temp/data/system_priv-app
mv -f ./out/temp/system/priv-app/Video ./out/temp/data/system_priv-app

echo "纯净包"
cd ./out/temp
zip -r ../full-flyme_ZTE-Grand-S-II-LTE_ya0shen9_5.1.11.25R.zip *
cd ../..

#echo "速推包"
#cp -r ./other/sutui/sutui ./out/temp/system/app
#cp -r ./other/sutui/xunfeishurufa ./out/temp/system/app
#cp ./other/sutui/liulanqi.apk ./out/temp/data/app/liulanqi.apk
#cp ./other/sutui/yingyongzhongxin.apk ./out/temp/data/app/yingyongzhongxin.apk
#cp ./other/sutui/360weishi.apk ./out/temp/data/app/360weishi.apk
#cp ./other/sutui/jinritoutiao.apk ./out/temp/data/app/jinritoutiao.apk
#cd ./out/temp
#zip -r ../B1-flyme_ZTE-Grand-S-II-LTE_ya0shen9_5.1.11.25R.zip *
#cd ../..

#echo "络云包"
#cp -r ./other/luoyun/luoyun ./out/temp/system/app
#cp -r ./other/luoyun/xunfeishurufa ./out/temp/system/app
#cp ./other/luoyun/360weishi.apk ./out/temp/data/app/360weishi.apk
#cp ./other/luoyun/liulanqi.apk ./out/temp/data/app/liulanqi.apk
#cp ./other/luoyun/yingyongzhongxin.apk ./out/temp/data/app/yingyongzhongxin.apk
#cp ./other/luoyun/jinritoutiao.apk ./out/temp/data/app/jinritoutiao.apk
#cd ./out/temp
#zip -r ../B2-flyme_ZTE-Grand-S-II-LTE_ya0shen9_5.1.11.25R.zip *
#cd ../..

#echo "蘑菇包"
#cp -r ./other/mogu/mogu ./out/temp/system/app
#cp -r ./other/mogu/xunfeishurufa ./out/temp/system/app
#cp ./other/mogu/yingyongzhongxin.apk ./out/temp/data/app/yingyongzhongxin.apk
#cp ./other/mogu/daohang.apk ./out/temp/data/app/daohang.apk
#cp ./other/mogu/liebaoqinglidashi.apk ./out/temp/data/app/liebaoqinglidashi.apk
#cp ./other/mogu/baiduditu.apk ./out/temp/data/app/baiduditu.apk
#cd ./out/temp
#zip -r ../A4-flyme_ZTE-Grand-S-II-LTE_ya0shen9_5.1.11.25R.zip *
#cd ../..

#echo "删除临时文件"
#rm -r ./out/temp