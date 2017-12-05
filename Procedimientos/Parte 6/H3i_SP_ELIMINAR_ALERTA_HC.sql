CREATE OR REPLACE PROCEDURE H3i_SP_ELIMINAR_ALERTA_HC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_ALERT IN VARCHAR2
)
AS

BEGIN

  	DELETE ALERTA_HC
    WHERE  CD_CODI_ALERT = v_CD_CODI_ALERT;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;