-- Esquema padrão para o projeto de Banco de Dados 1 2019.2

DROP TABLE REALIZA_RECLAMACAO;
DROP TABLE ITEM;
DROP TABLE ORDEM_COMPRA;
DROP TABLE TELEFONE_FORNECEDOR;
DROP TABLE NOTA_FISCAL;
DROP TABLE SOLICITACAO;
DROP TABLE FORNECEDOR;
DROP TABLE REALIZA_MANUTENCAO;
DROP TABLE EQUIPAMENTO;
DROP TABLE CAIXA;
DROP TABLE PRODUTO;
DROP TABLE CATEGORIA;
DROP TABLE MARCA;
DROP TABLE FILIAL CASCADE CONSTRAINT;
DROP TABLE DEPENDENTE;
DROP TABLE TELEFONE_FUNCIONARIO;
DROP TABLE FUNCIONARIO CASCADE CONSTRAINT;
DROP TABLE TELEFONE_CLIENTE;
DROP TABLE CLIENTE;

CREATE TABLE CLIENTE (
    cpf 	VARCHAR2(14),
	nome 	VARCHAR2(100) NOT NULL,
	email 	VARCHAR2(50) NOT NULL,
	pontos_crm INT,
    rua 	VARCHAR2(100) NOT NULL,
	num 	VARCHAR2(14) NOT NULL,
	cidade 	VARCHAR2(100) NOT NULL,
	estado 	VARCHAR2(100) NOT NULL,
	bairro 	VARCHAR2(100) NOT NULL,

	CONSTRAINT pk_cliente
	PRIMARY KEY (cpf)
);

CREATE TABLE TELEFONE_CLIENTE (
	telefone VARCHAR2(15),
	cpf_cliente VARCHAR2(14),

    CONSTRAINT fk_telefone_cliente 
    FOREIGN KEY (cpf_cliente) 
    REFERENCES  CLIENTE(cpf),

	CONSTRAINT pk_telefone_cliente
	PRIMARY KEY (cpf_cliente, telefone)
);

CREATE TABLE FUNCIONARIO (
    matricula INT,
    cpf		VARCHAR2(14) NOT NULL,
    identidade	VARCHAR2(7) NOT NULL,
    nome 	VARCHAR2(100) NOT NULL,
    endereco    VARCHAR2(200) NOT NULL,
    salario	NUMBER(6,2) NOT NULL,
    funcao	VARCHAR2(50) NOT NULL,
    matricula_supervisor INT,
    codigo_filial INT,
	
    CONSTRAINT fk_funcionario_supervisor
    FOREIGN KEY (matricula_supervisor) 
    REFERENCES  FUNCIONARIO(matricula),

	CONSTRAINT pk_funcionario
	PRIMARY KEY (matricula)
);

CREATE TABLE TELEFONE_FUNCIONARIO (
	telefone VARCHAR2(15),
	matricula INT,

    CONSTRAINT fk_telefone_funcionario
    FOREIGN KEY (matricula)
    REFERENCES  FUNCIONARIO(matricula),

	CONSTRAINT pk_funcionario_telefone
	PRIMARY KEY (telefone, matricula)
);


CREATE TABLE DEPENDENTE (
    cpf 	VARCHAR2(14),
    data_nasc 	DATE NOT NULL,
    nome 	VARCHAR2(100) NOT NULL,
	matricula_funcionario INT NOT NULL,
    
    CONSTRAINT fk_dependente_matricula
    FOREIGN KEY (matricula_funcionario) 
    REFERENCES  FUNCIONARIO(matricula),
	
	CONSTRAINT pk_dependente
	PRIMARY KEY (cpf, matricula_funcionario)	
);

CREATE TABLE FILIAL (
    codigo_identificacao  INT,
    nome  VARCHAR2(100) NOT NULL,
    endereco    VARCHAR2(200) NOT NULL,
    telefone VARCHAR2(15) NOT NULL,
    gerente INT,
	
    CONSTRAINT fk_gerente_filial
    FOREIGN KEY (gerente)
    REFERENCES  FUNCIONARIO(matricula),

    CONSTRAINT pk_filial
    PRIMARY KEY (codigo_identificacao)
);

