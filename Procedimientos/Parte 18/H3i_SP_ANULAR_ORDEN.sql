CREATE OR REPLACE PROCEDURE H3i_SP_ANULAR_ORDEN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_REC IN NUMBER
)
AS

BEGIN

	UPDATE REGISTRO
	SET NU_ESCU_REG = 2
	WHERE  NU_NUME_REG = v_NU_NUME_REC;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;