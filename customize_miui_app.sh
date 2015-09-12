#!/bin/bash
#
# $1: dir for original miui app 
# $2: dir for target miui app
#

XMLMERGYTOOL=$PORT_ROOT/tools/ResValuesModify/jar/ResValuesModify
GIT_APPLY=$PORT_ROOT/tools/git.apply

echo "original dir: $2"
echo "target dir:$1"

function overlaySmali() {
    for file in `find $1/smali -name *.smali`
    do
        filepath=`dirname $file`
        cp -f $file out/$filepath
    done
}

function applyPatch () {
    for patch in `find $1 -name *.patch`
    do
		cd out
		$GIT_APPLY ../$patch
		cd ..
		for rej in `find $2 -name *.rej`
		do
			echo "Patch $patch fail"
			exit 1
		done
    done
}

if [ $1 = "Phone" ];then
	echo "Merge Phone's xml"
	$XMLMERGYTOOL $1/res/values $2/res/values
	echo "replace functions in Phone"
	./replace_functions_in_phone.sh $2
        overlaySmali "Phone"
        applyPatch $1 $2
fi

if [ $1 = "MiuiHome" ];then
	$XMLMERGYTOOL $1/res/values $2/res/values
fi
