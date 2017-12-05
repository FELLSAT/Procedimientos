CREATE OR REPLACE VIEW VISTA_ADMINISTRADORAS_CON_PYP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
	SELECT EPS.CD_NIT_EPS ,
		EPS.NO_NOMB_EPS 
	FROM CONVENIOS 
	INNER JOIN EPS    
		ON CONVENIOS.CD_NIT_EPS_CONV = EPS.CD_NIT_EPS
	WHERE (CONVENIOS.NU_INDPYP_CONV = 1);