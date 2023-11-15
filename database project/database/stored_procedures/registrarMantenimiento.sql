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
