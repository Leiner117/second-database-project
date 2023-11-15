--CRUD TELEFONO
-- Insertar en la tabla telefono

GO
CREATE PROCEDURE InsertarTelefono
    @numero PhoneNumber,
    @cedula Cedula
AS
BEGIN
    INSERT INTO telefonosEmpleados VALUES (@numero, @cedula);
END;

-- Leer en la tabla telefono
GO
CREATE PROCEDURE LeerTelefono
    @cedula Cedula
AS
BEGIN
    SELECT * FROM telefonosEmpleados WHERE  CedulaEmpleado = @cedula;
END;
-- Actualizar en la tabla telefono
GO
CREATE PROCEDURE ActualizarTelefono
    @numero PhoneNumber,
    @cedula Cedula
AS
BEGIN
    UPDATE telefonosEmpleados
    SET numero = @numero
    WHERE CedulaEmpleado = @cedula AND numero = @numero;
END;
-- Eliminar en la tabla telefono
GO
CREATE PROCEDURE EliminarTelefono
    @numero PhoneNumber,
    @cedula Cedula
AS
BEGIN
    DELETE FROM telefonosEmpleados WHERE CedulaEmpleado = @cedula AND numero = @numero;
END;
--#####################################################