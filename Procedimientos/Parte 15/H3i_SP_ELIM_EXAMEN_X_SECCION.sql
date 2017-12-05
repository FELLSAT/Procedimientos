CREATE OR REPLACE PROCEDURE H3i_SP_ELIM_EXAMEN_X_SECCION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO_SEC IN VARCHAR2
)
AS

BEGIN

	DELETE R_SERV_SEC
	WHERE  CD_CODI_SEC = v_CODIGO_SEC;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;