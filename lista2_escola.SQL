#----------CRIAÇÃO DO BANCO
create database semestre;
use semestre;
	
#----------CRIAÇÃO DE TABELAS
create table depto(
	cod_depto char(5),
    nome_depto varchar(40)
);

create table disciplina(
	cod_disc int4,
    cod_depto char(5),
	nome_disc varchar(10),
    credito_disc int4
);


create table titulacao(
	cod_tit int4 ,
    nome_tit varchar(40)
);


create table professor(
	cod_prof int4,
    cod_depto char(5),
	cod_tit int4,
    nome_prof varchar(40)
);

create table pre_req(
	cod_depto_pre_req char(5),
    cod_disc_pre_req int4,
	cod_depto char(5),
    cod_disc int4
);


create table turma(
	ano_sem int4,
	cod_depto char(5),
    cod_disc int4,
    sig_tur char(2),
    capac_tur int4
);

create table prof_turma(
	ano_sem int4,
	cod_depto char(5),
    cod_disc int4,
    sig_tur char(2),
    cod_prof int4
);


create table horario(
	ano_sem int4,
    cod_depto char(5),
    cod_disc int4,
    sig_tur char(2),
    dia_sem int4,
    hora_inicio int4,
    num_sala int4,
    cod_pred int4,
    num_horas int4
);

create table sala(
	cod_pred int4,
    num_sala int4,
    descricao_sala varchar(40),
    capac_sala int4
);

create table predio(
	cod_pred int4,
	nome_pred varchar(40)
);

#----------CRIAÇÃO DAS PRIMARY KEYS
ALTER TABLE depto ADD CONSTRAINT pk_depto PRIMARY KEY (cod_depto);

ALTER TABLE disciplina ADD CONSTRAINT pk_disc PRIMARY KEY (cod_depto, cod_disc);

ALTER TABLE pre_req ADD CONSTRAINT pk_pre_req PRIMARY KEY (cod_depto, cod_disc, cod_depto_pre_req, cod_disc_pre_req);

ALTER TABLE turma ADD CONSTRAINT pk_turma PRIMARY KEY (ano_sem, cod_depto, cod_disc, sig_tur, capac_tur);

ALTER TABLE horario ADD CONSTRAINT pk_horario PRIMARY KEY (ano_sem, cod_depto, cod_disc, sig_tur, dia_sem, hora_inicio);

ALTER TABLE predio ADD CONSTRAINT pk_pred PRIMARY KEY (cod_pred);

ALTER TABLE sala ADD CONSTRAINT pk_sala PRIMARY KEY (cod_pred, num_sala);

ALTER TABLE professor ADD CONSTRAINT pk_professor PRIMARY KEY (cod_prof);

ALTER TABLE prof_turma ADD CONSTRAINT pk_prof_turma PRIMARY KEY (ano_sem, cod_depto, cod_disc, sig_tur, cod_prof);

ALTER TABLE titulacao ADD CONSTRAINT pk_titulacao PRIMARY KEY (cod_tit);

#----------CRIAÇÃO DE FK DISCIPLINA
ALTER TABLE disciplina 
	ADD CONSTRAINT fk_disciplina_cod_depto
	FOREIGN KEY(cod_depto) REFERENCES depto(cod_depto);


#----------CRIAÇÃO DE FK PRE_REQ
ALTER TABLE pre_req 
	ADD CONSTRAINT fk_pre_req_disc
	FOREIGN KEY(cod_depto, cod_disc) REFERENCES disciplina(cod_depto, cod_disc);

ALTER TABLE pre_req 
	ADD CONSTRAINT fk_pre_req_disc_pre_req
	FOREIGN KEY(cod_depto_pre_req, cod_disc_pre_req) REFERENCES disciplina(cod_depto, cod_disc);


#----------CRIAÇÃO DE FK TURMA
ALTER TABLE turma 
	ADD CONSTRAINT fk_turma_disc
	FOREIGN KEY(cod_depto, cod_disc) REFERENCES disciplina(cod_depto, cod_disc);




#----------CRIAÇÃO DE FK HORARIO
ALTER TABLE horario 
	ADD CONSTRAINT fk_horario_turma
	FOREIGN KEY(ano_sem, cod_depto, cod_disc, sig_tur) REFERENCES turma(ano_sem, cod_depto, cod_disc, sig_tur);

ALTER TABLE horario 
	ADD CONSTRAINT fk_horario_sala
	FOREIGN KEY(cod_pred, num_sala) REFERENCES sala(cod_pred, num_sala);




#----------CRIAÇÃO DE FK SALA
ALTER TABLE sala 
	ADD CONSTRAINT fk_sala_cod_pred
	FOREIGN KEY(cod_pred) REFERENCES predio(cod_pred);



#----------CRIAÇÃO DE FK PROFESSOR
ALTER TABLE professor 
	ADD CONSTRAINT fk_professor_cod_tit
	FOREIGN KEY(cod_tit) REFERENCES titulacao(cod_tit);

ALTER TABLE professor 
	ADD CONSTRAINT fk_professor_cod_depto
	FOREIGN KEY(cod_depto) REFERENCES depto(cod_depto);




