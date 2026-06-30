create database Mundo;
use Mundo;

create table pais
(
    nome varchar(55),
    cod int primary key,
    continente varchar(55),
    pop real,
    pib real,
    expec_vida real
);

create table cidade
(
    nome varchar(35),
    cod int primary key,
    pais int,
    pop real,
    capital enum ('S','N') default 'N',
    constraint fk_pais_cidade foreign key (pais)
    references pais (cod) -- Corrigido: tabela (coluna)
);

create table rio
(
    nome varchar(35) primary key,
    origem int,
    comprimento int,
    pais int,
    constraint fk_rio_origem foreign key (origem) references pais (cod),
    constraint fk_rio_pais foreign key (pais) references pais (cod)
);

insert into pais values
('Canada',001,'Am.Norte',30.1,658,77.08),
('Mexico',002,'Am.Norte',107.5,694,69.1),
('Brasil',003,'Am.sul',183.3,10004,65.2),
('USA',004,'Am.Norte',270,8003,75.5);

INSERT INTO cidade (cod, nome, pais, pop, capital) VALUES
(101, 'Washington', 4, 3.3, 'S'),    -- 4 = USA
(102, 'Monterrey', 2, 2.0, 'N'),     -- 2 = Mexico
(103, 'Brasilia', 3, 1.5, 'S'),      -- 3 = Brasil
(104, 'São Paulo', 3, 15.0, 'N'),    -- 3 = Brasil
(105, 'Ottawa', 1, 0.8, 'S'),        -- 1 = Canada
(106, 'Cid. Mexico', 2, 14.1, 'S');  -- 2 = Mexico

INSERT INTO rio (nome, origem, pais, comprimento) VALUES
('St. Lawrence', 4, 4, 3.3),  
('Grande', 4, 2, 2.0),        
('Parana', 3, 3, 1.5),       
('Mississippi', 4, 4, 15.0);  

SELECT c.nome AS Cidade, p.nome AS Pais -- 1
FROM cidade c
JOIN pais p ON c.pais = p.cod;

SELECT nome -- 2
FROM cidade 
WHERE capital = 'S';

SELECT * FROM pais  -- 3
WHERE expec_vida < 70;

SELECT c.nome AS Capital, p.pop AS Populacao_Pais  -- 4
FROM cidade c
JOIN pais p ON c.pais = p.cod
WHERE c.capital = 'S' AND p.pib > 1000;

SELECT c.nome AS Capital, c.pop AS Populacao_Capital  -- 5 
FROM cidade c
JOIN rio r ON r.origem = c.pais
WHERE r.nome = 'St. Lawrence' AND c.capital = 'S';

SELECT AVG(pop) AS Media_Populacao_Nao_Capitais -- 6
FROM cidade 
WHERE capital = 'N';

SELECT continente, AVG(pib) AS PIB_Medio -- 7
FROM pais
GROUP BY continente;

SELECT p.nome AS Pais, MIN(r.comprimento) AS Menor_Comprimento -- 8
FROM rio r
JOIN pais p ON r.origem = p.cod
GROUP BY p.nome
HAVING COUNT(r.nome) >= 2;

SELECT nome -- 9
FROM pais 
WHERE pib > (SELECT pib FROM pais WHERE nome = 'Canada');

