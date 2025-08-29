create database comercio;
use comercio;

create table cliente(
	idcliente int primary key auto_increment,
    nome varchar(30) not null,
    sexo enum ('M', 'F') not null,
    email varchar(50) unique,
    cpf varchar(15) unique
);

create table endereco(
	idendereco int primary key auto_increment,
    rua varchar(30) not null,
    bairro varchar(30) not null,
    cidade varchar(30) not null,
    estado char(2) not null,
    id_cliente int unique,
    foreign key (id_cliente)
    references cliente (idcliente)
);

create table telefone(
	idtelefone int primary key auto_increment,
    tipo enum('RES', 'COM', 'CEL') not null,
    numero varchar(10) not null,
    id_cliente int,
    foreign key (id_cliente)
    references cliente (idcliente)
);

insert into cliente values(null, 'Joao', 'M', 'joao@gmail.com', '76767587887');
insert into cliente values(null, 'Carlos', 'M', 'carlos@gmail.com', '72584671984');
insert into cliente values(null, 'Ana', 'F', 'ana@gmail.com', '54987584562');
insert into cliente values(null, 'Clara', 'F', 'clara@gmail.com', '45657123589');
insert into cliente values(null, 'George', 'M', 'george@gmail.com', '99456879215');
insert into cliente values(null, 'Celia', 'F', 'celia@gmail.com', '25887995632');

select * from cliente;

+-----------+--------+------+------------------+-------------+
| idcliente | nome   | sexo | email            | cpf         |
+-----------+--------+------+------------------+-------------+
|         1 | Joao   | M    | joao@gmail.com   | 76767587887 |
|         2 | Carlos | M    | carlos@gmail.com | 72584671984 |
|         3 | Ana    | F    | ana@gmail.com    | 54987584562 |
|         4 | Clara  | F    | clara@gmail.com  | 45657123589 |
|         5 | George | M    | george@gmail.com | 99456879215 |
|         6 | Celia  | F    | celia@gmail.com  | 25887995632 |
+-----------+--------+------+------------------+-------------+

desc endereco;

insert into endereco values(null, 'Rua da Bahia', 'Lourdes', 'Belo Horizonte', 'MG', 4);
insert into endereco values(null, 'Rua Figueiredo de Magalhâes', 'Copacabana', 'Rio de Janeiro', 'RJ', 1);
insert into endereco values(null, 'Rua da Bahia', 'Morumbi', 'Sao Paulo', 'SP', 3);
insert into endereco values(null, 'Rua Voluntarios da Patria', 'Botafogo', 'Rio de Janeiro', 'RJ', 2);
insert into endereco values(null, 'Rua Prof. Alfredo Colombo', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', 6);
insert into endereco values(null, 'Rua Nestor Gomes', 'Centro', 'Vitoria', 'ES', 5);

select * from endereco;

+------------+-----------------------------+-----------------+----------------+--------+------------+
| idendereco | rua                         | bairro          | cidade         | estado | id_cliente |
+------------+-----------------------------+-----------------+----------------+--------+------------+
|          1 | Rua da Bahia                | Lourdes         | Belo Horizonte | MG     |          4 |
|          2 | Rua Figueiredo de Magalhâes | Copacabana      | Rio de Janeiro | RJ     |          1 |
|          3 | Rua da Bahia                | Morumbi         | Sao Paulo      | SP     |          3 |
|          4 | Rua Voluntarios da Patria   | Botafogo        | Rio de Janeiro | RJ     |          2 |
|          5 | Rua Prof. Alfredo Colombo   | Barra da Tijuca | Rio de Janeiro | RJ     |          6 |
|          6 | Rua Nestor Gomes            | Centro          | Vitoria        | ES     |          5 |
+------------+-----------------------------+-----------------+----------------+--------+------------+

update endereco
set rua = 'Avenida Albert Einstein'
where id_cliente = 3;

desc telefone;

insert into telefone values(null, 'CEL', '945126749', 5);
insert into telefone values(null, 'RES', '45798542', 5);
insert into telefone values(null, 'CEL', '999393558', 1);
insert into telefone values(null, 'COM', '945678122', 2);
insert into telefone values(null, 'RES', '58746600', 1);
insert into telefone values(null, 'CEL', '985466697', 3);
insert into telefone values(null, 'CEL', '874512300', 3);
insert into telefone values(null, 'COM', '932975000', 1);
insert into telefone values(null, 'RES', '58799663', 5);
insert into telefone values(null, 'CEL', '998756410', 2);

select nome, sexo, bairro, cidade
from cliente
inner join endereco
on idcliente = id_cliente;

+--------+------+-----------------+----------------+
| nome   | sexo | bairro          | cidade         |
+--------+------+-----------------+----------------+
| Joao   | M    | Copacabana      | Rio de Janeiro |
| Carlos | M    | Botafogo        | Rio de Janeiro |
| Ana    | F    | Morumbi         | Sao Paulo      |
| Clara  | F    | Lourdes         | Belo Horizonte |
| George | M    | Centro          | Vitoria        |
| Celia  | F    | Barra da Tijuca | Rio de Janeiro |
+--------+------+-----------------+----------------+

select nome, sexo, bairro, cidade /*PROJEÇÂO*/
from cliente /*ORIGEM*/
    inner join endereco /*JUNÇÂO*/
    on idcliente = id_cliente /*JUNÇÂO*/
where sexo = 'F' /*SELEÇÃO*/

+-------+------+-----------------+----------------+
| nome  | sexo | bairro          | cidade         |
+-------+------+-----------------+----------------+
| Ana   | F    | Morumbi         | Sao Paulo      |
| Clara | F    | Lourdes         | Belo Horizonte |
| Celia | F    | Barra da Tijuca | Rio de Janeiro |
+-------+------+-----------------+----------------+

/*NOME, SEXO, EMAIL, TIPO, NUMERO*/

select nome, sexo, email, tipo, numero
from cliente
    inner join telefone
    on idcliente = id_cliente;

+--------+------+------------------+------+-----------+
| nome   | sexo | email            | tipo | numero    |
+--------+------+------------------+------+-----------+
| Joao   | M    | joao@gmail.com   | CEL  | 999393558 |
| Joao   | M    | joao@gmail.com   | RES  | 58746600  |
| Joao   | M    | joao@gmail.com   | COM  | 932975000 |
| Carlos | M    | carlos@gmail.com | COM  | 945678122 |
| Carlos | M    | carlos@gmail.com | CEL  | 998756410 |
| Ana    | F    | ana@gmail.com    | CEL  | 985466697 |
| Ana    | F    | ana@gmail.com    | CEL  | 874512300 |
| George | M    | george@gmail.com | CEL  | 945126749 |
| George | M    | george@gmail.com | RES  | 45798542  |
| George | M    | george@gmail.com | RES  | 58799663  |
+--------+------+------------------+------+-----------+

/*NOME, SEXO, BAIRRO, CIDADE, TIPO, NUMERO*/

select cliente.nome, cliente.sexo, endereco.bairro, endereco.cidade, telefone.tipo, telefone.numero
from cliente
inner join endereco
    on cliente.idcliente = endereco.id_cliente
inner join telefone
    on cliente.idcliente = telefone.id_cliente;

+--------+------+------------+----------------+------+-----------+
| nome   | sexo | bairro     | cidade         | tipo | numero    |
+--------+------+------------+----------------+------+-----------+
| Joao   | M    | Copacabana | Rio de Janeiro | CEL  | 999393558 |
| Joao   | M    | Copacabana | Rio de Janeiro | RES  | 58746600  |
| Joao   | M    | Copacabana | Rio de Janeiro | COM  | 932975000 |
| Carlos | M    | Botafogo   | Rio de Janeiro | COM  | 945678122 |
| Carlos | M    | Botafogo   | Rio de Janeiro | CEL  | 998756410 |
| Ana    | F    | Morumbi    | Sao Paulo      | CEL  | 985466697 |
| Ana    | F    | Morumbi    | Sao Paulo      | CEL  | 874512300 |
| George | M    | Centro     | Vitoria        | CEL  | 945126749 |
| George | M    | Centro     | Vitoria        | RES  | 45798542  |
| George | M    | Centro     | Vitoria        | RES  | 58799663  |
+--------+------+------------+----------------+------+-----------+

select c.nome, c.sexo, e.bairro, e.cidade, t.tipo, t.numero
from cliente c
inner join endereco e
    on c.idcliente = e.id_cliente
inner join telefone t
    on c.idcliente = t.id_cliente;


CREATE TABLE PRODUTO(
    IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
    NOME_PRODUTO VARCHAR(30) NOT NULL,
    PRECO INT,
    FRETE FLOAT(10,2) NOT NULL
);

/* ALTER TABLE */

/* ALTERANDO O NOME DE UMA COLUNA - CHANGE */

ALTER TABLE PRODUTO
CHANGE PRECO VALOR_UNITARIO INT NOT NULL;

DESC PRODUTO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int(11)     | NO   |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

ALTER TABLE PRODUTO
CHANGE VALOR_UNITARIO VALOR_UNITARIO INT;

DESC PRODUTO;

+----------------+-------------+------+-----+---------+----------------+
| Field          | Type        | Null | Key | Default | Extra          |
+----------------+-------------+------+-----+---------+----------------+
| IDPRODUTO      | int(11)     | NO   | PRI | NULL    | auto_increment |
| NOME_PRODUTO   | varchar(30) | NO   |     | NULL    |                |
| VALOR_UNITARIO | int(11)     | YES  |     | NULL    |                |
| FRETE          | float(10,2) | NO   |     | NULL    |                |
+----------------+-------------+------+-----+---------+----------------+

/* MODIFY - ALTERANDO O TIPO */

ALTER TABLE PRODUTO
MODIFY VALOR_UNITARIO VARCHAR(50) NOT NULL;

/* ADICIONANDO COLUNAS */

ALTER TABLE PRODUTO
ADD PESO FLOAT(10,2) NOT NULL;

/* APAGANDO UMA COLUNA */

ALTER TABLE PRODUTO
DROP COLUMN PESO;

/* ADICIONANDO UMA COLUNA NA ORDEM ESPECIFICA */

ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10,2) NOT NULL
AFTER NOME_PRODUTO;