#----------CRIAÇÃO DE FK PROF_TURMA
ALTER TABLE prof_turma 
	ADD CONSTRAINT fk_prof_turma_ano_sem
	FOREIGN KEY(ano_sem, cod_depto, cod_disc, sig_tur) REFERENCES turma(ano_sem, cod_depto, cod_disc, sig_tur);

ALTER TABLE prof_turma 
	ADD CONSTRAINT fk_prof_turma_cod_prof
	FOREIGN KEY(cod_prof) REFERENCES professor(cod_prof);

# ------- INSERTS ------- #
INSERT INTO predio(cod_pred, nome_pred)
VALUES
(43423,'Informática - aulas'),
(43529,'Polimeros - aulas'),
(43981,'Comex - aulas');

INSERT INTO sala(cod_pred, num_sala, descricao_sala, capac_sala)
VALUES
(43423,101,'Sala Comum',20),
(43423,102,'Sala Comum',20),
(43423,103,'Laboratorio',30),
(43423,104,'Laboratorio',50),

(43529,10,'Sala Comum',30),
(43529,11,'Sala Comum',30),
(43529,20,'Laboratorio',60),
(43529,21,'Laboratorio',60),


(43981,1,'Sala Comum',30),
(43981,2,'Sala Comum',30),
(43981,3,'Sala Comum',30),
(43981,4,'Laboratorio',60);



INSERT INTO depto(cod_depto, nome_depto)
VALUES
('INF01','Informatica'),
('POL01','Polimeros'),
('COM01','COMEX');

INSERT INTO disciplina(cod_depto, cod_disc, nome_disc, credito_disc) 
VALUES
('INF01', 1 ,'Eng1',2),
('INF01', 2 ,'Eng2',2),
('INF01', 3 ,'Log1',2),
('COM01', 4 ,'Ing1',1),
('COM01', 5 ,'Ing2',1),
('COM01', 6 ,'Ing3',1),
('POL01', 7 ,'Cal1',2),
('POL01', 8 ,'Cal2',2),
('INF01', 9 ,'Eng3',3),
('INF01', 10 ,'Eng4',6);


INSERT INTO titulacao(cod_tit, nome_tit)
VALUES
(1,'Doutor'),
(2,'Mestre'),
(3,'Coordenador'),
(4,'Especialista');


INSERT INTO professor(cod_prof, cod_depto, cod_tit, nome_prof)
VALUES 
(1,'INF01',1,'Antunes'),
(2,'INF01',2,'Semaj'),
(3,'INF01',3,'Ricardo'),
(4,'COM01',1,'Irineu'),
(5,'COM01',2,'Jailson'),
(6,'COM01',3,'Mario'),
(7,'POL01',1,'Joao'),
(8,'POL01',2,'Marcelo'),
(9,'POL01',3,'Manoel'),
(10,'POL01',4,'Luis');

INSERT INTO turma(ano_sem, cod_depto, cod_disc, sig_tur, capac_tur)
VALUES
(20021,'INF01',1,'1D',50),
(20021,'INF01',3,'1D',50),
(20021,'COM01',4,'1A',30),
(20021,'POL01',7,'1B',30),
(20022,'INF01',2,'1D',50),
(20022,'COM01',5,'1A',30),
(20022,'POL01',8,'1B',30),
(20031,'COM01',6,'1A',30);


INSERT INTO prof_turma(ano_sem, cod_depto, cod_disc, sig_tur, cod_prof)
VALUES 
(20021,'INF01',1,'1D',1),
(20021,'INF01',3,'1D',2),
(20021,'COM01',4,'1A',4),
(20022,'COM01',5,'1A',5),
(20031,'COM01',6,'1A',6),
(20021,'POL01',7,'1B',7),
(20022,'POL01',8,'1B',9);



INSERT INTO horario(ano_sem, cod_depto, cod_disc, sig_tur, dia_sem, hora_inicio, num_sala, cod_pred, num_horas)
VALUES 
(20021,'INF01',1,'1D',2,19,101,43423,4),
(20021,'INF01',3,'1D',3,19,102,43423,4),

(20021,'COM01',4,'1A',2,19,1,43981,2),
(20022,'COM01',5,'1A',4,19,2,43981,2),
(20031,'COM01',6,'1A',5,19,3,43981,2),

(20021,'POL01',7,'1B',3,19,10,43529,4),
(20022,'POL01',8,'1B',6,19,11,43529,4);

INSERT INTO pre_req(cod_depto_pre_req, cod_disc_pre_req, cod_depto, cod_disc)
VALUES
('INF01',1,'INF01',2),
('INF01',2,'INF01',9),
('INF01',9,'INF01',10),
('COM01',4,'COM01',5),
('COM01',5,'COM01',6),
('POL01',7,'POL01',8);


