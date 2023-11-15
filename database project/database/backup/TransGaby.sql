CREATE DATABASE TransGaby
use TransGaby

-- Tipo de dato Cedula formato 0-0000-0000
CREATE TYPE Cedula FROM CHAR(11);
CREATE RULE RCedula AS 
	@cedula LIKE '[0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
GO
EXEC sp_bindrule 	'RCedula',	'Cedula'
GO

CREATE DEFAULT DCedula AS '0-0000-0000'
GO
EXEC sp_bindefault	'DCedula',	'Cedula'
GO
-- Tipo de dato Email formato a@aa.aa
CREATE TYPE EmailAddress FROM VARCHAR(50) 
CREATE RULE RuleEmail AS
	@email like ('%_@__%.__%')
GO
EXEC sp_bindrule 'RuleEmail', 'EmailAddress'
GO
CREATE DEFAULT DEmail AS 'nombre@gmail.com'
go
EXEC sp_bindefault 'DEmail','EmailAddress'
go
-- Tipo de dato numero de telefono 
CREATE TYPE PhoneNumber FROM int
CREATE RULE RNumber AS 
	@phoneNumber like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
go
EXEC sp_bindrule 'RNumber','PhoneNumber'
go
CREATE DEFAULT DNumber AS '00000000'
go
EXEC sp_bindefault 'DNumber','PhoneNumber'
go
-- Tipo de dato PositiveMoney  para dinero positivo
CREATE TYPE PositiveMoney FROM money
CREATE RULE RPositiveMoney AS 
    @money > 0
go
EXEC sp_bindrule 'RPositiveMoney','PositiveMoney'
GO
CREATE DEFAULT DPositiveMoney AS '0'
go
EXEC sp_bindefault 'DPositiveMoney','PositiveMoney'
go

-- Tipo de dato Fecha de Nacimiento
CREATE TYPE BirthDate FROM date
CREATE RULE RBirthDate AS 
    @birthDate < GETDATE()
go
EXEC sp_bindrule 'RBirthDate','BirthDate'
go
CREATE DEFAULT DBirthDate AS '1900-01-01'
go
EXEC sp_bindefault 'DBirthDate','BirthDate'
go


-- Crea la tabla empleado con los campos Cedula, Nombre, Apellido y Apellido2. La llave primaria es la cedula.
CREATE TABLE  empleados (
    Cedula Cedula NOT NULL,
    Nombre CHAR(15) NOT NULL,
    Apellido CHAR(20) NOT NULL,
    Apellido2 CHAR(20) NOT NULL,
    FechaNacimiento BirthDate NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (Cedula) 
);
/*ALTER TABLE correoElectronico add CONSTRAINT fk_correo_empleado FOREIGN KEY (CedulaEmpleado) REFERENCES empleado (cedula)
ALTER TABLE telefono add CONSTRAINT fk_telefono_empleado FOREIGN KEY (CedulaEmpleado) REFERENCES empleado (cedula)
ALTER TABLE conductor ADD CONSTRAINT fk_conductor_empleado FOREIGN KEY (cedula) REFERENCES CONDUCTOR (cedula)
ALTER TABLE administrador add CONSTRAINT fk_administrador_empleado FOREIGN KEY (cedula) REFERENCES administrador (cedula)
ALTER TABLE vehiculo add CONSTRAINT fk_vehiculo_conductor FOREIGN KEY (cedulaConductor) REFERENCES conductor (cedula)
ALTER TABLE viajes add CONSTRAINT fk_viaje_conductor FOREIGN KEY (cedulaConductor) REFERENCES conductor (cedula)
ALTER TABLE transaccion add CONSTRAINT fk_transaccion_administrador FOREIGN KEY (cedula) REFERENCES administrador (cedula)
ALTER TABLE tarea add CONSTRAINT fk_tarea_empleado FOREIGN KEY (cedula) REFERENCES empleado (cedula)*/

-- Crea la tabla correoElectronico con las columnas Correo y CedulaEmpleado. La columna Correo es de tipo VARCHAR(50) y no puede ser nula. La columna CedulaEmpleado es de tipo INT y no puede ser nula. Además, se establece la restricción pk_correo como clave primaria de la tabla y la restricción fk_correo_empleado como clave foránea que referencia la columna cedula de la tabla empleado.
CREATE TABLE correoElectronicosEmpleados (
    Correo EmailAddress NOT NULL,
    CedulaEmpleado Cedula NOT NULL
    CONSTRAINT pk_correo PRIMARY KEY (correo),
    CONSTRAINT fk_correo_empleado FOREIGN KEY (CedulaEmpleado) REFERENCES empleados (Cedula) ON DELETE CASCADE
);

CREATE TABLE telefonosEmpleados (
    Numero PhoneNumber NOT NULL,
    CedulaEmpleado Cedula NOT NULL
    CONSTRAINT pk_telefono PRIMARY KEY (numero),
    CONSTRAINT fk_telefono_empleado FOREIGN KEY (CedulaEmpleado) REFERENCES empleados (cedula) ON DELETE CASCADE
);

