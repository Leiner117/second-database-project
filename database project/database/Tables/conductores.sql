CREATE TABLE conductores(
    cedula Cedula NOT NULL,
    CantidadViajes INT DEFAULT 0,
    CONSTRAINT pk_conductor PRIMARY KEY (cedula),
    CONSTRAINT fk_conductor_empleado FOREIGN KEY (cedula) REFERENCES empleados (cedula) ON DELETE CASCADE
)