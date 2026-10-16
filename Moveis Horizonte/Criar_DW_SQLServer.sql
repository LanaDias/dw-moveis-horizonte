-- DW fictício: Móveis Horizonte
-- SQL Server | Modelo estrela
CREATE DATABASE DW_MoveisHorizonte;
GO
USE DW_MoveisHorizonte;
GO

CREATE TABLE dbo.Dim_Produto (
    ProdutoID INT NOT NULL PRIMARY KEY,
    NomeProduto VARCHAR(120) NOT NULL,
    Categoria VARCHAR(50),
    Marca VARCHAR(60),
    Material VARCHAR(50),
    CustoUnitario DECIMAL(12,2),
    PrecoLista DECIMAL(12,2),
    Ativo VARCHAR(3)
);

CREATE TABLE dbo.Dim_Cliente (
    ClienteID INT NOT NULL PRIMARY KEY,
    NomeCliente VARCHAR(120) NOT NULL,
    TipoCliente VARCHAR(30),
    Cidade VARCHAR(80),
    Estado CHAR(2),
    DataNascimento DATE,
    Genero VARCHAR(30),
    DataCadastro DATE
);

CREATE TABLE dbo.Dim_Loja (
    LojaID INT NOT NULL PRIMARY KEY,
    NomeLoja VARCHAR(80) NOT NULL,
    Cidade VARCHAR(80),
    Estado CHAR(2),
    Bairro VARCHAR(80)
);

CREATE TABLE dbo.Dim_Vendedor (
    VendedorID INT NOT NULL PRIMARY KEY,
    NomeVendedor VARCHAR(100) NOT NULL,
    Cargo VARCHAR(60),
    DataAdmissao DATE
);

CREATE TABLE dbo.Dim_Data (
    DataID INT NOT NULL PRIMARY KEY,
    Data DATE NOT NULL,
    Ano SMALLINT,
    Trimestre VARCHAR(2),
    MesNumero TINYINT,
    MesNome VARCHAR(20),
    Dia TINYINT,
    DiaSemana VARCHAR(20),
    FimDeSemana VARCHAR(3)
);

CREATE TABLE dbo.Fato_Vendas (
    VendaItemID BIGINT NOT NULL PRIMARY KEY,
    NumeroVenda INT NOT NULL,
    DataID INT NOT NULL,
    ClienteID INT NOT NULL,
    ProdutoID INT NOT NULL,
    LojaID INT NOT NULL,
    VendedorID INT NOT NULL,
    Quantidade INT NOT NULL,
    ValorUnitario DECIMAL(12,2),
    ValorBruto DECIMAL(14,2),
    Desconto DECIMAL(12,2),
    Acrescimo DECIMAL(12,2),
    ValorLiquido DECIMAL(14,2),
    CustoTotal DECIMAL(14,2),
    FormaPagamento VARCHAR(40),
    StatusVenda VARCHAR(20),
    CONSTRAINT FK_Fato_Data FOREIGN KEY (DataID) REFERENCES dbo.Dim_Data(DataID),
    CONSTRAINT FK_Fato_Cliente FOREIGN KEY (ClienteID) REFERENCES dbo.Dim_Cliente(ClienteID),
    CONSTRAINT FK_Fato_Produto FOREIGN KEY (ProdutoID) REFERENCES dbo.Dim_Produto(ProdutoID),
    CONSTRAINT FK_Fato_Loja FOREIGN KEY (LojaID) REFERENCES dbo.Dim_Loja(LojaID),
    CONSTRAINT FK_Fato_Vendedor FOREIGN KEY (VendedorID) REFERENCES dbo.Dim_Vendedor(VendedorID)
);
GO

-- Sugestão de carga: primeiro dimensões, depois a fato.
-- Para treino de SCD tipo 1, atualize atributos diretamente.
-- Para SCD tipo 2, adicione ChaveSurrogada, DataInicio, DataFim e RegistroAtual
-- às dimensões que precisam preservar histórico.