CREATE TABLE conductores(
    cedula Cedula NOT NULL,
    CantidadViajes INT DEFAULT 0,
    CONSTRAINT pk_conductor PRIMARY KEY (cedula),
    CONSTRAINT fk_conductor_empleado FOREIGN KEY (cedula) REFERENCES empleados (cedula) ON DELETE CASCADE
)
/*
Tabla: vehiculo
*/
CREATE TABLE vehiculos (
    Placa CHAR(8) NOT NULL,
    CedulaConductor Cedula NOT NULL,
    Capacidad TINYINT NOT NULL,
    Modelo VARCHAR(20) NOT NULL,
    Marca VARCHAR(15) NOT NULL,
    Año SMALLINT NOT NULL,
	CantidadViajes INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_vehiculo PRIMARY KEY (placa),
    CONSTRAINT fk_vehiculo_conductor FOREIGN KEY (cedulaConductor) REFERENCES conductores (cedula) ON DELETE CASCADE
);

/*CREATE TABLE administradores(
    cedula Cedula NOT NULL,
    CONSTRAINT pk_administrador PRIMARY KEY (cedula),
    CONSTRAINT fk_administrador_empleado FOREIGN KEY (cedula) REFERENCES empleados (cedula) ON DELETE CASCADE
);*/

CREATE TABLE mantenimientoReparaciones (

    IdMantenimiento INT IDENTITY(1,1) NOT NULL,
    Fecha DATE NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    Costo PositiveMoney NOT NULL,
    Placa CHAR(8) NOT NULL
    CONSTRAINT pk_mantenimiento PRIMARY KEY (idMantenimiento),
    CONSTRAINT fk_mantenimiento_vehiculo FOREIGN KEY (placa) REFERENCES vehiculos (placa) ON DELETE CASCADE
);

CREATE TABLE clientes(
    Nombre varchar(25) NOT NULL,
    CantidadViajes INT DEFAULT 0,
    CantidadTransacciones INT DEFAULT 0,

    CONSTRAINT pk_cliente PRIMARY KEY (nombre)
);
CREATE TABLE correosClientes (
    Correo EmailAddress NOT NULL,
    NombreCliente VARCHAR(25) NOT NULL,
    CONSTRAINT pk_correoCliente PRIMARY KEY (correo),
    CONSTRAINT fk_correoCliente_cliente FOREIGN KEY (nombreCliente) REFERENCES clientes (nombre) ON DELETE CASCADE
);
CREATE TABLE telefonosClientes (
    Numero PhoneNumber NOT NULL,
    NombreCliente VARCHAR(25) NOT NULL,
    CONSTRAINT pk_telefonoCliente PRIMARY KEY (numero),
    CONSTRAINT fk_telefonoCliente_cliente FOREIGN KEY (nombreCliente) REFERENCES clientes (nombre) ON DELETE CASCADE
);

CREATE TABLE viajes(
    IdViaje INT IDENTITY(1,1) NOT NULL,
    CedulaConductor Cedula NOT NULL,
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
    CONSTRAINT chk_viaje_estado CHECK (Estado = 0 OR Estado = 1)
);

/*CREATE TABLE tareas (
    IdTarea INT IDENTITY(1,1) NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    Cedula Cedula NOT NULL,
    CONSTRAINT pk_tarea PRIMARY KEY (idTarea),
    CONSTRAINT fk_tarea_empleado FOREIGN KEY (cedula) REFERENCES empleados (cedula) ON DELETE CASCADE
);*/

CREATE TABLE transacciones (
    IdTransaccion INT IDENTITY(1,1) NOT NULL,
    Fecha DATE NOT NULL,
    Monto PositiveMoney NOT NULL,
    Detalle VARCHAR(100) NOT NULL,
    CONSTRAINT pk_transaccion PRIMARY KEY (idTransaccion)
);


CREATE TABLE pagos (
    IdPago INT IDENTITY(1,1) NOT NULL,
    IdTransaccion INT NOT NULL,
	IdViaje INT NOT NULL,
    CONSTRAINT pk_pago PRIMARY KEY (idPago),
    CONSTRAINT fk_pago_transaccion FOREIGN KEY (idTransaccion) REFERENCES transacciones (idTransaccion) ON DELETE CASCADE,
	CONSTRAINT fk_pago_viaje FOREIGN KEY (IdViaje) REFERENCES viajes (IdViaje) ON DELETE CASCADE 
);


CREATE TABLE gastos (
    IdGasto INT IDENTITY(1,1) NOT NULL,
    IdTransaccion INT NOT NULL,
    CONSTRAINT pk_gasto PRIMARY KEY (idGasto),
    CONSTRAINT fk_gasto_transaccion FOREIGN KEY (idTransaccion) REFERENCES transacciones (idTransaccion) ON DELETE CASCADE
);



--CRUD EMPLEADOS
-- Insertar en la tabla empleado

