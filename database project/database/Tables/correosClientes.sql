Use TransGaby
CREATE TABLE correosClientes (
    Correo EmailAddress NOT NULL,
    NombreCliente VARCHAR(25) NOT NULL,
    CONSTRAINT pk_correoCliente PRIMARY KEY (correo),
    CONSTRAINT fk_correoCliente_cliente FOREIGN KEY (nombreCliente) REFERENCES clientes (nombre) ON DELETE CASCADE
);