CREATE TABLE clientes(
    Nombre varchar(25) NOT NULL,
    CantidadViajes INT DEFAULT 0,
    CantidadTransacciones INT DEFAULT 0,

    CONSTRAINT pk_cliente PRIMARY KEY (nombre)
);