GO
CREATE OR ALTER PROCEDURE InsertarEmpleado
    @id Cedula,
    @nombre VARCHAR(50),
    @apellido1 VARCHAR(50),
    @apellido2 VARCHAR(50),
    @fecha BirthDate,
    @correo EmailAddress,
    @numero PhoneNumber
AS
BEGIN
    INSERT INTO empleados VALUES (@id, @nombre, @apellido1, @apellido2, @fecha);
    EXEC InsertarConductor @id;
    EXEC InsertarCorreoElectronico @correo, @id;
    EXEC InsertarTelefono @numero, @id;
END;

-- Leer en la tabla empleado
GO
CREATE PROCEDURE LeerEmpleado
    @id Cedula
AS
BEGIN
    SELECT * FROM empleados WHERE Cedula = @id;
END;
-- Actualizar en la tabla empleado
GO
CREATE OR ALTER PROCEDURE ActualizarEmpleado
    @id Cedula,
    @nombre NVARCHAR(50),
    @apellido1 NVARCHAR(50),
    @apellido2 NVARCHAR(50),
    @fecha BirthDate,
    @correo EmailAddress,
    @numero PhoneNumber

AS
BEGIN
    UPDATE empleados
    SET nombre = @nombre, apellido = @apellido1, apellido2 = @apellido2, fechaNacimiento = @fecha
    WHERE Cedula = @id;
    EXEC ActualizarCorreoElectronico @correo, @id;
    EXEC ActualizarTelefono @numero, @id;
END;

-- Eliminar en la tabla empleado
GO
CREATE PROCEDURE EliminarEmpleado
    @id Cedula
AS
BEGIN
    DELETE FROM empleados WHERE Cedula = @id;
END;
--#####################################################

--CRUD CORREO ELECTRONICO
-- Insertar en la tabla correoElectronico

GO
CREATE PROCEDURE InsertarCorreoElectronico
    @correo EmailAddress,
    @cedula Cedula
AS
BEGIN
    INSERT INTO correoElectronicosEmpleados VALUES (@correo, @cedula);
END;
-- Leer en la tabla correoElectronico
GO
CREATE PROCEDURE LeerCorreoElectronico
    @cedula Cedula
AS
BEGIN
    SELECT * FROM correoElectronicosEmpleados WHERE  CedulaEmpleado = @cedula;
END;
-- Actualizar en la tabla correoElectronico
GO
CREATE PROCEDURE ActualizarCorreoElectronico
    @correo EmailAddress,
    @cedula Cedula
AS
BEGIN
    UPDATE correoElectronicosEmpleados
    SET correo = @correo
    WHERE CedulaEmpleado = @cedula AND correo = @correo;
END;
GO

-- Eliminar en la tabla correoElectronico

GO
CREATE PROCEDURE EliminarCorreoElectronico
    @correo EmailAddress,
    @cedula Cedula
AS
BEGIN
    DELETE FROM correoElectronicosEmpleados WHERE CedulaEmpleado = @cedula AND correo = @correo;
END;
--#####################################################
--CRUD TELEFONO
-- Insertar en la tabla telefono

GO
CREATE PROCEDURE InsertarTelefono
    @numero PhoneNumber,
    @cedula Cedula
AS
BEGIN
    INSERT INTO telefonosEmpleados VALUES (@numero, @cedula);
END;

-- Leer en la tabla telefono
GO
CREATE PROCEDURE LeerTelefono
    @cedula Cedula
AS
BEGIN
    SELECT * FROM telefonosEmpleados WHERE  CedulaEmpleado = @cedula;
END;
-- Actualizar en la tabla telefono
GO
CREATE PROCEDURE ActualizarTelefono
    @numero PhoneNumber,
    @cedula Cedula
AS
BEGIN
    UPDATE telefonosEmpleados
    SET numero = @numero
    WHERE CedulaEmpleado = @cedula AND numero = @numero;
END;
-- Eliminar en la tabla telefono
GO
CREATE PROCEDURE EliminarTelefono
    @numero PhoneNumber,
    @cedula Cedula
AS
BEGIN
    DELETE FROM telefonosEmpleados WHERE CedulaEmpleado = @cedula AND numero = @numero;
END;
--#####################################################
--CRUD CONDUCTOR
-- Insertar en la tabla conductor
GO
CREATE PROCEDURE InsertarConductor
    @cedula Cedula
AS
BEGIN
    INSERT INTO conductores VALUES (@cedula,0);
END;
-- Leer en la tabla conductor
GO
CREATE PROCEDURE LeerConductor
    @cedula Cedula
AS
BEGIN
    SELECT * FROM conductores WHERE  cedula = @cedula;
END;
-- Actualizar en la tabla conductor
GO
CREATE PROCEDURE ActualizarConductor
    @cedula Cedula
AS
BEGIN
    UPDATE conductores
    SET cedula = @cedula
    WHERE cedula = @cedula;
END;

-- Eliminar en la tabla conductor
GO
CREATE PROCEDURE EliminarConductor
    @cedula Cedula
