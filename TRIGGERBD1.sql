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

SELECT * FROM PEDIDO


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