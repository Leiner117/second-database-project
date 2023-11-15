GO
CREATE PROCEDURE ConsultaConductoresDisponibles
AS
BEGIN
    SELECT
    CONCAT(REPLACE(E.Nombre,' ',''),' ',REPLACE(E.Apellido,' ',''),' ',REPLACE(E.Apellido2,' ','')) AS NombreConductor,
    C.cedula AS CedulaConductor
        
    FROM
        Empleados E
    INNER JOIN
        Conductores C ON E.Cedula = C.cedula
    LEFT JOIN
        Viajes V ON C.cedula = V.CedulaConductor
    WHERE
        V.CedulaConductor IS NULL OR (V.CedulaConductor IS NOT NULL AND V.Estado = 0);
END;