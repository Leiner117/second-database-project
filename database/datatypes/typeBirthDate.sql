-- Tipo de dato Fecha de Nacimiento
CREATE TYPE BirthDate FROM date;

CREATE RULE RBirthDate AS 
    @birthDate < GETDATE()
go
EXEC sp_bindrule 'RBirthDate','BirthDate'
go
CREATE DEFAULT DBirthDate AS '1900-01-01'
go
EXEC sp_bindefault 'DBirthDate','BirthDate'
go
