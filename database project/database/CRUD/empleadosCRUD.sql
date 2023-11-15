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
CREATE OR ALTER PROCEDURE LeerEmpleado
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
CREATE OR ALTER PROCEDURE EliminarEmpleado
    @id Cedula
AS
BEGIN
    DELETE FROM empleados WHERE Cedula = @id;
END;
--#####################################################