ALTER TABLE PRODUTO
DROP COLUMN PESO;

ALTER TABLE PRODUTO
ADD COLUMN PESO FLOAT(10,2) NOT NULL
FIRST;

insert into cliente values(null, 'Paula', 'F', 'paula@gmail.com', '77845612501');
insert into endereco values(null, 'Rua Walter Guimaraes Figueiredo', 'Buritis', 'Belo Horizonte', 'MG', 7);

/* RELATORIO GERAL DE TODOS OS CLIENTES */

 select * from cliente;
+-----------+---------+------+-------------------+-------------+
| idcliente | nome    | sexo | email             | cpf         |
+-----------+---------+------+-------------------+-------------+
|         1 | Joao    | M    | joao@gmail.com    | 76767587887 |
|         2 | Carlos  | M    | carlos@gmail.com  | 72584671984 |
|         3 | Ana     | F    | ana@gmail.com     | 54987584562 |
|         4 | Clara   | F    | clara@gmail.com   | 45657123589 |
|         5 | George  | M    | george@gmail.com  | 99456879215 |
|         6 | Celia   | F    | celia@gmail.com   | 25887995632 |
|         7 | Paula   | F    | paula@gmail.com   | 77845612501 |
|         8 | FLAVIO  | M    | FLAVIO@IG.COM     | 4657765     |
|         9 | ANDRE   | M    | ANDRE@GLOBO.COM   | 7687567     |
|        10 | GIOVANA | F    | NULL              | 0876655     |
|        11 | KARLA   | M    | KARLA@GMAIL.COM   | 545676778   |
|        12 | DANIELE | M    | DANIELE@GMAIL.COM | 43536789    |
|        13 | LORENA  | M    | NULL              | 774557887   |
|        14 | EDUARDO | M    | NULL              | 54376457    |
|        15 | ANTONIO | F    | ANTONIO@IG.COM    | 12436767    |
|        16 | ANTONIO | M    | ANTONIO@UOL.COM   | 3423565     |
|        17 | ELAINE  | M    | ELAINE@GLOBO.COM  | 32567763    |
|        18 | CARMEM  | M    | CARMEM@IG.COM     | 787832213   |
|        19 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942    |
|        20 | JOICE   | F    | JOICE@GMAIL.COM   | 55412256    |
+-----------+---------+------+-------------------+-------------+

/* RELATORIO GERAL DE TODOS OS CLIENTES (TELEFONE E ENDERECO) */

select c.idcliente, c.nome, c.sexo, c.email, c.cpf, e.rua, e.bairro, e.cidade, e.estado, t.tipo, t.numero
from cliente c
inner join endereco e
    on c.idcliente = e.id_cliente
inner join telefone t
    on c.idcliente = t.id_cliente;

+-----------+---------+------+-------------------+-------------+-----------------------------+------------+----------------+--------+------+-----------+
| idcliente | nome    | sexo | email             | cpf         | rua                         | bairro     | cidade         | estado | tipo | numero    |
+-----------+---------+------+-------------------+-------------+-----------------------------+------------+----------------+--------+------+-----------+
|         5 | George  | M    | george@gmail.com  | 99456879215 | Rua Nestor Gomes            | Centro     | Vitoria        | ES     | CEL  | 945126749 |
|         5 | George  | M    | george@gmail.com  | 99456879215 | Rua Nestor Gomes            | Centro     | Vitoria        | ES     | RES  | 45798542  |
|         1 | Joao    | M    | joao@gmail.com    | 76767587887 | Rua Figueiredo de Magalhâes | Copacabana | Rio de Janeiro | RJ     | CEL  | 999393558 |
|         2 | Carlos  | M    | carlos@gmail.com  | 72584671984 | Rua Voluntarios da Patria   | Botafogo   | Rio de Janeiro | RJ     | COM  | 945678122 |
|         1 | Joao    | M    | joao@gmail.com    | 76767587887 | Rua Figueiredo de Magalhâes | Copacabana | Rio de Janeiro | RJ     | RES  | 58746600  |
|         3 | Ana     | F    | ana@gmail.com     | 54987584562 | Avenida Albert Einstein     | Morumbi    | Sao Paulo      | SP     | CEL  | 985466697 |
|         3 | Ana     | F    | ana@gmail.com     | 54987584562 | Avenida Albert Einstein     | Morumbi    | Sao Paulo      | SP     | CEL  | 874512300 |
|         1 | Joao    | M    | joao@gmail.com    | 76767587887 | Rua Figueiredo de Magalhâes | Copacabana | Rio de Janeiro | RJ     | COM  | 932975000 |
|         5 | George  | M    | george@gmail.com  | 99456879215 | Rua Nestor Gomes            | Centro     | Vitoria        | ES     | RES  | 58799663  |
|         2 | Carlos  | M    | carlos@gmail.com  | 72584671984 | Rua Voluntarios da Patria   | Botafogo   | Rio de Janeiro | RJ     | CEL  | 998756410 |
|         9 | ANDRE   | M    | ANDRE@GLOBO.COM   | 7687567     | RUA GUEDES                  | CASCADURA  | B. HORIZONTE   | MG     | RES  | 68976565  |
|         9 | ANDRE   | M    | ANDRE@GLOBO.COM   | 7687567     | RUA GUEDES                  | CASCADURA  | B. HORIZONTE   | MG     | CEL  | 99656675  |
|        11 | KARLA   | F    | KARLA@GMAIL.COM   | 545676778   | RUA VISCONDESSA             | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 33567765  |
|        11 | KARLA   | F    | KARLA@GMAIL.COM   | 545676778   | RUA VISCONDESSA             | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 88668786  |
|        11 | KARLA   | F    | KARLA@GMAIL.COM   | 545676778   | RUA VISCONDESSA             | CENTRO     | RIO DE JANEIRO | RJ     | COM  | 55689654  |
|        12 | DANIELE | F    | DANIELE@GMAIL.COM | 43536789    | RUA NELSON MANDELA          | COPACABANA | RIO DE JANEIRO | RJ     | COM  | 88687979  |
|        13 | LORENA  | F    | NULL              | 774557887   | RUA ARAUJO LIMA             | CENTRO     | VITORIA        | ES     | COM  | 88965676  |
|        15 | ANTONIO | M    | ANTONIO@IG.COM    | 12436767    | AV CAPITAO ANTUNES          | CENTRO     | CURITIBA       | PR     | CEL  | 89966809  |
|        16 | ANTONIO | M    | ANTONIO@UOL.COM   | 3423565     | AV CARLOS BARROSO           | JARDINS    | SAO PAULO      | SP     | COM  | 88679978  |
|        17 | ELAINE  | F    | ELAINE@GLOBO.COM  | 32567763    | ALAMEDA SAMPAIO             | BOM RETIRO | CURITIBA       | PR     | CEL  | 99655768  |
|        18 | CARMEM  | F    | CARMEM@IG.COM     | 787832213   | RUA DA LAPA                 | LAPA       | SAO PAULO      | SP     | RES  | 89955665  |
|        19 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942    | RUA GERONIMO                | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 77455786  |
|        19 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942    | RUA GERONIMO                | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 89766554  |
|        20 | JOICE   | F    | JOICE@GMAIL.COM   | 55412256    | RUA GOMES FREIRE            | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 77755785  |
|         8 | FLAVIO  | M    | FLAVIO@IG.COM     | 4657765     | RUA GOMES FREIRE            | CENTRO     | RIO DE JANEIRO | RJ     | COM  | 44522578  |
+-----------+---------+------+-------------------+-------------+-----------------------------+------------+----------------+--------+------+-----------+



