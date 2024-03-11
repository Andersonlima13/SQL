CREATE TABLE Cliente (
CodCLI Serial PRIMARY KEY,
Nome Varchar(30),
Endereco Varchar(30),
Telefone Varchar(12),
InscE Varchar(10),
CNPJ Varchar(10),
Cidade Varchar(15),
UF Varchar(2)
);

CREATE TABLE Produto (
CodPROD Serial not null,
Descricao Varchar(20),
Valor Numeric(10,2),
Unidade Char(2),
constraint pk_prod primary key(CodPROD));

CREATE TABLE Pedido (
NumPED Serial PRIMARY KEY,
PrazoEntrega Integer,
Data Date,
CodCLI Integer,
CodVEND Integer,
FOREIGN KEY(CodCLI) REFERENCES Cliente (CodCLI)
);

CREATE TABLE Vendedor (
CodVEND Serial PRIMARY KEY,
Nome Varchar(30),
DataNasc Date,
SalarioFixo Numeric(12,2),
FaixaComissao Char(1)
);

CREATE TABLE ItensPedido (
NumPED Integer,
CodPROD Integer,
Quantidade Integer,
constraint pk_itens PRIMARY KEY(CodPROD,NumPED),
constraint fk_prod FOREIGN KEY(CodPROD) REFERENCES Produto (CodPROD),
constraint fk_ped FOREIGN KEY(NumPED) REFERENCES Pedido (NumPED)
);
 

ALTER TABLE Pedido ADD FOREIGN KEY(CodVEND) REFERENCES Vendedor (CodVEND);


-- Aula 04 - Banco Pedidos 

Select nome
	From cliente
	Where cidade = 'Joao Pessoa';
	
	select * from cliente; 
	select * from pedido; 
	select * from vendedor; 
	
Select nome, UF 
from cliente JOIN pedido 
        on cliente.codcli = pedido.codcli 
where UF in ('PB','PE') and prazoentrega > 15;

-- Operações de conjuntos 

(Select nome
    from cliente
    where cidade like 'Recife')
    UNION
(Select nome
 from vendedor);

select codcli
  from cliente
  where UF = 'PB'
  INTERSECT
select codcli
   from pedido;

select codcli
  from cliente
Except
select codcli
   from pedido;
   
select * from cliente order by codcli; 

select * from pedido order by numped; 

-- Produto cartesiano

Select cliente.codcli, nome, numped, pedido.codcli
from cliente, pedido;

Select cliente.codcli, nome, numped, pedido.codcli
from cliente cross JOIN pedido;

-- Joins

Select cliente.codcli, pedido.codcli, nome, numped
from cliente, pedido
where cliente.codcli = pedido.codcli;

Select cliente.codcli, pedido.codcli, nome, numped
from cliente JOIN pedido on cliente.codcli = pedido.codcli;

Select v.nome 
From vendedor v join pedido p 
        on v.codvend =  p.codvend
     join itenspedido i on p.numped = i.numped 
     join produto pr on i.codprod = pr.codprod
Where i.quantidade > 5 and pr.descricao = 'Chocolate'; 

-- Group by 

Select cidade, count(*)
from cliente C join pedido P on C.codcli = P.codcli 
join vendedor V on P.codvend = V.codvend 
Group by cidade;

select cliente.uf, count(*) 
from cliente
group by uf
having count(*) > 2; 
select v.faixacomissao, round(avg(salariofixo),2)
from vendedor v
where v.faixacomissao <> 'B'
group by v.faixacomissao
having avg(salariofixo) > 3000; 


select v.faixacomissao, min(salariofixo), max(salariofixo)
from vendedor v
group by v.faixacomissao



-- Criação das tabelas Departamento e Empregado

create table departamento (
   CodDepto                      serial not null, 
   Nome                          varchar(20),
   Local                         varchar(20));
alter table departamento add constraint pkdepto primary key(coddepto);

create table empregado (
       Matricula               serial not null,
       PrimeiroNome            varchar(15),
       Sobrenome   	           varchar(15),
       Dataadmissao            date,
       Cargo                   varchar(30),
       Salario                 numeric(13,2),
       gerente		             integer,
       CodDepto                integer);
alter table empregado add constraint pkEmp primary key(matricula);

Alter table empregado add constraint fkgerente foreign key(gerente) references Empregado;
Alter table Empregado add constraint fkdepto foreign key(coddepto) references Departamento;




insert into departamento values (default,'Informática','Sede');
insert into departamento values (default,'Pessoal','Sede');
insert into Empregado values (default,'Jõao', 'Guedes',current_date,'Analista de Sistemas Junior',3400.00,null,1);
insert into Empregado values (default,'José', 'Batista',current_date,'Analista de Sistemas Pleno',4200.00,1,1);
insert into Empregado values (default,'Ana Maria', 'Silva',current_date,'Analista de Sistemas Junior',3400.00,1,1);
insert into Empregado values (default,'Ricardo', 'Neves',current_date,'Analista de Sistemas Pleno',4200.00,2,1);
insert into Empregado values (default,'Valter', 'Moura',current_date,'Analista de Suporte Junior',3400.00,2,1);
insert into Empregado values (default,'Mariana','Oliveira',current_date,'Designer de Interface',4800.00,1,null);

