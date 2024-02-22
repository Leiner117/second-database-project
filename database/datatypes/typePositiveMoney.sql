-- Tipo de dato PositiveMoney  para dinero positivo
CREATE TYPE PositiveMoney FROM money
CREATE RULE RPositiveMoney AS 
    @money > 0
go
EXEC sp_bindrule 'RPositiveMoney','PositiveMoney'
GO
CREATE DEFAULT DPositiveMoney AS '0'
go
EXEC sp_bindefault 'DPositiveMoney','PositiveMoney'
go
