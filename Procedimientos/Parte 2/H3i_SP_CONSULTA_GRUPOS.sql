CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_GRUPOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_DESC IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_GRUP ,
             DE_DESC_GRUP 
        FROM GRUP_ARTICULO 
       WHERE  DE_DESC_GRUP LIKE '%' || v_DESC || '%' ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_GRUPOS;