#!/bin/sh

# 功能：定时输出java应用线程栈到文件
# 描述：指定Java进程、jstack打印间隔、打印次数
# 日期：2016.5.27 00:03 GMT+08:00

JAVA_PID=$1
COUNT=$2
SLEEP_TIME=$3

DUMP_DIR=java_dump/jstack
FILE_PREFIX=java_${JAVA_PID}

printUsage() {	
	echo "Usage:"
	echo "${0} pid count sleep_time"
}

if [ -z "$JAVA_PID" ]; then
	printUsage;
	exit 1;
fi

#default count is 10
if [ -z "$COUNT" ]; then
	COUNT=10;
fi

#default sleep time is 1s
if [ -z "$SLEEP_TIME" ]; then
	SLEEP_TIME="1s";
fi

if [ ! -d $DUMP_DIR ]; then
	mkdir -p $DUMP_DIR || { echo "Failed to create dir $DUMP_DIR."; exit 2; }
fi

i=1
while [ "$i" -le $COUNT ]
do 
	jstack $JAVA_PID > ${DUMP_DIR}/${FILE_PREFIX}_${i}.log;
	i=$(( i + 1 ));
	sleep $SLEEP_TIME;
done
