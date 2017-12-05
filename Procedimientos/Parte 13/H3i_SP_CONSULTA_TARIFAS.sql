CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_TARIFAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CRITERIO IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_TARB ,
            NO_NOMB_TARB ,
            NU_INLI_TARB ,
            TO_NUMBER(VL_BASE_TARB) VL_BASE_TARB  ,
            CD_CODI_ANO_TARB 
        FROM TARIFA_BASE 
        WHERE  CD_CODI_TARB = NVL(v_CRITERIO, CD_CODI_TARB) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;