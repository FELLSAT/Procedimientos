CREATE OR REPLACE PROCEDURE H3i_SP_ELIMINAR_GRALGLOSA3i
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  	v_TX_CODIGO_GEGL IN VARCHAR2
)
AS

BEGIN

   	DELETE GENERAL_GLOSA3i
    WHERE  TX_CODIGO_GEGL = v_TX_CODIGO_GEGL;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;