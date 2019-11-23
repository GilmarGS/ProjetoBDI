INSERT INTO funcionario VALUES(19444, '11111111117', '7456321', 'jorge', 'RUA TAL', 210.3, 'RH', NULL, NULL);
INSERT INTO funcionario VALUES(19454, '11111111117', '7456321', 'kedson', 'RUA TAL', 210.3, 'RH', 19444, NULL);

INSERT INTO funcionario VALUES(19999, '11111111117', '7456321', 'jose', 'RUA TAL', 220.3, 'RH', NULL, NULL);
INSERT INTO funcionario VALUES(18888, '11111145757', '7456321', 'raquel', 'RUA TAL', 199.3, 'RH', 19999, NULL);

INSERT INTO funcionario VALUES(1144444, '22222222222', '7777777', 'PAULO', 'RUA TAL', 211.3, 'RH', NULL, NULL);
INSERT INTO funcionario VALUES(115555, '11111111111', '7456321', 'ANA', 'RUA TAL', 111.3, 'RH', 1144444, NULL);
INSERT INTO funcionario VALUES(115544, '11111111112', '7456321', 'joao', 'RUA TAL', 111.33, 'RH', 1144444, NULL);
INSERT INTO funcionario VALUES(115577, '11111111113', '7456321', 'neco', 'RUA TAL', 11.33, 'RH', 1144444, NULL);
INSERT INTO funcionario VALUES(115533, '11111111114', '7456321', 'pedro', 'RUA TAL', 11.3, 'RH', 1144444, NULL);

INSERT INTO funcionario VALUES(1155377, '11111111115', '7456321', 'pedro pereira', 'RUA TAL', 11.3, 'padeiro', 1144444, NULL);



INSERT INTO filial VALUES(001,'Campina', 'RUA TAL tal', '333', 1144444);
INSERT INTO filial VALUES(002,'Real', 'RUA TAL tal', '444', 1144444);
INSERT INTO filial VALUES(003,'João pessoa', 'RUA TAL tal', '555', 1144444);
INSERT INTO filial VALUES(004,'São paulo', 'RUA TAL tal', '666', 1144444);
INSERT INTO filial VALUES(005,'Campina Grande', 'RUA TAL tal', '777', 115555);


INSERT INTO cliente VALUES('11055588855', 'carla', 'carla@gmail', 200, 'RUA TAL', 50, 'campina grande', 'universitario', 'pb');
INSERT INTO cliente VALUES('12055588855', 'luiza', 'luiza@gmail', 200, 'RUA TAL', 50, 'campina grande', 'universitario', 'pb');
INSERT INTO cliente VALUES('13055588855', 'jose', 'jose@gmail', 200, 'RUA TAL', 50, 'joao pessoa', 'universitario', 'pb');
INSERT INTO cliente VALUES('14055588855', 'paulo', 'paulo@gmail', 200, 'RUA TAL', 50, 'campo grande', 'universitario', 'pb');
INSERT INTO cliente VALUES('15055588855', 'carlos', 'carlos@gmail', 200, 'RUA TAL', 50, 'campinas', 'universitario', 'pb');


INSERT INTO dependente VALUES('22222222222', '03/03/2004', 'PAULINHO',1144444);
INSERT INTO dependente VALUES('22222222224', '03/03/2009', 'Carla',1144444);
INSERT INTO dependente VALUES('22222222225', '03/03/2005', 'Anderson',1144444);
INSERT INTO dependente VALUES('22222222234', '03/03/2018', 'Renata',115555);
INSERT INTO dependente VALUES('22222222235', '03/03/1998', 'Ingrid',115555);
INSERT INTO dependente VALUES('22222222236', '03/03/1998', 'Carlos',19444);
INSERT INTO dependente VALUES('22222222239', '03/03/2004', 'regis',19444);



