CREATE OR REPLACE PROCEDURE H3i_SP_DELETE_TIPO_SEGUIM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ID IN VARCHAR2
)
AS

BEGIN

   	DELETE TIPO_SEGUIMIENTO
    WHERE  ID = v_ID;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;