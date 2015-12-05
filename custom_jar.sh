#!/bin/bash


jarBaseName=$1
tempSmaliDir=$2

dir1=android/accounts/
dir2=android/print/
#dir3=android/printservice/
dir4=android/speech/

dir5=codeaurora/
dir6=com/
dir7=javax/
dir8=org/

if [ "$jarBaseName" = "framework" ];then
	echo ">>> in custom_jar $jarBaseName"
        mv $tempSmaliDir/smali/$dir1 $tempSmaliDir/smali_classes2/$dir1
        mv $tempSmaliDir/smali/$dir2 $tempSmaliDir/smali_classes2/$dir2
        #mv $tempSmaliDir/smali/$dir3 $tempSmaliDir/smali_classes2/$dir3
        mv $tempSmaliDir/smali/$dir4 $tempSmaliDir/smali_classes2/$dir4

        mv $tempSmaliDir/smali/$dir5 $tempSmaliDir/smali_classes2/$dir5
        mv $tempSmaliDir/smali/$dir6 $tempSmaliDir/smali_classes2/$dir6
        mv $tempSmaliDir/smali/$dir7 $tempSmaliDir/smali_classes2/$dir7
        mv $tempSmaliDir/smali/$dir8 $tempSmaliDir/smali_classes2/$dir8
fi
