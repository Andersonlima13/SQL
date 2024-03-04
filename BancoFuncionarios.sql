

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



insert into departamento values (default,'Informática','Sede');
insert into departamento values (default,'Pessoal','Sede');
insert into Empregado values (default,'Jõao', 'Guedes',current_date,'Analista de Sistemas Junior',3400.00,null,1);
insert into Empregado values (default,'José', 'Batista',current_date,'Analista de Sistemas Pleno',4200.00,1,1);
insert into Empregado values (default,'Ana Maria', 'Silva',current_date,'Analista de Sistemas Junior',3400.00,1,1);
insert into Empregado values (default,'Ricardo', 'Neves',current_date,'Analista de Sistemas Pleno',4200.00,2,1);
insert into Empregado values (default,'Valter', 'Moura',current_date,'Analista de Suporte Junior',3400.00,2,1);
insert into Empregado values (default,'Mariana','Oliveira',current_date,'Designer de Interface',4800.00,1,null);

select * from empregado; 