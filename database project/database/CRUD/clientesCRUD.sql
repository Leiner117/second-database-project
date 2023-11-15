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
CREATE OR ALTER PROCEDURE LeerCliente
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
CREATE OR ALTER PROCEDURE EliminarCliente
    @nombre VARCHAR(25)
AS
BEGIN
    DELETE FROM clientes WHERE nombre = @nombre;
END;
--#####################################################