Use TransGaby
CREATE TYPE PhoneNumber FROM int
CREATE RULE RNumber AS 
	@phoneNumber like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
go
EXEC sp_bindrule 'RNumber','PhoneNumber'
go
CREATE DEFAULT DNumber AS '00000000'
go
EXEC sp_bindefault 'DNumber','PhoneNumber'
go