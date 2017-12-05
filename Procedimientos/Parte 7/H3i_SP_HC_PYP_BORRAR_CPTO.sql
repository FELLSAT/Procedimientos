CREATE OR REPLACE PROCEDURE H3i_SP_HC_PYP_BORRAR_CPTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_AUTONUM IN NUMBER
)
AS

BEGIN

   DELETE CONCEPTO_HIST_PYP

    WHERE  NU_AUTO_CONCPYP = v_AUTONUM;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;