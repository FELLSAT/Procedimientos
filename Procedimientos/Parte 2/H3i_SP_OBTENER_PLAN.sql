CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_PLAN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_PLAN ,
             DE_DESC_PLAN 
        FROM PLANES  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_OBTENER_PLAN;