INSERT INTO realiza_reclamacao VALUES(01, CURRENT_TIMESTAMP, 'muito ruim', 001, '11055588855');
INSERT INTO realiza_reclamacao VALUES(02, CURRENT_TIMESTAMP, 'pessimo', 001,'11055588855');
INSERT INTO realiza_reclamacao VALUES(03, CURRENT_TIMESTAMP, 'nem', 001,'12055588855');
INSERT INTO realiza_reclamacao VALUES(04,  CURRENT_TIMESTAMP, 'horrivel',002,'12055588855');
INSERT INTO realiza_reclamacao VALUES(05, CURRENT_TIMESTAMP, 'vote', 002, '13055588855');



INSERT INTO telefone_funcionario VALUES('0000-0000', 115555);

INSERT INTO marca VALUES(3232, 'Rapoza');
INSERT INTO marca VALUES(3233, 'SempreVerde');


INSERT INTO categoria VALUES(44, 'Roupa');
INSERT INTO categoria VALUES(46, 'Jardim');
INSERT INTO categoria VALUES(47, 'Limpeza');


INSERT INTO caixa VALUES(0001, 001);
INSERT INTO caixa VALUES(0002, 001);


INSERT INTO equipamento VALUES(1111, 'equipamento da primeira filial', 0001);
INSERT INTO equipamento VALUES(1112, 'equipamento da primeira filial', 0001);


INSERT INTO realiza_manutencao VALUES(0002, 1111, 0001,  115555, CURRENT_TIMESTAMP,  1.22);
INSERT INTO realiza_manutencao VALUES(0003, 1111, 0001,  115555, CURRENT_TIMESTAMP,  1.22);
INSERT INTO realiza_manutencao VALUES(0004, 1112, 0001,  115555, CURRENT_TIMESTAMP,  1.22);
INSERT INTO realiza_manutencao VALUES(0005, 1111, 0001,  1155377, CURRENT_TIMESTAMP,  1.22);




INSERT INTO telefone_cliente VALUES('1111-11111', '11055588855');

INSERT INTO fornecedor VALUES('11-222-22', 'rapoza', 'rua tal, cidade tal, estado tal', 'fornecedor@gmail', 44);

INSERT INTO telefone_fornecedor VALUES('1111-11111', '11-222-22');

INSERT INTO ordem_compra VALUES(2, CURRENT_TIMESTAMP, '11055588855', 001, 1144444, 0001); 

INSERT INTO solicitacao VALUES(4, '03/03/2004', '03/03/2004', '03/03/2004', 5.00, '03/03/2004', 001, '11-222-22');

INSERT INTO nota_fiscal VALUES(02, '11-222-000', 10, '03/03/2004', 500.0, 4); 

INSERT INTO produto VALUES(01, 'cristal', 'agua mineral', 0.50, 001, 2, 155.1, 200.0, '03/03/2011', '05/06/12', 3232, 44);
INSERT INTO produto VALUES(02, 'reizinho', 'pipoca', 0.50, 001, 2, 80.1, 100.0, '03/03/2011', '05/06/12', 3232, 44);
INSERT INTO produto VALUES(03, 'rexona', 'desodorante', 0.50, 001, 2, 40.1, 55.0, '03/03/2011', '05/06/12', 3232, 44);
INSERT INTO produto VALUES(04, 'aaaa', 'peixe', 0.50, 001, 2, 45.1, 55.0, '03/03/2011', '05/06/12', 3233, 46);
INSERT INTO produto VALUES(05, 'bbbb', 'peixe', 0.50, 001, 2, 40.1, 55.0, '03/03/2011', '05/06/12', 3233, 46);
INSERT INTO produto VALUES(06, 'bbbb', 'peixe', 0.60, 001, 2, 40.1, 55.0, '03/03/2011', '05/06/12', 3233, 46);
INSERT INTO produto VALUES(07, 'gorgonzola', 'queijo', 0.60, 001, 2, 201.1, 55.0, '03/03/2011', '05/06/12', 3233, 47);
INSERT INTO produto VALUES(08, 'coalho', 'queijo', 0.60, 001, 1, 100.0, 55.0, '03/03/2011', '05/06/12', 3233, 47);


INSERT INTO item VALUES(111, 2, 02, 100, 0.10, 0.2);
INSERT INTO item VALUES(112, 2, 02, 100, 0.10, 0.07);
INSERT INTO item VALUES(113, 2, 02, 200, 0.10, 0.07);
