--CRUD VIAJES
-- Insertar en la tabla viajes
GO
CREATE OR ALTER PROCEDURE InsertarViaje
    @cedulaConductor Cedula,
    @vehiculo CHAR(8),
    @nombreCliente VARCHAR(25),
    @fecha DATE,
    @hora TIME,
    @CantidadPasajeros TINYINT,
    @lugarSalida VARCHAR(25),
    @lugarLlegada VARCHAR(25),
    @descripcion VARCHAR(100),
    @precio PositiveMoney,
    @estado BIT
AS
BEGIN
    INSERT INTO viajes VALUES (@cedulaConductor,@vehiculo, @nombreCliente, @fecha, @hora,@CantidadPasajeros,@lugarSalida, @lugarLlegada, @descripcion, @precio, @estado);
END;

-- Leer en la tabla viajes
GO
CREATE PROCEDURE LeerViaje
    @idViaje INT
AS
BEGIN
    SELECT * FROM viajes WHERE  idViaje = @idViaje;
END;
GO
-- Actualizar en la tabla viajes
GO
CREATE OR ALTER PROCEDURE ActualizarViaje
    @idViaje INT,
    @cedulaConductor Cedula,
    @vehiculo CHAR(8),
    @nombreCliente VARCHAR(25),
    @fecha DATE,
    @hora TIME,
    @CantidadPasajeros TINYINT,
    @lugarSalida VARCHAR(25),
    @lugarLlegada VARCHAR(25),
    @descripcion VARCHAR(100),
    @precio PositiveMoney,
    @estado BIT
AS
BEGIN
    UPDATE viajes
    SET cedulaConductor = @cedulaConductor,vehiculo = @vehiculo,nombreCliente = @nombreCliente, fecha = @fecha, hora = @hora,lugarSalida = @lugarSalida, lugarLlegada = @lugarLlegada, descripcion = @descripcion, precio = @precio, estado = @estado,CantidadPasajeros = @CantidadPasajeros
    WHERE idViaje = @idViaje;
END;
-- Eliminar en la tabla viajes
GO
CREATE OR ALTER PROCEDURE EliminarViaje
    @idViaje INT
AS
BEGIN
    DELETE FROM viajes WHERE idViaje = @idViaje;
END;
--#####################################################