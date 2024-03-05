CREATE table artista(
Datanasc date,
Codart serial not null,
Cidade varchar(30),
Pais varchar (30),
Nomeart varchar(30));

select * from artista;


CREATE TABLE filme(
Duracao varchar(20),
Ano char(4),
Codfilm serial not null,
titulo varchar(20));

select * from filme;


CREATE TABLE categoria(
Desccat varchar(40),
codcat serial not null,
);
