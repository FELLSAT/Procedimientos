select (MPRFEC) MES, a.AMORTIZACION, a.MPRVAL,(a.AMORTIZACION+a.MPRVAL) total, a.CODI_ESM
from AUDI_ESM a
where a.OPNCOD = 'AUT_PAG' 
	and a.MPRFEC between '01-01-2015' and '01-03-2015'
order by codi_esm, mes


SELECT MAX(CANTIDAD) CANTIDAD
FROM
	(
		SELECT COUNT(*) CANTIDAD,CODI_ESM
		from AUDI_ESM a
		where a.OPNCOD = 'AUT_PAG' 
			and a.MPRFEC between '01-01-2015' and '01-03-2015'
		GROUP BY CODI_ESM
	) A



select *
from
(
 select month(MPRFEC) MES, a.AMORTIZACION, a.MPRVAL,(a.AMORTIZACION+a.MPRVAL) total, a.CODI_ESM
 from AUDI_ESM a
 where a.OPNCOD = 'AUT_PAG' 
 and a.MPRFEC between '01-01-2015' and '01-03-2015' 
) B
PIVOT(
 MAX(TOTAL) FOR [MES] in ([1],[2]) -- ,[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15]
) P; 
