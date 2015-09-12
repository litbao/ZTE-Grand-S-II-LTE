#!/bin/bash

TMP_FILE=tmp.smali

for f in `grep -rn "IccCard;->registerForNetworkLocked(" $1 | cut -d: -f1 | uniq | sort`
do
    echo "replace file:$f"
    sed "s/IccCard;->registerForNetworkLocked(/IccCard;->registerForPersoLocked(/g" $f > $TMP_FILE
    cp $TMP_FILE $f
    rm $TMP_FILE
done


