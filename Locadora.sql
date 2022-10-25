CREATE DATABASE exercicio_SQL_locadora

GO 
USE exercicio_SQL_locadora

--Criação de tabela filme
GO
CREATE TABLE filme(
id                    INT                                                                 NOT NULL,
titulo                VARCHAR(40)                                                         NOT NULL,
ano                   INT             CHECK(ano<=2021)                                    NULL
PRIMARY KEY(id) 
)

--Criação de tabela estrela
GO
CREATE TABLE estrela(
id                    INT                                                                 NOT NULL,
nome                  VARCHAR(50)                                                         NOT NULL
PRIMARY KEY(id)
)

--Criação de tabela filme_estrela
GO
CREATE TABLE filme_estrela(
filme_id              INT                                                                 NOT NULL,
estrela_id            INT                                                                 NOT NULL
PRIMARY KEY (filme_id, estrela_id)
FOREIGN KEY (filme_id) 
        REFERENCES filme(id),
FOREIGN KEY (estrela_id) 
        REFERENCES estrela(id)
)
--Criação de tabela dvd
GO
CREATE TABLE dvd(
num                   INT                                                                 NOT NULL,
data_fabricacao       DATE            CHECK(data_fabricacao < GETDATE())                  NOT NULL,
filme_id              INT                                                                 NOT NULL
PRIMARY KEY (num)
FOREIGN KEY (filme_id) 
        REFERENCES filme(id)
)

--Criação de tabela cliente
GO
CREATE TABLE cliente(
num_cadastro          INT                                                                 NOT NULL,
nome                  VARCHAR(70)                                                         NOT NULL,
logradouro            VARCHAR(150)                                                        NOT NULL,
num                   INT             CHECK(num > 0)                                      NOT NULL,
cep                   CHAR(8)         CHECK(LEN(cep) = 8)                                 NULL
PRIMARY KEY (num_cadastro)
)

--Criação de tabela locacao
GO
CREATE TABLE locacao(
dvd_num               INT                                                                 NOT NULL,
cliente_num_cadastro  INT                                                                 NOT NULL,
data_locacao          DATE            DEFAULT(GETDATE())                                  NOT NULL,
data_devolucao        DATE                                                                NOT NULL,
valor                 DECIMAL(7,2)    CHECK(valor > 0.00)                                 NOT NULL
PRIMARY KEY (dvd_num, cliente_num_cadastro, data_locacao)
FOREIGN KEY (dvd_num) 
        REFERENCES dvd(num),
FOREIGN KEY (cliente_num_cadastro) REFERENCES cliente(num_cadastro),
CONSTRAINT check_data CHECK(data_devolucao > data_locacao)
)

--Esquema:
--Modificar tipo de coluna nome_real na estrela
ALTER TABLE estrela
ADD nome_real         VARCHAR(50)                                                         NULL

--Modificar tipo de coluna titulo no filme
ALTER TABLE filme
ALTER COLUMN  titulo  VARCHAR(80)                                                         NOT NULL

--Inserção de Dados filme
INSERT INTO filme(id, titulo, ano)
VALUES            (1001, 'Whiplash', 2015)

GO
INSERT INTO filme(id, titulo, ano)
VALUES            (1002, 'Birdman', 2015)

GO
INSERT INTO filme(id, titulo, ano)
VALUES            (1003, 'Interestelar', 2014)

GO
INSERT INTO filme(id, titulo, ano)
VALUES            (1004, 'A Culpa é das Estrelas', 2014)

GO
INSERT INTO filme(id, titulo, ano)
VALUES            (1005, 'Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014)

GO
INSERT INTO filme(id, titulo, ano)
VALUES            (1006, 'Sing', 2016)

--Inserção de Dados estrela
INSERT INTO estrela(id, nome, nome_real)
VALUES              (9901, 'Michael Keaton', 'Michael John Douglas')

GO
INSERT INTO estrela(id, nome, nome_real)
VALUES              (9902, 'Emma Stone', 'Emily Jean Stone')

GO
INSERT INTO estrela(id, nome, nome_real)
VALUES              (9903, 'Miles Teller', NULL)

GO
INSERT INTO estrela(id, nome, nome_real)
VALUES              (9904, 'Steve Carell', 'Steven John Carell')

GO
INSERT INTO estrela(id, nome, nome_real)
VALUES              (9905, 'Jennifer Garner', 'Jennifer Anne Garner')

--Inserção de Dados filme_estrela
INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES                    (1002, 9901)

GO
INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES                    (1002, 9902)

GO
INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES                    (1001, 9903)

GO
INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES                    (1005, 9904)

GO
INSERT INTO filme_estrela(filme_id, estrela_id)
VALUES                    (1005, 9905)

--Inserção de Dados dvd
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10001, '2020-12-02', 1001)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10002, '2019-10-18', 1002)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10003, '2020-04-03', 1003)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10004, '2020-12-02', 1001)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10005, '2019-10-18', 1004)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10006, '2020-04-03', 1002)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10007, '2020-12-02', 1005)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10008, '2019-10-18', 1002)