AS
BEGIN
    DELETE FROM conductores WHERE cedula = @cedula;
END;
--#####################################################
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
END;
--#####################################################
--CRUD VEHICULO
-- Insertar en la tabla vehiculo
GO
CREATE PROCEDURE InsertarVehiculo
    @placa CHAR(8),
    @cedulaConductor Cedula,
    @capacidad TINYINT,
    @modelo VARCHAR(20),
    @marca VARCHAR(15),
    @año SMALLINT
AS
BEGIN
    INSERT INTO vehiculos VALUES (@placa, @cedulaConductor, @capacidad, @modelo, @marca, @año,0);
END;
-- Leer en la tabla vehiculo
GO
CREATE PROCEDURE LeerVehiculo
    @placa CHAR(8)
AS
BEGIN
    SELECT * FROM vehiculos WHERE  placa = @placa;
END;
-- Actualizar en la tabla vehiculo
GO
CREATE PROCEDURE ActualizarVehiculo
    @placa CHAR(8),
    @cedulaConductor Cedula,
    @capacidad TINYINT,
    @modelo VARCHAR(20),
    @marca VARCHAR(15),
    @año SMALLINT
AS
BEGIN
    UPDATE vehiculos
    SET cedulaConductor = @cedulaConductor, capacidad = @capacidad, modelo = @modelo, marca = @marca, año = @año
    WHERE placa = @placa;
END;

-- Eliminar en la tabla vehiculo
GO
CREATE PROCEDURE EliminarVehiculo
    @placa CHAR(8)
AS
BEGIN
    DELETE FROM vehiculos WHERE placa = @placa;
END;
--#####################################################
--CRUD CLIENTES
-- Insertar en la tabla clientes
GO
CREATE OR ALTER PROCEDURE InsertarCliente
    @nombre VARCHAR(25),
    @correo EmailAddress,
    @numero PhoneNumber
AS
BEGIN
    INSERT INTO clientes VALUES (@nombre,0,0);
    EXEC InsertarCorreosClientes @correo, @nombre;
    EXEC InsertarTelefonosClientes @numero, @nombre;
END;

-- Leer en la tabla clientes
GO
CREATE PROCEDURE LeerCliente
    @nombre VARCHAR(25)
AS
BEGIN
    SELECT * FROM clientes WHERE  nombre = @nombre;
END;

-- Actualizar en la tabla clientes
GO
CREATE OR ALTER PROCEDURE ActualizarCliente
    @nombre VARCHAR(25),
    @correo EmailAddress,
    @numero PhoneNumber
AS
BEGIN
    UPDATE clientes
    SET nombre = @nombre
    WHERE nombre = @nombre;
    EXEC ActualizarCorreosClientes @correo, @nombre;
    EXEC ActualizarTelefonosClientes @numero, @nombre;
END;

-- Eliminar en la tabla clientes
GO
CREATE PROCEDURE EliminarCliente
    @nombre VARCHAR(25)
AS
BEGIN
    DELETE FROM clientes WHERE nombre = @nombre;
END;
--#####################################################
--CRUD VIAJES
-- Insertar en la tabla viajes
GO
CREATE OR ALTER PROCEDURE InsertarViaje
    @cedulaConductor Cedula,
    @nombreCliente VARCHAR(25),
    @fecha DATE,
    @hora TIME,
    @CantidadPasajeros TINYINT,
    @lugarSalida VARCHAR(25),
    @lugarLlegada VARCHAR(25),
    @descripcion VARCHAR(100),
    @precio PositiveMoney,
    @estado BIT
AS
BEGIN
    INSERT INTO viajes VALUES (@cedulaConductor, @nombreCliente, @fecha, @hora,@CantidadPasajeros,@lugarSalida, @lugarLlegada, @descripcion, @precio, @estado);
END;

-- Leer en la tabla viajes
GO
CREATE PROCEDURE LeerViaje
    @idViaje INT
AS
BEGIN
    SELECT * FROM viajes WHERE  idViaje = @idViaje;
END;
GO
-- Actualizar en la tabla viajes
GO
CREATE OR ALTER PROCEDURE ActualizarViaje
    @idViaje INT,
    @cedulaConductor Cedula,
    @nombreCliente VARCHAR(25),
    @fecha DATE,
    @hora TIME,
    @CantidadPasajeros TINYINT,
    @lugarSalida VARCHAR(25),
    @lugarLlegada VARCHAR(25),
    @descripcion VARCHAR(100),
    @precio PositiveMoney,
    @estado BIT
AS
BEGIN
    UPDATE viajes
    SET cedulaConductor = @cedulaConductor, nombreCliente = @nombreCliente, fecha = @fecha, hora = @hora,lugarSalida = @lugarSalida, lugarLlegada = @lugarLlegada, descripcion = @descripcion, precio = @precio, estado = @estado,CantidadPasajeros = @CantidadPasajeros
    WHERE idViaje = @idViaje;
