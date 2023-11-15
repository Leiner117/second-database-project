CREATE OR ALTER PROCEDURE ConsultaVehiculosDisponibles
AS
BEGIN
    SELECT
        V.Placa,
        V.Marca,
        V.Modelo,
        V.Año,
        V.Capacidad
    FROM
        Vehiculos V
    LEFT JOIN
        Viajes VT ON V.Placa = VT.Vehiculo
    WHERE
        (VT.CedulaConductor IS NULL OR (VT.CedulaConductor IS NOT NULL AND VT.Estado = 0))
        OR VT.Vehiculo IS NULL;
END;