/* RELATORIO DE HOMENS */

select c.idcliente, c.nome, c.sexo, c.email, c.cpf, e.rua, e.bairro, e.cidade, e.estado, t.tipo, t.numero
    -> from cliente c
    -> inner join endereco e
    ->     on c.idcliente = e.id_cliente
    -> inner join telefone t
    ->     on c.idcliente = t.id_cliente
    -> where sexo = 'M';
+-----------+---------+------+------------------+-------------+-----------------------------+------------+----------------+--------+------+-----------+
| idcliente | nome    | sexo | email            | cpf         | rua                         | bairro     | cidade         | estado | tipo | numero    |
+-----------+---------+------+------------------+-------------+-----------------------------+------------+----------------+--------+------+-----------+
|         1 | Joao    | M    | joao@gmail.com   | 76767587887 | Rua Figueiredo de Magalhâes | Copacabana | Rio de Janeiro | RJ     | CEL  | 999393558 |
|         1 | Joao    | M    | joao@gmail.com   | 76767587887 | Rua Figueiredo de Magalhâes | Copacabana | Rio de Janeiro | RJ     | RES  | 58746600  |
|         1 | Joao    | M    | joao@gmail.com   | 76767587887 | Rua Figueiredo de Magalhâes | Copacabana | Rio de Janeiro | RJ     | COM  | 932975000 |
|         2 | Carlos  | M    | carlos@gmail.com | 72584671984 | Rua Voluntarios da Patria   | Botafogo   | Rio de Janeiro | RJ     | COM  | 945678122 |
|         2 | Carlos  | M    | carlos@gmail.com | 72584671984 | Rua Voluntarios da Patria   | Botafogo   | Rio de Janeiro | RJ     | CEL  | 998756410 |
|         5 | George  | M    | george@gmail.com | 99456879215 | Rua Nestor Gomes            | Centro     | Vitoria        | ES     | CEL  | 945126749 |
|         5 | George  | M    | george@gmail.com | 99456879215 | Rua Nestor Gomes            | Centro     | Vitoria        | ES     | RES  | 45798542  |
|         5 | George  | M    | george@gmail.com | 99456879215 | Rua Nestor Gomes            | Centro     | Vitoria        | ES     | RES  | 58799663  |
|         8 | FLAVIO  | M    | FLAVIO@IG.COM    | 4657765     | RUA GOMES FREIRE            | CENTRO     | RIO DE JANEIRO | RJ     | COM  | 44522578  |
|         9 | ANDRE   | M    | ANDRE@GLOBO.COM  | 7687567     | RUA GUEDES                  | CASCADURA  | B. HORIZONTE   | MG     | RES  | 68976565  |
|         9 | ANDRE   | M    | ANDRE@GLOBO.COM  | 7687567     | RUA GUEDES                  | CASCADURA  | B. HORIZONTE   | MG     | CEL  | 99656675  |
|        15 | ANTONIO | M    | ANTONIO@IG.COM   | 12436767    | AV CAPITAO ANTUNES          | CENTRO     | CURITIBA       | PR     | CEL  | 89966809  |
|        16 | ANTONIO | M    | ANTONIO@UOL.COM  | 3423565     | AV CARLOS BARROSO           | JARDINS    | SAO PAULO      | SP     | COM  | 88679978  |
+-----------+---------+------+------------------+-------------+-----------------------------+------------+----------------+--------+------+-----------+


/* RELATORIO DE MULHERES */

select c.idcliente, c.nome, c.sexo, c.email, c.cpf, e.rua, e.bairro, e.cidade, e.estado, t.tipo, t.numero
    from cliente c
    inner join endereco e
        on c.idcliente = e.id_cliente
    inner join telefone t
        on c.idcliente = t.id_cliente
    where sexo = 'F';
+-----------+---------+------+-------------------+-------------+-------------------------+------------+----------------+--------+------+-----------+
| idcliente | nome    | sexo | email             | cpf         | rua                     | bairro     | cidade         | estado | tipo | numero    |
+-----------+---------+------+-------------------+-------------+-------------------------+------------+----------------+--------+------+-----------+
|         3 | Ana     | F    | ana@gmail.com     | 54987584562 | Avenida Albert Einstein | Morumbi    | Sao Paulo      | SP     | CEL  | 985466697 |
|         3 | Ana     | F    | ana@gmail.com     | 54987584562 | Avenida Albert Einstein | Morumbi    | Sao Paulo      | SP     | CEL  | 874512300 |
|        11 | KARLA   | F    | KARLA@GMAIL.COM   | 545676778   | RUA VISCONDESSA         | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 33567765  |
|        11 | KARLA   | F    | KARLA@GMAIL.COM   | 545676778   | RUA VISCONDESSA         | CENTRO     | RIO DE JANEIRO | RJ     | CEL  | 88668786  |
|        11 | KARLA   | F    | KARLA@GMAIL.COM   | 545676778   | RUA VISCONDESSA         | CENTRO     | RIO DE JANEIRO | RJ     | COM  | 55689654  |
|        12 | DANIELE | F    | DANIELE@GMAIL.COM | 43536789    | RUA NELSON MANDELA      | COPACABANA | RIO DE JANEIRO | RJ     | COM  | 88687979  |
|        13 | LORENA  | F    | NULL              | 774557887   | RUA ARAUJO LIMA         | CENTRO     | VITORIA        | ES     | COM  | 88965676  |
|        17 | ELAINE  | F    | ELAINE@GLOBO.COM  | 32567763    | ALAMEDA SAMPAIO         | BOM RETIRO | CURITIBA       | PR     | CEL  | 99655768  |
|        18 | CARMEM  | F    | CARMEM@IG.COM     | 787832213   | RUA DA LAPA             | LAPA       | SAO PAULO      | SP     | RES  | 89955665  |
|        19 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942    | RUA GERONIMO            | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 77455786  |
|        19 | ADRIANA | F    | ADRIANA@GMAIL.COM | 88556942    | RUA GERONIMO            | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 89766554  |
|        20 | JOICE   | F    | JOICE@GMAIL.COM   | 55412256    | RUA GOMES FREIRE        | CENTRO     | RIO DE JANEIRO | RJ     | RES  | 77755785  |
+-----------+---------+------+-------------------+-------------+-------------------------+------------+----------------+--------+------+-----------+

/* QUANTIDADE DE HOMENS E MULHERES */

select count(*) as quantidade, sexo
from cliente
group by sexo;
+------------+------+
| quantidade | sexo |
+------------+------+
|          8 | M    |
|         12 | F    |
+------------+------+

/* IDS E EMAIL DAS MULHERES QUE MOREM NO CENTRO DO RIO DE JANEIRO E 
NAO TENHAM CELULAR */

SELECT c.idcliente, c.email, c.nome, c.sexo, t.tipo, e.bairro, e.cidade
FROM cliente c
INNER JOIN telefone t ON c.idcliente = t.id_cliente
INNER JOIN endereco e ON c.idcliente = e.id_cliente
WHERE c.sexo = 'F'
AND e.bairro IN ('CENTRO', 'Centro')
AND e.cidade IN ('Rio de Janeiro', 'RIO DE JANEIRO')
and t.tipo in ('RES', 'COM');

+-----------+-------------------+---------+------+------+--------+----------------+
| idcliente | email             | nome    | sexo | tipo | bairro | cidade         |
+-----------+-------------------+---------+------+------+--------+----------------+
|        11 | KARLA@GMAIL.COM   | KARLA   | F    | COM  | CENTRO | RIO DE JANEIRO |
|        19 | ADRIANA@GMAIL.COM | ADRIANA | F    | RES  | CENTRO | RIO DE JANEIRO |
|        19 | ADRIANA@GMAIL.COM | ADRIANA | F    | RES  | CENTRO | RIO DE JANEIRO |
|        20 | JOICE@GMAIL.COM   | JOICE   | F    | RES  | CENTRO | RIO DE JANEIRO |
+-----------+-------------------+---------+------+------+--------+----------------+