/*1 -  Obter os cÃ³digos dos diferentes departamentos que tem turmas no ano-semestre
2002/1*/
delimiter //
CREATE PROCEDURE Proc1() 
begin 
  -- Declarações --
  DECLARE finished INTEGER DEFAULT 0;
  DECLARE WCod char (5);
  DECLARE C1 CURSOR FOR SELECT DISTINCT CodDepto FROM Turma where AnoSem = 20021;
  
  -- EVENTO PARA ENCERRAR O LAÇO --
  DECLARE CONTINUE HANDLER
  FOR NOT FOUND SET finished = 1;
  
  -- CRIAÇÃO DE UMA TABELA TEMPORARIA --
  create temporary table codDeptos (
	codDepto char(5)
  );
  
  -- ABRE O CURSOR --
  open c1;
  
  -- LOOP --
  laco_leitura: loop
  
	-- BUSCA O CONTEUDO DA LINHA --
	fetch C1 into WCod;
    
    -- INSERE CONTEUDO NA TABELA TEMPORARIA (CODDEPTOS) --
    insert into codDeptos values(WCod);
    
    -- DECISÃO PARA ENCERRAR A CONDIÇÃO DE ENCERRAMENTO E ENCERRA O LOOP-- 
    IF finished = 1 THEN
		LEAVE laco_leitura;
	END IF;
  end loop laco_leitura;
  
  select * from codDeptos;
  
  -- EXCLUI A TABLELA TEMPORARIA -- 
  drop temporary table codDeptos;
    
   -- ENCERRA O CURSOR -- 
  close c1;
  
  -- ENCERRA A PROCEDURE -- 
end //
-- EXCLUI A PROCEDURE -- 
drop procedure Proc1;
-- CHAMA A PROCEDURE (EXECUTA) -- 
call Proc1();

            
/*2 - Obter os codigos dos professores que sÃ£o do departamento de cÃ³digo 'INF01' e
que ministraram ao menos uma turma em 2002/1.*/
Delimiter //
Create Procedure Proc2()
	begin
	  DECLARE finished INTEGER DEFAULT 0;
      declare WCodProf int;
	  DECLARE C1 CURSOR FOR SELECT CodProf FROM ProfTurma where CodDepto = 'INF01' and AnoSem = 20021;
      
      DECLARE CONTINUE HANDLER
	  FOR NOT FOUND SET finished = 1;

	  create temporary table CodProfs (
	  CodProf int);
      
	  open c1;
	laco_leitura: loop
      fetch C1 into WCodProf;
	  insert into CodProfs values(WCodProf);
      IF finished = 1 THEN
		LEAVE laco_leitura;
	  END IF;
	end loop laco_leitura;
    
	select * from CodProfs;
	drop temporary table CodProfs;
	close c1;

end //
drop procedure Proc2;
call Proc2();

/*3 - Obter os horÃ¡rios de aula (dia da semana,hora inicial e nÃºmero de horas
ministradas) do professor "Antunes" em 20021.*/
Delimiter //
create procedure proc3()
begin
	DECLARE finished INTEGER DEFAULT 0;
    declare wdia_sem, whora_inicio, wNum_horas int;
	DECLARE C1 CURSOR FOR SELECT h.dia_sem, h.hora_inicio, h.num_horas FROM horario h
	INNER JOIN prof_turma a
		ON h.ano_sem = a.ano_sem 
		AND h.cod_depto = a.cod_depto
        AND h.cod_disc = a.cod_disc
        AND h.sig_tur = a.sig_tur
	INNER JOIN professor p 
		ON a.cod_prof = p.cod_prof
	WHERE p.nome_prof = "Antunes"
    AND h.ano_sem = 20021;
    DECLARE CONTINUE HANDLER
	  FOR NOT FOUND SET finished = 1;

	  create temporary table Horarios (
	  dia_sem int4, hora_inicio int4, num_horas int4);
      
	  open c1;
	  laco_leitura: loop
      fetch C1 into wdia_sem, whora_inicio, wNum_horas;
	  insert into Horarios values(wdia_sem, whora_inicio, wNum_horas);
      IF finished = 1 THEN
		LEAVE laco_leitura;
	  END IF;
	end loop laco_leitura;
    
	select * from Horarios;
	drop temporary table Horarios;
	close c1;
end //

drop procedure Proc3;
call Proc3();


/*4 - Obter os nomes dos departamentos que tÃªm turmas que, em 2002/1, tÃªm aulas na
sala 101 do prÃ©dio denominado 'InformÃ¡tica - aulas'.*/
Delimiter //
create procedure proc4()
begin
	DECLARE finished INTEGER DEFAULT 0;
    declare wnome_depto varchar(40);
	DECLARE C1 CURSOR FOR SELECT DISTINCT d.nome_depto FROM depto d
	INNER JOIN horario h
		ON d.cod_depto = h.cod_depto
    INNER JOIN predio p 
		ON h.cod_pred = p.cod_pred
	WHERE h.ano_sem = 20021
		AND p.nome_pred = 'Informática - aulas'
        AND h.num_sala = 101;
    DECLARE CONTINUE HANDLER
	  FOR NOT FOUND SET finished = 1;

	  create temporary table Departamentos (
	  nome_depto varchar(40));
      
	  open c1;
	  laco_leitura: loop
      fetch C1 into wnome_depto;
	  insert into Departamentos values(wnome_depto);
      IF finished = 1 THEN
		LEAVE laco_leitura;
	  END IF;
	end loop laco_leitura;
    
	select * from Departamentos;
	drop temporary table Departamentos;
	close c1;
end //

drop procedure Proc4;
call Proc4();