select * from empregado;


-- Consultas ao banco Empregados

Select e.sobrenome as "Empregado", d.nome as "Departamento", e.dataadmissao as "Data de Admissão"
From empregado e join departamento d on e.coddepto = d.coddepto;

Select e.primeironome as "Empregado", 	g.primeironome as "Gerente"
   From (empregado e join empregado g 
             on e.gerente = g.matricula);

Select d.nome as Departamento, 	e.primeironome as
Empregado
From departamento d left outer join empregado e
on d.coddepto = e.coddepto;

select d.nome as Departamento, e.primeironome 
as Empregado
	from departamento d right outer join empregado e
		on d.coddepto = e.coddepto
   order by d.nome;

Select d.nome as Departamento, 	e.primeironome as Empregado
From departamento d full join empregado e
		on d.coddepto = e.coddepto;

Select d.nome as Departamento, 	e.primeironome as Funcionario
	From departamento d left join empregado e
		on d.coddepto = e.coddepto
   Where e.coddepto is null
   Order by d.nome; 
   
   
-- BD Pedidos
-- script da aula 05 - subqueries e outros comandos

select * from produto order by codprod; 

Select descricao
From produto
Where unidade IN ('KG', 'L', 'M');

Select round(avg(valor),0)
From produto; 

-- Subqueries

Select descricao
From produto
Where codprod in 
     (select codprod
	  From itenspedido
      Where quantidade = 10);

select * from vendedor order by codvend; 

select nome
	From vendedor
	Where salariofixo < 
	      (select round(AVG(salariofixo),1)
		   From vendedor);
								 

select * from produto; 

Select  pr.unidade, max(pr.valor) 
From  produto pr
group by pr.unidade; 
		 
Select p.descricao 
From produto p
Where  p.valor > 
    ANY (Select  max(pr.valor) 
         From  produto pr
         group by pr.unidade) ;
		 
-- Teste com ALL

Select p.descricao 
From produto p
Where  p.valor > 
    ALL (Select  max(pr.valor) 
         From  produto pr
         group by pr.unidade) ;

-- Consultas correlacionadas

-- Faça a seguinte inserção
insert into produto values (default, 'XXX', 1.2, 'KG');

select * from produto order by codprod; 

select p.descricao
	From produto P
	Where not exists 
	(select *
     From itenspedido i
	 Where i.codprod = P.codprod);
	 
-- sem o NOT
select p.descricao
	From produto P
	Where exists 
	(select *
     From itenspedido i
	 Where i.codprod = P.codprod);
	 
-- igual a: 
Select p.descricao
From produto p 
Where p.codprod in  
     (select i.codprod
	  From itenspedido i);

-- com Not

Select p.descricao
From produto p 
Where p.codprod not in  
     (select i.codprod
	  From itenspedido i);

-- Usando IN e um filtro de linha

Select p.descricao
From produto p 
Where p.codprod in  
     (select i.codprod
	  From itenspedido i
	  Where i.quantidade = 10);
	    
-- Outras subqueries

Select distinct 
   (Select COUNT(*) from cliente where cidade like 'João Pessoa') AS "Quantidade de Pessoenses", 
   (Select COUNT(*) from cliente where cidade like 'Recife') AS "Quantidade de Recifenses"
  From cliente;
  
insert into cliente (codcli,nome) 
          (select codvend + 10, nome
          from vendedor
          where faixacomissao like 'A');
		  
select * from cliente order by codcli; 
select * from vendedor order by codvend; 

Update produto
Set valor = valor*1.025
Where valor < (select avg(valor) 
			   From produto
			   Where unidade = 'KG');
			   
select * from produto order by unidade; 

--Inserir antes do delete
insert into pedido values(100,10,'12/10/2020',4,null);

select * from pedido; 

delete from pedido P
where not exists (select nome
     		    from vendedor v
     		    where v.codvend = P.codvend);

-- Qual o resultado?

Select p.data 
from pedido p
where p.numped in 
       (select i.numped 
        from itenspedido i
        where i.codprod in 
               (select pr.codprod 
                from produto pr
                where descricao like 'Chocolate'))
-- Igual a: 
-- como reescrever a consulta usando JOIN?


-- Create table as

CREATE TABLE pedidoVendedor AS 
select p.numped, v.nome
from pedido p join vendedor v on p.codvend = v.codvend
where data < '12/12/2020'; 

Select * from pedidoVendedor;

insert into pedidoVendedor values(201, 'Bruno Assis');

create table vendedor1 as 
     select * from vendedor where 1=2;
select * from vendedor1;

-- AntiJOINs

SELECT c.nome, c.codcli 
FROM cliente c
WHERE c.codcli NOT IN 
		(SELECT p.codcli 
		 FROM pedido p) 
ORDER BY c.nome;

Select c.nome, c.codcli
from cliente c left join pedido p on c.codcli = p.codcli
where p.codcli is null
Order by c.nome;

Select c.nome, c.codcli as cliente, p.codcli as ClienteemPedido, numped
from cliente c left join pedido p on c.codcli = p.codcli
Order by c.nome;









