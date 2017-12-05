CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_ESPECI_ELEM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NO_NOMB_ESP IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT DISTINCT ESP.CD_CODI_ESP ,
                      ESP.NO_NOMB_ESP 
        FROM ESPECIALIDADES ESP
               JOIN R_MEDI_ESPE RME   ON ESP.CD_CODI_ESP = RME.CD_CODI_ESP_RMP
               AND RME.NU_ESTADO_RMP = 1
               AND ESP.NO_NOMB_ESP LIKE '%' || v_NO_NOMB_ESP || '%'
        ORDER BY NO_NOMB_ESP ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_ESPECI_ELEM;