CREATE OR REPLACE PROCEDURE H3i_SP_BUSCA_ESPECI_ASIGXPLAN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO_PLAN IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT DISTINCT CD_CODI_ESP ,
                      NO_NOMB_ESP ,
                      P.CD_CODI_PLAN 
        FROM PLANES P
               JOIN R_SER_PLAN R   ON p.CD_CODI_PLAN = R.CD_CODI_PLAN_RSP
               JOIN ESPECIALIDADES E   ON R.CD_CODI_ESP_RSP = E.CD_CODI_ESP
       WHERE  R.CD_CODI_PLAN_RSP = v_CODIGO_PLAN
        ORDER BY CD_CODI_ESP,
                 NO_NOMB_ESP ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_BUSCA_ESPECI_ASIGXPLAN;