CREATE TABLE MARCA (
	identificador INT,
    nome  VARCHAR2(100) NOT NULL,

	CONSTRAINT pk_marca
	PRIMARY KEY (identificador)
);

CREATE TABLE CATEGORIA (
	identificador INT,
    nome  VARCHAR2(100) NOT NULL,

	CONSTRAINT pk_categoria
	PRIMARY KEY (identificador)
);

-- MARGE_LUCRO está na representação númerica.
CREATE TABLE PRODUTO (
    codigo_identificacao  INT,
    nome  VARCHAR2(100) NOT NULL,
    descricao	VARCHAR2(255) NOT NULL,
    margem_lucro  NUMBER(6,2) NOT NULL,
    codigo_filial INT NOT NULL,
    quantidade INT,
    preco_compra NUMBER(6,2),
    preco_venda NUMBER(6,2),
    data_compra 	DATE NOT NULL,
    data_validade 	DATE NOT NULL,
    id_marca INT NOT NULL,
    id_categoria INT NOT NULL,

    CONSTRAINT fk_filial_estoca
    FOREIGN KEY (codigo_filial)
    REFERENCES  FILIAL(codigo_identificacao),

    CONSTRAINT fk_marca_produto
    FOREIGN KEY (id_marca)
    REFERENCES  MARCA(identificador),

    CONSTRAINT fk_categoria_produto
    FOREIGN KEY (id_categoria)
    REFERENCES  CATEGORIA(identificador),

	CONSTRAINT pk_produto
	PRIMARY KEY (codigo_identificacao)
);

CREATE TABLE CAIXA (
    numero_caixa  INT,
    codigo_filial INT,

    CONSTRAINT fk_caixa_filial
    FOREIGN KEY (codigo_filial)
    REFERENCES  FILIAL(codigo_identificacao),

	CONSTRAINT pk_caixa
	PRIMARY KEY (numero_caixa)
);

CREATE TABLE EQUIPAMENTO (
	identificador INT,
    descricao	VARCHAR2(255) NOT NULL,
    numero_caixa INT,

    CONSTRAINT fk_equipamento_caixa
    FOREIGN KEY (numero_caixa) 
    REFERENCES  CAIXA(numero_caixa),
	
	CONSTRAINT pk_equipamento
	PRIMARY KEY (numero_caixa, identificador)
);

CREATE TABLE REALIZA_MANUTENCAO (
    id_manutencao INT,
	identificador_equipamento INT NOT NULL,
    numero_caixa INT NOT NULL,
	matricula_funcionario INT NOT NULL,
	data_hora TIMESTAMP NOT NULL,
    custo NUMBER(6,2) NOT NULL,

    CONSTRAINT fk_manutencao_funcionario
    FOREIGN KEY (matricula_funcionario)
    REFERENCES  FUNCIONARIO(matricula),

    CONSTRAINT fk_manutencao_equipamento
    FOREIGN KEY (numero_caixa, identificador_equipamento) 
    REFERENCES  EQUIPAMENTO(numero_caixa, identificador),

	CONSTRAINT pk_manutencao
	PRIMARY KEY (id_manutencao)
);

CREATE TABLE FORNECEDOR (
    cnpj		VARCHAR2(18),
    nome  VARCHAR2(100) NOT NULL,
    endereco    VARCHAR2(200) NOT NULL,
	email 	VARCHAR2(50) NOT NULL,
    id_categoria INT NOT NULL,
    
    CONSTRAINT fk_categoria_fornecedor
    FOREIGN KEY (id_categoria)
    REFERENCES  CATEGORIA(identificador),

	CONSTRAINT pk_fornecedor
	PRIMARY KEY (cnpj)
);

