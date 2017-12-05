CREATE OR REPLACE PROCEDURE H3i_CONSUL_BAR_CON_BAR_ALTERNO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_CD_COD_ALT_BAR IN VARCHAR2,
    CV_1 OUT SYS_REFCURSOR
)
AS

BEGIN
    
    OPEN CV_1 FOR
        SELECT CD_CODI_BAR,
            CD_CODI_MUNI_BAR,
            CD_CODI_DPTO_BAR,
            CD_CODI_PAIS_BAR
        FROM BARRIO BAR
        WHERE BAR.CD_COD_ALT_BAR = V_CD_COD_ALT_BAR;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;