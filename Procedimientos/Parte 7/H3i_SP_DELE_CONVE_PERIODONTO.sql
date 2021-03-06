CREATE OR REPLACE PROCEDURE H3i_SP_DELE_CONVE_PERIODONTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_AUTO_COPE IN NUMBER
)
AS

BEGIN

   DELETE CONVENCION_PERIODONTOGRAMA

    WHERE  NU_AUTO_COPE = v_NU_AUTO_COPE;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;