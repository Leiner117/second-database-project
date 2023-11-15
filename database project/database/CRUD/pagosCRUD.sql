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