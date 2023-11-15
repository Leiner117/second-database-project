-- Crea la tabla correoElectronico con las columnas Correo y CedulaEmpleado. La columna Correo es de tipo VARCHAR(50) y no puede ser nula. La columna CedulaEmpleado es de tipo INT y no puede ser nula. Además, se establece la restricción pk_correo como clave primaria de la tabla y la restricción fk_correo_empleado como clave foránea que referencia la columna cedula de la tabla empleado.
Use TransGaby
CREATE TABLE correoElectronicosEmpleados (
    Correo EmailAddress NOT NULL,
    CedulaEmpleado Cedula NOT NULL
    CONSTRAINT pk_correo PRIMARY KEY (correo),
    CONSTRAINT fk_correo_empleado FOREIGN KEY (CedulaEmpleado) REFERENCES empleados (Cedula) ON DELETE CASCADE
);