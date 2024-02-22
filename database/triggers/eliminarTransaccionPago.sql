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
