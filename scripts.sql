-- CRIANDO AS TABELAS

CREATE TABLE clientes(
    idCliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE,
    telefone TEXT
);

CREATE TABLE pedidos(
    idPedidos INTEGER PRIMARY KEY AUTOINCREMENT,
    id_Cliente INTEGER,
    data_pedido TEXT,
    valor_total REAL,
    FOREIGN KEY (id_Cliente) REFERENCES clientes(idCliente)
);

-- INSERINDO DADOS NAS MESMAS

INSERT INTO clientes(nome, email, telefone)
VALUES('João Silva', 'joaosilva@email.com', '10101010101'),
('Michel Habib', 'michelhabib@email.com', '131313131313'),
('Ana Machado', 'anamachado@email.com', '11111111111');

INSERT INTO pedidos(id_Cliente, data_pedido, valor_total)
VALUES(2, '10-09-2024', 8000.00),
(2, '23-06-2024', 25.90),
(3, '01-01-2025', 80000.00);

-- IMPRIMINDO AS TABELAS SEPARADAMENTE

SELECT * FROM clientes;
SELECT * FROM pedidos;

-- IMPRIMINDO AS TABELAS JUNTAS

SELECT c.idCliente, c.nome, c.email, c.telefone, p.idPedidos, p.id_Cliente, p.data_pedido, p.valor_total
FROM clientes c
LEFT JOIN pedidos p
    ON c.idCliente = p.id_Cliente;