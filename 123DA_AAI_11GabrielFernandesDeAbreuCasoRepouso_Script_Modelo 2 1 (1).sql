/*
AUTO INSTRUCIONAL
Aluno: Gabriel Fernandes de Abreu
*/
/*
++++++++++++++++++++++++++++++++++++++
I)Criar as tabelas e as constraints
++++++++++++++++++++++++++++++++++++++
*/
DROP TABLE contratante
DROP TABLE hospede
DROP TABLE contrato
DROP TABLE formapgto
DROP TABLE parcelas

--A)Cria as tabelas
CREATE TABLE hospede
(
	codhospede INTEGER IDENTITY(1,1) not null,
	nomehospede varchar (50) not null,
	dtnasc date not null,
	cpf char (11) not null,
	tel char (9) not null,
	ci char (12) not null,
);

CREATE TABLE contrato
(
	codcontrato INTEGER IDENTITY(1,1) not null,
	codcontratante INTEGER not null,
	codhospede INTEGER not null,
	dtinicio date not null,
	dtfim date,
	vlrtotal numeric(8,2) not null,
	qtdeparcelas int not null,
);

CREATE TABLE formapgto 
(
	codformapgto INTEGER IDENTITY(1,1) not null,
	formapgto varchar (50) not null,
);

CREATE TABLE parcelas
(
	codparcela INTEGER IDENTITY(1,1) not null,
	codcontrato INTEGER not null, 
	codformapgto INTEGER not null,
	dtvenc date not null,
	vlrparcela DECIMAL(10, 2) not null,
	dtpgto date not null,
);


CREATE TABLE contratante(
	nomecontratante varchar (50) not null,
	codcontratante INTEGER IDENTITY(1,1) not null,
	cpf char (11) not null,
	tel char (9) not null,
);	


--B)CRIA AS PKs
ALTER TABLE hospede ADD CONSTRAINT hospede_codhospede_PK PRIMARY KEY (codhospede);
go
ALTER TABLE contrato ADD CONSTRAINT contrato_codcontrato_PK PRIMARY KEY (codcontrato);
go
ALTER TABLE contratante ADD CONSTRAINT contratante_codcontratante_PK PRIMARY KEY (codcontratante);
go
ALTER TABLE parcelas ADD CONSTRAINT parcela_codparcela_PK PRIMARY KEY (codparcela);
go
ALTER TABLE formapgto ADD CONSTRAINT formapgto_codformapgto_PK PRIMARY KEY (codformapgto);
go

--C)CRIA A FK
ALTER TABLE contrato
ADD FOREIGN KEY (codhospede) REFERENCES hospede(codhospede);
go

ALTER TABLE contrato
ADD FOREIGN KEY (codcontratante) REFERENCES contratante(codcontratante);
go

ALTER TABLE parcelas
ADD FOREIGN KEY (codcontrato) REFERENCES contrato(codcontrato);
go

ALTER TABLE parcelas
ADD FOREIGN KEY (codformapgto) REFERENCES formapgto(codformapgto);
go

--D)Os campos codhospede e dtinicio não podem repetir
ALTER TABLE contrato ADD CONSTRAINT contrato_codhospede_dtinicio_UQ UNIQUE(codhospede, dtinicio); 
go

--E)O campo DT_INICIO da tabela contrato, deverá receber a data do dia da digitação do contrato
ALTER TABLE contrato ADD CONSTRAINT contrato_dtinicio_DF DEFAULT (getdate()) FOR dtinicio;
go
--F)O campo DTNASC da tabela hóspede deverá ser maior ou igual a 1960 
ALTER TABLE hospede ADD CONSTRAINT hospede_dtnasc_CK CHECK (YEAR(dtnasc) >= 1960);
go

--G)Na tabela hóspede incluir o campo SEXO com tipo CHAR de tamanho 1
ALTER TABLE hospede ADD sexo CHAR(1);


