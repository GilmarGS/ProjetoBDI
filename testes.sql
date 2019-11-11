INSERT INTO funcionario VALUES('11.44.444', '22222222222', '1234567', 'PAULO', 'RUA TAL', 211133, 'RH', NULL, NULL);
INSERT INTO funcionario VALUES('11.55.55', '11111111111', '7654321', 'ANA', 'RUA TAL', 111133, 'RH', '11.44.444', NULL);

INSERT INTO filial VALUES(001,'Campina Grande', 'RUA TAL tal', null, '11.44.444');

INSERT INTO cliente VALUES('11055588855', 'carla', 'carla@gmail', 200, 'RUA TAL', 50, 'campina garnde', 'universitario', 'pb');

INSERT INTO dependente VALUES('22222222222', '03/03/2004', 'PAULINHO','11.44.444');

INSERT INTO realizaReclamacao VALUES('11055588855', 001, CURRENT_TIMESTAMP, 'jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj');

INSERT INTO telefoneFuncionario VALUES('11.55.55', '0000-0000');

INSERT INTO marca VALUES('id3232', 'Rapoza');

INSERT INTO categoria VALUES('i44', 'Roupa');

INSERT INTO caixa VALUES(0001, 001);

INSERT INTO equipamento VALUES(1111, 'equipamento da primeira filial', 0001);

INSERT INTO realizaManutencao VALUES(1111, '11.55.55', CURRENT_TIMESTAMP,  1.222);

INSERT INTO telefoneCliente VALUES('11055588855', '1111-11111');

INSERT INTO fornecedor VALUES('11-222-22', 'rapoza', 'rua tal, cidade tal, estado tal', 'fornecedor@gmail','www.fornecedor.com', 'i44');

INSERT INTO telefoneFornecedor VALUES('11-222-22', '1111-11111');

INSERT INTO ordemDeCompra VALUES(2, CURRENT_TIMESTAMP, 0001, '11055588855', 001, '11.44.444'); 

INSERT INTO solicitacao VALUES(4, '03/03/2004', '03/03/2004', '03/03/2004', 5.000, '03/03/2004', 001, '11-222-22');

INSERT INTO notaFiscal VALUES(02, '11-222-22', 10, '03/03/2004', 500, 4); 

INSERT INTO produto VALUES(01, 'cristal', 'agua mineral', 0.50, 001, 'id3232', 'i44');

INSERT INTO item VALUES(111, 100, 0.10, 2, 02, 01);



SELECT * FROM funcionario;



/* 
ALTER TABLE realizaReclamacao ADD CONSTRAINT fk_realiza_reclamacaoCliente FOREIGN KEY (cpfClienteReclamacao) REFERENCES cliente (cpfCliente) ON DELETE CASCADE; 
ALTER TABLE realizaReclamacao ADD CONSTRAINT fk_realiza_reclamacaoFilial FOREIGN KEY (codIdFilialReclamacao) REFERENCES filial (codIdFilial) ON DELETE CASCADE;

*/

