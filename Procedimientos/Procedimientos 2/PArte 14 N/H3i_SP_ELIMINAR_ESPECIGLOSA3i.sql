CREATE OR REPLACE PROCEDURE H3i_SP_ELIMINAR_ESPECIGLOSA3i
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  	v_TX_CODIGO_ESGL IN VARCHAR2
)
AS

BEGIN

   	DELETE ESPECIFICO_GLOSA3i
    WHERE  TX_CODIGO_ESGL = v_TX_CODIGO_ESGL;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;