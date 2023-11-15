--CRUD VEHICULO
-- Insertar en la tabla vehiculo
GO
CREATE PROCEDURE InsertarVehiculo
    @placa CHAR(8),
    @capacidad TINYINT,
    @modelo VARCHAR(20),
    @marca VARCHAR(15),
    @año SMALLINT
AS
BEGIN
    INSERT INTO vehiculos VALUES (@placa, @capacidad, @modelo, @marca, @año,0);
END;
-- Leer en la tabla vehiculo
GO
CREATE PROCEDURE LeerVehiculo
    @placa CHAR(8)
AS
BEGIN
    SELECT * FROM vehiculos WHERE  placa = @placa;
END;
-- Actualizar en la tabla vehiculo
GO
CREATE PROCEDURE ActualizarVehiculo
    @placa CHAR(8),
    @capacidad TINYINT,
    @modelo VARCHAR(20),
    @marca VARCHAR(15),
    @año SMALLINT
AS
BEGIN
    UPDATE vehiculos
    SET capacidad = @capacidad, modelo = @modelo, marca = @marca, año = @año
    WHERE placa = @placa;
END;

-- Eliminar en la tabla vehiculo
GO
CREATE PROCEDURE EliminarVehiculo
    @placa CHAR(8)
AS
BEGIN
    DELETE FROM vehiculos WHERE placa = @placa;
END;
--#####################################################