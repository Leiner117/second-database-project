-- Trigger para actualizar la cantidad de viajes de un vehiculo 
GO
CREATE OR ALTER TRIGGER ActualizarCantidadViajesVehiculo
ON Viajes
AFTER INSERT, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar la cantidad de viajes para los vehículos afectados por la inserción
    UPDATE v
    SET v.cantidadViajes = v.cantidadViajes + 1
    FROM Vehiculos v
    INNER JOIN inserted i ON v.Placa = i.Vehiculo;

    -- Actualizar la cantidad de viajes para los vehículos afectados por la eliminación
    UPDATE v
    SET v.cantidadViajes = v.cantidadViajes - 1
    FROM Vehiculos v
    INNER JOIN deleted d ON v.Placa = d.Vehiculo;
END;
