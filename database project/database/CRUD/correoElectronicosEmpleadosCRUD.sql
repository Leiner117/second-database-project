--CRUD CORREO ELECTRONICO
-- Insertar en la tabla correoElectronico

GO
CREATE PROCEDURE InsertarCorreoElectronico
    @correo EmailAddress,
    @cedula Cedula
AS
BEGIN
    INSERT INTO correoElectronicosEmpleados VALUES (@correo, @cedula);
END;
-- Leer en la tabla correoElectronico
GO
CREATE PROCEDURE LeerCorreoElectronico
    @cedula Cedula
AS
BEGIN
    SELECT * FROM correoElectronicosEmpleados WHERE  CedulaEmpleado = @cedula;
END;
-- Actualizar en la tabla correoElectronico
GO
CREATE PROCEDURE ActualizarCorreoElectronico
    @correo EmailAddress,
    @cedula Cedula
AS
BEGIN
    UPDATE correoElectronicosEmpleados
    SET correo = @correo
    WHERE CedulaEmpleado = @cedula AND correo = @correo;
END;
GO

-- Eliminar en la tabla correoElectronico

GO
CREATE PROCEDURE EliminarCorreoElectronico
    @correo EmailAddress,
    @cedula Cedula
AS
BEGIN
    DELETE FROM correoElectronicosEmpleados WHERE CedulaEmpleado = @cedula AND correo = @correo;
END;
--#####################################################