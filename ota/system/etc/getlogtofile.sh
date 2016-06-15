#!/system/bin/sh
######################
# Copyright (C) 2011 by ZTE
#####################
# Rewrite this file from old getlogtofile.sh by yangyulin 20111108
# upgrade to log2.0 to support log setting by system properties by yangyulin 20120814
# upgrade to log2.1 by fanwuxun 2013-07-05
#   1. remove kernel log, it saved by kernel log service
#   2. add smem log and reset log (maybe need by bsp or kernel mode)
#   3. copy anr log to folder anr
#   4. default set save lot to /data/local/logs
#
#####################
#
#[in]persist.sys.ztelog.autolocate    1 indicates saving log to /sdcard/logs if it presents, otherwise /data/local/logs
#                                     0 force locating /data/local/logs 
#                                     [default:0]
#[in]persist.sys.ztelog.mode          "simple" indicates no compressing logs when arrives max rotating cnt. 
#                                     "smart" indicates forcing no compressing on device and compressing on sdcard  
#                                     "complex", compressing         
#                                     [default: "smart"]
#[in]persist.sys.ztelog.prebootcnt    log count for previous boots
#                                     [default:5]
#[in]persist.sys.ztelog.capacity      max size, unit is byte, maxium size for all logs, we will try to arrive
#                                     limit, and at the same time we use FIFO principle to delete
#                                     the oldest log.
#[in]persist.sys.ztelog.packsize      we must split the logs to proper sized packages, otherwise 
#                                     if we arrive maxsize, it's difficult to delete oldest log.
#[in]persist.sys.ztelog.rotatesize    like "512k", unit byte, when current file arrive rotsize it will trigger a rotating.
#[in]persist.sys.ztelog.rotatenum     max rotating file number, when the same kind file's num arrive rotnum, they 
#                                     will be compressed into a package. 
#[in]persist.sys.ztelog.rotatesize_k  k for kernel
#[in]persist.sys.ztelog.rotatenum_k   k for kernel 
#[in]persist.sys.ztelog.rotatesize_m  m for main
#[in]persist.sys.ztelog.rotatenum_m   m for main 
#[in]persist.sys.ztelog.rotatesize_r  r for radio
#[in]persist.sys.ztelog.rotatenum_r   r for radio 
#[in]persist.sys.ztelog.rotatesize_e  e for event
#[in]persist.sys.ztelog.rotatenum_e   e for event
#[in]persist.sys.ztelog.rotatesize_s  s for system
#[in]persist.sys.ztelog.rotatenum_s   s for system
# 

compresslog=1
autolocate=0
LOGDIR=/data/local/logs
LNU=5
KROTNUM=17
KROTSIZE=512k
tosdcard=0

DEVDIR=/dev
BINDIR=/system/bin

echo prepare start
    
#get log location, if sdcard exists, it has priority
echo LOGDIR=$LOGDIR

mode_tmp=$(getprop persist.sys.ztelog.mode)
if [ ! -z $mode_tmp ] ; then
    echo $mode_tmp
else
    mode_tmp=smart
fi

if [ "$mode_tmp" == "simple" ] ; then
    compresslog=0
elif [ "$mode_tmp" == "smart" ] ; then
    if [ tosdcard -eq 1 ] ; then
        compresslog=1    
    else
        compresslog=0
    fi
else
    compresslog=1
fi
    
echo compresslog=$compresslog
	
#previous boot logs count
LNU_tmp=$(getprop persist.sys.ztelog.prebootcnt)
if [ ! -z $LNU_tmp ] ; then
    LNU=$LNU_tmp
fi
echo LNU=$LNU
	
mkdir $DEVDIR/logs
mkdir $LOGDIR
chmod 777 $LOGDIR
mkdir $LOGDIR/anr
mkdir $LOGDIR/logcat
mkdir $LOGDIR/smem
mkdir $LOGDIR/reset
chmod 777 $LOGDIR/*
cd $LOGDIR
	
for i in $(busybox seq 2 $LNU)
do
    mv loglast$(($LNU-$i+1)).tar.gz loglast$(($LNU-$i+2)).tar.gz
done
    
if [ -f logcat/logcat_main.log ] ; then
    echo "There are logs, package them!"
	
	# get resetlog
	date > $DEVDIR/logs/kernel_resetlog.txt
	cat /proc/lastboot >> $DEVDIR/logs/kernel_resetlog.txt
	#debugfs
	mount -t debugfs nodev /sys/kernel/debug
	cd /sys/kernel/debug/tracing
	echo sched_switch > current_tracer
	echo 1 > /proc/sys/kernel/ftrace_dump_on_oops
	cat /proc/lasttrace > $DEVDIR/logs/trace_data.txt
	cd $DEVDIR
	$BINDIR/busybox tar cf $LOGDIR/reset/resetlog.tar.gz logs/
	#echo 1 > tracing_enabled
	rm -r $DEVDIR/logs
	
	# copy anrlog
	ls /data/anr
	case "$?" in
		0) echo "has anr"
		cd $SYSDIR
		busybox cp -r /data/anr/* $LOGDIR/anr/
		rm -r /data/anr/*
	;;
	esac
	
	# copy tombstones log
	ls /data/tombstones
	case "$?" in
		0) echo "has tombstones"
		cd $SYSDIR
		busybox cp -r /data/tombstones/tombstone* $LOGDIR/logcat/
		rm -r /data/tombstones/tombstone*
	;;
	esac
	
	cd $LOGDIR
    busybox tar -cf loglast1.tar anr/* logcat/* /smem/* reset/* last_kmsg.txt 
    gzip loglast1.tar
    chmod 777 *
else
    echo "There is no log!"
fi
    
rm anr/*
rm logcat/*
rm smem/*
rm reset/*
rm last_kmsg.txt
    
stop logcat_main
stop logcat_radio
	
start logcat_main
start logcat_radio
echo prepare end

while true
do

#get smem log
cd $LOGDIR/smem
cat /sys/kernel/debug/smem_log/dump_voters > $LOGDIR/smem/dump_voters.txt
cat /sys/kernel/debug/smem_log/dump_sym > $LOGDIR/smem/dump_sym.txt
cat /sys/kernel/debug/smem_log/dump_power_sym > $LOGDIR/smem/dump_power_sym.txt

sleep 30

done
