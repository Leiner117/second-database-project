Use TransGaby
CREATE TABLE gastos (
    IdGasto INT IDENTITY(1,1) NOT NULL,
    IdTransaccion INT NOT NULL,
    CONSTRAINT pk_gasto PRIMARY KEY (idGasto),
    CONSTRAINT fk_gasto_transaccion FOREIGN KEY (idTransaccion) REFERENCES transacciones (idTransaccion) ON DELETE CASCADE
);