CREATE TABLE  filial(
    codIdFilial INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    endereco  VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    PRIMARY KEY(codIdFilial)

);

CREATE TABLE cliente(
    cpfCliente CHAR(11) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    pontosCRM INT NOT NULL,
    rua VARCHAR(50)NOT NULL,
    numero INT,
    cidade VARCHAR(30) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    estado VARCHAR (20) NOT NULL,
    PRIMARY KEY (cpfCliente)

);

CREATE TABLE funcionario(
    matricula VARCHAR(20) NOT NULL,
    cpfFuncionario CHAR(11) NOT NULL,
    nomeFuncionario VARCHAR(50) NOT NULL,
    enderecoFuncionario VARCHAR(50) NOT NULL,
    salario FLOAT NOT NULL,
    funcao VARCHAR(20) NOT NULL,
    matriculaSupervisor VARCHAR(20) NOT NULL,
    PRIMARY KEY (matricula),
    FOREIGN KEY (matriculaSupervisor) REFERENCES funcionario(matricula)

);

CREATE TABLE dependente(
    cpfDependente CHAR(11) NOT NULL,
    nascimento DATE NOT NULL,
    nomeDependente VARCHAR(50) NOT NULL,
    matriculaDependente VARCHAR(20) NOT NULL,
    PRIMARY KEY (cpfDependente),
    FOREIGN KEY (matriculaDependente) REFERENCES funcionario(matricula)
    


);


CREATE TABLE telefoneFuncionario(
    matriculaFuncionario VARCHAR (20),
    numeroTelFuncionario VARCHAR(20),
    PRIMARY KEY (matriculaFuncionario)
   
    
    

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
    codIdCaixa INT NOT NULL,
    PRIMARY KEY (numeroCaixa),
    FOREIGN KEY (codIdCaixa) REFERENCES filial(codIdFilial)
    
);




