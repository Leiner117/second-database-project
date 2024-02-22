GO
CREATE OR ALTER PROCEDURE ConsultarViajesConductores
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT
        CONCAT(REPLACE(E.Nombre,' ',''),' ',REPLACE(E.Apellido,' ',''),' ',REPLACE(E.Apellido2,' ','')) AS NombreConductor,
        C.cedula AS CedulaConductor,
        COUNT(V.IdViaje) AS TotalViajes,
        SUM(CantidadPasajeros) AS TotalPersonasTrasladadas
    FROM
        Empleados E
    INNER JOIN
        Conductores C ON E.Cedula = C.cedula
    INNER JOIN
        Viajes V ON C.cedula = V.CedulaConductor
    WHERE
        V.Fecha BETWEEN @FechaInicio AND @FechaFin
    GROUP BY
        C.cedula,
        E.Nombre,
        E.Apellido,
        E.Apellido2;
END;