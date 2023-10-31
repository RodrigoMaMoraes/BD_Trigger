# BD_Trigger

## ETAPA 1
-- criação da tabela --
create table Pedido(
IDpedido int auto_increment primary key,
DataPedido datetime,
NomeCliente varchar(100)
);

insert into Pedido (DataPedido, NomeCliente) values 
(NOW(), 'CLIENTE1'),
(NOW(), 'CLIENTE2'),
(NOW(), 'CLIENTE3');

![FT1](https://github.com/RodrigoMaMoraes/BD_Trigger/blob/main/TRIGGER/R1TRIIGER01.PNG)

## ETAPA 2

DELIMITER $
create trigger RegistroDataCriacaoPedido
before insert on Pedido
for each row 
begin 

set New.DataPedido = now();
end;
$
DELIMITER ;

insert into Pedido (NomeCliente) values ('Maria');

select * FROM PEDIDO; 

![FT2](https://github.com/RodrigoMaMoraes/BD_Trigger/blob/main/TRIGGER/R1TRIGGER.PNG)

## PARTE 2

## ETAPA 3

create table Filmes(
id int  primary key auto_increment,
titulo varchar(100),
minutos int 
); 

delimiter $ 
create trigger chk_minutos before insert on filmes 
for each row 
begin
if new.minutos < 0 then 
set new.minutos = null;
end if;
end$

delimiter ;

insert into Filmes (titulo, minutos) values ('The terrible trigger', 120);
insert into Filmes (titulo, minutos) values ('O alto da campadecida', 135);
insert into Filmes (titulo, minutos) values ('Faroeste Caboclo', 240);
insert into Filmes (titulo, minutos) values ('The matrix', 90);
insert into Filmes (titulo, minutos) values ('Blade runner ', -88);
insert into Filmes (titulo, minutos) values ('O labirinto do fauno', 110);
insert into Filmes (titulo, minutos) values ('Metropole', 0);
insert into Filmes (titulo, minutos) values ('A lista', 120);

SELECT * FROM FILMES

![FT3](https://github.com/RodrigoMaMoraes/BD_Trigger/blob/main/TRIGGER/R2TRIGGERFILME.PNG)

delimiter $ 
create trigger chk_minutos before insert on Filmes
for each row 
begin
if new.minutos < 0 then 

signal sqlstate '45000'
set message_text = "Valor inváilido para minutos", 
mysql_errno = 2022; 

end if;
end$ 

delimiter ;

create table Log_deletion(
id  int  primary key  auto_increment,
titulo varchar(60),
quando datetime,
quem varchar(40)
);

delimiter $ 
create trigger Log_deletion after delete on Filmes 
for each row 
begin
insert into log_deletion values (null, old.titulo, sysdate(), user());
end$ 
delimiter ; 

delete from Filmes where id = 2;
delete from Filmes where id = 4;

select * from log_deletion;

![FT4](https://github.com/RodrigoMaMoraes/BD_Trigger/blob/main/TRIGGER/R4FILMES.PNG)
