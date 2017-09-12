#数据库初始化脚本
#(1)创建数据库(若已存在请另改数据库名)
CREATE DATABASE niitblog;
USE niitblog;
#(2)创建表
#博主表
CREATE TABLE bsuser(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	username VARCHAR(20) NOT NULL UNIQUE COMMENT '用户名',
	email VARCHAR(100) NOT NULL UNIQUE COMMENT '邮箱',
	password VARCHAR(100) NOT NULL COMMENT '密码',
	avatar VARCHAR(100) COMMENT '头像',
	qq VARCHAR(20) COMMENT 'qq',
	intro VARCHAR(200) COMMENT '简介',
	payqd VARCHAR(300) COMMENT '支付二维码',
	cretime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
	PRIMARY KEY(id),
	KEY idx_username(username),
	KEY idx_email(email)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#博文表
CREATE TABLE bspost(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	author VARCHAR(20) NOT NULL COMMENT '作者用户名',
	title VARCHAR(100) NOT NULL COMMENT '标题',
	body TEXT NOT NULL COMMENT '正文',
	cretime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	updtime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最新更新时间',
	status INT NOT NULL COMMENT '状态 -1未发布 0隐藏 1已发布',
	readtimes INT NOT NULL DEFAULT 0 COMMENT '被阅读次数',
	PRIMARY KEY(id),
	KEY idx_author(author),
	KEY idx_title(title),
	KEY idx_updtime(updtime)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#评论表
CREATE TABLE bscomment(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	postid BIGINT NOT NULL COMMENT '博文id',
	active VARCHAR(20) NOT NULL COMMENT '发起人用户名',
	passive VARCHAR(20) NOT NULL COMMENT '接收人用户名',
	comment VARCHAR(200) NOT NULL COMMENT '评论内容',
	cretime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	PRIMARY KEY(id),
	KEY idx_postid(postid),
	KEY idx_active(active),
	KEY idx_passive(passive)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#留言表
CREATE TABLE bsleaveword(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	active VARCHAR(20) NOT NULL COMMENT '发起人用户名',
	passive VARCHAR(20) NOT NULL COMMENT '接收人用户名',
	leaveword VARCHAR(300) NOT NULL COMMENT '留言内容',
	cretime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	PRIMARY KEY(id),
	KEY idx_active(active),
	KEY idx_passive(passive)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#私信表
CREATE TABLE bschat(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	active VARCHAR(20) NOT NULL COMMENT '发起人用户名',
	passive VARCHAR(20) NOT NULL COMMENT '接收人用户名',
	msg TEXT NOT NULL COMMENT '私信内容',
	cretime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	PRIMARY KEY(id),
	KEY idx_active(active),
	KEY idx_passive(passive)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#点赞表
CREATE TABLE bslike(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	active VARCHAR(20) NOT NULL COMMENT '点赞人用户名',
	passive VARCHAR(20) COMMENT '被赞人用户名',
	postid BIGINT COMMENT '被赞博文id',
	cretime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	PRIMARY KEY(id),
	KEY idx_active(active),
	KEY idx_passive(passive),
	KEY idx_postid(postid)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#标签表
CREATE TABLE bstag(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	tagname VARCHAR(20) NOT NULL UNIQUE COMMENT '标签名',
	posts INT NOT NULL DEFAULT 0 COMMENT '对应博文数量',
	cretime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#标签博文中间表
CREATE TABLE bstag2post(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	postid BIGINT NOT NULL COMMENT '博文id',
	tagid BIGINT NOT NULL COMMENT '标签id',
	PRIMARY KEY(id),
	KEY idx_postid(postid),
	KEY idx_tagid(tagid)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#关注表
CREATE TABLE bsfollow(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	active VARCHAR(20) NOT NULL COMMENT '关注人用户名',
	passive VARCHAR(20) NOT NULL COMMENT '被关注人用户名',
	cretime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	PRIMARY KEY(id),
	KEY idx_active(active),
	KEY idx_passive(passive)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#消息表
CREATE TABLE bsmessage(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	msgtype INT NOT NULL COMMENT '类型 1评论 2留言 3私信 4点赞',
	status INT NOT NULL DEFAULT 0 COMMENT '状态 0-未读 1-已读',
	cretime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	PRIMARY KEY(id),
	KEY idx_msgtype(msgtype)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
#敏感信息表
CREATE TABLE bssensitive(
	id BIGINT NOT NULL AUTO_INCREMENT COMMENT 'id',
	word VARCHAR(10) NOT NULL COMMENT '敏感词',
	cretime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	PRIMARY KEY(id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;