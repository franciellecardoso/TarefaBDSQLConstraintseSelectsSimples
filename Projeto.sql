CREATE DATABASE exercicio_SQL_projeto

GO 
USE exercicio_SQL_projeto

--Criação de tabela projects
GO
CREATE TABLE projects(
id                    INT            IDENTITY(10001, 1)                      NOT NULL,
name                  VARCHAR(45)                                            NOT NULL,
description           VARCHAR(45)                                            NULL,
date                  DATE           CHECK(date > '01/09/2014')              NOT NULL 
PRIMARY KEY(id)
)

--Criação de tabela users
GO
CREATE TABLE users(
id                    INT            IDENTITY(1, 1)                          NOT NULL,
name                  VARCHAR(45)                                            NOT NULL,
username              VARCHAR(45)    UNIQUE                                  NOT NULL,
password              VARCHAR(45)    DEFAULT('123mudar')                     NOT NULL,
email                 VARCHAR(45)                                            NOT NULL
PRIMARY KEY(id)
)

--Criação de tabela users_has_projects
GO
CREATE TABLE users_has_projects(
users_id              INT                                                    NOT NULL,
projects_id           INT                                                    NOT NULL
PRIMARY KEY (users_id, projects_id)
FOREIGN KEY (users_id)        
        REFERENCES   users(id),
FOREIGN KEY (projects_id)     
        REFERENCES   projects(id)
)
--Modificar tipo de coluna username na users
ALTER TABLE users
ALTER COLUMN    username      VARCHAR(10)        NOT NULL

--Modificar tipo de coluna password na users
ALTER TABLE users
ALTER COLUMN     password      VARCHAR(8)        NOT NULL

--Inserção de Dados projects
INSERT INTO projects(name, description, date)
VALUES               ('Re-folha', 'Refatoração das Folhas', '05/09/2014')

GO       
INSERT INTO projects(name, description, date)
VALUES               ('Manutenção PCs', 'Manutenção PCs','06/09/2014')

GO   
INSERT INTO projects(name, description, date)
VALUES               ('Auditoria' , NULL, '07/09/2014')

--Inserção de Dados users
INSERT INTO users(name, username, email)
VALUES            ('Maria', 'Rh_maria', 'maria@empresa.com' )

GO
INSERT INTO users(name, username, password, email)
VALUES            ('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com')

GO
INSERT INTO users(name, username, email)
VALUES            ('Ana', 'Rh_ana', 'ana@empresa.com')

GO
INSERT INTO users(name, username, email)
VALUES            ('Clara', 'Ti_clara', 'clara@empresa.com')

GO
INSERT INTO users(name, username, password, email)
VALUES            ('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')

--Inserção de Dados users_has_projects
INSERT INTO users_has_projects VALUES 
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)

--Atualizar Dados projects
UPDATE projects
SET date = '12/09/2014'
WHERE name LIKE 'Manutenção%' 

--Atualizar Dados users
UPDATE users
SET username = 'Rh_cido'
WHERE name = 'Aparecido'

--Atualizar Dados users
UPDATE users
SET password = '888@'
WHERE username = 'Rh_maria' AND password = '123mudar'

--Excluir users_has_projects
DELETE users_has_projects
WHERE users_id = 2

--Consulta todas as linhas e todas as coluna projects, users, users_has_projects
SELECT * FROM projects
SELECT * FROM users
SELECT * FROM users_has_projects
