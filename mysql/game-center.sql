
drop table if exists tb_game_center_resource;

create table tb_game_center_resource(
id              		bigint(20)  	auto_increment 			comment '主键自增',
activity_type   		smallint    	not null 				comment '活动类型',
activity_id     		bigint(20)  	not null				comment '活动ID',
resource_location_id    bigint(20)  	not null				comment '资源位ID, 标识该资源展示在哪个区域',
status          		tinyint(1)  	not null				comment '资源状态, 正常:1;删除:2',
payload         		smallint    	not null	default 0	comment '资源优先级，相对于处于同一资源位的活动有效',
gmt_create      		date        	not null				comment '创建时间',
gmt_modified    		date        	not null				comment '修改时间',
primary key (id),
key idx_resource_location_id (resource_location_id),
key idx_resource_status (status)
)ENGINE=InnoDB default charset=utf8 comment='积分商城游戏中心首页资源表';


drop table if exists tb_game_center_resource_location;

create table tb_game_center_resource_location(
id 					bigint(20)  		auto_increment			comment '主键自增',
name				varchar(255)		not null				comment '资源位名称',
title				varchar(512)		not null				comment '资源位展示名，如：Banner，今日推荐，大家都在玩等',
description			varchar(1024)		not null				comment '资源位描述',
max_limit			smallint		  	not null default 0		comment '该资源位的最大资源数限制，0不限制',
min_limit			smallint			not null default 0		comment '该资源位的最小资源数限制，0不限制',
payload				smallint			not null default 0		comment '资源位优先级',
status				tinyint(1)			not null default 1		comment '资源状态, 正常:1;删除:2',
gmt_create			date       			not null				comment '创建时间',
gmt_modified		date 				not null				comment '修改时间',
primary key (id),
unique key unidx_location_name (name)
)ENGINE=InnoDB default charset=utf8 comment='积分商城游戏中心首页资源位表';


-- 初始化数据：3个区域
insert into tb_game_center_resource_location(name, title, description, max_limit, min_limit, payload, status, gmt_create, gmt_modified)
values ('Banner','Banner', '积分商城游戏中心Banner区资源位', 6, 0, 0, 1, now(), now()), 
('TodayRecommend', '今日推荐', '积分商城游戏中心今日推荐区资源位', 0, 0, 0, 1, now(), now()), 
('EveryonePlay', '大家都在玩', '积分商城游戏中心大家都在玩区资源位', 0, 0, 0, 1, now(), now());



drop table if exists tb_activity_shield;

create table tb_activity_shield(
id 					bigint(20)  		auto_increment 			comment '主键自增',
developer_id		bigint(20)			default null			comment '开发者ID',
app_id				bigint(20)			not null				comment 'APP ID',
activity_type		smallint			not null				comment	'活动类型',
activity_id			bigint(20)			not null				comment '活动ID',
gmt_create			date       			not null				comment '创建时间',
gmt_modified		date       			not null				comment '修改时间',
primary key (id),
unique key unidx_shield (app_id, activity_type, activity_id)
)ENGINE=InnoDB default charset=utf8 comment='活动屏蔽表';