SELECT c.idcliente, c.email
FROM cliente c
INNER JOIN telefone t ON c.idcliente = t.id_cliente
INNER JOIN endereco e ON c.idcliente = e.id_cliente
WHERE c.sexo = 'F'
AND e.bairro IN ('CENTRO', 'Centro')
AND e.cidade IN ('Rio de Janeiro', 'RIO DE JANEIRO')
and t.tipo in ('RES', 'COM');

+-----------+-------------------+
| idcliente | email             |
+-----------+-------------------+
|        11 | KARLA@GMAIL.COM   |
|        19 | ADRIANA@GMAIL.COM |
|        19 | ADRIANA@GMAIL.COM |
|        20 | JOICE@GMAIL.COM   |
+-----------+-------------------+

/*Essa relatório não dá para dizer que está correto, pois a cardinalidade do cliente com 
o telefone é de 1 para N, logo, algumas dessas clientes relatadas acima podem ter mais de um tipo de telefone. 
Nesse caso precisa fazer uma subquery, ou seja, um select dentro de outro*/




/* PARA UMA CAMPANHA DE MARKETING, O SETOR SOLICITOU UM
RELATÓRIO COM O NOME, EMAIL E TELEFONE CELULAR 
DOS CLIENTES QUE MORAM NO ESTADO DO RIO DE JANEIRO 
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATORIO PARA
O PROGRAMADOR */

select c.nome, c.email, t.numero as 'telefone celular'
from cliente c
inner join endereco e
    on c.idcliente = e.id_cliente
inner join telefone t
    on c.idcliente = t.id_cliente
where e.estado = 'RJ'
and t.tipo = 'CEL';

+--------+------------------+------------------+
| nome   | email            | telefone celular |
+--------+------------------+------------------+
| Joao   | joao@gmail.com   | 999393558        |
| Carlos | carlos@gmail.com | 998756410        |
| KARLA  | KARLA@GMAIL.COM  | 33567765         |
| KARLA  | KARLA@GMAIL.COM  | 88668786         |
+--------+------------------+------------------+


/* PARA UMA CAMPANHA DE PRODUTOS DE BELEZA, O COMERCIAL SOLICITOU UM
RELATÓRIO COM O NOME, EMAIL E TELEFONE CELULAR 
DAS MULHERES QUE MORAM NO ESTADO DE SÃO PAULO 
VOCÊ TERÁ QUE PASSAR A QUERY PARA GERAR O RELATORIO PARA
O PROGRAMADOR */

select c.nome, c.email, t.numero as 'telefone celular'
from cliente c
inner join endereco e
    on c.idcliente = e.id_cliente
inner join telefone t
    on c.idcliente = t.id_cliente
where c.sexo = 'F'
and t.tipo = 'CEL'
and e.estado = 'SP';

+------+---------------+------------------+
| nome | email         | telefone celular |
+------+---------------+------------------+
| Ana  | ana@gmail.com | 985466697        |
| Ana  | ana@gmail.com | 874512300        |
+------+---------------+------------------+


/*Função IFNULL()*/

select c.nome, ifnull(c.email, 'Nao cadastrou email') as email, e.estado, t.numero
from cliente c
inner join endereco e
    on c.idcliente = e.id_cliente
inner join telefone t
    on c.idcliente = t.id_cliente

/*VIEW*/

create view v_relatorio as
    select c.nome, c.sexo, ifnull(c.email, 'Nao cadastrou email') as email ,t.tipo, t.numero, e.bairro, e.cidade, e.estado
    from cliente c
    inner join endereco e
        on c.idcliente = e.id_cliente
    inner join telefone t
        on c.idcliente = t.id_cliente;

select * from relatorio;

+---------+------+---------------------+------+-----------+------------+----------------+--------+
| nome    | sexo | email               | tipo | numero    | bairro     | cidade         | estado |
+---------+------+---------------------+------+-----------+------------+----------------+--------+
| George  | M    | george@gmail.com    | CEL  | 945126749 | Centro     | Vitoria        | ES     |
| George  | M    | george@gmail.com    | RES  | 45798542  | Centro     | Vitoria        | ES     |
| Joao    | M    | joao@gmail.com      | CEL  | 999393558 | Copacabana | Rio de Janeiro | RJ     |
| Carlos  | M    | carlos@gmail.com    | COM  | 945678122 | Botafogo   | Rio de Janeiro | RJ     |
| Joao    | M    | joao@gmail.com      | RES  | 58746600  | Copacabana | Rio de Janeiro | RJ     |
| Ana     | F    | ana@gmail.com       | CEL  | 985466697 | Morumbi    | Sao Paulo      | SP     |
| Ana     | F    | ana@gmail.com       | CEL  | 874512300 | Morumbi    | Sao Paulo      | SP     |
| Joao    | M    | joao@gmail.com      | COM  | 932975000 | Copacabana | Rio de Janeiro | RJ     |
| George  | M    | george@gmail.com    | RES  | 58799663  | Centro     | Vitoria        | ES     |
| Carlos  | M    | carlos@gmail.com    | CEL  | 998756410 | Botafogo   | Rio de Janeiro | RJ     |
| ANDRE   | M    | ANDRE@GLOBO.COM     | RES  | 68976565  | CASCADURA  | B. HORIZONTE   | MG     |
| ANDRE   | M    | ANDRE@GLOBO.COM     | CEL  | 99656675  | CASCADURA  | B. HORIZONTE   | MG     |
| KARLA   | F    | KARLA@GMAIL.COM     | CEL  | 33567765  | CENTRO     | RIO DE JANEIRO | RJ     |
| KARLA   | F    | KARLA@GMAIL.COM     | CEL  | 88668786  | CENTRO     | RIO DE JANEIRO | RJ     |
| KARLA   | F    | KARLA@GMAIL.COM     | COM  | 55689654  | CENTRO     | RIO DE JANEIRO | RJ     |
| DANIELE | F    | DANIELE@GMAIL.COM   | COM  | 88687979  | COPACABANA | RIO DE JANEIRO | RJ     |
| LORENA  | F    | Nao cadastrou email | COM  | 88965676  | CENTRO     | VITORIA        | ES     |
| ANTONIO | M    | ANTONIO@IG.COM      | CEL  | 89966809  | CENTRO     | CURITIBA       | PR     |
| ANTONIO | M    | ANTONIO@UOL.COM     | COM  | 88679978  | JARDINS    | SAO PAULO      | SP     |
| ELAINE  | F    | ELAINE@GLOBO.COM    | CEL  | 99655768  | BOM RETIRO | CURITIBA       | PR     |
| CARMEM  | F    | CARMEM@IG.COM       | RES  | 89955665  | LAPA       | SAO PAULO      | SP     |
| ADRIANA | F    | ADRIANA@GMAIL.COM   | RES  | 77455786  | CENTRO     | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM   | RES  | 89766554  | CENTRO     | RIO DE JANEIRO | RJ     |
| JOICE   | F    | JOICE@GMAIL.COM     | RES  | 77755785  | CENTRO     | RIO DE JANEIRO | RJ     |
| FLAVIO  | M    | FLAVIO@IG.COM       | COM  | 44522578  | CENTRO     | RIO DE JANEIRO | RJ     |
+---------+------+---------------------+------+-----------+------------+----------------+--------+

status
/*Mostra o status do banco de dados*/

delimiter
/*Caracter delimitador do SQL. Por padrão é o ; */

/*Stored Procedures*/

delimiter $
create procedure nome()
begin
    qualquer programação;
end
$


delimiter $
create procedure nome_empresa()
begin
    select 'Tecnoverso' as empresa;
end
$

/*Chamando uma procedure*/

call nome_empresa()$
delimiter ;
call nome_empresa();

/*Chamada de procedure com parâmetros*/

delimiter $
create procedure conta(num1 int, num2 int)
begin
    select num1 + num2 as conta;
end
$

delimiter ;

call conta(1,1);
call conta(2,2);
call conta(4,4);
call conta(8,8);
call conta(16,16);
call conta(32,32);
call conta(64,64);
call conta(128,128);
call conta(256,256);
call conta(512,512);
call conta(1024,1024);

show databases;
+--------------------+
| Database           |
+--------------------+
| aula01             |
| cadastro           |
| comercio           |
| estoque            |
| exercicio          |
| information_schema |
| livraria           |
| mysql              |
| performance_schema |
| projeto            |
| sys                |
+--------------------+

drop database projeto;

create database projeto;
use projeto;

