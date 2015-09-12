#!/bin/bash
#
# $1: dir for miui
# $2: dir for original
#

APKTOOL=$PORT_ROOT/tools/apktool
GIT_APPLY=$PORT_ROOT/tools/git.apply
BUILD_OUT=out

if [ "$2" = "out/framework2" ];then
	echo "compile framework2.jar"
	for file2 in `find telephony-common.jar.out -name *.smali`; do
			file=${file2/telephony-common.jar.out/$BUILD_OUT\/framework2}
			echo "rm file: $file"
			rm -rf "$file"
	done
fi





