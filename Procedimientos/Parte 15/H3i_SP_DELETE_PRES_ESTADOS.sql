CREATE OR REPLACE PROCEDURE H3i_SP_DELETE_PRES_ESTADOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ID_ESTADO IN NUMBER
)
AS

BEGIN

	DELETE PRES_ESTADOS
	WHERE  ID_ESTADO = v_ID_ESTADO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;