/*5 * Obter os códigos dos professores com título denominado 'Doutor' que não
ministraram aulas em 2002/1. */
Delimiter //
create procedure proc5()
begin
	DECLARE finished INTEGER DEFAULT 0;
    declare wcod_prof int4;
	DECLARE C1 CURSOR FOR SELECT DISTINCT cod_prof FROM professor 
	WHERE cod_tit in(SELECT cod_tit FROM titulacao WHERE nome_tit = 'Doutor')
    AND cod_prof not in(SELECT cod_prof FROM prof_turma WHERE ano_sem = 20021);
    DECLARE CONTINUE HANDLER
	  FOR NOT FOUND SET finished = 1;

	  create temporary table Professores (
	  wcod_prof int4);
      
	  open c1;
	  laco_leitura: loop
      fetch C1 into wcod_prof;
	  insert into Professores values(wcod_prof);
      IF finished = 1 THEN
		LEAVE laco_leitura;
	  END IF;
	end loop laco_leitura;
    
	select * from Professores;
	drop temporary table Professores;
	close c1;
end //

drop procedure Proc5;
call Proc5();

# 6 - Obter os identificadores das salas (código do prédio e número da sala) que, em 2002/1: nas segundas-feiras (dia da semana = 2), tiveram ao menos uma turma do departamento 'Informática', e o nas quartas-feiras (dia da semana = 4), tiveram ao menos uma turma ministrada pelo professor denominado 'Antunes'. 
Delimiter //
create procedure proc6()
begin
	DECLARE finished INTEGER DEFAULT 0;
    declare  wcod_pred, wnum_sala int4;
	DECLARE C1 CURSOR FOR SELECT cod_pred, num_sala FROM horario
     WHERE (cod_pred, num_sala) IN 
	(SELECT h.cod_pred, h.num_sala FROM horario h
		INNER JOIN prof_turma a
			ON h.ano_sem = a.ano_sem 
			AND h.cod_depto = a.cod_depto
			AND h.cod_disc = a.cod_disc
			AND h.sig_tur = a.sig_tur
		INNER JOIN professor p 
			ON a.cod_prof = p.cod_prof
		WHERE p.nome_prof = 'Antunes' 
			AND h.dia_sem = 4) 
	AND (cod_pred, num_sala) IN 
	(SELECT h.cod_pred, h.num_sala FROM horario h  
		INNER JOIN depto d
			ON h.cod_depto = d.cod_depto
		WHERE d.nome_depto = 'Informatica' 
			AND h.dia_sem = 2);
    DECLARE CONTINUE HANDLER
	  FOR NOT FOUND SET finished = 1;

	  create temporary table Salas (
	  wcod_pred int4, wnum_sala int4);
      
	  open c1;
	  laco_leitura: loop
      fetch C1 into wcod_pred, wnum_sala;
	  insert into Salas values(wcod_pred, wnum_sala);
      IF finished = 1 THEN
		LEAVE laco_leitura;
	  END IF;
	end loop laco_leitura;
    
	select * from Salas;
	drop temporary table Salas;
	close c1;
end //

drop procedure Proc6;
call Proc6();

# 7 - Obter o dia da semana, a hora de início e o número de horas de cada horário de cada turma ministrada por um professor de nome `Antunes', em 2002/1, na sala número 101 do prédio de código 43423.
Delimiter //
create procedure proc7()
begin
	DECLARE finished INTEGER DEFAULT 0;
    declare  wdia_sem, whora_inicio, wnum_horas int4;
	DECLARE C1 CURSOR FOR SELECT distinct h.dia_sem, h.hora_inicio, h.num_horas FROM horario h
	INNER JOIN prof_turma a
		ON h.ano_sem = a.ano_sem 
		AND h.cod_depto = a.cod_depto
        AND h.cod_disc = a.cod_disc
        AND h.sig_tur = a.sig_tur
	INNER JOIN professor p 
		ON a.cod_prof = p.cod_prof
	WHERE p.nome_prof = 'Antunes'
    AND h.ano_sem = 20021
    AND h.num_sala = 101
    AND h.cod_pred = 43423;
    DECLARE CONTINUE HANDLER
	  FOR NOT FOUND SET finished = 1;

	  create temporary table Semana (
	 wdia_sem int4, whora_inicio int4, wnum_horas int4);
      
	  open c1;
	  laco_leitura: loop
      fetch C1 into wdia_sem, whora_inicio, wnum_horas;
	  insert into Semana values(wdia_sem, whora_inicio, wnum_horas);
      IF finished = 1 THEN
		LEAVE laco_leitura;
	  END IF;
	end loop laco_leitura;
    
	select * from Semana;
	drop temporary table Semana;
	close c1;
end //

drop procedure Proc7;
call Proc7();

# 8 - Um professor pode ministrar turmas de disciplinas pertencentes a outros departamentos. Para cada professor que já ministrou aulas em disciplinas de outros departamentos, obter o código do professor, seu nome, o nome de seu departamento e o nome do departamento no qual ministrou disciplina.
delimiter //
create procedure proc8()
begin
	declare wcod_prof int4;
    declare wnome_prof, wnome_depto, wnome_depto1 varchar(40);
    declare done int default false;
    
    declare C1 cursor for (
		SELECT p.cod_prof, p.nome_prof, d1.nome_depto, d2.nome_depto AS MINISTRA, d2.nome_depto AS NAO_MINISTRA FROM professor p
		inner join Depto as d1 on d1.cod_depto = p.cod_depto
		inner join prof_turma as pt on pt.cod_prof = p.cod_prof
		inner join depto as d2 on d2.cod_depto = pt.cod_depto
		where p.cod_depto <> d2.cod_depto and d2.nome_depto != d1.nome_depto);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    open C1;
    create temporary table professor (
		wcod_prof int4, 
        wnome_prof varchar(40), 
        wnome_depto varchar(40),
        wnome_depto1 varchar(40));
    
    while done <> TRUE do
		fetch C1 into wcod_prof, wnome_prof, wnome_depto, wnome_depto1;
        if done <> true then
			insert into professor values(wcod_prof, wnome_prof, wnome_depto, wnome_depto1);
        end if;
    end while;
    select * from professor;
    close C1;
    drop temporary table professor;
