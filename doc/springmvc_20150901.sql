prompt PL/SQL Developer import file
prompt Created on 2015年9月1日 by test
set feedback off
set define off
prompt Dropping SYS_DEPARTMENT...
drop table SYS_DEPARTMENT cascade constraints;
prompt Dropping SYS_DICTIONARY...
drop table SYS_DICTIONARY cascade constraints;
prompt Dropping SYS_DICTIONARYTYPE...
drop table SYS_DICTIONARYTYPE cascade constraints;
prompt Dropping SYS_KNOWLEDGE...
drop table SYS_KNOWLEDGE cascade constraints;
prompt Dropping SYS_ORGANIZATION...
drop table SYS_ORGANIZATION cascade constraints;
prompt Dropping SYS_RESOURCE...
drop table SYS_RESOURCE cascade constraints;
prompt Dropping SYS_ROLE...
drop table SYS_ROLE cascade constraints;
prompt Dropping SYS_ROLE_RESOURCE...
drop table SYS_ROLE_RESOURCE cascade constraints;
prompt Dropping SYS_USER...
drop table SYS_USER cascade constraints;
prompt Dropping SYS_USER_FJ...
drop table SYS_USER_FJ cascade constraints;
prompt Dropping SYS_USER_FJ_BAK20150831...
drop table SYS_USER_FJ_BAK20150831 cascade constraints;
prompt Dropping SYS_USER_ROLE...
drop table SYS_USER_ROLE cascade constraints;
prompt Dropping T_CUSTOMER...
drop table T_CUSTOMER cascade constraints;
prompt Creating SYS_DEPARTMENT...
create table SYS_DEPARTMENT
(
  ID        NUMBER(8) not null,
  DEPT_NAME VARCHAR2(200),
  LEVEL_ID  NUMBER(8),
  STATUS    NUMBER(8)
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table SYS_DEPARTMENT
  add constraint PK_SYS_DEPARTMENT primary key (ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_DICTIONARY...
create table SYS_DICTIONARY
(
  ID                NUMBER(8) not null,
  CODE              VARCHAR2(64) not null,
  TEXT              VARCHAR2(64) not null,
  DICTIONARYTYPE_ID NUMBER(8) not null,
  SEQ               NUMBER(8) not null,
  STATE             NUMBER(8) not null,
  ISDEFAULT         NUMBER(8) not null
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table SYS_DICTIONARY
  add constraint PK_SYS_DICTIONARY primary key (ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_DICTIONARYTYPE...
create table SYS_DICTIONARYTYPE
(
  ID          NUMBER(8) not null,
  CODE        VARCHAR2(64) not null,
  NAME        VARCHAR2(64) not null,
  SEQ         NUMBER(8) not null,
  DESCRIPTION VARCHAR2(255),
  PID         NUMBER(8)
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table SYS_DICTIONARYTYPE
  add constraint PK_SYS_DICTIONARYTYPE primary key (ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_KNOWLEDGE...
create table SYS_KNOWLEDGE
(
  ID             NUMBER(8) not null,
  NAME           VARCHAR2(70) not null,
  PID            NUMBER(8),
  SEQ            NUMBER(8) not null,
  CREATEDATETIME TIMESTAMP(6),
  ICON           VARCHAR2(32),
  MESSAGE        VARCHAR2(4000)
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table SYS_KNOWLEDGE
  add constraint PK_SYS_KNOWLEDGE primary key (ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_ORGANIZATION...
create table SYS_ORGANIZATION
(
  ID             NUMBER(8) not null,
  NAME           VARCHAR2(64) not null,
  ADDRESS        VARCHAR2(100),
  CODE           VARCHAR2(64) not null,
  ICON           VARCHAR2(32),
  PID            NUMBER(8),
  SEQ            NUMBER(8) not null,
  CREATEDATETIME TIMESTAMP(6) not null
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table SYS_ORGANIZATION
  add constraint PK_SYS_ORGANIZATION primary key (ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_RESOURCE...
create table SYS_RESOURCE
(
  ID             NUMBER(8) not null,
  NAME           VARCHAR2(64) not null,
  URL            VARCHAR2(100),
  DESCRIPTION    VARCHAR2(255),
  ICON           VARCHAR2(32),
  PID            NUMBER(8),
  SEQ            NUMBER(8) not null,
  STATE          NUMBER(8) not null,
  RESOURCETYPE   NUMBER(8) not null,
  CREATEDATETIME TIMESTAMP(6) not null
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table SYS_RESOURCE
  add constraint PK_SYS_RESOURCE primary key (ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_ROLE...
create table SYS_ROLE
(
  ID          NUMBER(8) not null,
  NAME        VARCHAR2(64) not null,
  SEQ         NUMBER(8) not null,
  DESCRIPTION VARCHAR2(255),
  ISDEFAULT   NUMBER(8) not null
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table SYS_ROLE
  add constraint PK_SYS_ROLE primary key (ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_ROLE_RESOURCE...
create table SYS_ROLE_RESOURCE
(
  ROLE_ID     NUMBER(8) not null,
  RESOURCE_ID NUMBER(8) not null
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_USER...
create table SYS_USER
(
  ID              NUMBER(8) not null,
  LOGINNAME       VARCHAR2(64) not null,
  NAME            VARCHAR2(64) not null,
  PASSWORD        VARCHAR2(64) not null,
  SEX             NUMBER(8) not null,
  AGE             NUMBER(8) not null,
  USERTYPE        NUMBER(8) not null,
  ISDEFAULT       NUMBER(8) not null,
  STATE           NUMBER(8) not null,
  ORGANIZATION_ID NUMBER(8) not null,
  CREATEDATETIME  TIMESTAMP(6) not null,
  ZYM             VARCHAR2(300),
  FJ_ID           NUMBER(8)
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table SYS_USER
  add constraint PK_SYS_USER primary key (ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_USER_FJ...
create table SYS_USER_FJ
(
  ID         NUMBER(8) not null,
  USER_ID    NUMBER(8) not null,
  URL        VARCHAR2(800) not null,
  SLTURL     VARCHAR2(800) not null,
  WJM        VARCHAR2(200) not null,
  CREATETIME VARCHAR2(20) not null,
  TOMCATURL  VARCHAR2(300)
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table SYS_USER_FJ
  add constraint PK_SYS_USER_FJ primary key (ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_USER_FJ_BAK20150831...
create table SYS_USER_FJ_BAK20150831
(
  ID         NUMBER(8) not null,
  USER_ID    NUMBER(8) not null,
  URL        VARCHAR2(800) not null,
  SLTURL     VARCHAR2(800) not null,
  WJM        VARCHAR2(200) not null,
  CREATETIME VARCHAR2(20) not null,
  TOMCATURL  VARCHAR2(300)
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating SYS_USER_ROLE...
create table SYS_USER_ROLE
(
  USER_ID NUMBER(8) not null,
  ROLE_ID NUMBER(8) not null
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table SYS_USER_ROLE
  add constraint PK_SYS_USER_ROLE primary key (USER_ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Creating T_CUSTOMER...
create table T_CUSTOMER
(
  ID                  NUMBER not null,
  CUSTOMERID          VARCHAR2(50),
  CUSTOMERNAME        NVARCHAR2(50) not null,
  CARDTYPE            VARCHAR2(50),
  CARDNUM             VARCHAR2(50),
  CUSTOMERSEX         CHAR(1),
  CUSTOMERBGDH        VARCHAR2(50),
  CUSTOMERMOBILEPHONE VARCHAR2(50),
  CUSTOMERJTDH        NVARCHAR2(50),
  CUSTOMEREMAIL       VARCHAR2(50),
  CUSTOMERADDRESS     NVARCHAR2(200),
  CUSTOMERREMARK      NVARCHAR2(200),
  CUSTOMERCREATETIME  VARCHAR2(20),
  CUSTOMERUPDATETIME  VARCHAR2(20)
)
tablespace SMVC_DATA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table T_CUSTOMER
  add constraint PK_T_CUSTOMER primary key (ID)
  using index 
  tablespace SMVC_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );

prompt Disabling triggers for SYS_DEPARTMENT...
alter table SYS_DEPARTMENT disable all triggers;
prompt Disabling triggers for SYS_DICTIONARY...
alter table SYS_DICTIONARY disable all triggers;
prompt Disabling triggers for SYS_DICTIONARYTYPE...
alter table SYS_DICTIONARYTYPE disable all triggers;
prompt Disabling triggers for SYS_KNOWLEDGE...
alter table SYS_KNOWLEDGE disable all triggers;
prompt Disabling triggers for SYS_ORGANIZATION...
alter table SYS_ORGANIZATION disable all triggers;
prompt Disabling triggers for SYS_RESOURCE...
alter table SYS_RESOURCE disable all triggers;
prompt Disabling triggers for SYS_ROLE...
alter table SYS_ROLE disable all triggers;
prompt Disabling triggers for SYS_ROLE_RESOURCE...
alter table SYS_ROLE_RESOURCE disable all triggers;
prompt Disabling triggers for SYS_USER...
alter table SYS_USER disable all triggers;
prompt Disabling triggers for SYS_USER_FJ...
alter table SYS_USER_FJ disable all triggers;
prompt Disabling triggers for SYS_USER_FJ_BAK20150831...
alter table SYS_USER_FJ_BAK20150831 disable all triggers;
prompt Disabling triggers for SYS_USER_ROLE...
alter table SYS_USER_ROLE disable all triggers;
prompt Disabling triggers for T_CUSTOMER...
alter table T_CUSTOMER disable all triggers;
prompt Loading SYS_DEPARTMENT...
insert into SYS_DEPARTMENT (ID, DEPT_NAME, LEVEL_ID, STATUS)
values (1, '财务部', 1, 1);
commit;
prompt 1 records loaded
prompt Loading SYS_DICTIONARY...
insert into SYS_DICTIONARY (ID, CODE, TEXT, DICTIONARYTYPE_ID, SEQ, STATE, ISDEFAULT)
values (1, '0', '管理员', 2, 0, 0, 1);
insert into SYS_DICTIONARY (ID, CODE, TEXT, DICTIONARYTYPE_ID, SEQ, STATE, ISDEFAULT)
values (2, '1', '用户', 2, 0, 0, 1);
insert into SYS_DICTIONARY (ID, CODE, TEXT, DICTIONARYTYPE_ID, SEQ, STATE, ISDEFAULT)
values (25, '0', '身份证', 19, 0, 0, 1);
insert into SYS_DICTIONARY (ID, CODE, TEXT, DICTIONARYTYPE_ID, SEQ, STATE, ISDEFAULT)
values (26, '1', '其他证件', 19, 1, 0, 1);
commit;
prompt 4 records loaded
prompt Loading SYS_DICTIONARYTYPE...
insert into SYS_DICTIONARYTYPE (ID, CODE, NAME, SEQ, DESCRIPTION, PID)
values (1, 'base', '基础设置', 0, '基础设置', null);
insert into SYS_DICTIONARYTYPE (ID, CODE, NAME, SEQ, DESCRIPTION, PID)
values (2, 'usertype', '用户类型', 1, '用户类型', 1);
insert into SYS_DICTIONARYTYPE (ID, CODE, NAME, SEQ, DESCRIPTION, PID)
values (19, 'cardtype', '证件类型', 4, '证件类型', 1);
commit;
prompt 3 records loaded
prompt Loading SYS_KNOWLEDGE...
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (24, '知识6', 1, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'NULL', null);
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (1, '知识1', null, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_company', 'NULL');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (4, '知识2', null, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_company', 'NULL');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (8, '信息2', 4, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_dic', '也是站在国家长期、协调和可持续发展的高度采取的有效政策，体现了聚集党心、凝聚民心的政治远见；更是站在国家发展转型升级，推进国家治理体系与治理能力现代化的高度，将中国的发展提升到依法治国状态的重大举措。清除腐败，是国家的福音。');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (9, '信息1', 1, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_dic', '一个敢于剜除自己肌体上的脓疮的政党，是能够压倒一切困难而不被一切困难压倒的政党，更是最有希望、最有前途、最能够给国家和人民带来希望、带来梦想、带来幸福的执政党。清除腐败，是一个敢于剜除自己肌体上的脓疮的政党，是能够压倒一切困难而不被一切困难压倒的政党，更是最有希望、最有前途、最能够给国家和人民带来希望、带来梦想、带来幸福的执政党。清除腐败，是人民的福一个敢于剜除自己肌体上的脓疮的政党，是能够压倒一切困难而不被一切困难压倒的政党，更是最有希望、最有前途、最能够给国家和人民带来希望、带来梦想、带来幸福的执政党。清除腐败，是人民的福音一个敢于剜除自己肌体上的脓疮的政党，是能够压倒一切困难而不被一切困难压倒的政党，更是最有希望、最有前途、最能够给国家和人民带来希望、带来梦想、带来幸福的执政党。清除腐败，是人民的福音一个敢于剜除自己肌体上的脓疮的政党，是能够压倒一切困难而不被一切困难压倒的政党，更是最有希望、最有前途、最能够给国家和人民带来希望、带来梦想、带来幸福的执政党。清除腐败，是人民的福音一个敢于剜除自己肌体上的脓疮的政党，是能够压倒一切困难而不被一切困难压倒的政党，更是最有希望、最有前途、最能够给国家和人民带来希望、带来梦想、带来幸福的执政党。清除腐败，是人民的福音一个敢于剜除自己肌体上的脓疮的政党，是能够压倒一切困难而不被一切困难压倒的政党，更是最有希望、最有前途、最能够给国家和人民带来希望、带来梦想、带来幸福的执政党。清除腐败，是人民的福音音人民的福音');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (13, '知识3', null, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_company', 'NULL');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (14, '信息3', 4, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_dic', '中国人民政治协商会议第十二届全国委员会副主席、中共中央统战部部长令计划涉嫌严重违纪，目前正接受组织调查。”');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (15, '信息4', 13, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_dic', '反腐败，已经发挥了强大的政治凝聚作用，体现了执政党与全国人民坚决反腐败的决心与信心，表现出中国共产党刮骨疗毒、廉洁执政、清明治国的鲜明政治态度。');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (16, '知识4', null, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_folder', null);
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (17, '信息5', null, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_folder', '打发第三方');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (18, '知识5', 1, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_folder', '爱的是发的是');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (19, '信息 6', 18, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_folder', '啥的发生的');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (20, '信息5', 1, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_folder', 'abc');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (21, '信息7', 18, 0, to_timestamp('18-08-2015 16:32:42.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_folder', '啊');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (22, '12', 1, 0, to_timestamp('18-08-2015 16:32:43.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_folder', '12');
insert into SYS_KNOWLEDGE (ID, NAME, PID, SEQ, CREATEDATETIME, ICON, MESSAGE)
values (23, 'ads', null, 0, to_timestamp('18-08-2015 16:32:43.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'icon_folder', null);
commit;
prompt 16 records loaded
prompt Loading SYS_ORGANIZATION...
insert into SYS_ORGANIZATION (ID, NAME, ADDRESS, CODE, ICON, PID, SEQ, CREATEDATETIME)
values (100, '公司管理层', null, '0101', 'icon_folder', 1, 0, to_timestamp('19-08-2015 15:20:45.106000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_ORGANIZATION (ID, NAME, ADDRESS, CODE, ICON, PID, SEQ, CREATEDATETIME)
values (101, '软件研发部', null, '0102', 'icon_folder', 1, 1, to_timestamp('19-08-2015 15:21:30.590000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_ORGANIZATION (ID, NAME, ADDRESS, CODE, ICON, PID, SEQ, CREATEDATETIME)
values (102, '工程技术部', null, '0103', 'icon_folder', 1, 2, to_timestamp('19-08-2015 15:22:02.318000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_ORGANIZATION (ID, NAME, ADDRESS, CODE, ICON, PID, SEQ, CREATEDATETIME)
values (103, '市场拓展部', null, '0104', 'icon_folder', 1, 3, to_timestamp('19-08-2015 15:22:22.059000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_ORGANIZATION (ID, NAME, ADDRESS, CODE, ICON, PID, SEQ, CREATEDATETIME)
values (104, '行政管理部', null, '0105', 'icon_folder', 1, 5, to_timestamp('19-08-2015 15:22:40.990000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_ORGANIZATION (ID, NAME, ADDRESS, CODE, ICON, PID, SEQ, CREATEDATETIME)
values (105, '财务计划部', null, '0106', 'icon_folder', 1, 6, to_timestamp('19-08-2015 15:23:02.898000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_ORGANIZATION (ID, NAME, ADDRESS, CODE, ICON, PID, SEQ, CREATEDATETIME)
values (1, '软件公司', '地址', '01', 'icon_company', null, 0, to_timestamp('19-02-2014 00:00:00.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 7 records loaded
prompt Loading SYS_RESOURCE...
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (200, '生产研发文档', null, '生产研发文档', null, 66, 1, 0, 0, to_timestamp('01-09-2015 10:45:34.003000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (201, '人事管理文档', null, null, null, 66, 2, 0, 0, to_timestamp('01-09-2015 10:46:27.194000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (202, '通讯录', null, null, 'icon_search', 202, 6, 0, 0, to_timestamp('01-09-2015 10:55:10.434000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (203, '通讯录管理', null, null, 'icon_dic', 202, 0, 0, 0, to_timestamp('01-09-2015 10:56:02.409000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (204, '个人办公', null, null, 'icon_user', 204, 1, 0, 0, to_timestamp('01-09-2015 11:00:25.599000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (205, '我的流程', null, null, 'icon_user', 204, 0, 0, 0, to_timestamp('01-09-2015 11:01:22.516000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (206, '考勤管理', null, null, 'icon_company', 206, 3, 0, 0, to_timestamp('01-09-2015 11:02:49.514000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (207, '员工考勤信息', null, null, 'icon_dic', 206, 0, 0, 0, to_timestamp('01-09-2015 11:03:19.232000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (1, '系统管理', null, '系统管理', 'icon_sys', 1, 0, 0, 0, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (2, '资源管理', '/resource/manager', '资源管理', 'icon_resource', 1, 4, 0, 0, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (3, '角色管理', '/role/manager', '角色管理', 'icon_role', 1, 2, 0, 0, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (4, '用户管理', '/user/manager', '用户管理', 'icon_user', 1, 1, 0, 0, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (5, '资源列表', '/resource/treeGrid', '资源列表', 'icon_resource', 2, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (6, '添加', '/resource/add', '资源添加', 'icon_resource', 2, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (7, '编辑', '/resource/edit', '资源编辑', 'icon_resource', 2, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (8, '删除', '/resource/delete', '资源删除', 'icon_resource', 2, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (10, '角色列表', '/role/dataGrid', '角色列表', 'icon_role', 3, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (11, '添加', '/role/add', '角色添加', 'icon_role', 3, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (12, '编辑', '/role/edit', '角色编辑', 'icon_role', 3, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (13, '删除', '/role/delete', '角色删除', 'icon_role', 3, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (14, '授权', '/role/grant', '角色授权', 'icon_role', 3, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (15, '用户列表', '/user/dataGrid', '用户列表', 'icon_user', 4, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (16, '添加', '/user/add', '用户添加', 'icon_user', 4, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (17, '编辑', '/user/edit', '用户编辑', 'icon_user', 4, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (18, '删除', '/user/delete', '用户删除', 'icon_user', 4, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (19, '查看', '/user/view', '用户查看', 'icon_user', 4, 0, 0, 1, to_timestamp('18-08-2015 16:25:10.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (20, '部门管理', '/organization/manager', '部门管理', 'icon_org', 1, 3, 0, 0, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (21, '部门列表', '/organization/treeGrid', '用户列表', 'icon_org', 20, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (22, '添加', '/organization/add', '部门添加', 'icon_org', 20, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (23, '编辑', '/organization/edit', '部门编辑', 'icon_org', 20, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (24, '删除', '/organization/delete', '部门删除', 'icon_org', 20, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (25, '查看', '/organization/view', '部门查看', 'icon_org', 20, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (26, '数据字典', '/dictionary/manager', '数据字典', 'icon_dic', 1, 5, 0, 0, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (27, '字典列表', '/dictionary/dataGrid', '字典列表', 'icon_dic', 26, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (28, '字典类别列表', '/dictionarytype/dataGrid', '字典类别列表', 'icon_dic', 26, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (29, '添加', '/dictionary/add', '字典添加', 'icon_dic', 26, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (30, '编辑', '/dictionary/edit', '字典编辑', 'icon_dic', 26, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (31, '删除', '/dictionary/delete', '字典删除', 'icon_dic', 26, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (57, '人员管理', null, null, 'icon_role', 57, 2, 0, 0, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (58, '员工信息管理', '/customer/manager', null, 'icon_user', 57, 1, 0, 0, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (59, '员工列表', '/customer/dataGrid', null, 'icon_user', 58, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (60, '增加', '/customer/add', null, 'icon_user', 59, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (61, '编辑', '/customer/edit', null, 'icon_user', 59, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (62, '删除', '/customer/delete', null, 'icon_user', 59, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (63, '查看', '/customer/view', null, 'icon_user', 59, 0, 0, 1, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (64, '统计分析', null, null, 'icon_dic', 64, 4, 0, 0, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (65, '考勤记录', '/agent/manager', null, 'icon_dic', 64, 0, 0, 0, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (66, '知识文档', null, 'test', 'icon_folder', 66, 5, 0, 0, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
insert into SYS_RESOURCE (ID, NAME, URL, DESCRIPTION, ICON, PID, SEQ, STATE, RESOURCETYPE, CREATEDATETIME)
values (67, '规章制度文档', '/knowledge/manager', null, null, 66, 0, 0, 0, to_timestamp('18-08-2015 16:25:11.000000', 'dd-mm-yyyy hh24:mi:ss.ff'));
commit;
prompt 49 records loaded
prompt Loading SYS_ROLE...
insert into SYS_ROLE (ID, NAME, SEQ, DESCRIPTION, ISDEFAULT)
values (100, '普通员工', 3, '普通员工', 1);
insert into SYS_ROLE (ID, NAME, SEQ, DESCRIPTION, ISDEFAULT)
values (101, '部门领导', 2, '部门领导', 1);
insert into SYS_ROLE (ID, NAME, SEQ, DESCRIPTION, ISDEFAULT)
values (1, '超级管理员', 0, '超级管理员，拥有全部权限', 0);
insert into SYS_ROLE (ID, NAME, SEQ, DESCRIPTION, ISDEFAULT)
values (2, '管理层领导', 1, '公司管理层领导', 1);
commit;
prompt 4 records loaded
prompt Loading SYS_ROLE_RESOURCE...
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 203);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 24);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 206);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 30);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 21);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 207);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 15);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 12);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 58);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 6);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 4);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 27);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 28);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 204);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 16);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 26);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 8);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 3);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 205);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 59);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 18);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 60);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 201);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 23);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 13);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 1);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 57);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 200);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 25);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 11);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 31);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 67);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 7);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 14);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 65);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 202);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 20);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 22);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 19);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 29);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 5);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 64);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 66);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 62);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 2);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 61);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 10);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 17);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (1, 63);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (100, 15);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (100, 19);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 28);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 205);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (100, 16);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (100, 18);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (100, 4);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (100, 17);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (100, 1);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 19);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 3);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 23);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 207);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 203);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 29);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 20);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 59);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 206);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 13);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 12);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 62);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 200);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 25);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 63);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 26);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 4);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 2);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 22);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 11);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 30);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 1);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 66);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 65);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 18);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 7);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 64);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 31);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 60);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 204);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 6);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 202);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 21);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 67);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 16);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 17);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 15);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 61);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 24);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 8);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 14);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 57);
commit;
prompt 100 records committed...
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 5);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 27);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 201);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 58);
insert into SYS_ROLE_RESOURCE (ROLE_ID, RESOURCE_ID)
values (2, 10);
commit;
prompt 105 records loaded
prompt Loading SYS_USER...
insert into SYS_USER (ID, LOGINNAME, NAME, PASSWORD, SEX, AGE, USERTYPE, ISDEFAULT, STATE, ORGANIZATION_ID, CREATEDATETIME, ZYM, FJ_ID)
values (2, 'aljqiang', '赖洁强', 'c4ca4238a0b923820dcc509a6f75849b', 0, 25, 0, 1, 0, 100, to_timestamp('18-08-2015 16:54:30.512000', 'dd-mm-yyyy hh24:mi:ss.ff'), '村长有人偷牛', null);
insert into SYS_USER (ID, LOGINNAME, NAME, PASSWORD, SEX, AGE, USERTYPE, ISDEFAULT, STATE, ORGANIZATION_ID, CREATEDATETIME, ZYM, FJ_ID)
values (1, 'admin', '超级管理员', 'c4ca4238a0b923820dcc509a6f75849b', 0, 18, 0, 0, 0, 1, to_timestamp('18-08-2015 16:27:35.000000', 'dd-mm-yyyy hh24:mi:ss.ff'), '我是超级管理员', null);
insert into SYS_USER (ID, LOGINNAME, NAME, PASSWORD, SEX, AGE, USERTYPE, ISDEFAULT, STATE, ORGANIZATION_ID, CREATEDATETIME, ZYM, FJ_ID)
values (3, 'a', '小明', 'c4ca4238a0b923820dcc509a6f75849b', 0, 25, 1, 1, 0, 101, to_timestamp('19-08-2015 15:39:47.596000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into SYS_USER (ID, LOGINNAME, NAME, PASSWORD, SEX, AGE, USERTYPE, ISDEFAULT, STATE, ORGANIZATION_ID, CREATEDATETIME, ZYM, FJ_ID)
values (121, 'b', '小强', 'c4ca4238a0b923820dcc509a6f75849b', 0, 25, 1, 1, 0, 101, to_timestamp('19-08-2015 15:42:31.370000', 'dd-mm-yyyy hh24:mi:ss.ff'), '11', null);
insert into SYS_USER (ID, LOGINNAME, NAME, PASSWORD, SEX, AGE, USERTYPE, ISDEFAULT, STATE, ORGANIZATION_ID, CREATEDATETIME, ZYM, FJ_ID)
values (122, 'c', '小瑶', 'c4ca4238a0b923820dcc509a6f75849b', 1, 24, 1, 1, 0, 104, to_timestamp('19-08-2015 15:42:55.846000', 'dd-mm-yyyy hh24:mi:ss.ff'), null, null);
insert into SYS_USER (ID, LOGINNAME, NAME, PASSWORD, SEX, AGE, USERTYPE, ISDEFAULT, STATE, ORGANIZATION_ID, CREATEDATETIME, ZYM, FJ_ID)
values (141, 'd', '小花', 'c4ca4238a0b923820dcc509a6f75849b', 1, 25, 1, 1, 0, 105, to_timestamp('28-08-2015 10:19:32.751000', 'dd-mm-yyyy hh24:mi:ss.ff'), 'test', null);
commit;
prompt 6 records loaded
prompt Loading SYS_USER_FJ...
prompt Table is empty
prompt Loading SYS_USER_FJ_BAK20150831...
insert into SYS_USER_FJ_BAK20150831 (ID, USER_ID, URL, SLTURL, WJM, CREATETIME, TOMCATURL)
values (5, 1, '\photo\1427705206474.jpg', '\photo\suolt\1427705206474.jpg', '1427705206474.jpg', '30-MAR-15', 'E:\apache-tomcat-6.0.13\webapps\lightmvc');
insert into SYS_USER_FJ_BAK20150831 (ID, USER_ID, URL, SLTURL, WJM, CREATETIME, TOMCATURL)
values (7, 16, '\upload\photo\1419491241686.jpg', '\upload\photo\suolt\1419491241686.jpg', '1419491241686.jpg', '25-DEC-14', 'F:\tomcat6.0.43\webapps\lightmvc');
commit;
prompt 2 records loaded
prompt Loading SYS_USER_ROLE...
insert into SYS_USER_ROLE (USER_ID, ROLE_ID)
values (2000, 1);
insert into SYS_USER_ROLE (USER_ID, ROLE_ID)
values (122, 100);
insert into SYS_USER_ROLE (USER_ID, ROLE_ID)
values (2001, 100);
insert into SYS_USER_ROLE (USER_ID, ROLE_ID)
values (3, 100);
insert into SYS_USER_ROLE (USER_ID, ROLE_ID)
values (141, 100);
insert into SYS_USER_ROLE (USER_ID, ROLE_ID)
values (2, 2);
insert into SYS_USER_ROLE (USER_ID, ROLE_ID)
values (1, 1);
insert into SYS_USER_ROLE (USER_ID, ROLE_ID)
values (16, 2);
insert into SYS_USER_ROLE (USER_ID, ROLE_ID)
values (121, 101);
commit;
prompt 9 records loaded
prompt Loading T_CUSTOMER...
insert into T_CUSTOMER (ID, CUSTOMERID, CUSTOMERNAME, CARDTYPE, CARDNUM, CUSTOMERSEX, CUSTOMERBGDH, CUSTOMERMOBILEPHONE, CUSTOMERJTDH, CUSTOMEREMAIL, CUSTOMERADDRESS, CUSTOMERREMARK, CUSTOMERCREATETIME, CUSTOMERUPDATETIME)
values (2138, null, '张灿瑶', '0', '51012219920817702X', '0', null, '15184498125', null, '907575845@qq.com', null, '123', '23-7月 -14', '2015-08-28 16:26:33');
commit;
prompt 1 records loaded
prompt Enabling triggers for SYS_DEPARTMENT...
alter table SYS_DEPARTMENT enable all triggers;
prompt Enabling triggers for SYS_DICTIONARY...
alter table SYS_DICTIONARY enable all triggers;
prompt Enabling triggers for SYS_DICTIONARYTYPE...
alter table SYS_DICTIONARYTYPE enable all triggers;
prompt Enabling triggers for SYS_KNOWLEDGE...
alter table SYS_KNOWLEDGE enable all triggers;
prompt Enabling triggers for SYS_ORGANIZATION...
alter table SYS_ORGANIZATION enable all triggers;
prompt Enabling triggers for SYS_RESOURCE...
alter table SYS_RESOURCE enable all triggers;
prompt Enabling triggers for SYS_ROLE...
alter table SYS_ROLE enable all triggers;
prompt Enabling triggers for SYS_ROLE_RESOURCE...
alter table SYS_ROLE_RESOURCE enable all triggers;
prompt Enabling triggers for SYS_USER...
alter table SYS_USER enable all triggers;
prompt Enabling triggers for SYS_USER_FJ...
alter table SYS_USER_FJ enable all triggers;
prompt Enabling triggers for SYS_USER_FJ_BAK20150831...
alter table SYS_USER_FJ_BAK20150831 enable all triggers;
prompt Enabling triggers for SYS_USER_ROLE...
alter table SYS_USER_ROLE enable all triggers;
prompt Enabling triggers for T_CUSTOMER...
alter table T_CUSTOMER enable all triggers;
set feedback on
set define on
prompt Done.
