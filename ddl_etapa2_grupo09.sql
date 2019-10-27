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