end //

drop procedure Proc8;
call Proc8();

# 9 - Obter o nome dos professores que possuem horários conflitantes (possuem turmas que tenham a mesma hora inicial, no mesmo dia da semana e no mesmo semestre). Além dos nomes, mostrar as chaves primárias das turmas em conflito. 
Delimiter //
create procedure proc9()
begin
	DECLARE finished INTEGER DEFAULT 0;
    declare  wnome_prof varchar(40);
    declare  wano_sem, wcod_disc, wsig_tur int4;
    declare  wcod_depto char(5);
	DECLARE C1 CURSOR FOR SELECT p.nome_prof, t.ano_sem, t.cod_depto, t.cod_disc, t.sig_tur FROM turma t
	INNER JOIN prof_turma pt
		ON t.ano_sem = pt.ano_sem
        AND t.cod_depto = pt.cod_depto
        AND t.cod_disc = pt.cod_disc
        AND t.sig_tur = pt.sig_tur
	INNER JOIN professor p
		ON pt.cod_prof = p.cod_prof
	INNER JOIN horario h
		ON t.ano_sem = h.ano_sem
        AND t.cod_depto = h.cod_depto
        AND t.cod_disc = h.cod_disc
        AND t.sig_tur = h.sig_tur
	WHERE (SELECT COUNT(*) FROM horario hh
            INNER JOIN prof_turma ptt
				ON hh.ano_sem = ptt.ano_sem
				AND hh.cod_depto = ptt.cod_depto
				AND hh.cod_disc = ptt.cod_disc
				AND hh.sig_tur = ptt.sig_tur
			WHERE h.ano_sem = hh.ano_sem 
				AND h.hora_inicio = hh.hora_inicio
                AND h.dia_sem = hh.dia_sem
                AND ptt.cod_prof = p.cod_prof)>1;
    DECLARE CONTINUE HANDLER
	  FOR NOT FOUND SET finished = 1;

	  create temporary table Nom_Prof (
	 wnome_prof varchar(40),
     wano_sem int4, wcod_disc int4, wsig_tur int4,
     wcod_depto char(5));
      
	  open c1;
	  laco_leitura: loop
      fetch C1 into wnome_prof, wano_sem, wcod_disc, wsig_tur, wcod_depto;
	  insert into Nom_Prof values(wnome_prof, wano_sem, wcod_disc, wsig_tur, wcod_depto);
      IF finished = 1 THEN
		LEAVE laco_leitura;
	  END IF;
	end loop laco_leitura;
    
	select * from Nom_Prof;
	drop temporary table Nom_Prof;
	close c1;
end //

drop procedure Proc9;
call Proc9();

# 10 -  Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido do nome da disciplina que é seu pré-requisito. 
Delimiter //
create procedure proc10()
begin
	DECLARE finished INTEGER DEFAULT 0;
    declare  wnome_disc varchar(40);
    declare  wnome_disc1 varchar(40);
	DECLARE C1 CURSOR FOR SELECT d1.nome_disc AS DISCIPLINA, d2.nome_disc AS PRE_REQ FROM pre_req pr
	INNER JOIN disciplina d1
		ON pr.cod_disc = d1.cod_disc
        AND pr.cod_depto = d1.cod_depto
	INNER JOIN disciplina d2
		ON pr.cod_disc_pre_req = d2.cod_disc
        AND pr.cod_depto_pre_req = d2.cod_depto;
    DECLARE CONTINUE HANDLER
	  FOR NOT FOUND SET finished = 1;

	  create temporary table disc (
	  wnome_disc varchar(40),
      wnome_disc1 varchar(40));
      
	  open c1;
	  laco_leitura: loop
      fetch C1 into wnome_disc, wnome_disc1;
	  insert into disc values(wnome_disc, wnome_disc1);
      IF finished = 1 THEN
		LEAVE laco_leitura;
	  END IF;
	end loop laco_leitura;
    
	select * from disc;
	drop temporary table disc;
	close c1;
end //

drop procedure Proc10;
call Proc10();

# 11 - Obter os nomes das disciplinas que não têm pré-requisito
Delimiter //
create procedure proc11()
begin
	DECLARE finished INTEGER DEFAULT 0;
    declare  wnome_disc varchar(40);
	DECLARE C1 CURSOR FOR SELECT nome_disc FROM disciplina
	WHERE cod_disc NOT IN (SELECT cod_disc FROM pre_req);
    DECLARE CONTINUE HANDLER
	  FOR NOT FOUND SET finished = 1;

	  create temporary table discPre (
	  wnome_disc varchar(40));
      
	  open c1;
	  laco_leitura: loop
      fetch C1 into wnome_disc;
	  insert into discPre values(wnome_disc);
      IF finished = 1 THEN
		LEAVE laco_leitura;
	  END IF;
	end loop laco_leitura;
    
	select * from discPre;
	drop temporary table discPre;
	close c1;
