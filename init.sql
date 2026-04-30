-- 1. Crear la base de datos si no existe (evita errores si ya está creada)
CREATE DATABASE IF NOT EXISTS tarea 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Seleccionar la base de datos a usar
USE tarea;

-- 3. Crear tablas respetando la jerarquía de las llaves foráneas (Padres -> Hijos)

CREATE TABLE IF NOT EXISTS Sectors(
    id_sector INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    industria VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_sector)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Company(
    symbol VARCHAR(10) NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    pais VARCHAR(255) NOT NULL,
    id_sector INT NOT NULL,
    PRIMARY KEY (symbol),
    FOREIGN KEY (id_sector) REFERENCES Sectors(id_sector) 
        ON DELETE RESTRICT 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Leadership(
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    CEO VARCHAR(255) NOT NULL,
    PRIMARY KEY (symbol, fecha),
    FOREIGN KEY (symbol) REFERENCES Company(symbol) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Financial_Reports(
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    Ingresos NUMERIC(15, 2) NOT NULL,
    Ganancias NUMERIC(15, 2) NOT NULL,
    Activos NUMERIC(15, 2) NOT NULL,
    PRIMARY KEY (symbol, fecha),
    FOREIGN KEY (symbol) REFERENCES Company(symbol) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Debt_Structure(
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    DeudaTotal NUMERIC(15, 2) NOT NULL,
    Cash NUMERIC(15, 2) NOT NULL,
    PRIMARY KEY (symbol, fecha),
    FOREIGN KEY (symbol) REFERENCES Company(symbol) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Dividends(
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    Monto NUMERIC(15, 2) NOT NULL,
    -- Nota: Si Periodicidad es en meses/días, INT es mejor. Si es texto (ej. "Trimestral"), usa VARCHAR.
    Periodicidad NUMERIC(15, 2) NOT NULL, 
    PRIMARY KEY (symbol, fecha),
    FOREIGN KEY (symbol) REFERENCES Company(symbol) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Market_Data(
    symbol VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    MarketCap NUMERIC(15, 2) NOT NULL,
    NumEmpleados INT NOT NULL, -- Corregido: Un número de empleados debe ser entero (INT)
    PrecioCierre NUMERIC(15, 2) NOT NULL,
    PRIMARY KEY (symbol, fecha),
    FOREIGN KEY (symbol) REFERENCES Company(symbol) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;