create table cursos(
    idcurso int primary key auto_increment,
    nome varchar(30) not null,
    horas int(3) not null,
    valor float(10,2) not null
);

insert into cursos values(null, 'Java', 30, 500.00);
insert into cursos values(null, 'Fundamentos de Bancos de Dados', 40, 700.00);

select * from cursos;

delimiter #

status

create procedure cad_curso(p_nome varchar(30), p_horas int(30), p_preco float(10,2))
begin
    insert into cursos values(null, p_nome, p_horas, p_preco);
end
#     

delimiter ;

call cad_curso('BI SQL Server', 35, 3000.00);
call cad_curso('Power BI', 20, 1000.00);
call cad_curso('Tableau', 30, 1200.00);

call cad_curso('Python', 100, 5000.00);
call cad_curso('Cloud Computing', 200, 10000.00);
call cad_curso('Calculo', 80, 900.00);

+---------+--------------------------------+-------+----------+
| idcurso | nome                           | horas | valor    |
+---------+--------------------------------+-------+----------+
|       1 | Java                           |    30 |   500.00 |
|       2 | Fundamentos de Bancos de Dados |    40 |   700.00 |
|       3 | BI SQL Server                  |    35 |  3000.00 |
|       4 | Power BI                       |    20 |  1000.00 |
|       5 | Tableau                        |    30 |  1200.00 |
|       6 | Python                         |   100 |  5000.00 |
|       7 | Cloud Computing                |   200 | 10000.00 |
|       8 | Calculo                        |    80 |   900.00 |
+---------+--------------------------------+-------+----------+

/*Criar uma procedure para consultar cursos*/

delimiter #

status

create procedure le_curso(p_idcurso int)
begin
    select nome, horas, valor
    from cursos
    where idcurso = p_idcurso;
end
#     

delimiter ;

call le_curso(7);

/*_______________________________________________________________________________________________________________________________________________________*/

/*Anotações aulas antigas*/

/*Passo 1: Criar as tabelas*/

create table cliente(
    idcliente int,
    nome varchar(30) not null
);

create table telefone(
    idtelefone int,
    tipo char(3) not null,
    numero varchar(10) not null,
    id_cliente int
);

/*Passo 2: Criar as constraints*/

alter table cliente add constraint pk_cliente
primary key(idcliente);

alter table telefone add constraint fk_cliente
foreign key(id_cliente) references cliente (idcliente);

show create table telefone;
/*Esse comando acima mostra uma descrição mais completa da tabela criada.
Com esse mesmo comando dá para notar o quão importante é criar as 
tabelas antes para depois criar as chaves*/

/*_______________________________________________________________________________________________________________________________________________________*/

/*Inserindo as tabelas da database oficina*/

create database oficina;
use oficina;

create table cliente(
    idcliente int primary key auto_increment,
    nome varchar(30) not null,
    sexo enum('M', 'F') not null,
    id_carro int unique    
);

create table telefone(
    idtelefone int primary key auto_increment,
    tipo enum('cel', 'res', 'com') not null,
    numero varchar(30) not null,
    id_cliente int
);

create table marca(
    idmarca int primary key auto_increment,
    marca varchar(30) unique
);

create table carro(
    idcarro int primary key auto_increment,
    modelo varchar(30) not null,
    placa varchar(30) not null unique,
    id_marca int
);

create table cor(
    idcor int primary key auto_increment,
    cor varchar(30) unique
);

create table carro_cor(
    id_carro int,
    id_cor int,
    primary key(id_carro, id_cor) 
);

/*Constraints*/

alter table telefone
add constraint fk_telefone_cliente
foreign key (id_cliente)
references cliente (idcliente);

alter table cliente
add constraint fk_cliente_carro
foreign key (id_carro)
references carro (idcarro);

alter table carro
add constraint fk_carro_marca
foreign key (id_marca)
references marca(idmarca);

alter table carro_cor
add constraint fk_cor
foreign key (id_cor)
references cor(idcor);

alter table carro_cor
add constraint fk_carro
foreign key (id_carro)
references carro(idcarro);

/*Preencher o banco com no mínimo 10 clientes*/

/*Marcas*/

insert into marca values(null, 'Fiat');
insert into marca values(null, 'Volkswagen');
insert into marca values(null, 'Chevrolet');
insert into marca values(null, 'Ford');
insert into marca values(null, 'Peugeot');
insert into marca values(null, 'Renault');
insert into marca values(null, 'Citroen');
insert into marca values(null, 'Hyundai');
insert into marca values(null, 'Honda');
insert into marca values(null, 'Toyota');
insert into marca values(null, 'Nissan');
insert into marca values(null, 'Audi');
insert into marca values(null, 'BMW');
insert into marca values(null, 'Mercedes');
insert into marca values(null, 'Mini');
insert into marca values(null, 'Mitsubishi');
insert into marca values(null, 'Jeep');
insert into marca values(null, 'Ram');
insert into marca values(null, 'Volvo');
insert into marca values(null, 'Kia');
insert into marca values(null, 'Caoa Chery');
insert into marca values(null, 'Porsche');
insert into marca values(null, 'Byd');
insert into marca values(null, 'Lexus');

+---------+------------+
| idmarca | marca      |
+---------+------------+
|       1 | Fiat       |
|       2 | Volkswagen |
|       3 | Chevrolet  |
|       4 | Ford       |
|       5 | Peugeot    |
|       6 | Renault    |
|       7 | Citroen    |
|       8 | Hyundai    |
|       9 | Honda      |
|      10 | Toyota     |
|      11 | Nissan     |
|      12 | Audi       |
|      13 | BMW        |
|      14 | Mercedes   |
|      15 | Mini       |
|      16 | Mitsubishi |
|      17 | Jeep       |
|      18 | Ram        |
|      19 | Volvo      |
|      20 | Kia        |
|      21 | Caoa Chery |
|      22 | Porsche    |
|      23 | Byd        |
|      24 | Lexus      |
+---------+------------+

/*Carros*/

insert into carro values(null, 'Polo', 'OSE-7E46', 2);
insert into carro values(null, 'Panamera', 'OSI-7Q26', 22);
insert into carro values(null, 'Argo', 'ISO-5O57', 1);
insert into carro values(null, 'Kwid', 'TGF-7R78', 6);
insert into carro values(null, 'Onix', 'SDF-7D45', 3);
insert into carro values(null, 'C4', 'SFD-5484', 7);
insert into carro values(null, 'R8', 'TUK-4562', 2);
insert into carro values(null, 'Hb20', 'DJG-4S74', 8);
insert into carro values(null, 'Ka', 'SSD-6G66', 4);
insert into carro values(null, 'Eco Sport', 'TUG-7745', 4);
insert into carro values(null, '1500 Laramie', 'TNB-4512', 18);
insert into carro values(null, 'Countryman', 'JOP-7Y46', 15);
insert into carro values(null, 'S10', 'EXO-9987', 3);
insert into carro values(null, '2008', 'DRU-2472', 5);
insert into carro values(null, 'Corolla', 'DEL-1T76', 10);
insert into carro values(null, 'Etios', 'JFK-8630', 10);
insert into carro values(null, 'Hrv', 'AKO-7410', 9);
insert into carro values(null, 'Sentra', 'GAY-9641', 11);
insert into carro values(null, 'Pulse', 'PUM-8J45', 1);
insert into carro values(null, 'T-cross', 'OLX-5974', 2);
insert into carro values(null, 'Compass', 'KIA-4555', 17);
insert into carro values(null, 'C180', 'SIA-4756', 14);
insert into carro values(null, 'X1', 'OXH-7456', 13);
insert into carro values(null, 'L200', 'GXC-0120', 16);
insert into carro values(null, 'Civic', 'UUI-0000', 9);
insert into carro values(null, 'Oroch', 'UAI-7462', 6);
insert into carro values(null, 'Gol', 'SOU-0574', 2);
insert into carro values(null, 'Punto', 'BHZ-9632', 1);
insert into carro values(null, 'Celta', 'MGS-7H10', 3);
insert into carro values(null, 'Mobi', 'OUI-8888', 1);
insert into carro values(null, 'Pajero', 'OSE-1461', 16);
insert into carro values(null, 'Renegade', 'OSE-7562', 17);
insert into carro values(null, 'Onix', 'OSE-8741', 3);
insert into carro values(null, 'Amarok', 'OLK-7W78', 2);
insert into carro values(null, 'Toro', 'TYE-6541', 1);
insert into carro values(null, 'Kicks', 'YES-0020', 11);
insert into carro values(null, 'Hb20', 'FGH-0O00', 8);
insert into carro values(null, 'Palio', 'FDP-8751', 1);
insert into carro values(null, 'Sandero', 'PQP-0150', 6);
insert into carro values(null, 'Parati', 'VNC-7R54', 2);
insert into carro values(null, 'Rampage', 'OSE-4624', 18);
insert into carro values(null, '911', 'ERT-7O41', 22);
insert into carro values(null, 'Argo', 'IIO-0054', 1);
insert into carro values(null, 'Polo', 'UIP-9846', 2);
insert into carro values(null, 'Spin', 'PST-4821', 3);
insert into carro values(null, 'Duster', 'PTE-4665', 6);
insert into carro values(null, 'A3', 'OSF-4410', 12);
insert into carro values(null, 'Fusion', 'CRG-4A00', 4);
insert into carro values(null, 'Fiesta', 'MPX-5412', 4);
insert into carro values(null, 'Captur', 'YUI-7896', 6);
insert into carro values(null, '208', 'LOU-4562', 5);
insert into carro values(null, 'C3', 'LOL-3692', 7);
insert into carro values(null, 'Tida', 'CAD-3E69', 11);
insert into carro values(null, 'Hilux', 'ONC-8I41', 10);
insert into carro values(null, 'Xc60', 'ONG-8564', 19);
insert into carro values(null, 'Sw4', 'FFF-7412', 10);
insert into carro values(null, 'Onix', 'TYI-2580', 3);
insert into carro values(null, 'Ka', 'SFX-0O78', 4);
insert into carro values(null, 'Gol', 'FGR-5469', 2);
insert into carro values(null, 'Duster', 'GGH-0014', 6);
insert into carro values(null, 'Pulse', 'XXX-1E46', 1);

 select m.marca, c.modelo, c.id_marca
 from carro c
 inner join marca m
     on c.id_marca = m.idmarca
 order by c.id_marca;