--H)O campo SEXO poderá receber apenas dois valores: M ou F
ALTER TABLE hospede ADD CONSTRAINT hospede_sexo_CK CHECK (sexo IN ('M', 'F'));

/*
++++++++++++++++++++++++++++++++++++++
II)Povoar as tabelas
++++++++++++++++++++++++++++++++++++++
*/

--Forma_Pgto = no mínimo 4 linhas
INSERT INTO formapgto (formapgto) 
VALUES	('Crédito');
INSERT INTO formapgto (formapgto) 
VALUES	('Boleto Bancário');
INSERT INTO formapgto (formapgto) 
VALUES	('PIX');
INSERT INTO formapgto (formapgto) 
VALUES	('Dinheiro');

--Contratrante = no mínimo 3 linhas
INSERT INTO contratante (nomecontratante, cpf, tel) 
VALUES	('Pedro Guimarães', '91952522668', '837164937');
INSERT INTO contratante (nomecontratante, cpf, tel) 
VALUES	('Olavo Inácio', '16144669639', '246813579');
INSERT INTO contratante (nomecontratante, cpf, tel) 
VALUES	('Guilherme Arana', '15331990606', '987654329');

--Hóspede = no mínimo 10 linhas
INSERT INTO hospede (nomehospede, dtnasc, cpf, tel, ci, sexo) 
VALUES	('Sofia Oliveira', '1975-09-17', '90471638492', '195847563', '874856374986', 'F');
INSERT INTO hospede (nomehospede, dtnasc, cpf, tel, ci, sexo) 
VALUES	('Lucas Silva', '1982-07-08', '04857384756', '356756489', '223144564768', 'M');
INSERT INTO hospede (nomehospede, dtnasc, cpf, tel, ci, sexo) 
VALUES	('Marina Santos', '1970-05-25', '83749501947', '965405456', '776457685768', 'F');
INSERT INTO hospede (nomehospede, dtnasc, cpf, tel, ci, sexo) 
VALUES	('Rafael Pereira', '1978-11-12', '74658392047', '976548906', '665543746587', 'M');
INSERT INTO hospede (nomehospede, dtnasc, cpf, tel, ci, sexo) 
VALUES	('Isabella Costa', '1965-04-03', '84930685947', '112748598', '123098907865', 'F');
INSERT INTO hospede (nomehospede, dtnasc, cpf, tel, ci, sexo) 
VALUES	('Gabriel Ferreira', '1973-08-19', '98706543216', '099873245', '467385748899', 'M');
INSERT INTO hospede (nomehospede, dtnasc, cpf, tel, ci, sexo) 
VALUES	('Laura Almeida', '1988-10-06', '87690654345', '998874567', '009988675648', 'F');
INSERT INTO hospede (nomehospede, dtnasc, cpf, tel, ci, sexo) 
VALUES	('Matheus Carvalho', '1969-03-28', '98763432456', '445687653', '263227485998', 'M');
INSERT INTO hospede (nomehospede, dtnasc, cpf, tel, ci, sexo) 
VALUES	('Ana Souza', '1971-12-14', '98749302748', '997754365', '336647589609', 'F');
INSERT INTO hospede (nomehospede, dtnasc, cpf, tel, ci, sexo) 
VALUES	('Pedro Lima', '1985-06-09', '98453245678', '990087654',  '883647564778', 'M');

--Contrato = no mínimo 15 linhas