end //

drop procedure Proc11;
call Proc11();

# 12 - Obter o nome de cada disciplina que possui ao menos dois pré-requisitos. 
Delimiter //
create procedure proc12()
begin
	DECLARE finished INTEGER DEFAULT 0;
    declare  wnome_disc varchar(40);
	DECLARE C1 CURSOR FOR SELECT DISTINCT d.nome_disc FROM disciplina d
	WHERE (SELECT COUNT(pr.cod_disc) FROM pre_req pr WHERE pr.cod_disc = d.cod_disc)>=2;
    DECLARE CONTINUE HANDLER
	  FOR NOT FOUND SET finished = 1;

	  create temporary table discPre (
	  wnome_disc varchar(40));
      
	  open c1;
	  laco_leitura: loop
      fetch C1 into wnome_disc;
	  insert into discPre values(wnome_disc);
      IF finished = 1 THEN
		LEAVE laco_leitura;
	  END IF;
	end loop laco_leitura;
    
	select * from discPre;
	drop temporary table discPre;
	close c1;
end //

drop procedure Proc12;
call Proc12();


# 13 - 1. Obter os nomes docentes cuja titulação tem código diferente de 3. 
DROP PROCEDURE IF EXISTS proc13; 
DELIMITER $$
CREATE PROCEDURE proc13()
BEGIN
	DECLARE finished INTEGER DEFAULT 0;
    declare  wnome_prof varchar(40);
	DECLARE	C1 CURSOR FOR SELECT nome_prof FROM professor WHERE cod_tit!=3 and cod_tit is not null;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
    CREATE temporary TABLE DOCENTES 
    ( 
       Nome VARCHAR(40) 
    );
    OPEN C1;
		laco_leitura : loop
        FETCH C1 into wnome_prof;
        insert into discPre values(wnome_disc);
        IF finished = 1 THEN
		LEAVE laco_leitura;
		END IF;
		END LOOP laco_leitura;
        
        SELECT * FROM DOCENTES;
    	drop temporary table DOCENTES;
        	CLOSE C1;

END $$
CALL proc13();

# 14 - 	Obter os nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na
# sala 101 do prédio denominado 'Informática - aulas'. Resolver usando theta-join
# e junção natural.
DROP PROCEDURE IF EXISTS proc14; 
DELIMITER $$
CREATE PROCEDURE proc14()
BEGIN
	DECLARE wnome_depto VARCHAR(40);
	DECLARE finished INT DEFAULT 0;
	DECLARE	C1 CURSOR FOR 
    SELECT DISTINCT d.nome_depto FROM depto d
	NATURAL JOIN horario h , predio p 
	WHERE h.cod_pred = p.cod_pred
        AND h.ano_sem = 20021
		AND p.nome_pred = 'Informática - aulas'
        AND h.num_sala = 101;
    
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
    DROP TABLE IF EXISTS DEPTOS; 
    CREATE temporary TABLE DEPTOS 
    ( 
       wnome_depto VARCHAR(40) 
    );
    OPEN C1;
		laco_leitura : loop
        FETCH C1 into wnome_depto;
        IF finished = 1 THEN
		LEAVE laco_leitura;
		END IF;
        INSERT INTO DEPTOS VALUES (wnome_depto);
		END LOOP laco_leitura;
        SELECT * FROM DEPTOS;
	CLOSE C1;
END $$
CALL proc14();


# 15 - Obter o nome de cada departamento seguido do nome de cada uma de suas
# disciplinas que possui mais que três créditos (caso o departamento não tenha
# disciplinas ou caso o departamento não tenha disciplinas com mais que três
# créditos, seu nome deve aparecer seguido de vazio). A seguinte solução não está
# correta (porquê?): 
DROP PROCEDURE IF EXISTS proc15; 
DELIMITER $$
CREATE PROCEDURE proc15()
BEGIN
	DECLARE wnome_depto VARCHAR(40);
    DECLARE wnome_disc VARCHAR(40);
	DECLARE finished INT DEFAULT 0;
	DECLARE	C1 CURSOR FOR 
    SELECT distinct case when credito_disc > 3 then nome_depto end, nome_disc
    FROM depto
		natural left join disciplina
	;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
    DROP TABLE IF EXISTS DEPTOS_DISC; 
    CREATE temporary TABLE DEPTOS_DISC 
    ( 
       wnome_depto VARCHAR(40) ,
       wnome_disc varchar(40)
    );
    OPEN C1;
		laco_leitura : loop
        FETCH C1 into wnome_depto,wnome_disc;
        IF finished = 1 THEN
		LEAVE laco_leitura;
		END IF;
        INSERT INTO DEPTOS_DISC VALUES (wnome_depto,wnome_disc);
		END LOOP;
        SELECT * FROM DEPTOS_DISC;
	CLOSE C1;
END $$
CALL proc15();


# 16 - Obter o nome dos professores que possuem horários conflitantes (possuem
# turmas que tenham a mesma hora inicial, no mesmo dia da semana e no mesmo
# semestre). 