GO
INSERT INTO dvd(num, data_fabricacao, filme_id)
VALUES          (10009, '2020-04-03', 1003)

--Inserção de Dados cliente
INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES              (5501, 'Matilde Luz', 'Rua Síria', 150, '03086040')

GO
INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES              (5502, 'Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110')

GO
INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES              (5503, 'Daniel Ramalho', 'Rua Itajutiba', 169, NULL)

GO
INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES              (5504, 'Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL)

GO
INSERT INTO cliente(num_cadastro, nome, logradouro, num, cep)
VALUES              (5505, 'Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110')

--Inserção de Dados locacao
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10001, 5502, '2021-02-18', '2021-02-21', 3.50)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10009, 5502, '2021-02-18', '2021-02-21', 3.50)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10002, 5503, '2021-02-18', '2021-02-19', 3.50)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10002, 5505, '2021-02-20', '2021-02-23', 3.00)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10004, 5505, '2021-02-20', '2021-02-23', 3.00)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10005, 5505, '2021-02-20', '2021-02-23', 3.00)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10001, 5501, '2021-02-24', '2021-02-26', 3.50)

GO
INSERT INTO locacao (dvd_num, cliente_num_cadastro, data_locacao, data_devolucao, valor)
VALUES               (10008, 5501, '2021-02-24', '2021-02-26', 3.50)

--Atualizar Dados cliente 5503
UPDATE cliente
SET cep = '08411150' 
WHERE num_cadastro = 5503

--Atualizar Dados cliente 5504
UPDATE cliente
SET cep = '02918190'
WHERE num_cadastro = 5504

--Atualizar Dados locacao e cliente
UPDATE locacao
SET valor = 3.25
WHERE data_locacao = '2021-02-18' AND cliente_num_cadastro = 5502 

--Atualizar Dados locacao e cliente
UPDATE locacao
SET valor = 3.10
WHERE data_locacao = '2021-02-24' AND cliente_num_cadastro = 5501

--Atualizar Dados dvd 10005
UPDATE dvd
SET data_fabricacao = '2019-07-14'
WHERE num = 10005

--Atualizar Dados estrela Miles
UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'

--Excluir filme Sing
DELETE filme
WHERE titulo = 'Sing'

--Consultar(SELECTS SIMPLES):
--1) Fazer um select que retorne os nomes dos filmes de 2014
SELECT titulo AS Filmes_de_2014 
FROM filme
WHERE ano = 2014

--2) Fazer um select que retorne o id e o ano do filme Birdman
SELECT CAST(id AS VARCHAR(4))  AS ID_do_filme_Birdman ,
       CAST(ano AS VARCHAR(4)) AS Ano  
FROM filme
WHERE titulo = 'Birdman'

--3) Fazer um select que retorne o id e o ano do filme que chama
SELECT id, ano 
FROM filme
WHERE titulo LIKE '%plash'

--4) Fazer um select que retorne o id, o nome e o nome_real da estrela cujo nome começa com Steve
SELECT id, nome, nome_real 
FROM estrela
WHERE nome LIKE 'Steve%' 

/*
  5) Fazer um select que retorne FilmeId e a data_fabricação em formato (DD/MM/YYYY)
     (apelidar de fab) dos filmes fabricados a partir de 01-01-2020
*/
SELECT filme_id, 
       CONVERT (CHAR(10), data_fabricacao, 103) AS fab
FROM dvd
WHERE data_fabricacao > '2020-01-01'


/*
  6) Fazer um select que retorne DVDnum, data_locacao, data_devolucao, valor e valor 
     com multa de acréscimo de 2.00 da locação do cliente 5505
*/
SELECT dvd_num, data_locacao, data_devolucao, valor, 2.00 AS multa, 
       valor + 2.00 AS valor_acrescimo
FROM locacao
WHERE cliente_num_cadastro = 5505

--7) Fazer um select que retorne Logradouro, num e CEP de Matilde Luz
SELECT logradouro, num, cep 
FROM cliente
WHERE nome = 'Matilde Luz'

--8) Fazer um select que retorne Nome real de Michael Keaton
SELECT nome_real
FROM estrela
WHERE nome = 'Michael Keaton'

/*
  9) Fazer um select que retorne o num_cadastro, o nome e o endereço completo, 
  concatenando (logradouro, numero e CEP), apelido end_comp, dos clientes cujo ID é 
  maior ou igual 5503
*/
SELECT num_cadastro, nome, 
       logradouro + ', Nº' + CAST(num AS VARCHAR(3)) +', CEP ' + cep AS end_compl
FROM cliente
WHERE num_cadastro = 5503 OR num_cadastro > 5503

--Consulta todas as linhas e todas as colunas cliente, estrela, dvd, filme, filme_estrela, locacao
SELECT * FROM cliente 
SELECT * FROM estrela
SELECT * FROM dvd
SELECT * FROM filme
SELECT * FROM filme_estrela
SELECT * FROM locacao