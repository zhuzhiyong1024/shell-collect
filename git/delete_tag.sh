#!/bin/bash

#1.输入tag名称
read -p "please input tag name for delete: " TAG_NAME

if [ "$TAG_NAME" == "" ]; then 
	echo "tag name can't be empty!"
	exit 1
fi

#2.删除本地tag
git tag -d "$TAG_NAME" > /dev/null 2>&1

if [ 0 == $? ]; then
	echo "delete tag success."
else
	echo "delete tag failed."
	exit 2
fi

#3.删除远程tag
git push origin :"$TAG_NAME" > /dev/null 2>&1

if [ 0 == $? ]; then 
	echo "delete remote tag success."
	exit 0
else 
	echo "delete remote tag failed."
	exit 3
fi

