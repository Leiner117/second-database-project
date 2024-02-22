Use TransGaby
CREATE TABLE telefonosClientes (
    Numero PhoneNumber NOT NULL,
    NombreCliente VARCHAR(25) NOT NULL,
    CONSTRAINT pk_telefonoCliente PRIMARY KEY (numero),
    CONSTRAINT fk_telefonoCliente_cliente FOREIGN KEY (nombreCliente) REFERENCES clientes (nombre) ON DELETE CASCADE
);