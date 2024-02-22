-- Consulta de viajes y clientes por un rango de fechas
GO
CREATE OR ALTER PROCEDURE ConsultarViajesYClientes
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT
        COUNT(IdViaje) AS TotalViajes,
        SUM(CantidadPasajeros) AS TotalPersonasTrasladadas
    FROM
        Viajes
    WHERE
        Fecha BETWEEN @FechaInicio AND @FechaFin;
END;