+------------+--------------+----------+
| marca      | modelo       | id_marca |
+------------+--------------+----------+
| Fiat       | Mobi         |        1 |
| Fiat       | Argo         |        1 |
| Fiat       | Pulse        |        1 |
| Fiat       | Punto        |        1 |
| Fiat       | Toro         |        1 |
| Fiat       | Palio        |        1 |
| Fiat       | Argo         |        1 |
| Fiat       | Pulse        |        1 |
| Volkswagen | Amarok       |        2 |
| Volkswagen | Gol          |        2 |
| Volkswagen | T-cross      |        2 |
| Volkswagen | Polo         |        2 |
| Volkswagen | Gol          |        2 |
| Volkswagen | Polo         |        2 |
| Volkswagen | Parati       |        2 |
| Chevrolet  | Onix         |        3 |
| Chevrolet  | S10          |        3 |
| Chevrolet  | Celta        |        3 |
| Chevrolet  | Onix         |        3 |
| Chevrolet  | Spin         |        3 |
| Chevrolet  | Onix         |        3 |
| Ford       | Ka           |        4 |
| Ford       | Eco Sport    |        4 |
| Ford       | Fusion       |        4 |
| Ford       | Fiesta       |        4 |
| Ford       | Ka           |        4 |
| Peugeot    | 2008         |        5 |
| Peugeot    | 208          |        5 |
| Renault    | Oroch        |        6 |
| Renault    | Duster       |        6 |
| Renault    | Duster       |        6 |
| Renault    | Captur       |        6 |
| Renault    | Sandero      |        6 |
| Renault    | Kwid         |        6 |
| Citroen    | C4           |        7 |
| Citroen    | C3           |        7 |
| Hyundai    | Hb20         |        8 |
| Hyundai    | Hb20         |        8 |
| Honda      | Civic        |        9 |
| Honda      | Hrv          |        9 |
| Toyota     | Sw4          |       10 |
| Toyota     | Hilux        |       10 |
| Toyota     | Etios        |       10 |
| Toyota     | Corolla      |       10 |
| Nissan     | Sentra       |       11 |
| Nissan     | Kicks        |       11 |
| Nissan     | Tida         |       11 |
| Audi       | A3           |       12 |
| Audi       | R8           |       12 |
| BMW        | X1           |       13 |
| Mercedes   | C180         |       14 |
| Mini       | Countryman   |       15 |
| Mitsubishi | Pajero       |       16 |
| Mitsubishi | L200         |       16 |
| Jeep       | Compass      |       17 |
| Jeep       | Renegade     |       17 |
| Ram        | Rampage      |       18 |
| Ram        | 1500 Laramie |       18 |
| Volvo      | Xc60         |       19 |
| Porsche    | Panamera     |       22 |
| Porsche    | 911          |       22 |
+------------+--------------+----------+

 select m.marca, c.modelo, c.id_marca, c.idcarro
 from carro c
 inner join marca m
     on c.id_marca = m.idmarca
 order by c.idcarro;

+------------+--------------+----------+---------+
| marca      | modelo       | id_marca | idcarro |
+------------+--------------+----------+---------+
| Volkswagen | Polo         |        2 |      62 |
| Porsche    | Panamera     |       22 |      63 |
| Fiat       | Argo         |        1 |      64 |
| Renault    | Kwid         |        6 |      65 |
| Chevrolet  | Onix         |        3 |      66 |
| Citroen    | C4           |        7 |      67 |
| Audi       | R8           |       12 |      68 |
| Hyundai    | Hb20         |        8 |      69 |
| Ford       | Ka           |        4 |      70 |
| Ford       | Eco Sport    |        4 |      71 |
| Ram        | 1500 Laramie |       18 |      72 |
| Mini       | Countryman   |       15 |      73 |
| Chevrolet  | S10          |        3 |      74 |
| Peugeot    | 2008         |        5 |      75 |
| Toyota     | Corolla      |       10 |      76 |
| Toyota     | Etios        |       10 |      77 |
| Honda      | Hrv          |        9 |      78 |
| Nissan     | Sentra       |       11 |      79 |
| Fiat       | Pulse        |        1 |      80 |
| Volkswagen | T-cross      |        2 |      81 |
| Jeep       | Compass      |       17 |      82 |
| Mercedes   | C180         |       14 |      83 |
| BMW        | X1           |       13 |      84 |
| Mitsubishi | L200         |       16 |      85 |
| Honda      | Civic        |        9 |      86 |
| Renault    | Oroch        |        6 |      87 |
| Volkswagen | Gol          |        2 |      88 |
| Fiat       | Punto        |        1 |      89 |
| Chevrolet  | Celta        |        3 |      90 |
| Fiat       | Mobi         |        1 |      91 |
| Mitsubishi | Pajero       |       16 |      92 |
| Jeep       | Renegade     |       17 |      93 |
| Chevrolet  | Onix         |        3 |      94 |
| Volkswagen | Amarok       |        2 |      95 |
| Fiat       | Toro         |        1 |      96 |
| Nissan     | Kicks        |       11 |      97 |
| Hyundai    | Hb20         |        8 |      98 |
| Fiat       | Palio        |        1 |      99 |
| Renault    | Sandero      |        6 |     100 |
| Volkswagen | Parati       |        2 |     101 |
| Ram        | Rampage      |       18 |     102 |
| Porsche    | 911          |       22 |     103 |
| Fiat       | Argo         |        1 |     104 |
| Volkswagen | Polo         |        2 |     105 |
| Chevrolet  | Spin         |        3 |     106 |
| Renault    | Duster       |        6 |     107 |
| Audi       | A3           |       12 |     108 |
| Ford       | Fusion       |        4 |     109 |
| Ford       | Fiesta       |        4 |     110 |
| Renault    | Captur       |        6 |     111 |
| Peugeot    | 208          |        5 |     112 |
| Citroen    | C3           |        7 |     113 |
| Nissan     | Tida         |       11 |     114 |
| Toyota     | Hilux        |       10 |     115 |
| Volvo      | Xc60         |       19 |     116 |
| Toyota     | Sw4          |       10 |     117 |
| Chevrolet  | Onix         |        3 |     118 |
| Ford       | Ka           |        4 |     119 |
| Volkswagen | Gol          |        2 |     120 |
| Renault    | Duster       |        6 |     121 |
| Fiat       | Pulse        |        1 |     122 |
+------------+--------------+----------+---------+

select c.idcarro
 from carro c
 inner join marca m
     on c.id_marca = m.idmarca
 order by c.idcarro;




