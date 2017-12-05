CREATE OR REPLACE PROCEDURE QyR3i_SP_ELIM_DIRECCION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
 	v_AREA_SALUD IN VARCHAR2
)
AS

BEGIN

	DELETE QYR_DIRECCION
	WHERE  ID_IDEN_AS_D = v_AREA_SALUD;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;