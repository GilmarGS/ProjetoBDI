CREATE TABLE funcionario(
    matricula VARCHAR(20),
    cpfFuncionario CHAR(11) NOT NULL,
    nomeFuncionario VARCHAR(50) NOT NULL,
    enderecoFuncionario VARCHAR(50) NOT NULL,
    salario FLOAT NOT NULL,
    funcao VARCHAR(20) NOT NULL,
    matriculaSupervisor VARCHAR(20),
    PRIMARY KEY (matricula),
    FOREIGN KEY (matriculaSupervisor) REFERENCES funcionario(matricula)

);

CREATE TABLE  filial(
    codIdFilial INT,
    nome VARCHAR(50) NOT NULL,
    endereco  VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    matriculaFuncionario VARCHAR(20),
    PRIMARY KEY(codIdFilial),
    FOREIGN KEY (matriculaFuncionario) REFERENCES funcionario(matricula)

);

CREATE TABLE cliente(
    cpfCliente CHAR(11),
    nomeCliente VARCHAR(50) NOT NULL,
    emailCliente VARCHAR(50) NOT NULL,
    pontosCRM INT NOT NULL,
    rua VARCHAR(50)NOT NULL,
    numero INT,
    cidade VARCHAR(30) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    estado VARCHAR (20) NOT NULL,
    PRIMARY KEY (cpfCliente)
);

CREATE TABLE dependente(
    cpfDependente CHAR(11) NOT NULL,
    nascimento DATE NOT NULL,
    nomeDependente VARCHAR(50) NOT NULL,
    matriculaDependente VARCHAR(20),
    PRIMARY KEY (cpfDependente),
    FOREIGN KEY (matriculaDependente) REFERENCES funcionario(matricula)
);

CREATE TABLE realizaReclamacao (
    cpfCliente CHAR(11),
    codIdFilial INT,
    dataHoraReclamacao TIMESTAMP NOT NULL,
    descricao VARCHAR(200),
    PRIMARY KEY (cpfCliente, codIdFilial) 
);

CREATE TABLE telefoneFuncionario(
    matriculaFuncionario VARCHAR (20),
    numeroTelFuncionario VARCHAR(20),
    PRIMARY KEY (matriculaFuncionario, numeroTelFuncionario) 
);

CREATE TABLE marca(
    idMarca VARCHAR (12),
    nomeMarca VARCHAR (50) NOT NULL,
    PRIMARY KEY (idMarca)
);

CREATE TABLE categoria(
    idCategoria VARCHAR (12),
    nomeCategoria VARCHAR (50) NOT NULL,
    PRIMARY KEY (idCategoria)
);

CREATE TABLE caixa (
    numeroCaixa INT,
    codIdCaixa INT,
    PRIMARY KEY (numeroCaixa),
    FOREIGN KEY (codIdCaixa) REFERENCES filial(codIdFilial)
    
);

CREATE TABLE equipamento (
    idEquipamento INT,
    descricao VARCHAR (50) NOT NULL,
    numeroCaixaEquipamento INT NOT NULL,
    PRIMARY KEY (idEquipamento),
    FOREIGN KEY (numeroCaixaEquipamento) REFERENCES caixa(numeroCaixa)
    
);

CREATE TABLE realizaManutencao (
    idEquipamento INT,
    matFuncionario VARCHAR(20),
    dataHoraManutencao TIMESTAMP NOT NULL,
    custo NUMBER NOT NULL,
    PRIMARY KEY (idEquipamento, matFuncionario) 
);

CREATE TABLE telefoneCliente(
    cpfTelCliente VARCHAR (20),
    numeroTelCliente VARCHAR(20),
    PRIMARY KEY (cpfTelCliente, numeroTelCliente)
);

CREATE TABLE fornecedor(
    cnpj VARCHAR(20),
    nomeFornecedor VARCHAR(50) NOT NULL,
    enderecoFornecedor VARCHAR(50) NOT NULL,
    emailFornecedor VARCHAR(50) NOT NULL,
    siteFornecedor VARCHAR(20) NOT NULL,
    idCategoriaFornecedor VARCHAR (12),
    PRIMARY KEY (cnpj),
    FOREIGN KEY (idCategoriaFornecedor) REFERENCES categoria(idCategoria)

);

CREATE TABLE telefoneFornecedor(
    cnpjTelForncedor VARCHAR (20),
    numeroTelFornecedor VARCHAR(20),
    PRIMARY KEY (cnpjTelForncedor, numeroTelFornecedor)

);

CREATE TABLE ordemDeCompra(
    numOrdemDeCompra VARCHAR(20),
    dataEHotaVenda TIMESTAMP NOT NULL,
    numCaixa INT NOT NULL,
    cpfCliente CHAR(11) NOT NULL,
    codIdFilial INT NOT NULL,
    matFuncionario VARCHAR(20) NOT NULL,
    PRIMARY KEY (numOrdemDeCompra),
    FOREIGN KEY (numCaixa) REFERENCES caixa(numeroCaixa),
    FOREIGN KEY (cpfCliente) REFERENCES cliente (cpfCliente),
    FOREIGN KEY (codIdFilial) REFERENCES filial (codIdFilial),
    FOREIGN KEY (matFuncionario) REFERENCES funcionario(matricula)
);

CREATE TABLE solicitacao(
    idSolicitacao INT,
    dataSolicitacao DATE NOT NULL,
    dataPrevistaEntrega DATE NOT NULL,
    dataEnrega DATE NOT NULL,
    valorCompra NUMBER,
    prazoPagamentoDia DATE,
    codIDFilial INT,
    cnpjFornecedor VARCHAR(20),
    PRIMARY KEY (idSolicitacao),
    FOREIGN KEY (codIDFilial) REFERENCES filial(codIdFilial),
    FOREIGN KEY (cnpjFornecedor) REFERENCES fornecedor (cnpj)
);

CREATE TABLE notafiscal(
    numNotaFiscal VARCHAR(20),
    cnpjNotaFiscal VARCHAR(20) NOT NULL,
    quantidade INT,
    dataNotaFiscal DATE NOT NULL,
    valorPorItem NUMBER,
    idNFSolicitacao INT NOT NULL,
    PRIMARY KEY (numNotaFiscal),
    FOREIGN KEY(idNFSolicitacao) REFERENCES solicitacao(idSolicitacao)
);

CREATE TABLE produto (
    codIdProduto INT,
    nomeProduto VARCHAR(10) NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    margemLucroMin NUMBER NOT NULL,
    codIdFilial INT NOT NULL,
    idMarca VARCHAR (12) NOT NULL,   
    idCategoria VARCHAR (12) NOT NULL,  
    PRIMARY KEY (codIdProduto),
    FOREIGN KEY (codIdFilial) REFERENCES filial(codIdFilial),
    FOREIGN KEY (idMarca) REFERENCES marca (idMarca), 
    FOREIGN KEY (idCategoria) REFERENCES categoria (idCategoria) 
);

CREATE TABLE item (
    idItem INT,
    quantidadeItens INT NOT NULL,
    desconto NUMBER,
    numOrdemDeCompra VARCHAR(20) NOT NULL,
    numNotaFiscal VARCHAR(20) NOT NULL,
    codIdProduto INT NOT NULL,    
    PRIMARY KEY (idItem),
    FOREIGN KEY (numOrdemDeCompra) REFERENCES ordemDeCompra(numOrdemDeCompra),
    FOREIGN KEY (numNotaFiscal) REFERENCES notafiscal (numNotaFiscal), 
    FOREIGN KEY (codIdProduto) REFERENCES produto (codIdProduto) 
);
