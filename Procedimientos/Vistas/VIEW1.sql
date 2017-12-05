CREATE OR REPLACE VIEW VIEW1
-- =============================================      
-- Author:  FELIPE SATIZABAL
-- ============================================= 
AS 
	SELECT CONVENIOS.NU_NUME_CONV ,
		EPS.NO_NOMB_EPS 
	FROM CONVENIOS 
	INNER JOIN EPS    
		ON CONVENIOS.CD_NIT_EPS_CONV = EPS.CD_NIT_EPS;