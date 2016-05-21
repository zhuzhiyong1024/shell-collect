#!/bin/bash

ERROR_LOG_DIR=$HOME/git_log
ERROR_LOG_FILE=git_error.log
ERROR_LOG=$ERROR_LOG_DIR/$ERROR_LOG_FILE

function create_git_log_file(){
	if [ ! -f $ERROR_LOG ]; then
		touch $ERROR_LOG
	else
		cat /dev/null > $ERROR_LOG
	fi
	if [ 0 != $? ]; then 
		echo "create log file failed."
		exit 1
	fi
}

if [ ! -d $ERROR_LOG_DIR ]; then
	mkdir $ERROR_LOG_DIR
	if [ 0 != $? ]; then 
		echo "mkdir git failed."
		exit 1
	fi
fi

create_git_log_file


#1.获取tag名称和tag批注
read -p "please input tag name: " TAG_NAME

if [ "$TAG_NAME" == "" ]; then
	echo "tag name can't be empty!"
	exit 1
fi

read -p "please input tag comment: " TAG_COMMENT 
if [ "$TAG_COMMENT" == "" ]; then
	echo "tag comment can't be empty!"
	exit 1
fi

#2.本地添加tag
git tag -a "$TAG_NAME" -m "$TAG_COMMENT" 2>> $ERROR_LOG

if [ 0 == $? ]; then
	echo "add tag success."
else
	echo "add tag failed. please check error log."
	exit 2
fi

#3.推送到远端
git push origin "$TAG_NAME" 2>> $ERROR_LOG
if [ 0 == $? ]; then
	echo "push to remote success."
else
	echo "push to remote failed. please check error log."
	exit 3
fi



