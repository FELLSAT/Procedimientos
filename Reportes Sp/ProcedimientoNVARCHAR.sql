CREATE PROCEDURE pruebapivotdinamic (@codigo NVARCHAR(10),@fecha1 DATE,@fecha2 DATE)
AS
	DECLARE @TSQL NVARCHAR(MAX),
			@Params NVARCHAR(MAX),
			@extra NVARCHAR(MAX) = 'FOR [MES] in ([1],[2],[3],[4],[5])';

	SET @TSQL = N'
					SELECT *
					FROM (
						SELECT  month(MPRFEC) MES, MPRVAL, CODI_ESM
						FROM AUDI_ESM
						WHERE  MPRFEC between @fecha1 and @fecha2
						and OPNCOD = @codigo
					) A
					PIVOT(
						MAX(MPRVAL)'+@extra+'						
					) P';
	SET @Params = N'@codigo NVARCHAR(10),
					@fecha1 DATE,
					@fecha2 DATE';
	EXECUTE sp_executesql @TSQL, @Params, @codigo = @codigo, @fecha1 = @fecha1, @fecha2 = @fecha2;
GO

DROP PROCEDURE pruebapivotdinamic;

EXEC pruebapivotdinamic @codigo = 'AUT_PAG', @fecha1 = '01-01-2015', @fecha2 = '30-06-2015';