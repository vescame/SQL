-- Prova Par
-- Nome: Vinicius Escame dos Santos
-- Status da atividade: FUNCIONOU
-- OBS: QUERY FUNCIONA PORÉM, SEM OUTPUT

Create table Funcionarios (
Codigo smallint,
PrimeiroNome varchar (20),
SegundoNome varchar (20),
UltimoNome varchar (20),
DataNasci date,
CPF decimal(11,0),
RG varchar (15),
Endereco varchar(100),
CEP int,
Cidade varchar(50),
Fone varchar(20),
CodigoDepartamento smallint,
Funcao varchar(20),
Salario decimal (15,2)
);

SELECT column_name FROM ALL_TAB_COLS WHERE table_name = 'FUNCIONARIOS';

Create table Departamentos (
Codigo smallint,
Nome varchar(30),
Localizacao varchar(30),
CodigoFuncionarioGerente smallint);


INSERT INTO Funcionarios values(
	1,
	'Nome 1',
	'Sobrenome 1',
	'Ultimo nome 1',
	'11 apr 1994',
	1311311311,
	'9909990',
	'Rua Um Um tambem',
	09821766,
	'Sao Paulo',
	'11099934',
	1,
	'Funcao 1',
	1233.45
);

INSERT INTO FUNCIONARIOS values(
	2,
	'Nome 2',
	'Sobrenome 2',
	'Ultimo nome 2',
	'11 apr 1996',
	13113113443,
	'99099944',
	'Rua dois Av. dois tambem',
	09821755,
	'Sao Paulo',
	'11099934445',
	2,
	'Funcao 2',
	4455.45);

INSERT INTO FUNCIONARIOS values(
	3,
	'Nome 3',
	'Sobrenome 3',
	'Ultimo nome 3',
	'11 apr 1976',
	13113113148,
	'99099988',
	'Rua tres Av. tres tambem',
	09821446,
	'Sao Paulo',
	'11099956744',
	3,
	'Funcao 1',
	1233.45);

INSERT INTO FUNCIONARIOS values(
	4,
	'Nome 4',
	'Sobrenome 4',
	'Ultimo nome 4',
	'11 jan 1984',
	13113113198,
	'99099218',
	'Rua quatro Av. quarto tambem',
	09821446,
	'Sao Paulo',
	'11339956744',
	1,
	'Funcao 5',
	1854.45);
INSERT INTO FUNCIONARIOS values(
	5,
	'Nome 5',
	'Sobrenome 5',
	'Ultimo nome 5',
	'11 feb 1994',
	13113123198,
	'99349218',
	'Rua quatro Av. quarto tambem',
	09821446,
	'Sao Paulo',
	'11339956744',
	1,
	'Funcao 5',
	1854.45);

INSERT INTO DEPARTAMENTOS VALUES (
	1,
	'Departamento 1',
	'Localizacao 1',
	1 );
INSERT INTO DEPARTAMENTOS VALUES (
	2,
	'Departamento 2',
	'Localizacao 2',
	2 );
INSERT INTO DEPARTAMENTOS VALUES (
	3,
	'Departamento 3',
	'Localizacao 3',
	3);


-- TESTES
SELECT CODIGODEPARTAMENTO FROM SYS.FUNCIONARIOS;

SELECT * FROM SYS.DEPARTAMENTOS;


/* CRIAR UMA PROCEDURE USANDO CURSOR EXPLICITO PARA
 * QUE LISTE O VALOR DA FOLHA DE PAGAMENTO DE CADA NOME DE DEPARTAMENTO */

-- QUERY
SELECT SUM(F.SALARIO) AS TOTAL, D.NOME FROM 
SYS.FUNCIONARIOS F
INNER JOIN SYS.DEPARTAMENTOS D ON F.CODIGODEPARTAMENTO = D.CODIGO
GROUP BY D.NOME
ORDER BY D.NOME;


-- CURSOR
CREATE OR REPLACE PROCEDURE LISTA_SALARIO
IS
	CURSOR c1 IS 
	SELECT SUM(F.SALARIO) AS TOTAL, D.NOME
		FROM SYS.FUNCIONARIOS F
	INNER JOIN SYS.DEPARTAMENTOS D ON F.CODIGODEPARTAMENTO = D.CODIGO
	GROUP BY D.NOME
	ORDER BY D.NOME;
	vtotal decimal(15,0);
	vdepartamento varchar(30);
BEGIN
	dbms_output.put_line('iniciando procedure lista_salario');
	OPEN c1;
	FETCH c1 INTO vtotal, vdepartamento;
	while c1%found loop
        dbms_output.put_line('Valor Total: ' || vtotal || ' Departamento: ' || vdepartamento);
        FETCH c1 INTO vtotal, vdepartamento;
    end loop;
    close c1;
END;

BEGIN
	LISTA_SALARIO;
END;

COMMIT;
