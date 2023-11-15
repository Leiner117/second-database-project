/*
Tabla: vehiculo
*/
Use TransGaby
CREATE TABLE vehiculos (
    Placa CHAR(8) NOT NULL,
    Capacidad TINYINT NOT NULL,
    Modelo VARCHAR(20) NOT NULL,
    Marca VARCHAR(15) NOT NULL,
    Año SMALLINT NOT NULL,
	CantidadViajes INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_vehiculo PRIMARY KEY (placa),
    CONSTRAINT ck_vehiculo_capacidad CHECK (capacidad > 0),
);