insert into cliente value(null, 'Joao Victor', 'M', 62);
insert into cliente value(null, 'Joao', 'M', 63);
insert into cliente value(null, 'Lucas', 'M', 64);
insert into cliente value(null, 'Joao Paulo', 'M', 65);
insert into cliente value(null, 'Joao Luiz', 'M', 66);
insert into cliente value(null, 'Joao Guilherme', 'M', 67);
insert into cliente value(null, 'Joao Carlos', 'M', 68);
insert into cliente value(null, 'Joao Pedro', 'M', 69);
insert into cliente value(null, 'Joao Paulo', 'M', 70);
insert into cliente value(null, 'Joao Miguel', 'M', 71);
insert into cliente value(null, 'Fernanda', 'F', 72);
insert into cliente value(null, 'Luana', 'F', 73);
insert into cliente value(null, 'Joana', 'F', 74);
insert into cliente value(null, 'Celia', 'F', 75);
insert into cliente value(null, 'Nilda', 'F', 76);
insert into cliente value(null, 'Laura', 'F', 77);
insert into cliente value(null, 'Lara', 'F', 78);
insert into cliente value(null, 'Julia', 'F', 79);
insert into cliente value(null, 'Juliana', 'F', 80);
insert into cliente value(null, 'Sophia', 'F', 81);
insert into cliente value(null, 'Carlos Maia', 'M', 82);
insert into cliente value(null, 'Carlos Victor', 'M', 83);
insert into cliente value(null, 'Carlos Emanuel', 'M', 84);
insert into cliente value(null, 'Pedro', 'M', 85);
insert into cliente value(null, 'Henrique', 'M', 86);
insert into cliente value(null, 'Marcos', 'M', 87);
insert into cliente value(null, 'Ronaldo', 'M', 88);
insert into cliente value(null, 'Ivan', 'M', 89);
insert into cliente value(null, 'Carlos Emanuel', 'M', 90);
insert into cliente value(null, 'Maria Clara', 'F', 91);
insert into cliente value(null, 'Maria Eduarda', 'F', 92);
insert into cliente value(null, 'Maria Fernanda', 'F', 93);
insert into cliente value(null, 'Maria Julia', 'F', 94);
insert into cliente value(null, 'Mariana', 'F', 95);
insert into cliente value(null, 'Marina', 'F', 96);
insert into cliente value(null, 'Maria Fernanda', 'F', 97);
insert into cliente value(null, 'Maria Clara', 'F', 98);
insert into cliente value(null, 'Maria Eduarda', 'F', 99);
insert into cliente value(null, 'Luiz Carlos', 'M', 100);
insert into cliente value(null, 'Luiz Henrique', 'M', 101);
insert into cliente value(null, 'Luiz Claudio', 'M', 102);
insert into cliente value(null, 'Luiz Antonio', 'M', 103);
insert into cliente value(null, 'Joao Luiz', 'M', 104);
insert into cliente value(null, 'Luiz Guilherme', 'M', 105);
insert into cliente value(null, 'Luiz Castro', 'M', 106);
insert into cliente value(null, 'Luiz Eduardo', 'M', 107);
insert into cliente value(null, 'Luiz Fernando', 'M', 108);
insert into cliente value(null, 'Ana Maria', 'F', 109);
insert into cliente value(null, 'Ana Clara', 'F', 110);
insert into cliente value(null, 'Ana Camila', 'F', 111);
insert into cliente value(null, 'Ana Cecilia', 'F', 112);
insert into cliente value(null, 'Ana Claudia', 'F', 113);
insert into cliente value(null, 'Ana Julia', 'F', 114);
insert into cliente value(null, 'Ana Laura', 'F', 115);
insert into cliente value(null, 'Ana Beatriz', 'F', 116);
insert into cliente value(null, 'Ana Julia', 'F', 117);
insert into cliente value(null, 'Ana Paula', 'F', 118);
insert into cliente value(null, 'Ana Carolina', 'F', 119);
insert into cliente value(null, 'Ana Clara', 'F', 120);
insert into cliente value(null, 'Ana Carolina', 'F', 121);
insert into cliente value(null, 'Ana Livia', 'F', 122);

select cl.nome, m.marca, cr.modelo
from carro cr
inner join marca m 
    on cr.id_marca = m.idmarca
inner join cliente cl
    on cr.idcarro = cl.id_carro;

    +----------------+------------+--------------+
| nome           | marca      | modelo       |
+----------------+------------+--------------+
| Joao Carlos    | Audi       | R8           |
| Luiz Fernando  | Audi       | A3           |
| Carlos Emanuel | BMW        | X1           |
| Joao Luiz      | Chevrolet  | Onix         |
| Joana          | Chevrolet  | S10          |
| Carlos Emanuel | Chevrolet  | Celta        |
| Maria Julia    | Chevrolet  | Onix         |
| Luiz Castro    | Chevrolet  | Spin         |
| Ana Paula      | Chevrolet  | Onix         |
| Joao Guilherme | Citroen    | C4           |
| Ana Claudia    | Citroen    | C3           |
| Joao           | Fiat       | Argo         |
| Juliana        | Fiat       | Pulse        |
| Ivan           | Fiat       | Punto        |
| Maria Clara    | Fiat       | Mobi         |
| Marina         | Fiat       | Toro         |
| Maria Eduarda  | Fiat       | Palio        |
| Joao Luiz      | Fiat       | Argo         |
| Ana Livia      | Fiat       | Pulse        |
| Joao Paulo     | Ford       | Ka           |
| Joao Miguel    | Ford       | Eco Sport    |
| Ana Maria      | Ford       | Fusion       |
| Ana Clara      | Ford       | Fiesta       |
| Ana Carolina   | Ford       | Ka           |
| Lara           | Honda      | Hrv          |
| Henrique       | Honda      | Civic        |
| Joao Pedro     | Hyundai    | Hb20         |
| Maria Clara    | Hyundai    | Hb20         |
| Carlos Maia    | Jeep       | Compass      |
| Maria Fernanda | Jeep       | Renegade     |
| Carlos Victor  | Mercedes   | C180         |
| Luana          | Mini       | Countryman   |
| Pedro          | Mitsubishi | L200         |
| Maria Eduarda  | Mitsubishi | Pajero       |
| Julia          | Nissan     | Sentra       |
| Maria Fernanda | Nissan     | Kicks        |
| Ana Julia      | Nissan     | Tida         |
| Celia          | Peugeot    | 2008         |
| Ana Cecilia    | Peugeot    | 208          |
| Luiz Antonio   | Porsche    | 911          |
| Fernanda       | Ram        | 1500 Laramie |
| Luiz Claudio   | Ram        | Rampage      |
| Joao Paulo     | Renault    | Kwid         |
| Marcos         | Renault    | Oroch        |
| Luiz Carlos    | Renault    | Sandero      |
| Luiz Eduardo   | Renault    | Duster       |
| Ana Camila     | Renault    | Captur       |
| Ana Carolina   | Renault    | Duster       |
| Nilda          | Toyota     | Corolla      |
| Laura          | Toyota     | Etios        |
| Ana Laura      | Toyota     | Hilux        |
| Ana Julia      | Toyota     | Sw4          |
| Sophia         | Volkswagen | T-cross      |
| Ronaldo        | Volkswagen | Gol          |
| Mariana        | Volkswagen | Amarok       |
| Luiz Henrique  | Volkswagen | Parati       |
| Luiz Guilherme | Volkswagen | Polo         |
| Ana Clara      | Volkswagen | Gol          |
| Ana Beatriz    | Volvo      | Xc60         |
+----------------+------------+--------------+

select cl.nome, cl.sexo, m.marca, cr.modelo
from carro cr
inner join marca m 
    on cr.id_marca = m.idmarca
inner join cliente cl
    on cr.idcarro = cl.id_carro;


