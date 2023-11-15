-- Tipo de dato Cedula formato 0-0000-0000
CREATE TYPE Cedula FROM CHAR(11);
CREATE RULE RCedula AS 
	@cedula LIKE '[0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
GO
EXEC sp_bindrule 	'RCedula',	'Cedula'
GO

CREATE DEFAULT DCedula AS '0-0000-0000'
GO
EXEC sp_bindefault	'DCedula',	'Cedula'
GO