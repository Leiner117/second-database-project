CREATE DATABASE TransGaby
use TransGaby


/*CREATE TABLE administradores(
    cedula Cedula NOT NULL,
    CONSTRAINT pk_administrador PRIMARY KEY (cedula),
    CONSTRAINT fk_administrador_empleado FOREIGN KEY (cedula) REFERENCES empleados (cedula) ON DELETE CASCADE
);*/


/*CREATE TABLE tareas (
    IdTarea INT IDENTITY(1,1) NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    Cedula Cedula NOT NULL,
    CONSTRAINT pk_tarea PRIMARY KEY (idTarea),
    CONSTRAINT fk_tarea_empleado FOREIGN KEY (cedula) REFERENCES empleados (cedula) ON DELETE CASCADE
);*/




/*
--CRUD ADMINISTRADOR
-- Insertar en la tabla administrador
GO
CREATE PROCEDURE InsertarAdministrador
    @cedula Cedula
AS
BEGIN
    INSERT INTO administradores VALUES (@cedula);
END;
-- Leer en la tabla administrador
GO
CREATE PROCEDURE LeerAdministrador
    @cedula Cedula
AS
BEGIN
    SELECT * FROM administradores WHERE  cedula = @cedula;
END;
-- Actualizar en la tabla administrador

GO
CREATE PROCEDURE ActualizarAdministrador
    @cedula Cedula
AS
BEGIN
    UPDATE administradores
    SET cedula = @cedula
    WHERE cedula = @cedula;
END;
-- Eliminar en la tabla administrador
GO
CREATE PROCEDURE EliminarAdministrador
    @cedula Cedula
AS  
BEGIN
    DELETE FROM administradores WHERE cedula = @cedula;
END;*/
--#####################################################



/*--CRUD TAREA
-- Insertar en la tabla tarea
GO
CREATE PROCEDURE InsertarTarea
    @descripcion VARCHAR(100),
    @cedula Cedula
AS
BEGIN
    INSERT INTO tareas VALUES (@descripcion, @cedula);
END;
GO
-- Leer en la tabla tarea
GO
CREATE PROCEDURE LeerTarea
    @idTarea INT
AS
BEGIN
    SELECT * FROM tareas WHERE  idTarea = @idTarea;
END;
-- Actualizar en la tabla tarea
GO
CREATE PROCEDURE ActualizarTarea
    @idTarea INT,
    @descripcion VARCHAR(100),
    @cedula Cedula
AS
BEGIN
    UPDATE tareas
    SET descripcion = @descripcion, cedula = @cedula
    WHERE idTarea = @idTarea;
END;
-- Eliminar en la tabla tarea
GO
CREATE PROCEDURE EliminarTarea
    @idTarea INT
AS
BEGIN
    DELETE FROM tareas WHERE idTarea = @idTarea;
END;*/
--#####################################################






--#####################################################


EXEC InsertarEmpleado '4-0836-0038','Enrique','Alvarado','Rodriguez','2002-11-23','leiner11@gmail.com',17657777;
EXEC InsertarCorreoElectronico 'juan@gmail.com','1-0836-0038';
EXEC InsertarTelefono 87657777,'1-0836-0038';

EXEC InsertarVehiculo 'ABC123',12,'Toyota','Coaster',2015;
EXEC InsertarVehiculo 'AB323',12,'Mercedes','Sprinter',2012;
EXEC InsertarCliente 'Wave','leiner@gmail.com',67665446;

SELECT 
    SPECIFIC_NAME
FROM 
    INFORMATION_SCHEMA.ROUTINES
WHERE 
    ROUTINE_TYPE = 'PROCEDURE';


exec EliminarEmpleado '4-0836-0038';
exec RegistrarViaje '4-0836-0038','ABC123','Wave','2023-04-12','15:00',30,'San Jose','Fortuna','Viaje a Cartago',100,1;

SELECT * FROM  viajes
exec RegistrarMantenimiento '2023-11-12','Cambio de aceite',100,'ABC123';
SELECT * FROM empleados;
SELECT * FROM correoElectronicosEmpleados;
SELECT * FROM telefonosEmpleados;
SELECT * FROM conductores;
SELECT * FROM administradores;
SELECT * FROM vehiculos;
SELECT * FROM clientes;
SELECT * FROM viajes;
SELECT * FROM transacciones;
SELECT * FROM pagos;










-- Crear una vista para el informe financiero global
DROP VIEW IF EXISTS VistaInformeFinancieroGlobal;


  -- Filtrar por viajes realizados en el año actual;
SELECT * FROM VistaInformeFinancieroGlobal;

-- Crear una vista para el informe financiero de un cliente

DROP VIEW IF EXISTS VistaInformeFinancieroCliente;




-- Consulta de conductores disponibles

-- Consulta de Gastos y pagos por un rango de fechas


-- Consulta todos los viajes realizados por conductores




EXEC ConsultaVehiculosDisponibles

EXEC ConsultarViajesConductores '2023-01-01','2023-12-31';

Select * from vehiculos
