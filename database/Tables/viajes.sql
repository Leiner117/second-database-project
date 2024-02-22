
CREATE TABLE viajes(
    IdViaje INT IDENTITY(1,1) NOT NULL,
    CedulaConductor Cedula NOT NULL,
    Vehiculo CHAR(8) NOT NULL,
    NombreCliente VARCHAR(25) NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    CantidadPasajeros TINYINT NOT NULL DEFAULT 0,
    LugarSalida VARCHAR(25) NOT NULL,
    LugarLlegada VARCHAR(25) NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    Precio PositiveMoney NOT NULL,
    Estado BIT NOT NULL
    
    CONSTRAINT pk_viaje PRIMARY KEY (idViaje),
    CONSTRAINT fk_viaje_conductor FOREIGN KEY (cedulaConductor) REFERENCES conductores (cedula) ON DELETE CASCADE,
    CONSTRAINT fk_viaje_cliente FOREIGN KEY (nombreCliente) REFERENCES clientes (nombre) ON DELETE CASCADE,
    CONSTRAINT fk_viaje_vehiculo FOREIGN KEY (vehiculo) REFERENCES vehiculos (placa) ON DELETE CASCADE,
);