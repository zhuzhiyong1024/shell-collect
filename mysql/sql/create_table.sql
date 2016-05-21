create table T_CONFIG
(
	CONFIGNAME 	varchar(64) not null,
	CONFIGVALUE varchar(1024),
	primary key (CONFIGNAME)
)default charset=utf8;

create table T_ACCOUNT
(
	`PROFILEID`		varchar(20)	NOT NULL,
	`MONEY`			DOUBLE		DEFAULT NULL,
	PRIMARY KEY (`PROFILEID`)
)default charset=utf8;