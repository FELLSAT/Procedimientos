CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_GRUPO_TERAP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT DISTINCT TX_GRUPTENP_MESU 
        FROM MedicamentosSustitutos ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;