END;
-- Eliminar en la tabla viajes
GO
CREATE OR ALTER PROCEDURE EliminarViaje
    @idViaje INT
AS
BEGIN
    DELETE FROM viajes WHERE idViaje = @idViaje;
END;
--#####################################################
--CRUD TAREA
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
END;
--#####################################################
--CRUD TRANSACCION
-- Insertar en la tabla transaccion
GO
CREATE PROCEDURE InsertarTransaccion
    @fecha DATE,
    @monto PositiveMoney,
    @detalle VARCHAR(100)
AS
BEGIN
    INSERT INTO transacciones VALUES (@fecha, @monto, @detalle);
END;
-- Leer en la tabla transaccion
GO
CREATE PROCEDURE LeerTransaccion
    @idTransaccion INT
AS
BEGIN
    SELECT * FROM transacciones WHERE  idTransaccion = @idTransaccion;
END;
-- Actualizar en la tabla transaccion
GO
CREATE PROCEDURE ActualizarTransaccion
    @idTransaccion INT,
    @fecha DATE,
    @monto MONEY,
    @detalle VARCHAR(100)
AS
BEGIN
    UPDATE transacciones
    SET fecha = @fecha, monto = @monto, detalle = @detalle
    WHERE idTransaccion = @idTransaccion;
END;
-- Eliminar en la tabla transaccion
GO
CREATE PROCEDURE EliminarTransaccion
    @idTransaccion INT
AS
BEGIN
    DELETE FROM transacciones WHERE idTransaccion = @idTransaccion;
END;
--#####################################################
--CRUD PAGO
-- Insertar en la tabla pago
GO
CREATE OR ALTER PROCEDURE InsertarPago
    @idTransaccion INT,
    @idViaje INT
AS
BEGIN
    INSERT INTO pagos VALUES (@idTransaccion,@idViaje);
END;
-- Leer en la tabla pago
GO
CREATE PROCEDURE LeerPago
    @idPago INT
AS
BEGIN
    SELECT * FROM pagos WHERE  idPago = @idPago;
END;
-- Actualizar en la tabla pago
GO
CREATE PROCEDURE ActualizarPago
    @idPago INT,
    @idTransaccion INT,
    @idViaje INT
AS
BEGIN
    UPDATE pagos
    SET idTransaccion = @idTransaccion , idViaje = @idViaje
    WHERE idPago = @idPago;
END;
-- Eliminar en la tabla pago
GO
CREATE PROCEDURE EliminarPago
    @idPago INT
AS
BEGIN

    DELETE FROM pagos WHERE idPago = @idPago;
END;
--#####################################################
--CRUD GASTO
-- Insertar en la tabla gasto
GO
CREATE PROCEDURE InsertarGasto
    @idTransaccion INT
AS
BEGIN
    INSERT INTO gastos VALUES (@idTransaccion);
END;
-- Leer en la tabla gasto
GO
CREATE PROCEDURE LeerGasto
    @idGasto INT
AS
BEGIN
    SELECT * FROM gastos WHERE  idGasto = @idGasto;
END;
-- Actualizar en la tabla gasto
GO
CREATE PROCEDURE ActualizarGasto
    @idGasto INT,
    @idTransaccion INT
AS
BEGIN
    UPDATE gastos
    SET idTransaccion = @idTransaccion
    WHERE idGasto = @idGasto;
END;
-- Eliminar en la tabla gasto
GO
CREATE PROCEDURE EliminarGasto
    @idGasto INT
AS
BEGIN
    DELETE FROM gastos WHERE idGasto = @idGasto;
END;
--#####################################################
--CRUD MANTENIMIENTO REPARACIONES
-- Insertar en la tabla mantenimientoReparaciones
GO
CREATE  OR ALTER PROCEDURE InsertarMantenimientoReparaciones
    @fecha DATE,
    @descripcion VARCHAR(100),
    @costo PositiveMoney,
    @placa CHAR(8)
AS
BEGIN
    INSERT INTO mantenimientoReparaciones VALUES (@fecha, @descripcion, @costo, @placa);
END;
-- Leer en la tabla mantenimientoReparaciones
GO
CREATE OR ALTER PROCEDURE  LeerMantenimientoReparaciones
    @idMantenimiento INT
AS
BEGIN
    SELECT * FROM mantenimientoReparaciones WHERE  idMantenimiento = @idMantenimiento;
END;
-- Actualizar en la tabla mantenimientoReparaciones
GO
CREATE OR ALTER PROCEDURE ActualizarMantenimientoReparaciones
    @idMantenimiento INT,
    @fecha DATE,
    @descripcion VARCHAR(100),
    @costo PositiveMoney,
    @placa CHAR(8)
AS
BEGIN
    UPDATE mantenimientoReparaciones
    SET fecha = @fecha, descripcion = @descripcion, costo = @costo, placa = @placa
    WHERE idMantenimiento = @idMantenimiento;
END;
-- Eliminar en la tabla mantenimientoReparaciones
GO
CREATE OR ALTER PROCEDURE EliminarMantenimientoReparaciones
    @idMantenimiento INT
