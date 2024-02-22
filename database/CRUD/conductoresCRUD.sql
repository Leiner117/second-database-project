--CRUD CONDUCTOR
-- Insertar en la tabla conductor
GO
CREATE PROCEDURE InsertarConductor
    @cedula Cedula
AS
BEGIN
    INSERT INTO conductores VALUES (@cedula,0);
END;
-- Leer en la tabla conductor
GO
CREATE PROCEDURE LeerConductor
    @cedula Cedula
AS
BEGIN
    SELECT * FROM conductores WHERE  cedula = @cedula;
END;
-- Actualizar en la tabla conductor
GO
CREATE PROCEDURE ActualizarConductor
    @cedula Cedula
AS
BEGIN
    UPDATE conductores
    SET cedula = @cedula
    WHERE cedula = @cedula;
END;

-- Eliminar en la tabla conductor
GO
CREATE PROCEDURE EliminarConductor
    @cedula Cedula
AS
BEGIN
    DELETE FROM conductores WHERE cedula = @cedula;
END;
--#####################################################