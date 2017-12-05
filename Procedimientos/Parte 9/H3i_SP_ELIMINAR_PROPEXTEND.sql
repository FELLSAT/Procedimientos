CREATE OR REPLACE PROCEDURE H3i_SP_ELIMINAR_PROPEXTEND
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_PLHI_HIEX IN NUMBER
)
AS

BEGIN

   DELETE HIST_EXTEND

    WHERE  NU_NUME_PLHI_HIEX = v_NU_NUME_PLHI_HIEX;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;