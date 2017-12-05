CREATE OR REPLACE PROCEDURE H3i_SP_ACTUA_ORDEN_MEDICAMENTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
 (
 	V_NoHICL IN NUMBER,
	V_NU_LABO_EVOL IN NUMBER
 )
	
AS
BEGIN
	UPDATE HIST_MEDI
	SET NU_NUME_HICL_HMED = V_NoHICL
	WHERE NU_LABO_EVOL = V_NU_LABO_EVOL;
END;