+----------------+------+------------+--------------+
| nome           | sexo | marca      | modelo       |
+----------------+------+------------+--------------+
| Joao Carlos    | M    | Audi       | R8           |
| Luiz Fernando  | M    | Audi       | A3           |
| Carlos Emanuel | M    | BMW        | X1           |
| Joao Luiz      | M    | Chevrolet  | Onix         |
| Joana          | F    | Chevrolet  | S10          |
| Carlos Emanuel | M    | Chevrolet  | Celta        |
| Maria Julia    | F    | Chevrolet  | Onix         |
| Luiz Castro    | M    | Chevrolet  | Spin         |
| Ana Paula      | F    | Chevrolet  | Onix         |
| Joao Guilherme | M    | Citroen    | C4           |
| Ana Claudia    | F    | Citroen    | C3           |
| Lucas          | M    | Fiat       | Argo         |
| Juliana        | F    | Fiat       | Pulse        |
| Ivan           | M    | Fiat       | Punto        |
| Maria Clara    | F    | Fiat       | Mobi         |
| Marina         | F    | Fiat       | Toro         |
| Maria Eduarda  | F    | Fiat       | Palio        |
| Joao Luiz      | M    | Fiat       | Argo         |
| Ana Livia      | F    | Fiat       | Pulse        |
| Joao Paulo     | M    | Ford       | Ka           |
| Joao Miguel    | M    | Ford       | Eco Sport    |
| Ana Maria      | F    | Ford       | Fusion       |
| Ana Clara      | F    | Ford       | Fiesta       |
| Ana Carolina   | F    | Ford       | Ka           |
| Lara           | F    | Honda      | Hrv          |
| Henrique       | M    | Honda      | Civic        |
| Joao Pedro     | M    | Hyundai    | Hb20         |
| Maria Clara    | F    | Hyundai    | Hb20         |
| Carlos Maia    | M    | Jeep       | Compass      |
| Maria Fernanda | F    | Jeep       | Renegade     |
| Carlos Victor  | M    | Mercedes   | C180         |
| Luana          | F    | Mini       | Countryman   |
| Pedro          | M    | Mitsubishi | L200         |
| Maria Eduarda  | F    | Mitsubishi | Pajero       |
| Julia          | F    | Nissan     | Sentra       |
| Maria Fernanda | F    | Nissan     | Kicks        |
| Ana Julia      | F    | Nissan     | Tida         |
| Celia          | F    | Peugeot    | 2008         |
| Ana Cecilia    | F    | Peugeot    | 208          |
| Joao           | M    | Porsche    | Panamera     |
| Luiz Antonio   | M    | Porsche    | 911          |
| Fernanda       | F    | Ram        | 1500 Laramie |
| Luiz Claudio   | M    | Ram        | Rampage      |
| Joao Paulo     | M    | Renault    | Kwid         |
| Marcos         | M    | Renault    | Oroch        |
| Luiz Carlos    | M    | Renault    | Sandero      |
| Luiz Eduardo   | M    | Renault    | Duster       |
| Ana Camila     | F    | Renault    | Captur       |
| Ana Carolina   | F    | Renault    | Duster       |
| Nilda          | F    | Toyota     | Corolla      |
| Laura          | F    | Toyota     | Etios        |
| Ana Laura      | F    | Toyota     | Hilux        |
| Ana Julia      | F    | Toyota     | Sw4          |
| Joao Victor    | M    | Volkswagen | Polo         |
| Sophia         | F    | Volkswagen | T-cross      |
| Ronaldo        | M    | Volkswagen | Gol          |
| Mariana        | F    | Volkswagen | Amarok       |
| Luiz Henrique  | M    | Volkswagen | Parati       |
| Luiz Guilherme | M    | Volkswagen | Polo         |
| Ana Clara      | F    | Volkswagen | Gol          |
| Ana Beatriz    | F    | Volvo      | Xc60         |
+----------------+------+------------+--------------+

/*___________________________________________________________________________________________________________________________________________________________________*/

/*Estrutura de uma trigger*/

CREATE TRIGGER NOME
BEFORE/AFTER INSERT/DELETE/UPDATE ON TABELA
FOR EACH ROW (PARA CADA LINHA)
BEGIN -> INICIO

        QUALQUER COMANDO SQL

END -> FIM

create table usuario(
    idusuario int primary key auto_increment,
    nome varchar(30),
    login varchar(30),
    senha varchar(100)
);

create table bkp_usuario(
    idbackup int primary key auto_increment,
    idusuario int,
    nome varchar(30),
    login varchar(30)
);

/*Criando a Trigger*/

delimiter $

create trigger backup_user
before delete on usuario
for each row
begin
    insert into bkp_usuario (idusuario, nome, login)
    values (old.idusuario, old.nome, old.login);
end

delimiter ;

insert into usuario values(null, 'Andrade', 'Andrade2009', 'Hexacampeao');

select * from usuario;

delete from usuario
where idusuario = 1;

select * from bkp_usuario;

/*Trigger de auditoria*/

create database loja;
use loja;

create table produto(
    idproduto int primary key auto_increment,
    nome varchar(30),
    valor float(10,2)
);

insert into produto values(null, 'Livro Modelagem', 50.00);
insert into produto values(null, 'Livro Power BI', 60.00);
insert into produto values(null, 'Livro Oracle', 80.00);
insert into produto values(null, 'Livro Sql Server', 100.00);

create database backup;
use backup;

create table bkp_produto(
    idbackup int primary key auto_increment,
    idproduto int,
    nome varchar(30),
    valor_original float(10,2),
    valor_alterado float(10,2),
    data datetime,
    usuario varchar(30),
    evento char(1)
);

use loja;

select * from produto;

delimiter $
create trigger audit_prod
after update on produto
for each row
begin
    insert into backup.bkp_produto(idproduto, nome, valor_original, valor_alterado, data, usuario, evento)
    values(old.idproduto, old.nome, old.valor, new.valor, now(), current_user(), 'U');

end
$
delimiter ;

update produto
set valor = 110.00
where idproduto = 4;

select * from backup.bkp_produto;
+----------+-----------+------------------+----------------+----------------+---------------------+----------------+--------+
| idbackup | idproduto | nome             | valor_original | valor_alterado | data                | usuario        | evento |
+----------+-----------+------------------+----------------+----------------+---------------------+----------------+--------+
|        1 |         4 | Livro Sql Server |         100.00 |         110.00 | 2025-02-20 17:16:33 | root@localhost | U      |
+----------+-----------+------------------+----------------+----------------+---------------------+----------------+--------+

/*_____________________________________________________________________*/

/*Aula 44 - Autorelacionamento*/

create database aula44;
use aula44;

create table cursos(
    idcurso int primary key auto_increment,
    nome varchar(30),
    horas int,
    valor float(10,2),
    id_prereq int
);

alter table cursos add constraint fk_prereq
foreign key (id_prereq) references cursos (idcurso);

insert into cursos values(null, 'BD Relacional', 20, 400.00, null);
insert into cursos values(null, 'Business Intelligence', 40, 800.00, 1);
insert into cursos values(null, 'Relatorios Avancados', 20, 600.00, 2);
insert into cursos values(null, 'Logica Program', 20, 400.00, null);
insert into cursos values(null, 'Ruby', 30, 500.00, 4);

select * from cursos;

select nome, valor, horas, ifnull(id_prereq, 'Sem Prereq') Requisito
from cursos;

/*Nome, valor, horas e o nome do pre requisito*/

select c.nome as curso,
c.valor as valor,
c.horas as carga,
ifnull(p.nome, '---') as prereq
from cursos c
left join cursos p
on p.idcurso = c.id_prereq;

+-----------------------+--------+-------+-----------------------+
| curso                 | valor  | carga | prereq                |
+-----------------------+--------+-------+-----------------------+
| BD Relacional         | 400.00 |    20 | ---                   |
| Business Intelligence | 800.00 |    40 | BD Relacional         |
| Relatorios Avancados  | 600.00 |    20 | Business Intelligence |
| Logica Program        | 400.00 |    20 | ---                   |
| Ruby                  | 500.00 |    30 | Logica Program        |
+-----------------------+--------+-------+-----------------------+

/*_____________________________________________________________________*/


create database cursores;
use cursores;

create table vendedores(
    idvendedor int primary key auto_increment,
    nome varchar(50),
    jan int,
    fev int, 
    mar int
);

insert into vendedores values(null, 'Michel', 874554, 745, 44541);
insert into vendedores values(null, 'Clara', 8754, 3692, 7845124);
insert into vendedores values(null, 'Julia', 65487, 1010101, 787874);
insert into vendedores values(null, 'Ana', 55555, 66666, 77777);




create table vend_total(
    nome varchar(50),
    jan int,
    fev int, 
    mar int,
    total int,
    media int
);

delimiter $

create procedure inseredados()
begin
    declare fim int default 0;
    declare var1, var2, var3, vtotal, vmedia int;
    declare vnome varchar(50);

    declare reg cursor for(
        select nome, jan, fev, mar from vendedores
    );

    declare continue handler for not found set fim = 1;

    open reg;

        repeat
            fetch reg into vnome, var1, var2, var3;

            if not fim then
                set vtotal = var1+var2+var3;
                set vmedia = vtotal/3;
                insert into vend_total values(vnome, var1, var2, var3, vtotal, vmedia);
            end if;
        until fim end repeat;

    close reg;
end
$

delimiter ;

select * from vendedores;
select * from vend_total;

call inseredados();
select * from vend_total;

