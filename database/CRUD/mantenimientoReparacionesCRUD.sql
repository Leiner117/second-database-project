--CRUD MANTENIMIENTO REPARACIONES
-- Insertar en la tabla mantenimientoReparaciones
GO
CREATE  OR ALTER PROCEDURE InsertarMantenimientoReparaciones
    @fecha DATE,
    @descripcion VARCHAR(100),
    @costo PositiveMoney,
    @placa CHAR(8)
AS
BEGIN
    INSERT INTO mantenimientoReparaciones VALUES (@fecha, @descripcion, @costo, @placa);
END;
-- Leer en la tabla mantenimientoReparaciones
GO
CREATE OR ALTER PROCEDURE  LeerMantenimientoReparaciones
    @idMantenimiento INT
AS
BEGIN
    SELECT * FROM mantenimientoReparaciones WHERE  idMantenimiento = @idMantenimiento;
END;
-- Actualizar en la tabla mantenimientoReparaciones
GO
CREATE OR ALTER PROCEDURE ActualizarMantenimientoReparaciones
    @idMantenimiento INT,
    @fecha DATE,
    @descripcion VARCHAR(100),
    @costo PositiveMoney,
    @placa CHAR(8)
AS
BEGIN
    UPDATE mantenimientoReparaciones
    SET fecha = @fecha, descripcion = @descripcion, costo = @costo, placa = @placa
    WHERE idMantenimiento = @idMantenimiento;
END;
-- Eliminar en la tabla mantenimientoReparaciones
GO
CREATE OR ALTER PROCEDURE EliminarMantenimientoReparaciones
    @idMantenimiento INT
AS
BEGIN
    DELETE FROM mantenimientoReparaciones WHERE idMantenimiento = @idMantenimiento;
END;
--#####################################################

select * from mantenimientoReparaciones
exec ActualizarMantenimientoReparaciones 1, '2023-01-01', 'Cambio de llanta', 100, 'ABC-777'