CREATE TABLE SOLICITACAO (
	identificador INT,
    data_solicitacao 	DATE NOT NULL,
    data_prevista 	DATE,
    data_entrega 	DATE,
    valor_compra	NUMBER(10,2) NOT NULL,
    prazo_pagamento 	DATE NOT NULL,
    codigo_filial 	INT NOT NULL,
    cnpj_fornecedor	VARCHAR2(18) NOT NULL,

    CONSTRAINT fk_filial_realiza
    FOREIGN KEY (codigo_filial)
    REFERENCES  FILIAL(codigo_identificacao),

    CONSTRAINT fk_recebe_fornecedor
    FOREIGN KEY (cnpj_fornecedor)
    REFERENCES  FORNECEDOR(cnpj),
    
	CONSTRAINT pk_solicitacao
	PRIMARY KEY (identificador)
);

CREATE TABLE NOTA_FISCAL (
    numero INT,
    cnpj	VARCHAR2(18) NOT NULL,
    quantidade	INT NOT NULL,
    data  DATE NOT NULL,
    valor_por_item	NUMBER(8,2) NOT NULL,
	identificador_solicitacao INT NOT NULL,

    CONSTRAINT fk_solicitacao_tem
    FOREIGN KEY (identificador_solicitacao)
    REFERENCES  SOLICITACAO(identificador),

	CONSTRAINT pk_nota_fiscal
	PRIMARY KEY (numero)
);

CREATE TABLE TELEFONE_FORNECEDOR (
	telefone VARCHAR2(15),
	cnpj VARCHAR2(18),

    CONSTRAINT fk_telefone_fornecedor
    FOREIGN KEY (cnpj)
    REFERENCES  FORNECEDOR(cnpj),

	CONSTRAINT pk_telefone_fornecedor
	PRIMARY KEY (cnpj, telefone)
);

CREATE TABLE ORDEM_COMPRA (
    numero_nota_fiscal  INT,
	data_hora	TIMESTAMP NOT NULL,
	cpf_cliente VARCHAR2(14) NOT NULL,
    codigo_filial INT NOT NULL,
	matricula_funcionario INT NOT NULL,
    numero_caixa INT NOT NULL,

    CONSTRAINT fk_ordem_cliente 
    FOREIGN KEY (cpf_cliente) 
    REFERENCES  CLIENTE(cpf),

    CONSTRAINT fk_filial_possui_ordem
    FOREIGN KEY (codigo_filial)
    REFERENCES  FILIAL(codigo_identificacao),

    CONSTRAINT fk_funcionario_realiza
    FOREIGN KEY (matricula_funcionario) 
    REFERENCES  FUNCIONARIO(matricula),

    CONSTRAINT fk_caixa_realizado
    FOREIGN KEY (numero_caixa) 
    REFERENCES  CAIXA(numero_caixa),

	CONSTRAINT pk_ordem_compra
	PRIMARY KEY (numero_nota_fiscal)
);

-- DESCONTO está na representação númerica.
CREATE TABLE ITEM (
    identificador  INT,
    num_nota_fiscal_ordem INT,
    numero_nota_fiscal INT,
    quantidade	INT NOT NULL,
    preco_produto NUMBER(6,2) NOT NULL,
    desconto NUMBER(3,2) NOT NULL,

    CONSTRAINT fk_ordem_compra
    FOREIGN KEY (num_nota_fiscal_ordem)
    REFERENCES  ORDEM_COMPRA(numero_nota_fiscal),

    CONSTRAINT fk_nota_fiscal
    FOREIGN KEY (numero_nota_fiscal)
    REFERENCES  NOTA_FISCAL(numero),

	CONSTRAINT pk_item
	PRIMARY KEY (identificador, num_nota_fiscal_ordem)
);

