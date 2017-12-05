SELECT ISNULL([1], 0) AS Enero,ISNULL([2], 0) AS Febrero,ISNULL([3], 0) AS Marzo
FROM (
	SELECT  month(MPRFEC) MES, MPRVAL, CODI_ESM
	FROM AUDI_ESM
	WHERE  MPRFEC BETWEEN '01-01-2015' AND '01-03-2015'
	AND OPNCOD = 'AUT_PAG'
) A
PIVOT(
	MAX(MPRVAL)
	FOR [MES] IN ([1],[2],[3])
)P

-----------------------------------
DROP PROCEDURE SP_REPORTE
DROP PROCEDURE SP_REPORTE2
DROP FUNCTION FN_REPORTES
DROP FUNCTION getClientesCoincidentes

---------------------------------
EXEC SP_REPORTE @IN_CODIGO_OPN = 'AUT_PAG', @IN_FECHA_INI = '01-01-2015' , @IN_FECHA_FIN = '01-07-2015' 
EXEC SP_REPORTE2 @IN_CODIGO_OPN = 'AUT_PAG', @IN_FECHA_INI = '01-01-2015' , @IN_FECHA_FIN = '01-08-2015' 

------------------------------------

SELECT *
FROM (
	SELECT  month(MPRFEC) MES, MPRVAL, CODI_ESM
	FROM AUDI_ESM
	WHERE  MPRFEC between '01-03-2015' and '01-07-2015'
	and OPNCOD = 'AUT_PAG'
) A
PIVOT(
	MAX(MPRVAL)
	FOR [MES] in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) P


--------------------------------

SELECT CAST(COUNT(DISTINCT(DATENAME(MONTH,MPRFEC))) AS INT)
FROM AUDI_ESM
WHERE  MPRFEC BETWEEN '01-01-2015' AND  '30-06-2015'
	AND OPNCOD = 'AUT_PAG';






