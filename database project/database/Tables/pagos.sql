Use TransGaby
CREATE TABLE pagos (
    IdPago INT IDENTITY(1,1) NOT NULL,
    IdTransaccion INT NOT NULL,
	IdViaje INT NOT NULL,
    CONSTRAINT pk_pago PRIMARY KEY (idPago),
    CONSTRAINT fk_pago_transaccion FOREIGN KEY (idTransaccion) REFERENCES transacciones (idTransaccion) ON DELETE CASCADE,
	CONSTRAINT fk_pago_viaje FOREIGN KEY (IdViaje) REFERENCES viajes (IdViaje) ON DELETE CASCADE 
);
