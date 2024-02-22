GO
CREATE OR ALTER PROCEDURE RegistrarViaje
    @cedulaConductor Cedula,
	@vehiculo char(8),
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
            EXEC InsertarViaje @cedulaConductor,@vehiculo,@nombreCliente, @fecha, @hora,@CantidadPasajeros,@lugarSalida, @lugarLlegada, @descripcion, @precio, @estado;
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