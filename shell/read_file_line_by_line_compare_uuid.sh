#!/bin/bash

# 功能：特征日志记录查找
# 描述：在一条日志中，如果两个uuid不同，则标记为问题的日志记录.
# Create at: 2016.5.22 15:33 GMT+08:00

# 思路：逐行读取日志记录，grep正则匹配找出所有的uuid，并存入数组;
#       有且仅有2个uuid的数组才符合要求，接下来比较这2个uuid，如果
#		不同则认为是问题日志

# TODO：1.直接匹配读取到的字符串效率更高，目前是将读取的行存入临时文件，
#       在grep正则匹配，有点多此一举
#		2.匹配UUID的正则表达式中间部分明显重复了，看能否简化

START=$(date +%s)
INPUT_FILE=./myapp.log
TOTAL_LINES=0
ISSUE_LINES=0
TEMP_FILE=./temp.log
RESULT_LOG=./result.log
while IFS='' read -r line || [[ -n "$line" ]]; do
	((TOTAL_LINES++));
	echo $line > $TEMP_FILE
    uuid_array=($(grep '[0-9a-f]\{8\}-[0-9a-f]\{4\}-[0-9a-f]\{4\}-[0-9a-f]\{4\}-[0-9a-f]\{12\}' -o < $TEMP_FILE));
	
	if [ "2" -eq "${#uuid_array[@]}" ]; then
		if [ ! "${uuid_array[0]}" = "${uuid_array[1]}" ]; then	
			echo "Line $TOTAL_LINES: $line]" >> $RESULT_LOG;
			((ISSUE_LINES++));
		fi
	fi
done < $INPUT_FILE

# 清理临时文件
rm $TEMP_FILE

END=$(date +%s)
ELAPSED_TIME=$(( $END - $START ))

# 分析结果报告
if [ "$ISSUE_LINES" -gt "0" ]; then
	echo "Finish analysis in ${ELAPSED_TIME}s, total lines: $TOTAL_LINES, issue lines: $ISSUE_LINES. Please check '`realpath $RESULT_LOG`'."
else 
	echo "Finish analysis in $ELAPSED_TIMEs, total lines: $TOTAL_LINES, no issue found."
fi


 