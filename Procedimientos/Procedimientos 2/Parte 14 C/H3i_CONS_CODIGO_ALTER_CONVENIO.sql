CREATE OR REPLACE PROCEDURE H3i_CONS_CODIGO_ALTER_CONVENIO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NU_NUME_CONV IN NUMBER,
    CV_1 OUT SYS_REFCURSOR
)
    
AS

BEGIN
    OPEN CV_1 FOR
        SELECT CON.CD_CODI_CONV CD_COD_ALT_CONV, 
            CON.CD_NIT_EPS_CONV CD_NIT_EPS_CONV,
            RPE.CD_CODI_REG_RPE CD_CODI_REG
        FROM CONVENIOS CON
        INNER JOIN R_PAC_EPS RPE
            ON CON.CD_NIT_EPS_CONV = RPE.CD_NIT_EPS_RPE
        WHERE NU_NUME_CONV = V_NU_NUME_CONV;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;