CREATE DATABASE sistema_pedidos;
SHOW DATABASES;
USE sistema_pedidos;

CREATE TABLE cliente(id_cliente int not null AUTO_INCREMENT, nome_cliente varchar(50) NOT NULL, telefone_cliente INT NOT NULL, PRIMARY KEY(id_cliente) );
CREATE TABLE produto (id_produto int not null AUTO_INCREMENT, nome_produto varchar(50) not null, preco_produto DECIMAL(10,2) NOT NULL, PRIMARY KEY(id_produto) );
CREATE TABLE pedido (id_pedido int not null AUTO_INCREMENT, data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP, status_pedido ENUM('Confirmado','Em preparo', 'Entregue', 'Cancelado') DEFAULT 'Confirmado', PRIMARY KEY (id_pedido), id_cliente INT NOT NULL, FOREIGN KEY(id_cliente)  REFERENCES cliente(id_cliente));
CREATE TABLE item_pedido (id_item_pedido INT NOT NULL AUTO_INCREMENT,  id_pedido int not null, id_produto int not NULL, quantidade_produto INT NOT NULL, PRIMARY KEY(id_item_pedido), FOREIGN KEY(id_pedido) REFERENCES pedido(id_pedido), FOREIGN KEY(id_produto) REFERENCES produto(id_produto));
ALTER TABLE cliente MODIFY telefone_cliente VARCHAR(30) NOT NULL;

INSERT INTO  cliente ( nome_cliente, telefone_cliente ) VALUES
     ('Charles Leclerc', '(11) 91234-5678)'), ('Max Verstappen', '(21) 99876-5432'), ('Lewis Hamilton', '(31) 98765-4321'), ('Oscar Piastri', '(61) 99123-4567')
;
select * from cliente;
INSERT INTO produto(nome_produto, preco_produto) VALUES ('Cheeseburger', 25.99), ('X-tudo', 32.99), ('Hamburger Vegetariano', 40), ('Porção de Batata Frita', 20.50),('Lata de Refrigerante', 6.50), ('Lata de suco', 8);
INSERT INTO  pedido ( status_pedido, id_cliente ) VALUES('Entregue', 1 ), ('Cancelado', 2), ('Em preparo', 3), ('Confirmado', 4);
INSERT INTO  pedido ( status_pedido, id_cliente ) VALUE('Em preparo',2);
# Mostrar o id dos clientes como o id de seu(s) respectivo(s) pedidos.
select cliente.nome_cliente, cliente.id_cliente, pedido.id_pedido from cliente JOIN pedido ON cliente.id_cliente = pedido.id_cliente;
DESCRIBE item_pedido;
SELECT * FROM produto;
INSERT INTO  item_pedido ( id_pedido, id_produto, quantidade_produto ) VALUES (2,1,1 ), (1, 1,1), (1,4,2), (1,5,1), (1,6,1),(2,2,1), (2,5,1), (5,1,1), (5,6,1),(3,3,2), (5,6,2), (4,1,1), (4,6,1) ;
# Listagem de pedidos como nome do cliente
SELECT cliente.nome_cliente, pedido.* from cliente join pedido on cliente.id_cliente = pedido.id_cliente;
# Listagem de itens de um pedido
SELECT produto.nome_produto, produto.preco_produto, item_pedido.quantidade_produto, item_pedido.id_pedido from produto join item_pedido on produto.id_produto = item_pedido.id_produto ORDER BY id_pedido ASC;
# Pedido com nome do cliente, status e valor total.
SELECT cliente.nome_cliente, pedido.id_pedido, pedido.status_pedido, SUM(produto.preco_produto * item_pedido.quantidade_produto) as total_pedido FROM cliente join pedido on cliente.id_cliente = pedido.id_cliente join item_pedido on item_pedido.id_pedido = pedido.id_pedido join produto on produto.id_produto = item_pedido.id_produto GROUP BY pedido.id_pedido, cliente.nome_cliente, pedido.status_pedido;
# Pedido com nome do cliente, itens e subtotal dos items
SELECT cliente.nome_cliente, pedido.id_pedido, item_pedido.id_produto, produto.nome_produto, item_pedido.quantidade_produto, (item_pedido.quantidade_produto * produto.preco_produto) as 'subtotal' from cliente join pedido on cliente.id_cliente = pedido.id_cliente join item_pedido on item_pedido.id_pedido = pedido.id_pedido join produto on item_pedido.id_produto = produto.id_produto ;




