CREATE DATABASE IF NOT EXISTS edu_demo;

USE edu_demo;

DROP TABLE IF EXISTS edu_edmo_pms_user;

/*==============================================================*/
/* Table: edu_edmo_pms_user                                      */
/*==============================================================*/
CREATE TABLE edu_edmo_pms_user
(
   id                   BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   VERSION              INT NOT NULL DEFAULT 0 COMMENT 'version',
   create_time          DATETIME DEFAULT NULL COMMENT '创建时间',
   user_no              VARCHAR(50) NOT NULL COMMENT '用户帐号',
   user_type            VARCHAR(1) NOT NULL COMMENT '用户类型（1:超级管理员，2:普通管理员，3:用户主帐号，4:用户子帐号）',
   main_user_id         BIGINT(50) DEFAULT 0 COMMENT '主帐号ID',
   user_pwd             VARCHAR(256) NOT NULL COMMENT '登录密码',
   user_name            VARCHAR(50) NOT NULL COMMENT '姓名',
   mobile_no            VARCHAR(15) COMMENT '手机号',
   email                VARBINARY(100) COMMENT '邮箱',
   STATUS               INT NOT NULL COMMENT '状态(100:可用，101:不可用 )',
   last_login_time      DATETIME COMMENT '最后登录时间',
   is_changed_pwd       INT COMMENT '是否更改过密码',
   pwd_error_count      INT NOT NULL DEFAULT 0 COMMENT '连续输错密码次数',
   pwd_error_time       DATETIME COMMENT '最后输错密码时间',
   remark               VARCHAR(300) COMMENT '备注',
   PRIMARY KEY (id),
   UNIQUE KEY AK_Key_2 (user_no)
);

ALTER TABLE edu_edmo_pms_user COMMENT '用户信息表';

##创建触发器
DELIMITER |   
CREATE TRIGGER default_datetime BEFORE INSERT ON edu_edmo_pms_user   
  FOR EACH ROW   
    IF new.create_time IS NULL THEN   
      SET new.create_time = NOW();   
    END IF;|   
DELIMITER ;

## 用户的初始化数据(密码123456)
INSERT INTO edu_edmo_pms_user (id, user_no, user_pwd, remark, user_name, mobile_no, STATUS, user_type, last_login_time, is_changed_pwd, pwd_error_count, pwd_error_time) VALUES 
(1, 'admin', '7c4a8d09ca3762af61e59520943dc26494f8941b', '超级管理员', '超级管理员', '13800138000', '100', '1', NULL, 0, 0, NULL);