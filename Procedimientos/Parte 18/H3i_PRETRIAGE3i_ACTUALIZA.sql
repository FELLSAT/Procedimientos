CREATE OR REPLACE PROCEDURE H3i_PRETRIAGE3i_ACTUALIZA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	v_NU_AUTO_PTRI IN NUMBER,
	v_NU_ESTADO_PTRI IN NUMBER,
	v_FE_INGRE_PTRI IN DATE
)
AS

BEGIN

	UPDATE PRETRIAGE
	SET FE_INGRE_PTRI = v_FE_INGRE_PTRI,
		NU_ESTADO_PTRI = v_NU_ESTADO_PTRI
	WHERE  NU_AUTO_PTRI = v_NU_AUTO_PTRI;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;