/* criar trigger para concatenar sufixo ao nome do departamento na inserção */
create or replace trigger T_BI_DEPTO
before
insert on departamentos
for each row
enable
declare
  sufixo varchar(10) := '_TG';
begin
  :new.NOME := concat(:new.NOME, sufixo);
end;
/

-- para visualizar o erro de execução
-- select * from user_errors where type = 'TRIGGER' and name = 'T_BI_DEPTO';

select * from system.departamentos;

insert into system.departamentos values (4, 'Departamento 4', 'Localizacao 4', 4);

/* criar trigger que restrinja a inserção de professor que não seja 'doutor' (titulação) */

select * from all_tab_columns where table_name = 'PROFESSOR';
select * from all_tab_columns where table_name = 'TITULACAO';

select * from SYSTEM.titulacao;
select * from SYSTEM.professor;

create or replace trigger T_BI_PROFESSOR_N_DOUTOR
before
insert or update on system.professor
for each row
enable
declare
  /* 
  cursor v_cursor is 
      select codtit from SYSTEM.TITULACAO where nometit = 'Doutor';
  */ 
  v_cod_doutor SYSTEM.TITULACAO.CODTIT%TYPE;
begin
  /* 
  open v_cursor;
  fetch v_cursor into v_cod_doutor;
  */
  select codtit
    into v_cod_doutor
    from SYSTEM.TITULACAO
   where nometit = 'Doutor';
  if :new.codtit = v_cod_doutor then
    dbms_output.put_line('Não podemos inserir um professor que seja DOUTOR');
    raise_application_error(-20000, 'Não podemos inserir um professor que seja DOUTOR');
  end if;
  -- close v_cursor;
end;
/

insert into system.professor values (8, 'GEST1', 1, 'Outro Prof');
update system.professor set CODTIT = 1 where UPPER(NOMEPROF) = 'OUTRO PROF';

