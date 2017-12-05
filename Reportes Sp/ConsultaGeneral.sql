select 
	ae.CODI_ESM, ae.TX_FUERZA, 
	ae.NOM_ESM as rubro, am.NOMBRE_MODALIDAD as descripcion, 
	ROUND(ae.MPRVAL,0) as presu_ini,
	ISNULL((select sum(e.MPRVAL) from AUDI_ESM e where e.VIGENCIA=2015 and e.OPNCOD='ADI_ING' and e.CODI_ESM = ae.CODI_ESM),0) as adiciones,
	ISNULL((select sum(e.MPRVAL) from AUDI_ESM e where e.VIGENCIA=2015 and e.OPNCOD='RED_ING' and e.CODI_ESM = ae.CODI_ESM),0) as reduccion,
	ISNULL((select sum(e.MPRVAL) from AUDI_ESM e where e.VIGENCIA=2015 and e.OPNCOD='PRE_ING' and e.CODI_ESM = ae.CODI_ESM)+
 	(select sum(e.MPRVAL) from AUDI_ESM e where e.VIGENCIA=2015 and e.OPNCOD='ADI_ING' and e.CODI_ESM = ae.CODI_ESM)-
 	(select sum(e.MPRVAL) from AUDI_ESM e where e.VIGENCIA=2015 and e.OPNCOD='RED_ING' and e.CODI_ESM = ae.CODI_ESM),0) AS presu_defi
from AUDI_ESM ae, AUDI_MODALIDAD am
where ae.VIGENCIA=2015
	and ae.OPNCOD ='PRE_ING'
	and ae.TX_MODALIDAD = am.CODIGO_MODALIDAD;



SELECT DateName(month,MPRFEC), MPRVAL, CODI_ESM
FROM AUDI_ESM
WHERE  MPRFEC between '01-01-2015' and '01-04-2015'
	AND OPNCOD = 'AUT_PAG'


SELECT *
FROM (
	SELECT  month(MPRFEC) MES, MPRVAL, CODI_ESM
	FROM AUDI_ESM
	WHERE  MPRFEC between '01-01-2015' and '30-04-2015'
	and OPNCOD = 'AUT_PAG'
) A
PIVOT(
	MAX(MPRVAL)
	FOR [MES] in ([1],[2],[3],[4])
) P
