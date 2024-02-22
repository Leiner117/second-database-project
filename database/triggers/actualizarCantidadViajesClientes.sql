GO
CREATE OR ALTER TRIGGER ActualizarCantidadViajesClientes
ON Viajes
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar la cantidad de viajes para los clientes afectados por la inserción
    UPDATE c
    SET c.cantidadViajes = c.cantidadViajes + 1
    FROM Clientes c
    INNER JOIN inserted i ON c.Nombre = i.NombreCliente;

    -- Actualizar la cantidad de viajes para los clientes afectados por la eliminación
    UPDATE c
    SET c.cantidadViajes = c.cantidadViajes - 1
    FROM Clientes c
    INNER JOIN deleted d ON c.Nombre = d.NombreCliente;
END;
