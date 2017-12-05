CREATE OR REPLACE PROCEDURE H3i_SP_ELIMINAR_EPS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  	v_NIT IN VARCHAR2
)
AS

BEGIN

   	DELETE EPS
    WHERE  CD_NIT_EPS = v_NIT;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;