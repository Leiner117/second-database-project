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