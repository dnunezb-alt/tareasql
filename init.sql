CREATE TABLE Financial_Reports(
    id_reporte SERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    Ingresos NUMERIC(15, 2) NOT NULL,
    Ganancias NUMERIC(15, 2) NOT NULL,
    Activos NUMERIC(15, 2) NOT NULL,
);
CREATE TABLE Debt_Structure(
    id_deuda SERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    DeudaTotal NUMERIC(15, 2) NOT NULL,
    Cash NUMERIC(15, 2) NOT NULL,
);
CREATE TABLE Dividends(
    id_dividendo SERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    Monto NUMERIC(15, 2) NOT NULL,
    Periodicidad NUMERIC(15, 2) NOT NULL,
);
CREATE TABLE Market_Data(
    id_Market SERIAL PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    MarketCap NUMERIC(15, 2) NOT NULL,
    NumEmpleados NUMERIC(15, 2) NOT NULL,
    PrecioCierre NUMERIC(15, 2) NOT NULL
);