USE tarea;
CREATE TABLE Sectors(
    id_sector INT NOT NULL ,
    nombre VARCHAR(255) NOT NULL,
    industria VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_sector)
);
CREATE TABLE Company(
    symbol VARCHAR(10) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    pais VARCHAR(255) NOT NULL,
    id_sector INT NOT NULL,
    PRIMARY KEY (symbol),
    FOREIGN KEY (id_sector) REFERENCES Sectors(id_sector)
);
CREATE TABLE Leadership(
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    CEO VARCHAR(255) NOT NULL,
    PRIMARY KEY (symbol, fecha),
    FOREIGN KEY (symbol) REFERENCES Company(symbol)
);
CREATE TABLE Financial_Reports(
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    Ingresos NUMERIC(15, 2) NOT NULL,
    Ganancias NUMERIC(15, 2) NOT NULL,
    Activos NUMERIC(15, 2) NOT NULL,
    PRIMARY KEY (symbol, fecha),
    FOREIGN KEY (symbol) REFERENCES Company(symbol)
);
CREATE TABLE Debt_Structure(
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    DeudaTotal NUMERIC(15, 2) NOT NULL,
    Cash NUMERIC(15, 2) NOT NULL,
    PRIMARY KEY (symbol, fecha),
    FOREIGN KEY (symbol) REFERENCES Company(symbol)
);
CREATE TABLE Dividends(
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    Monto NUMERIC(15, 2) NOT NULL,
    Periodicidad NUMERIC(15, 2) NOT NULL,
    PRIMARY KEY (symbol, fecha),
    FOREIGN KEY (symbol) REFERENCES Company(symbol)
);
CREATE TABLE Market_Data(
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    MarketCap NUMERIC(15, 2) NOT NULL,
    NumEmpleados NUMERIC(15, 2) NOT NULL,
    PrecioCierre NUMERIC(15, 2) NOT NULL,
    PRIMARY KEY (symbol, fecha),
    FOREIGN KEY (symbol) REFERENCES Company(symbol)
);