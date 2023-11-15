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