AS
BEGIN
    DELETE FROM mantenimientoReparaciones WHERE idMantenimiento = @idMantenimiento;
END;
--#####################################################
--CRUD CORREOS CLIENTES
-- Insertar en la tabla correosClientes
GO
CREATE PROCEDURE InsertarCorreosClientes
    @correo EmailAddress,
    @nombreCliente VARCHAR(25)
AS
BEGIN
    INSERT INTO correosClientes VALUES (@correo, @nombreCliente);
END;
-- Leer en la tabla correosClientes
GO
CREATE PROCEDURE LeerCorreosClientes
    @correo EmailAddress
AS
BEGIN
    SELECT * FROM correosClientes WHERE  correo = @correo;
END;
-- Actualizar en la tabla correosClientes
GO
CREATE PROCEDURE ActualizarCorreosClientes
    @correo EmailAddress,
    @nombreCliente VARCHAR(25)

AS
BEGIN
    UPDATE correosClientes
    SET nombreCliente = @nombreCliente
    WHERE correo = @correo;
END;
-- Eliminar en la tabla correosClientes
GO
CREATE PROCEDURE EliminarCorreosClientes
    @correo EmailAddress
AS
BEGIN
    DELETE FROM correosClientes WHERE correo = @correo;
END;
--#####################################################
--CRUD TELEFONOS CLIENTES
-- Insertar en la tabla telefonosClientes
GO
CREATE PROCEDURE InsertarTelefonosClientes
    @numero PhoneNumber,
    @nombreCliente VARCHAR(25)
AS
BEGIN
    INSERT INTO telefonosClientes VALUES (@numero, @nombreCliente);
END;
-- Leer en la tabla telefonosClientes
GO
CREATE PROCEDURE LeerTelefonosClientes
    @numero PhoneNumber
AS
BEGIN
    SELECT * FROM telefonosClientes WHERE  numero = @numero;
END;
-- Actualizar en la tabla telefonosClientes
GO
CREATE PROCEDURE ActualizarTelefonosClientes
    @numero PhoneNumber,
    @nombreCliente VARCHAR(25)
AS
BEGIN
    UPDATE telefonosClientes
    SET nombreCliente = @nombreCliente
    WHERE numero = @numero;
END;
-- Eliminar en la tabla telefonosClientes
GO
CREATE PROCEDURE EliminarTelefonosClientes
    @numero PhoneNumber
AS
BEGIN
    DELETE FROM telefonosClientes WHERE numero = @numero;
END;
--#####################################################


EXEC InsertarEmpleado '4-0836-0038','Enrique','Alvarado','Rodriguez','2002-11-23','leiner11@gmail.com',17657777;

EXEC InsertarCorreoElectronico 'juan@gmail.com','1-0836-0038';
EXEC InsertarTelefono 87657777,'1-0836-0038';
EXEC InsertarConductor '1-0836-0038';
EXEC InsertarAdministrador '2-0836-0038';
EXEC InsertarVehiculo 'ABC123','1-0836-0038',12,'Toyota','Coaster',2015;
EXEC InsertarVehiculo 'AB323','1-0836-0038',12,'Mercedes','Sprinter',2012;
EXEC InsertarCliente 'Wave';

SELECT 
    SPECIFIC_NAME
FROM 
    INFORMATION_SCHEMA.ROUTINES
WHERE 
    ROUTINE_TYPE = 'PROCEDURE';
-- Realizar un viaje
GO
CREATE OR ALTER PROCEDURE RegistrarViaje
    @cedulaConductor Cedula,
    @nombreCliente VARCHAR(25),
    @fecha DATE,
    @hora TIME,
    @CantidadPasajeros TINYINT,
    @lugarSalida VARCHAR(25),
    @lugarLlegada VARCHAR(25),
    @descripcion VARCHAR(100),
    @precio PositiveMoney,
    @estado BIT
AS
BEGIN
    BEGIN TRANSACTION;
    --DECLARE @idViaje INT;
    DECLARE @idViaje INT;
    DECLARE @idTransaccion INT;
    BEGIN TRY
        -- Insertar en la tabla viajes
        
        IF NOT EXISTS (SELECT * FROM viajes WHERE cedulaConductor = @cedulaConductor AND fecha = @fecha AND hora = @hora)
        BEGIN
            EXEC InsertarViaje @cedulaConductor, @nombreCliente, @fecha, @hora,@CantidadPasajeros,@lugarSalida, @lugarLlegada, @descripcion, @precio, @estado;
            SET @idViaje = @@IDENTITY;
           
        END
        ELSE
        BEGIN
            THROW 50001, 'No se puede aprobar el viaje. Verifique la disponibilidad o estado del viaje.', 1;
            ROLLBACK TRANSACTION;
            RETURN;
        END 

        -- Realizar la transacción de pago

        EXEC InsertarTransaccion @fecha, @precio, 'Pago por viaje realizado';
        
        SET @idTransaccion = @@Identity;
       
        EXEC InsertarPago @idTransaccion, @idViaje;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        -- Manejar el error (puedes registrar en una tabla de errores, lanzar una excepción, etc.)
        -- Imprimir mensaje de error
        PRINT ERROR_MESSAGE();
    END CATCH