DROP PROCEDURE IF EXISTS proc16; 
DELIMITER $$
CREATE PROCEDURE proc16()
BEGIN
	DECLARE wnome_prof VARCHAR(40);
	DECLARE finished INT DEFAULT 0;
	DECLARE	C1 CURSOR FOR 
    SELECT professor.nome_prof from professor 
	INNER JOIN turma on turma.cod_depto = professor.cod_depto
	INNER JOIN horario on horario.cod_depto = turma.cod_depto
	INNER JOIN horario h2 on h2.ano_sem = horario.ano_sem
	WHERE h2.dia_sem = horario.dia_sem and h2.hora_inicio = horario.hora_inicio;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
    DROP TABLE IF EXISTS NOMES_PROF; 
    CREATE temporary TABLE NOMES_PROF 
    ( 
       wnome_prof VARCHAR(40) 
    );
    OPEN C1;
		laco_leitura : loop
        FETCH C1 into wnome_prof;
        IF finished = 1 THEN
		LEAVE laco_leitura;
		END IF;
        INSERT INTO NOMES_PROF VALUES (wnome_prof);
		END LOOP;
        SELECT * FROM NOMES_PROF;
	CLOSE C1;
END $$
CALL proc16();


# 17 - Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido
# do nome da disciplina que é seu pré-requisito (usar junções explícitas - quando
# possível usar junção natural). 
DROP PROCEDURE IF EXISTS proc17; 
DELIMITER $$
CREATE PROCEDURE proc17()
BEGIN
	DECLARE wnome_disc VARCHAR(40);
    DECLARE wnome_discprereq VARCHAR(40);
	DECLARE finished INT DEFAULT 0;
	DECLARE	C1 CURSOR FOR 
    SELECT d.nome_disc,dpre.nome_disc FROM disciplina d 
	NATURAL JOIN pre_req p
	INNER JOIN disciplina dpre on dpre.cod_disc = p.cod_disc_pre_req;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
    DROP TABLE IF EXISTS DISC_PREREQ; 
    CREATE temporary TABLE DISC_PREREQ 
    ( 
       wnome_disc VARCHAR(40) ,
       wnome_discprereq varchar(40)
    );
    OPEN C1;
		ler : loop
        FETCH C1 into wnome_disc,wnome_discprereq;
        IF finished = 1 THEN
		LEAVE ler;
		END IF;
        INSERT INTO DISC_PREREQ VALUES (wnome_disc,wnome_discprereq);
		END LOOP;
        SELECT * FROM DISC_PREREQ;
	CLOSE C1;
END
$$
CALL proc17();


# 18 - Para cada disciplina, mesmo para aquelas que não possuem pré-requisito, obter o
# nome da disciplina seguido do nome da disciplina que é seu pré-requisito (usar
# junções explícitas - quando possível usar junção natural). 
DROP PROCEDURE IF EXISTS proc18; 
DELIMITER $$
CREATE PROCEDURE proc18()
BEGIN
	DECLARE wnome_disc VARCHAR(40);
    DECLARE wnome_discorNot VARCHAR(40);
	DECLARE finished INT DEFAULT 0;
	DECLARE	C1 CURSOR FOR 
    SELECT d.nome_disc,dpre.nome_disc FROM disciplina d
	NATURAL LEFT JOIN pre_req p
	LEFT JOIN disciplina dpre on dpre.cod_disc = p.cod_disc_pre_req;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
    DROP TABLE IF EXISTS DISC_PRE_OR_NOT; 
    CREATE temporary TABLE DISC_PRE_OR_NOT 
    ( 
       wnome_disc VARCHAR(40) ,
       wnome_discorNot  varchar(40)
    );
    OPEN C1;
		ler : loop
        FETCH C1 into wnome_disc,wnome_discorNot;
        IF finished = 1 THEN
		LEAVE ler;
		END IF;
        INSERT INTO DISC_PRE_OR_NOT VALUES (wnome_disc,wnome_discorNot);
		END LOOP;
        SELECT * FROM DISC_PRE_OR_NOT;
	CLOSE C1;
END
$$
CALL proc18();


# 19 - Para cada disciplina que tem um pré-requisito que a sua vez também tem um
# pré-requisito, obter o nome da disciplina seguido do nome do pré-requisito de
# seu pré-requisito. 
DROP PROCEDURE IF EXISTS proc19; 
DELIMITER $$
CREATE PROCEDURE proc19()
BEGIN
	DECLARE nome_disc VARCHAR(40);
    DECLARE nome_discpre VARCHAR(40);
	DECLARE finished INT DEFAULT 0;
	DECLARE	C1 CURSOR FOR 
    SELECT d.nome_disc,d2.nome_disc from disciplina d
	INNER JOIN pre_req p on p.cod_disc = d.cod_disc
	INNER JOIN pre_req p2 on p2.cod_disc = p.cod_disc_pre_req
	INNER JOIN disciplina d2 on d2.cod_disc = p2.cod_disc_pre_req;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
    DROP TABLE IF EXISTS DISC_PRE_DO_PRE; 
    CREATE temporary TABLE DISC_PRE_DO_PRE 
    ( 
       nome_disc VARCHAR(40) ,
       nome_discpre  varchar(40)
    );
    OPEN C1;
		ler : loop
        FETCH C1 into nome_disc,nome_discpre;
        IF finished = 1 THEN
		LEAVE ler;
		END IF;
        INSERT INTO DISC_PRE_DO_PRE VALUES (nome_disc,nome_discpre);
		END LOOP;
        SELECT * FROM DISC_PRE_DO_PRE;
	CLOSE C1;
