-- Tarefa 1 - BD Filmes

-- Questão 6
select * from artista order by codart; 
select * from categoria; 
select * from estudio order by codest; 
select * from filme order by codfilme; 
select * from personagem; 

-- Questão 7
insert into filme values(default,'Elvis',2022,120,null,3);
select * from filme;

-- Questão 8

select * 
from artista 
order by nomeart; 

-- Questão 9
select * from artista
where nomeart like 'B%'; 

-- Questão 10
select *
from filme
where ano = 2019; 

-- Questão 11
select * from personagem; 
update personagem
set cache = cache +0.15*cache

-- Questão 12
select * from artista; 
insert into artista values (default,'Gloria Pires','Rio de Janeiro','Brasil','10/10/1965');
insert into artista values (default,'Djavan','Maceio','Brasil','10/10/1955');

-- Questão 13
select * from artista; 
delete from artista where nomeart = 'Djavan'; 

-- Questão 14
select f.titulo
from filme f
where f.duracao > 120; 

-- Questão 15
SELECT a.nomeart, a.codart, a.cidade 
FROM artista a
where a.cidade is null;

update artista 
set cidade = 'Los Angeles'
where nomeart in ('Brad Pitt', 'Tom Cruise','Bradley Cooper');

-- Questão 16
SELECT c.desccateg 
FROM filme f join categoria c on f.codcateg = c.codcateg
where f.titulo like 'Coringa';

-- Questão 17
SELECT F.titulo, E.nomeest, C.desccateg
FROM filme F JOIN estudio E ON F.codest = E.codest
JOIN categoria C ON C.codcateg = F.codcateg;

-- Questão 18
SELECT A.nomeart 
FROM personagem P join Filme F
on P.codfilme = F.CODFILME
JOIN artista A on A.codart = P.codart
WHERE F.titulo = 'Encontro Explosivo';

-- Questão 19
SELECT A.nomeart, p.nomepers
FROM artista A
JOIN personagem P ON  P.CODART = A.CODART
JOIN filme F ON P.CODFILME = F.CODFILME
JOIN categoria C ON C.CODCATEG = F.CODCATEG
WHERE A.nomeart like 'B%' AND C.desccateg = 'Aventura';

-- Questão 20
SELECT c.desccateg, count(C.codcateg)
FROM categoria C JOIN filme F ON F.codcateg = C.codcateg
GROUP BY C.desccateg;

-- questão 21
select a.codart, a.nomeart, p.nomepers
from artista a left outer join personagem p on a.codart = p.codart;

-- questão 22
select codart
  from artista
Except
  select codart
   from personagem;

-- questão 23
Select f.titulo as Filme
From filme f left join categoria c on f.codcateg = c.codcateg
Where f.codcateg is null; 





CREATE TABLE Filme ( 
       CodFILME       Serial  NOT NULL,
       Titulo          Varchar(25),
       Ano             integer,
       Duracao         integer,
       CodCATEG       integer,
       CodEst         integer);

CREATE TABLE Artista ( 
       CodART      Serial  NOT NULL,
       NomeART    Varchar(25),
       Cidade          Varchar(20),
       Pais            Varchar(20),
       DataNasc       Date);

CREATE TABLE Estudio ( 
       CodEst     serial  NOT NULL,
       NomeEst    Varchar(25));

CREATE TABLE Categoria ( 
       CodCATEG       serial  NOT NULL,
       DescCATEG VARCHAR(25));

CREATE TABLE Personagem ( 
       CodART     integer  NOT NULL,
       CodFILME   integer  NOT NULL,
       NomePers  VARCHAR(25),
       Cache           numeric(15,2));

ALTER TABLE Filme ADD CONSTRAINT PKFilme PRIMARY KEY(CodFILME);

ALTER TABLE Artista ADD CONSTRAINT PKArtista PRIMARY KEY(CodART);

ALTER TABLE Estudio ADD CONSTRAINT PKEst PRIMARY KEY(CodEst);

ALTER TABLE Categoria ADD CONSTRAINT PKCategoria PRIMARY KEY(CodCATEG);

ALTER TABLE Personagem ADD CONSTRAINT PKPersonagem PRIMARY KEY(CodART,CodFILME);

ALTER TABLE Filme ADD CONSTRAINT FKFilme1Categ FOREIGN KEY(CodCATEG) REFERENCES Categoria;

ALTER TABLE Filme ADD CONSTRAINT FKFilme2Estud FOREIGN KEY(CodEst) REFERENCES Estudio;

ALTER TABLE Personagem ADD CONSTRAINT FKPersonagem2Artis FOREIGN KEY(CodART) REFERENCES Artista;

ALTER TABLE Personagem ADD CONSTRAINT FKPersonagem1Filme FOREIGN KEY(CodFILME) REFERENCES Filme;