END;
-- Realizar el mantenimiento de un vehículo
GO
CREATE OR ALTER PROCEDURE RegistrarMantenimiento
    @fecha DATE,
    @descripcion VARCHAR(100),
    @costo positiveMoney,
    @placa CHAR(8)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        EXEC InsertarMantenimientoReparaciones @fecha, @descripcion, @costo, @placa;
        DECLARE @idTransaccion INT;
        EXEC InsertarTransaccion @fecha, @costo, 'Gasto por mantenimiento del vehículo';
        SELECT @idTransaccion = @@IDENTITY;
        EXEC InsertarGasto @idTransaccion;
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT ERROR_MESSAGE();
    END CATCH
END;

exec EliminarEmpleado '4-0836-0038';
exec RegistrarViaje '4-0836-0038','Wave','2023-04-12','15:00',30,'San Jose','Fortuna','Viaje a Cartago',100,1;

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


-- Trigger para actualizar la cantidad de viajes de un vehiculo 
GO
CREATE OR ALTER TRIGGER ActualizarCantidadViajesVehiculo
ON Viajes
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar la cantidad de viajes para los vehículos afectados por la inserción
    UPDATE v
    SET v.cantidadViajes = v.cantidadViajes + 1
    FROM Vehiculos v
    INNER JOIN inserted i ON v.CedulaConductor = i.CedulaConductor;

    -- Actualizar la cantidad de viajes para los vehículos afectados por la eliminación
    UPDATE v
    SET v.cantidadViajes = v.cantidadViajes - 1
    FROM Vehiculos v
    INNER JOIN deleted d ON v.CedulaConductor = d.CedulaConductor;
END;



--Trigger para actualizar la cantidad de viajes de un conductor
GO
CREATE OR ALTER TRIGGER ActualizarCantidadViajesConductor
ON Viajes
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar la cantidad de viajes para los conductores afectados por la inserción
    UPDATE c
    SET c.cantidadViajes = c.cantidadViajes + 1
    FROM Conductores c
    INNER JOIN inserted i ON c.Cedula = i.CedulaConductor;

    -- Actualizar la cantidad de viajes para los conductores afectados por la eliminación
    UPDATE c
    SET c.cantidadViajes = c.cantidadViajes - 1
    FROM Conductores c
    INNER JOIN deleted d ON c.Cedula = d.CedulaConductor;
END;
GO
CREATE OR ALTER TRIGGER ActualizarCantidadViajesClientes
ON Viajes
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar la cantidad de viajes para los clientes afectados por la inserción
    UPDATE c
    SET c.cantidadViajes = c.cantidadViajes + 1
    FROM Clientes c
    INNER JOIN inserted i ON c.Nombre = i.NombreCliente;

    -- Actualizar la cantidad de viajes para los clientes afectados por la eliminación
    UPDATE c
    SET c.cantidadViajes = c.cantidadViajes - 1
    FROM Clientes c
    INNER JOIN deleted d ON c.Nombre = d.NombreCliente;
END;


GO
-- Trigger para borrar transaccion relacionada a un pago
CREATE OR ALTER TRIGGER EliminarTransaccionPago

ON Pagos
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Eliminar la transacción relacionada al pago
    DELETE FROM Transacciones
    WHERE IdTransaccion IN (SELECT IdTransaccion FROM deleted);
END;



-- Crear una vista para el informe financiero global
DROP VIEW IF EXISTS VistaInformeFinancieroGlobal;

CREATE VIEW VistaInformeFinancieroGlobal AS
SELECT
    MIN(T.Fecha) AS FechaInicio,
    MAX(T.Fecha) AS FechaFin,
    --Contar los viajes realizados en el año actual
    COUNT(V.IdViaje) AS ViajesTotales,
    SUM(CASE WHEN G.IdTransaccion IS NOT NULL THEN T.Monto ELSE 0 END) AS GastosTotales,
    SUM(CASE WHEN P.IdTransaccion IS NOT NULL THEN T.Monto ELSE 0 END) AS PagosTotales,
    SUM(CASE WHEN P.IdTransaccion IS NOT NULL THEN T.Monto ELSE -T.Monto END) AS GananciaTotal
FROM
    Transacciones T
LEFT JOIN
    Gastos G ON T.IdTransaccion = G.IdTransaccion
LEFT JOIN
    Pagos P ON T.IdTransaccion = P.IdTransaccion
LEFT JOIN 
    Viajes V ON P.IdViaje = V.IdViaje AND ((YEAR(V.Fecha)) = YEAR(GETDATE()))
WHERE
    YEAR(T.Fecha) = YEAR(GETDATE())  -- Filtrar por viajes realizados en el año actual;
  -- Filtrar por viajes realizados en el año actual;
