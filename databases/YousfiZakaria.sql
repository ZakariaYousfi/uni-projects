--1)
create tablespace default_tbs datafile 'c:\default_tbs.dat' size 100M autoextend on online;
create temporary tablespace temp_tbs tempfile 'c:\temp_tbs.dat' size 100M autoextend on;
--2)
create user DBAASSOCIATION identified by psw default tablespace default_tbs temporary tablespace temp_tbs ;
--3)
grant all privileges to DBAASSOCIATION ;
--4)

create table  MEMBRES( NUMERO_MBR integer , NOM_MBR VARCHAR(50) , DATE_ADHESION_MBR date , ADRESSE_MBR varchar (100) , constraint pk_num primary key (NUMERO_MBR )) ; 
create table CONGRES ( CODE_CGN integer , THEME_CGN varchar(30) , PAYS_CGN varchar(20) , DUREE_CGN varchar (30) ,NB_PARTICIPANT_CGN integer ,  MONTANT_FIXE number , MONTANT_TOTAL_COTISE number , constraint pk_code primary key (CODE_CGN ) ) ; 
CREATE table PARTICIPATIONS (NUMERO_MBR integer , CODE_CGN integer  , MONTANT_COTISE number, constraint pk_par primary key (NUMERO_MBR ,CODE_CGN) ,constraint fk_mbr foreign key (NUMERO_MBR) references MEMBRES(NUMERO_MBR) ON DELETE CASCADE,constraint fk_cgn foreign key (CODE_CGN) references CONGRES (CODE_CGN) ON DELETE CASCADE ) ; 
-- 5) a

ALTER TABLE CONGRES ADD CONSTRAINT CHK_NBPAR CHECK(NB_PARTICIPANT_CGN>0);
--5) b

 alter table MEMBRES add constraint ck_MEMBRES_null check(NUMERO_MBR  is not null);
--5) c

 alter table CONGRES add constraint ck_MONTANT_FIXE check(MONTANT_FIXE>0);
 alter table CONGRES add constraint ck_MONTANT_TOTAL_COTISE check(MONTANT_TOTAL_COTISE>0);
 alter table PARTICIPATIONS add constraint ck_MONTANT_COTISE check(MONTANT_COTISE>0);
--5) d

ALTER TABLE CONGRES ADD CONSTRAINT UC_CONGRES UNIQUE (THEME_CGN);
--5) e

create trigger montant_sup
before insert on PARTICIPATIONS
FOR EACH ROW
DECLARE
mon_fixe CONGRES.MONTANT_FIXE%type;
BEGIN
select MONTANT_FIXE into mon_fixe from CONGRES where CONGRES.CODE_CGN=:new.CODE_CGN;
if mon_fixe > :new.MONTANT_COTISE then
RAISE_APPLICATION_ERROR(20056,'MONTANT_COTISE >> montant fixé par participant pour un congrès.');
end if;
end;
/

--5) f 
create trigger mise_aj_part
AFTER insert on PARTICIPATIONS
FOR EACH ROW
BEGIN
UPDATE CONGRES SET MONTANT_TOTAL_COTISE=MONTANT_TOTAL_COTISE+:new.MONTANT_COTISE,
NB_PARTICIPANT_CGN=NB_PARTICIPANT_CGN+1
WHERE CODE_CGN=:new.CODE_CGN;
end;
/

--6)
INSERT INTO MEMBRES VALUES (1,'YOUSFI ZAKARIA','28/11/2022','CITY 99 BLOC B ORAN');
INSERT INTO MEMBRES VALUES (2,'KRIMLIN BANA','29/11/2022','MOSCOW CITY KHARKIV RUSSIA');
INSERT INTO MEMBRES VALUES (3,'SNOOP DOGG','30/11/2022','60ST CALIFORNIA UNITED STATES');

INSERT INTO CONGRES VALUES (1,'A','ALGERIA','2h30mins',1,5000,6000);
INSERT INTO CONGRES VALUES (2,'B','RUSSIA','4h',1,6000,7000);
INSERT INTO CONGRES VALUES (3,'C','USA','6h',1,7000,8000);

INSERT INTO PARTICIPATIONS VALUES (1,1,6000);
INSERT INTO PARTICIPATIONS VALUES (2,2,7000);
INSERT INTO PARTICIPATIONS VALUES (3,3,8000);

--7)
SELECT p.NUMERO_MBR,m.NOM_MBR ,c.THEME_CGN,p.MONTANT_COTISE 
from PARTICIPATIONS p,MEMBRES m,CONGRES c 
where p.NUMERO_MBR=m.NUMERO_MBR and p.CODE_CGN=c.CODE_CGN 
order by p.MONTANT_COTISE DESC;

--8)
SELECT UNIQUE c.CODE_CGN,c.THEME_CGN,c.NB_PARTICIPANT_CGN AS NBP 
from CONGRES c, PARTICIPATIONS p  
where c.CODE_CGN = p.CODE_CGN;

--9)
SELECT CODE_CGN, THEME_CGN, NB_PARTICIPANT_CGN, MONTANT_FIXE, MONTANT_TOTAL_COTISE 
from CONGRES 
WHERE MONTANT_TOTAL_COTISE = (SELECT MAX(MONTANT_TOTAL_COTISE) FROM CONGRES);

 