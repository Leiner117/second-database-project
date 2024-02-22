GO
CREATE OR ALTER PROCEDURE ConsultarGastosIngresos
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT
        T.IdTransaccion,
        T.Fecha,
        T.Detalle,
        T.Monto,
        CASE
            WHEN G.IdTransaccion IS NOT NULL THEN 'Gasto'
            WHEN P.IdTransaccion IS NOT NULL THEN 'Pago'
            ELSE 'No definido'
        END AS TipoTransaccion
    FROM
        Transacciones T
    LEFT JOIN
        Gastos G ON T.IdTransaccion = G.IdTransaccion
    LEFT JOIN
        Pagos P ON T.IdTransaccion = P.IdTransaccion
    WHERE
        T.Fecha BETWEEN @FechaInicio AND @FechaFin;
END;