END
$$
CALL proc19();


# 20 - Obter uma tabela que contém três colunas. Na primeira coluna aparece o nome
# de cada disciplina que possui pré-requisito, na segunda coluna aparece o nome
# de cada um de seus pré-requisitos e a terceira contém o nível de pré-requisito.
# Nível 1 significa que trata-se de um pré-requisito imediato da disciplina, nível 2
# significa que trata-se de um pré-requisito de um pré-requisito da disciplina, e 
# 3 assim por diante. Limitar a consulta para três níveis. (DICA USAR UNION ALL) 
DROP PROCEDURE IF EXISTS proc20; 
DELIMITER $$
CREATE PROCEDURE proc20()
BEGIN
	DECLARE wNome_Disc int4;
	DECLARE finished INT DEFAULT 0;
	DECLARE	C1 CURSOR FOR 
		select d1.Nome_Disc as 'Disciplina', d2.Nome_Disc as 'Pré-requisito', d3.Nome_Disc as 'Pré-requisito do Pré-requisito' from pre_req as pr
		inner join Disciplina as d1 on pr.cod_disc = d1.cod_disc
		inner join Disciplina as d2 on pr.Nome_Disc = d1.Nome_Disc
		inner join pre_req as pr2 on pr2.cod_disc = d2.cod_disc
		inner join Disciplina as d3 on d3.Nome_Disc = pr.Nome_Disc;
    
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
    DROP TABLE IF EXISTS PROFS_TIT; 
    CREATE temporary TABLE PROFS_TIT 
    ( 
       wNome_Disc int4);
       
    OPEN C1;
		ler : loop
        FETCH C1 into wNome_Disc;
        IF finished = 1 THEN
		LEAVE ler;
		END IF;
        INSERT INTO PROFS_TIT VALUES (wNome_Disc);
		END LOOP;
        SELECT * FROM PROFS_TIT;
	CLOSE C1;
END $$
CALL proc20();

    
# 21 - Obter os códigos dos professores com código de título vazio que não
# ministraram aulas em 2001/2 (resolver com junção natural). 
DROP PROCEDURE IF EXISTS proc21; 
DELIMITER $$
CREATE PROCEDURE proc21()
BEGIN
	DECLARE wcod_prof int4;
	DECLARE finished INT DEFAULT 0;
	DECLARE	C1 CURSOR FOR 
    select p.cod_prof from Professor as p
    natural join Prof_Turma where p.CodTit is null 
    and NOT EXISTS (select * from Prof_Turma as pt where pt.Cod_Prof = p.Cod_Prof and pt.Ano_Sem = 20012);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
    DROP TABLE IF EXISTS PROFS_TIT; 
    CREATE temporary TABLE PROFS_TIT 
    ( 
       wcod_prof int4);
       
    OPEN C1;
		ler : loop
        FETCH C1 into wcod_prof;
        IF finished = 1 THEN
		LEAVE ler;
		END IF;
        INSERT INTO PROFS_TIT VALUES (wcod_prof);
		END LOOP;
        SELECT * FROM PROFS_TIT;
	CLOSE C1;
END
$$
CALL proc21();


#CRIAR PROCEDURE USANDO CURSOR PARA RESOLVER EXERCICIO 4 DA LISTA 3
#Obter uma tabela com duas colunas, contendo o nome de cada disciplina
#seguido do nome de cada um de seus pré-requisitos. Disciplinas sem prérequisito
#têm a segunda coluna vazia.

create table pre_req(
	cod_depto_pre_req char(5),
    cod_disc_pre_req int4,
	cod_depto char(5),
    cod_disc int4
);

DROP PROCEDURE IF EXISTS DISC_PREREQ; 
DELIMITER $$
CREATE PROCEDURE DISC_PREREQ()
BEGIN
	DECLARE disc VARCHAR(40);
    DECLARE preReq VARCHAR(40);
	DECLARE existe_mais_linhas INT DEFAULT 0;
	DECLARE	DIF_CURSOR CURSOR FOR 
    SELECT d.cod_disc, pr.cod_disc_pre_req FROM disciplina d left join pre_req pr on d.cod_disc = pr.cod_disc order by d.cod_disc;
-- ou SELECT p.cod_disc
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET existe_mais_linhas=1;
    DROP TABLE IF EXISTS TBDISC_PREREQ; 
    CREATE temporary TABLE TBDISC_PREREQ 
    ( 
       disc VARCHAR(40),
	   preReq VARCHAR(40) 
    );
    OPEN DIF_CURSOR;
		ler : loop
        FETCH DIF_CURSOR into disc,preReq;
        IF existe_mais_linhas = 1 THEN
		LEAVE ler;
		END IF;
        INSERT INTO TBDISC_PREREQ VALUES (disc,preReq);
		END LOOP;
        SELECT * FROM TBDISC_PREREQ;
	CLOSE DIF_CURSOR;
END
$$
CALL DISC_PREREQ();