CREATE TABLE REALIZA_RECLAMACAO (
    id_reclamacao INT,
	data_hora	TIMESTAMP NOT NULL,
    descricao	VARCHAR2(255) NOT NULL,
    codigo_filial INT NOT NULL,
	cpf_cliente VARCHAR2(14) NOT NULL,

    CONSTRAINT fk_reclamacao_filial
    FOREIGN KEY (codigo_filial)
    REFERENCES  FILIAL(codigo_identificacao),

    CONSTRAINT fk_reclamacao_cliente
    FOREIGN KEY (cpf_cliente) 
    REFERENCES  CLIENTE(cpf),

	CONSTRAINT pk_reclamacao
	PRIMARY KEY (id_reclamacao)
);

ALTER TABLE FUNCIONARIO ADD CONSTRAINT FK_CODIGO_FILIAL_IN_FUNCIONARIO FOREIGN KEY (CODIGO_FILIAL) REFERENCES FILIAL(CODIGO_IDENTIFICACAO);



-- Consultas Etapa 3


-- 1 Consulta rodando - Falta testar com dados

SELECT c.*
FROM CLIENTE c, FILIAL f, REALIZA_RECLAMACAO r
WHERE (r.codigo_filial = f.codigo_identificacao 
       AND f.nome = 'Campina'
       AND (SELECT count(*)
           FROM RECALIZA_RECLAMACAO r, CLIENTE c
           WHERE r.cpf_cliente = c.cpf)>1)

-- 2 Consulta rodando - Falta testar com dados

SELECT MAX(i.quantidade)
FROM ITEM i
UNION
SELECT i.desconto
FROM ITEM i
WHERE i.desconto BETWEEN 0.05 AND 0.10

-- 3 Consulta rodando - Falta testar com dados

CREATE VIEW ListaCompras AS
SELECT c.nome AS nomeCliente, c.cpf, f.nome
FROM CLIENTE c, FILIAL f, ORDEM_COMPRA o
WHERE c.cpf = o.cpf_cliente AND f.codigo_identificacao = o.codigo_filial

-- 4 Consulta rodando - Falta testar com dados

SELECT f.*
FROM FUNCIONARIO f
WHERE f.matricula = f.matricula_supervisor
    ORDER BY f.salario DESC;

-- 5 Consulta rodando - Falta testar com dados

SELECT p.codigo_identificacao, p.nome
FROM PRODUTO p
WHERE preco_venda < 100;

-- 6 Consulta não está rodando, ir consertando

SELECT p.codigo_identificao, p.nome
FROM PRODUTO p, CATEGORIA c, MARCA m
WHERE c.nome = "Jardim" AND m.nome= "SempreVerde"
    (SELECT p. margem_lucro
    FROM PRODUTO p
    WHERE max(p.margem_lucro));

--7

--8 Consulta rodando - Falta testar com dados

create view ListaFiliais AS
SELECT f.nome as nomeF, i.nome
from FUNCIONARIO f, FILIAL i
WHERE f.matricula = i.gerente
         
--9 Consulta rodando - Falta testar com dados

SELECT c.numero_caixa
FROM CAIXA c, REALIZA_MANUTENCAO r, EQUIPAMENTO e
WHERE c.numero_caixa = e.numero_caixa AND e.identificador = r.identificador_equipamento
    AND (SELECT count(*)
         FROM  REALIZA_MANUTENCAO r, EQUIPAMENTO e
         WHERE e.identificador = r.identificador_equipamento) < 2
         
--10


--11 Consulta rodando - Falta testar com dados

SELECT r.data_hora
FROM REALIZA_MANUTENCAO r, FUNCIONARIO f
WHERE (r.matricula_funcionario = f.matricula AND f.nome LIKE '%Pereira%') AND (f.funcao = 'padeiro')

-- 12 Consulta não está rodando, ir consertando

