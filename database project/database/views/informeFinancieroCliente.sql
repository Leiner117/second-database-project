CREATE VIEW VistaInformeFinancieroCliente AS
SELECT
    MIN(T.Fecha) AS FechaInicio,
    MAX(T.Fecha) AS FechaFin,
    COUNT(DISTINCT V.IdViaje) AS ViajesTotales,
    C.Nombre AS NombreCliente,
    SUM(CASE WHEN P.IdTransaccion IS NOT NULL THEN T.Monto ELSE 0 END) AS PagosTotales
FROM
    Transacciones T
LEFT JOIN
    Pagos P ON T.IdTransaccion = P.IdTransaccion
LEFT JOIN 
    Viajes V ON P.IdViaje = V.IdViaje
LEFT JOIN
    Clientes C ON V.NombreCliente = C.Nombre
WHERE
    C.Nombre IS NOT NULL  -- Filtrar clientes con nombres no nulos
GROUP BY
    C.Nombre;