INSERT INTO contrato (codhospede, codcontratante, dtinicio, dtfim, vlrtotal, qtdeparcelas) 
VALUES	(1, 1, '2021-06-01', '2021-08-01', 3000.00, 1);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, dtfim, vlrtotal, qtdeparcelas) 
VALUES	(2, 2, '2021-04-01', '2021-03-01', 4000.00, 4);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, dtfim, vlrtotal, qtdeparcelas) 
VALUES	(3, 3, '2021-05-01', '2021-06-01', 3300.00, 3);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, dtfim, vlrtotal, qtdeparcelas) 
VALUES	(4, 1, '2021-03-01', '2021-5-01', 2200.00, 2);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, dtfim, vlrtotal, qtdeparcelas) 
VALUES	(5, 2, '2021-05-01', '2021-11-01', 6000.00, 2);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, dtfim, vlrtotal, qtdeparcelas) 
VALUES	(6, 3, '2021-06-01', '2021-12-01', 6300.00, 3);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, dtfim, vlrtotal, qtdeparcelas) 
VALUES	(7, 1, '2021-07-01', '2022-01-01', 3000.00, 3);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, dtfim, vlrtotal, qtdeparcelas) 
VALUES	(8, 2, '2021-08-01', '2022-02-01', 4400.00, 2);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, dtfim, vlrtotal, qtdeparcelas) 
VALUES	(9, 3, '2021-09-01', '2022-03-01', 4200.00, 2);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, dtfim, vlrtotal, qtdeparcelas) 
VALUES	(10, 1, '2021-10-01', '2022-04-01', 4600.00, 2);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, vlrtotal, qtdeparcelas) 
VALUES	(1, 2, '2021-11-01', 1000.00, 1);
INSERT INTO contrato (codhospede, codcontratante, dtinicio,  vlrtotal, qtdeparcelas) 
VALUES	(2, 3, '2022-01-01',  4700.00, 2);
INSERT INTO contrato (codhospede, codcontratante, dtinicio,  vlrtotal, qtdeparcelas) 
VALUES	(3, 1, '2022-01-01',  4200.00, 2);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, vlrtotal, qtdeparcelas) 
VALUES	(4, 2, '2022-02-01',  6300.00, 3);
INSERT INTO contrato (codhospede, codcontratante, dtinicio, vlrtotal, qtdeparcelas) 
VALUES	(5, 3, '2022-03-01',  4500.00, 2);

--Parcelas = no mínimo 30 linhas

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (1, 1, '2021-09-12', 3000, '2021-06-10'); 

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (2, 3, '2021-09-08', 1000, '2021-05-09');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (2, 3, '2021-09-08', 1000, '2021-06-09');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (2, 3, '2021-09-08', 1000, '2021-07-09');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (2, 3, '2021-09-08', 1000, '2021-08-09');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (3, 2, '2021-08-06', 1100, '2021-05-03');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (3, 2, '2021-08-06', 1100, '2021-06-03');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (3, 2, '2021-08-06', 1100, '2021-07-03');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (4, 3, '2021-05-20', 1100, '2023-03-12');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (4, 3, '2021-05-20', 1100, '2023-04-12');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (5, 2, '2024-07-15', 3000, '2023-02-15');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (5, 2, '2024-07-15', 3000, '2023-03-15');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (6, 1, '2024-03-12', 2100, '2023-04-14');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (6, 1, '2024-03-12', 2100, '2023-05-14');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (6, 1, '2024-03-12', 2100, '2023-06-14');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES(7, 2, '2024-05-23', 1000, '2023-01-05');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES(7, 2, '2024-05-23', 1000, '2023-02-05');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES(7, 2, '2024-05-23', 1000, '2023-03-05');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (8, 4, '2024-03-22', 2200, '2023-05-15');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (8, 4, '2024-03-22', 2200, '2023-06-15');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (9,2, '2024-04-14', 2100, '2023-11-16');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (9,2, '2024-04-14', 2100, '2023-12-16');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (10, 3, '2024-07-12', 2300, '2023-08-18');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (10, 3, '2024-07-12', 2300, '2023-09-18');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (11, 1, '2024-02-17', 1000, '2023-04-20');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (12, 3, '2024-09-21', 2350, '2023-05-22');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (12, 3, '2024-09-21', 2350, '2023-06-22');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (13, 4, '2024-10-23', 2100, '2023-04-10');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (13, 4, '2024-10-23', 2100, '2023-05-10');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES(14, 1, '2024-12-05', 2100, '2023-03-09');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES(14, 1, '2024-12-05', 2100, '2023-04-09');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES(14, 1, '2024-12-05', 2100, '2023-05-09');

INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (15, 2, '2024-10-02', 2250, '2023-03-10');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (15, 2, '2024-10-02', 2250, '2023-04-10');
INSERT INTO parcelas (codcontrato, codformapgto, dtvenc, vlrparcela, dtpgto) 
VALUES (15, 2, '2024-10-02', 2250, '2023-05-10');




/*
++++++++++++++++++++++++++++++++++++++
III)COMANDOS SELECT
++++++++++++++++++++++++++++++++++++++
*/
--A) 

select   h.codhospede AS 'Código do Hóspede', 
		 h.nomehospede AS 'Hóspede', 
		 c.codcontrato AS 'Código  do Contrato', 
		 ct.nomecontratante AS 'Contratante', 
		 c.dtinicio AS 'Data de Início do Contrato', 
		 c.dtfim AS 'Data de Fim do Contrato',
		 c.vlrtotal AS 'Valor Total do Contrato',
		 c.qtdeparcelas AS 'Quantidade de Parcelas'

from	hospede h INNER JOIN contrato c 
			ON h.codhospede = c.codhospede
		INNER JOIN contratante ct
			ON c.codcontratante = ct.codcontratante

where  c.codhospede = 1 or c.codhospede = 2 or c.codhospede = 3 or c.codhospede = 4 or c.codhospede = 5

ORDER BY  h.codhospede DESC;




--B)

select    MONTH(p.dtvenc) AS 'Mês',
		  fp.formapgto AS 'Forma de Pgto',
		  SUM(c.vlrtotal) AS 'Total das Parcelas'

from	  parcelas p INNER JOIN contrato c 
			 ON p.codcontrato = c.codcontrato
		  INNER JOIN formapgto fp 
			 ON fp.codformapgto = p.codformapgto
		  INNER JOIN hospede h
			 ON h.codhospede = c.codhospede

where    YEAR(p.dtvenc) = '2021' and h.sexo = 'F'

group by fp.formapgto, p.dtvenc;	

/*
++++++++++++++++++++++++++++++++++++++
IV)Criar uma VIEW à sua escolha que tenha um SELECT o mais complicado que você puder imaginar.
++++++++++++++++++++++++++++++++++++++
*/

CREATE VIEW vw_detalhes_contrato AS

SELECT	c.codcontrato,
		h.nomehospede,
		ct.nomecontratante,
		c.dtinicio,
		c.dtfim,
		c.vlrtotal,
		c.qtdeparcelas,
		p.codparcela,
		p.dtvenc,
		p.vlrparcela,
		p.dtpgto,
		fp.formapgto

from	contrato c
		INNER JOIN hospede h ON c.codhospede = h.codhospede
		INNER JOIN contratante ct ON c.codcontratante = ct.codcontratante
		INNER JOIN parcelas p ON c.codcontrato = p.codcontrato
		INNER JOIN formapgto fp ON p.codformapgto = fp.codformapgto;

select *
from vw_detalhes_contrato
where dtinicio > '2021-01-01'
  AND vlrtotal > 5000;

/*
++++++++++++++++++++++++++++++++++++++
V)Fazer um UPDATE de algum dado da tabela hóspede
++++++++++++++++++++++++++++++++++++++
*/
update  hospede
set		tel = 986483755  
where	nomehospede = 'Olávo Inacio';

/*
++++++++++++++++++++++++++++++++++++++
VI)Fazer um DELETE de um contrato finalizado
++++++++++++++++++++++++++++++++++++++
*/
delete from parcelas
where       codparcela = 1;

delete from  contrato 
where        codcontrato = 1;