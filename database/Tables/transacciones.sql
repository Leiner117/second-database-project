Use TransGaby
CREATE TABLE transacciones (
    IdTransaccion INT IDENTITY(1,1) NOT NULL,
    Fecha DATE NOT NULL,
    Monto PositiveMoney NOT NULL,
    Detalle VARCHAR(100) NOT NULL,
    CONSTRAINT pk_transaccion PRIMARY KEY (idTransaccion)
);
