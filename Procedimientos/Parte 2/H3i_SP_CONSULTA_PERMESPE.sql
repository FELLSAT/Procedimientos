CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_PERMESPE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_ESP_RET IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_ESP_RET ,
             CD_CODI_TAG_RET 
        FROM R_ESPE_TAG 
       WHERE  CD_CODI_ESP_RET = v_CD_CODI_ESP_RET ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_PERMESPE;