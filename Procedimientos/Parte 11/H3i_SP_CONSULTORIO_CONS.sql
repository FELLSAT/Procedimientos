CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTORIO_CONS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODLUAT IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_CONS ,
             DE_DESC_CONS || ' -(' || L.NO_NOMB_LUAT || ')' DE_DESC_CONS  ,
             DE_UBIC_CONS ,
             CD_CODI_LUAT_CONS ,
             NU_TIPO_ATENCION ,
             NU_ES_GRUPAL 
        FROM CONSULTORIOS 
              INNER JOIN LUGAR_ATENCION L   ON CD_CODI_LUAT_CONS = CD_CODI_LUAT
       WHERE  CD_CODI_LUAT_CONS = NVL(v_CODLUAT, CD_CODI_LUAT_CONS)
        ORDER BY DE_DESC_CONS ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;