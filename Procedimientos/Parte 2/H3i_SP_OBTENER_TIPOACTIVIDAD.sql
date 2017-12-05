CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_TIPOACTIVIDAD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_TIAC ,
             DE_DESC_TIAC ,
             CD_COAS_TIAC ,
             ESTADO 
        FROM TIPOACTIVIDAD  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_OBTENER_TIPOACTIVIDAD;