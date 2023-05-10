-- audit trigger
-- select * from V$SESSION;
/*
tr_funcionario (cod, nome, ... , salario)

-- we create an historical table

tr_funcionario_hist (cod, nome, ... , salario)

*/

/* every change in the professor table 
will generate a log for an eventual audit 
1 - duplicate the table
2 - add columns: DT_ATUALIZACAO and LOGIN_CORRENT
*/

create table PROFESSOR_HIST as select * from PROFESSOR;
alter table PROFESSOR_HIST
  add DT_ATUALIZACAO DATE;
alter table PROFESSOR_HIST
  add LOGIN_CORRENTE varchar(45);
  
select * from SYS.ALL_TAB_COLS where TABLE_NAME = 'PROFESSOR_HIST';
  
select * from PROFESSOR_HIST;

create or replace trigger TR_AUDIT_PROFESSOR
after update on SYSTEM.PROFESSOR
for each row
enable
declare
  V_LOGGED_USER VARCHAR(45);
  V_SYSDATE DATE;
begin
  select sys_context('userenv', 'session_user')
    into V_LOGGED_USER
    from dual;
  V_SYSDATE := SYSDATE;
  insert into PROFESSOR_HIST values (:new.CODPROF, :new.CODDEPTO, :new.CODTIT, :new.NOMEPROF, V_SYSDATE, V_LOGGED_USER);
end;
/

select CURRENT_TIMESTAMP from dual;
select * from PROFESSOR_HIST;
select * from PROFESSOR;

update PROFESSOR set NOMEPROF = 'Professor Girafales' where NOMEPROF = 'Cleiton';

/* DISCIPLINA <---> PREREQ (retirar PK/ FK)
/* criar conceitos da integridade referencial via trigger (pai/filho) */

select * from SYS.ALL_TAB_COLS where TABLE_NAME = 'PREREQ';
describe PREREQ;
select * from SYS.ALL_TAB_COLS where TABLE_NAME = 'DISCIPLINA';

select * from DISCIPLINA natural join PREREQ;
select * from PREREQ;
select (case when T1.NUMDISC IS NULL then -1 end), (case when T2.NUMDISC IS NULL then -1 end)
  from DISCIPLINA T1
  left join DISCIPLINA T2 on (T1.NUMDISC = 3 AND T2.NUMDISC = 6);
delete from PREREQ where numdiscprereq = 7;

select T1.NUMDISC, T2.NUMDISC
  from DISCIPLINA T1, DISCIPLINA T2 WHERE T1.NUMDISC = 3 AND T2.NUMDISC = 1;

create or replace trigger TR_INTEGR_DISCIPLINA
before update or insert on PREREQ
for each row
enable
declare
  V_TB_KEY_1 NUMBER;
  V_TB_KEY_2 NUMBER;
begin

select DISTINCT (select NUMDISC 
                    from DISCIPLINA
                   where NUMDISC = :NEW.NUMDISC), 
                 (select NUMDISC 
                    from DISCIPLINA
                   where NUMDISC = :NEW.NUMDISCPREREQ)
  into V_TB_KEY_1, V_TB_KEY_2
  from DUAL;

   -- dbms_output.put_line(V_TB_KEY_1 || ' - ' || V_TB_KEY_2);
   if V_TB_KEY_1 IS NULL OR V_TB_KEY_2 IS NULL then
      raise_application_error(-20000, 'Nao podemos inserir uma disciplina que nao exista');
   end if;
   /*exception
      when no_data_found then
        V_TB_KEY_2 := -1;*/
end;
/

select * --t1.NUMDISC
  from DISCIPLINA t1
inner join PREREQ t2 on (t1.NUMDISC = t2.NUMDISC or t1.NUMDISC = t2.NUMDISCPREREQ);

select t1.NUMDISC
  from DISCIPLINA t1
 inner join PREREQ t2 on (t1.NUMDISC = t2.NUMDISC or t1.NUMDISC = t2.NUMDISCPREREQ) 
 where t1.NUMDISC = 3
   or t1.NUMDISC = 5;

insert into prereq values ('PROG1', 7, 'PROG1', 3);

select * from prereq;

SELECT *
  FROM user_constraints
 WHERE table_name = 'DISCIPLINA';

alter table PREREQ
 drop constraint FK_PREREQ_EH_PRE_DISCIPLI;

alter table DISCIPLINA
 drop constraint FK_DISCIPLI_RELATION_DEPTO;

select NUMDISC
   from DISCIPLINA
natural join PREREQ
  where NUMDISC = 7;

 select t1.NUMDISC
   from DISCIPLINA t1
inner join PREREQ t2 on t1.NUMDISC = t2.NUMDISCPREREQ
  where t1.NUMDISC = 7;
