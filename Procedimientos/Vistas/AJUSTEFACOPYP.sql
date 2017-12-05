CREATE OR REPLACE VIEW AJUSTEFACOPYP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
	SELECT MOVI_CARGOS.NU_NUME_FACO_MOVI,
		SUM(MOVI_CARGOS.VL_UNID_MOVI) VALOR  
	FROM TFLFPYP 
	INNER JOIN LABORATORIO    
		ON TFLFPYP.CODIGO = LABORATORIO.CD_CODI_SER_LABO
	INNER JOIN MOVI_CARGOS    
		ON LABORATORIO.NU_NUME_MOVI_LABO = MOVI_CARGOS.NU_NUME_MOVI
	WHERE (MOVI_CARGOS.FE_FECH_MOVI BETWEEN '09/12/2004' AND '01/03/2005')
		AND (MOVI_CARGOS.NU_NUME_CONV_MOVI = 89)
	GROUP BY MOVI_CARGOS.NU_NUME_FACO_MOVI;