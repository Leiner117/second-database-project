Use TransGaby
CREATE TABLE mantenimientoReparaciones (

    IdMantenimiento INT IDENTITY(1,1) NOT NULL,
    Fecha DATE NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    Costo PositiveMoney NOT NULL,
    Placa CHAR(8) NOT NULL
    CONSTRAINT pk_mantenimiento PRIMARY KEY (idMantenimiento),
    CONSTRAINT fk_mantenimiento_vehiculo FOREIGN KEY (placa) REFERENCES vehiculos (placa) ON DELETE CASCADE
);