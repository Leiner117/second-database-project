--Trigger para actualizar la cantidad de viajes de un conductor
GO
CREATE OR ALTER TRIGGER ActualizarCantidadViajesConductor
ON Viajes
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar la cantidad de viajes para los conductores afectados por la inserción
    UPDATE c
    SET c.cantidadViajes = c.cantidadViajes + 1
    FROM Conductores c
    INNER JOIN inserted i ON c.Cedula = i.CedulaConductor;

    -- Actualizar la cantidad de viajes para los conductores afectados por la eliminación
    UPDATE c
    SET c.cantidadViajes = c.cantidadViajes - 1
    FROM Conductores c
    INNER JOIN deleted d ON c.Cedula = d.CedulaConductor;
END;