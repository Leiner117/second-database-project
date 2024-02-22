Use TransGaby
CREATE TABLE telefonosEmpleados (
    Numero PhoneNumber NOT NULL,
    CedulaEmpleado Cedula NOT NULL
    CONSTRAINT pk_telefono PRIMARY KEY (numero),
    CONSTRAINT fk_telefono_empleado FOREIGN KEY (CedulaEmpleado) REFERENCES empleados (cedula) ON DELETE CASCADE
);