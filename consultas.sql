-- Consultas Etapa 3


-- Consulta 1 consertada e testada com dados

SELECT *
FROM CLIENTE 
WHERE cpf in (SELECT cpf
              FROM REALIZA_RECLAMACAO r, CLIENTE c, FILIAL f
              WHERE r.cpf_cliente = c.cpf AND 
              f.codigo_identificacao = r.codigo_filial AND
              f.nome = 'Campina'
              GROUP BY cpf_cliente
              HAVING COUNT(*) > 1) 

-- 2 Consulta rodando - TESTADA OK

SELECT MAX(i.quantidade)
FROM ITEM i
WHERE i.desconto BETWEEN 0.05 AND 0.10

-- 3 Consulta rodando - TESTADA OK

CREATE VIEW ListaCompras AS
SELECT c.nome AS nomeCliente, c.cpf, f.nome
FROM CLIENTE c, FILIAL f, ORDEM_COMPRA o
WHERE c.cpf = o.cpf_cliente AND f.codigo_identificacao = o.codigo_filial

-- 4 Consulta consertada rodando - TESTADA OK

SELECT DISTINCT f.*
FROM FUNCIONARIO f, FUNCIONARIO s
WHERE f.matricula = s.matricula_supervisor
    ORDER BY f.salario DESC;

-- 5 Consulta rodando - TESTADA OK

SELECT p.codigo_identificacao, p.nome
FROM PRODUTO p
WHERE preco_venda < 100;

-- 6 Consulta não está rodando, ir consertando

SELECT p.codigo_identificao, p.nome
FROM PRODUTO p
WHERE p.magem_lucro(SELECT  MAX(p.margem_lucro)
                    FROM PRODUTO p, CATEGORIA c, MARCA m
                    WHERE p.id_categoria = c.identificador  AND c.nome = 'Jardim'
                    AND p.id_marca = m.identificador AND m.nome = 'SempreVerde')

-- 6 alternativa? rodando e testada
SELECT p.codigo_identificacao, p.nome
FROM PRODUTO p, CATEGORIA c, MARCA m
WHERE p.margem_lucro in (SELECT  MAX(p.margem_lucro)
                    FROM PRODUTO p, CATEGORIA c
                    WHERE p.id_categoria = c.identificador)
AND c.nome = 'Jardim'
AND p.id_marca = m.identificador 
AND m.nome = 'SempreVerde'

--7 Consulta rodando - TESTADA OK

SELECT f.nome AS nome_funcionario, d.nome AS nome_dependentes
FROM DEPENDENTE d, FUNCIONARIO f
WHERE d.matricula_funcionario = f.matricula AND
d.matricula_funcionario = (SELECT matricula_funcionario
                           FROM(SELECT d.matricula_funcionario, COUNT(d.matricula_funcionario) AS quantidade_dependentes
                                FROM FUNCIONARIO f, DEPENDENTE d
                                WHERE  f.matricula = d.matricula_funcionario
                                GROUP BY d.matricula_funcionario)
                           WHERE quantidade_dependentes = (SELECT MAX(quantidade_dependentes)
                                                           FROM(SELECT d.matricula_funcionario, COUNT(d.matricula_funcionario) AS quantidade_dependentes
                                                                FROM FUNCIONARIO f, DEPENDENTE d
                                                                WHERE  f.matricula = d.matricula_funcionario
                                                                GROUP BY d.matricula_funcionario)))
 
 
--8 Consulta rodando - TESTADA OK

CREATE VIEW ListaFiliais AS
SELECT f.nome AS nomeF, i.nome
FROM FUNCIONARIO f, FILIAL i
WHERE f.matricula = i.gerente
         
--9 Consulta rodando - TESTADA OK

SELECT DISTINCT c.numero_caixa
FROM CAIXA c, REALIZA_MANUTENCAO r, EQUIPAMENTO e
WHERE c.numero_caixa = e.numero_caixa AND
e.identificador = r.identificador_equipamento
GROUP BY c.numero_caixa, r.identificador_equipamento
HAVING COUNT(*) <= 1

         
--10


--11 Consulta rodando - TESTADA OK

SELECT r.*
FROM REALIZA_MANUTENCAO r, FUNCIONARIO f
WHERE ((r.matricula_funcionario = f.matricula) AND (f.nome LIKE '%Pereira%') AND (f.funcao = 'padeiro'))

-- 12 Consulta rodando, TESTADA OK

SELECT f.nome AS supervisor, d.nome AS nome_dependentes_mais_de_18
FROM FUNCIONARIO f, FUNCIONARIO s, DEPENDENTE d
WHERE f.matricula = s.matricula_supervisor AND 
d.matricula_funcionario = f.matricula AND 
d.cpf in (SELECT cpf
          FROM DEPENDENTE d 
          WHERE trunc(to_char(sysdate - d.data_nasc)/365) >= 18)      

     
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
     

     
--17 Consulta rodando, REVISAR A LÓGICA - Falta testar com dados

CREATE TRIGGER TRI_SalarioFuncionario_SalarioGerente
BEFORE INSERT OR UPDATE OF salario ON FUNCIONARIO
FOR EACH ROW
WHEN  (((NEW.salario>OLD.salario) AND (NEW.funcao != 'gerente')) AND ((NEW.salario<OLD.salario) AND (NEW.funcao = 'gerente')))
BEGIN
    RAISE_APPLICATION_ERROR(-20003, 'Valor salarial não permitido');
END;
     
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
    (primeira_data_hora IN ORDEM_COMPRA.data_hora%TYPE, 
    segunda_data_hora IN ORDEM_COMPRA.data_hora%TYPE, 
    total_compras OUT NUMBER)
AS
BEGIN
    total_compras:= TO_CHAR(
    SELECT SUM(i.preco_produto * i.quantidade)
    FROM ITEM i, ORDEM_COMPRA o
    WHERE ((i.num_nota_fiscal_ordem = o.numero_nota_fiscal) AND (o.data_hora BETWEEN o.primeira_data_hora AND o.segunda_data_hora)));
    
    DBMS_OUTPUT.PUT_LINE('O valor total de compras é'||TO_CHAR(total_compras));
    
COMMIT;
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
     

