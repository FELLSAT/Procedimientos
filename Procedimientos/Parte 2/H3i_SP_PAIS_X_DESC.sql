CREATE OR REPLACE PROCEDURE H3i_SP_PAIS_X_DESC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NO_NOMB_PAIS IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_PAIS ,
             NO_NOMB_PAIS 
        FROM PAISES 
       WHERE  NO_NOMB_PAIS LIKE (v_NO_NOMB_PAIS || '%') AND ROWNUM <= 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_PAIS_X_DESC;