SELECT * FROM VistaInformeFinancieroGlobal;

-- Crear una vista para el informe financiero de un cliente

DROP VIEW IF EXISTS VistaInformeFinancieroCliente;
CREATE VIEW VistaInformeFinancieroCliente AS
SELECT
    MIN(T.Fecha) AS FechaInicio,
    MAX(T.Fecha) AS FechaFin,
    COUNT(DISTINCT V.IdViaje) AS ViajesTotales,
    C.Nombre AS NombreCliente,
    SUM(CASE WHEN P.IdTransaccion IS NOT NULL THEN T.Monto ELSE 0 END) AS PagosTotales
FROM
    Transacciones T
LEFT JOIN
    Pagos P ON T.IdTransaccion = P.IdTransaccion
LEFT JOIN 
    Viajes V ON P.IdViaje = V.IdViaje
LEFT JOIN
    Clientes C ON V.NombreCliente = C.Nombre
WHERE
    C.Nombre IS NOT NULL  -- Filtrar clientes con nombres no nulos
GROUP BY
    C.Nombre;

-- Crear una vista para el informe de mantenimientos realizados por cada vehículo

CREATE VIEW VistaMantenimientosPorVehiculo AS
SELECT
    Placa,
    COUNT(IdMantenimiento) AS CantidadMantenimientos
FROM
    mantenimientoReparaciones
GROUP BY
    Placa;

-- Consulta de conductores disponibles
GO
CREATE PROCEDURE ConsultaConductoresDisponibles
AS
BEGIN
    SELECT
    CONCAT(REPLACE(E.Nombre,' ',''),' ',REPLACE(E.Apellido,' ',''),' ',REPLACE(E.Apellido2,' ','')) AS NombreConductor,
    C.cedula AS CedulaConductor
        
    FROM
        Empleados E
    INNER JOIN
        Conductores C ON E.Cedula = C.cedula
    LEFT JOIN
        Viajes V ON C.cedula = V.CedulaConductor
    WHERE
        V.CedulaConductor IS NULL OR (V.CedulaConductor IS NOT NULL AND V.Estado = 0);
END;
-- Consulta de Gastos y pagos por un rango de fechas
GO
CREATE OR ALTER PROCEDURE ConsultarGastosIngresos
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT
        T.IdTransaccion,
        T.Fecha,
        T.Detalle,
        T.Monto,
        CASE
            WHEN G.IdTransaccion IS NOT NULL THEN 'Gasto'
            WHEN P.IdTransaccion IS NOT NULL THEN 'Pago'
            ELSE 'No definido'
        END AS TipoTransaccion
    FROM
        Transacciones T
    LEFT JOIN
        Gastos G ON T.IdTransaccion = G.IdTransaccion
    LEFT JOIN
        Pagos P ON T.IdTransaccion = P.IdTransaccion
    WHERE
        T.Fecha BETWEEN @FechaInicio AND @FechaFin;
END;
-- Consulta de viajes y clientes por un rango de fechas
GO
CREATE OR ALTER PROCEDURE ConsultarViajesYClientes
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT
        COUNT(IdViaje) AS TotalViajes,
        SUM(CantidadPasajeros) AS TotalPersonasTrasladadas
    FROM
        Viajes
    WHERE
        Fecha BETWEEN @FechaInicio AND @FechaFin;
END;

-- Consulta todos los viajes realizados por conductores
GO
CREATE OR ALTER PROCEDURE ConsultarViajesConductores
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT
        CONCAT(REPLACE(E.Nombre,' ',''),' ',REPLACE(E.Apellido,' ',''),' ',REPLACE(E.Apellido2,' ','')) AS NombreConductor,
        C.cedula AS CedulaConductor,
        COUNT(V.IdViaje) AS TotalViajes,
        SUM(CantidadPasajeros) AS TotalPersonasTrasladadas
    FROM
        Empleados E
    INNER JOIN
        Conductores C ON E.Cedula = C.cedula
    INNER JOIN
        Viajes V ON C.cedula = V.CedulaConductor
    WHERE
        V.Fecha BETWEEN @FechaInicio AND @FechaFin
    GROUP BY
        C.cedula,
        E.Nombre,
        E.Apellido,
        E.Apellido2;
END;

-- Consultar los vehiculos disponibles
GO
CREATE OR ALTER PROCEDURE ConsultaVehiculosDisponibles
AS
BEGIN
    SELECT
        V.Placa,
        V.Marca,
        V.Modelo
    FROM
        Vehiculos V
    LEFT JOIN
        Viajes VT ON V.CedulaConductor = VT.CedulaConductor
    LEFT JOIN 
        conductores C ON C.Cedula = V.CedulaConductor
    WHERE
        VT.CedulaConductor IS NULL OR (VT.CedulaConductor IS NOT NULL AND VT.Estado = 0);
END;


EXEC ConsultaVehiculosDisponibles

EXEC ConsultarViajesConductores '2023-01-01','2023-12-31';

Select * from vehiculos
