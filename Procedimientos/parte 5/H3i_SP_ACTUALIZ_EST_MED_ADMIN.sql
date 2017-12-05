CREATE OR REPLACE PROCEDURE H3i_SP_ACTUALIZ_EST_MED_ADMIN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_NU_NUME_REG IN NUMBER,
	V_NU_NUME_HMED IN NUMBER,
	V_MED_CERRADO IN NUMBER,
	V_NUME_ADIN IN NUMBER
)
AS
BEGIN

	UPDATE DOSIS_ADMINISTRADAS
	SET MED_CERRADO = V_MED_CERRADO
	WHERE NU_NUME_REG = V_NU_NUME_REG 
	AND NUM_MED_ADMIN_ACT = V_NUME_ADIN 
	AND	NU_NUME_HMED = V_NU_NUME_HMED;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);

END;