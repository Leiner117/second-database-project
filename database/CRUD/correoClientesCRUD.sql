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