SELECT d.nome
FROM FUNCIONARIO f, DEPENDENTE d
WHERE (f.matricula_supervisor = d.matricula_funcionario) AND 
    (SELECT *
    FROM DEPENDENTE d
    WHERE (TIMESTAMPDIFF(YEAR,d.data_nasc,CURDATE()) >= 18)
     
     
-- ( ESSE SELECT TRUNC VIMOS NA INTERNET QUE PODE AJUDAR)     
--SELECT trunc((months_between(sysdate, to_date(d.data_nasc,'dd/mm/yyyy')))/12) AS idade
--FROM DEPENDENTE d

     
--13 Consulta não está rodando, ir consertando
    
CREATE VIEW list As
(
SELECT p.*
FROM PRODUTO p, CATEGORIA c
WHERE p.id_categoria = c.identificador AND c.nome= 'Limpeza' 

UNION 
SELECT SUM(valor_total)
       FROM (SELECT p.quantidade, p.preco_compra, (p.quantidade*p.preco_compra) as valor_total
             from produto p)
       FROM Produto p)
     
--14 Consulta não está rodando, ir consertando
     
CREATE VIEW list_CNPJ AS
SELECT f.cnpj
FROM FORNECEDOR f, NOTA_FISCAL n, SOLICITACAO s
WHERE n.identificador_solicitacao =s.identificador AND (n.data,year) = 2019 AND
    SELECT MAX(SELECT SUM(valor_compra)
              FROM SOLICITACAO s, Solicitacao a
              GROUP BY valor_compra
              HAVING s.cnpj_fornecedor = a.cnpj_fornecedor)
     
     
-- 15 Consulta rodando - Falta testar com dados
     
ALTER TABLE FORNECEDOR
ADD CONSTRAINT cnpj_fo
CHECK(REGEXP_LIKE(cnpj,'^\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}$'))
     
--16 Consulta rodando, REVISAR A LÓGICA - Falta testar com dados
     
CREATE TRIGGER TRI_DataPrevistaMenor_DataSolitacao
BEFORE INSERT OR UPDATE OF data_solicitacao, data_prevista ON SOLICITACAO
FOR EACH ROW
WHEN  (NEW.data_prevista < NEW.data_solicitacao)
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Data de entrega prevista não permitida');
END;
     

     
--17
     
--18  Consulta rodando - Falta testar com dados
     
CREATE TRIGGER TRI_DataCompra_DataValidade
BEFORE INSERT OR UPDATE OF data_compra, data_validade ON PRODUTO
FOR EACH ROW
WHEN  ((NEW.data_compra > NEW.data_validade))
BEGIN
    RAISE_APPLICATION_ERROR(-20002, 'Data de compra não permitida');
END;
     
--19 Consulta não está rodando, ir consertando

CREATE OR REPLACE PROCEDURE calculaComprasNoPeriodo
    (data_hora1 IN ORDEM_COMPRA.data_hora%TYPE, 
     data_hora2 IN ORDEM_COMPRA.data_hora%TYPE,
     total_compras OUT NUMBER) 
AS
BEGIN
   -- WITH total_compras AS(
   SELECT SUM(i.preco_produto * i.quantidade) 
   FROM ITEM i, ORDEM_COMPRA o
   WHERE ((i.num_nota_fiscal_ordem = o.numero_nota_fiscal) AND (o.data_hora1 BETWEEN o.data_hora1 AND o.data_hora2))
   
   DBMS_OUTPUT.PUT_LINE('O total de vendas no período informado é de '|| TO_CHAR(total_compras));
END;

--A tabela de ITEM possui chave estrangeira de ORDEM_COMPRA, além do preço do produto e quantidade. De posse das ordens de compra, basta calcular o preço e quantidade para cada ordem e somar. (Palavras de Thiago kk)
     
--20 Consulta rodando - Falta testar com dados( Ver com Thiago se são essas tabelas que presisam ser usadas, não fica muito claro)
     
CREATE OR REPLACE PROCEDURE alteraPrecoDeVenda
    (p_codigo_identificacao IN PRODUTO.codigo_identificacao%TYPE, 
     novo_preco_compra IN PRODUTO.preco_compra%TYPE) 
AS
BEGIN
     UPDATE PRODUTO
     SET preco_compra = novo_preco_compra
     WHERE codigo_identificacao = p_codigo_identificacao;
     COMMIT;
END;
     