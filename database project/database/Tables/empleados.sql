-- Crea la tabla empleado con los campos Cedula, Nombre, Apellido y Apellido2. La llave primaria es la cedula.
CREATE TABLE  empleados (
    Cedula Cedula NOT NULL,
    Nombre CHAR(15) NOT NULL,
    Apellido CHAR(20) NOT NULL,
    Apellido2 CHAR(20) NOT NULL,
    FechaNacimiento BirthDate NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (Cedula) 
);