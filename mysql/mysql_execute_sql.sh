#!/bin/bash

#登录mysql
mysql -u $username -p

#切换数据库
use $databaseName;

#执行sql脚本文件
source /home/user/create_table.sql;