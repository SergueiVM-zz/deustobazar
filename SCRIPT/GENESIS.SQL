connect system/manager;

create tablespace tab_bazar
datafile 'c:\orant\database\bazar0orcl.ora'
size 3000k
default storage (initial 50k next 25k
minextents 1 maxextents 121 pctincrease 0);

create user bazar identified by bazar
default tablespace tab_bazar
temporary tablespace temporary_data;

grant connect, resource to bazar;

connect bazar/bazar;