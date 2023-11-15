-- Tipo de dato Email formato a@aa.aa
USE TransGaby 
CREATE TYPE EmailAddress FROM VARCHAR(50) 
CREATE RULE RuleEmail AS
	@email like ('%_@__%.__%')
GO
EXEC sp_bindrule 'RuleEmail', 'EmailAddress'
GO
CREATE DEFAULT DEmail AS 'nombre@gmail.com'
go
EXEC sp_bindefault 'DEmail','EmailAddress'
go