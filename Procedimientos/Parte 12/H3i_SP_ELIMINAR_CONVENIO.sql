CREATE OR REPLACE PROCEDURE H3i_SP_ELIMINAR_CONVENIO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  	v_CODCONVENIO IN NUMBER
)
AS

BEGIN

   	DELETE CONVENIOS
    WHERE  NU_NUME_CONV = v_CODCONVENIO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;