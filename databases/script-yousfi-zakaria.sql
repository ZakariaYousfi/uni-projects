Select * from dict;
Select count(*) from dict;
Desc Dict;


select comments from dict where table_name='Nom_table';
Select username from USER_USERS;


select table_name 
from all_tables 
where owner = upper('dbaintervention');
Select table_name form user_tables;
Select * from all_tables where owner = ‘DBAINTERVENTION’;

Select owner,table_name from all_tables where owner=’SYSTEM’ or owner=’DBAINTERVENTION’ order by owner;
Select table_name
from all_tables
where owner = ‘SYSTEM’;
Select table_name from user_tables;
Select table_name from all_tables where owner=’DBAINTERVENTION’;

Select column_name,data_type,data_length from user_tab_columns where table_name=’VEHICULE’;
Select column_name,data_type,data_length from user_tab_columns where table_name=’INTERVENTIONS’;

select constraint_name, constraint_type 
from user_constraints 
where table_name=’INTERVENTIONS’;

Select * from user_constraints ;

select column_name, data_type, data_length from user_tab_columns  
where table_name=’INTERVENTIONS’;

Select constraint_name,r_constraint_name,constraint_type from user_constraints where table_name=’INTERVENTIONS’;

select privilege, table_name from user_tab_privs where grantee=upper('admin’);

select * from dba_role_privs where GRANTEE =upper('admin');

select * from user_role_privs ;

select * from all_objects where owner=upper(‘admin’);

Select * from user_objects ;

select owner from all_tables where table_name='INTERVENTIONS';

select bytes/1024 as size_ from dba_segments where segment_name='INTERVENTIONS';



