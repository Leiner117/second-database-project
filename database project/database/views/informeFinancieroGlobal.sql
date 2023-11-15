CREATE VIEW VistaInformeFinancieroGlobal AS
SELECT
    MIN(T.Fecha) AS FechaInicio,
    MAX(T.Fecha) AS FechaFin,
    --Contar los viajes realizados en el año actual
    COUNT(V.IdViaje) AS ViajesTotales,
    SUM(CASE WHEN G.IdTransaccion IS NOT NULL THEN T.Monto ELSE 0 END) AS GastosTotales,
    SUM(CASE WHEN P.IdTransaccion IS NOT NULL THEN T.Monto ELSE 0 END) AS PagosTotales,
    SUM(CASE WHEN P.IdTransaccion IS NOT NULL THEN T.Monto ELSE -T.Monto END) AS GananciaTotal
FROM
    Transacciones T
LEFT JOIN
    Gastos G ON T.IdTransaccion = G.IdTransaccion
LEFT JOIN
    Pagos P ON T.IdTransaccion = P.IdTransaccion
LEFT JOIN 
    Viajes V ON P.IdViaje = V.IdViaje AND ((YEAR(V.Fecha)) = YEAR(GETDATE()))
WHERE
    YEAR(T.Fecha) = YEAR(GETDATE())  -- Filtrar por viajes realizados en el año actual;