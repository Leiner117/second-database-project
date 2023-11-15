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