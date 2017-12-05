CREATE OR REPLACE PROCEDURE H3i_SP_ELIMINAR_SCOP_VARIABLE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_SV IN NUMBER
)
AS

BEGIN

   DELETE SCOP_VARIABLE

    WHERE  NU_NUME_SV = v_NU_NUME_SV;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;