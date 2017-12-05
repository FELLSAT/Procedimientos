
CREATE OR REPLACE PROCEDURE H3i_CONS_NIT_EPS_REGIMEN_ALTER
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NumHIST IN VARCHAR2,
    CV_1 OUT SYS_REFCURSOR
)

AS
BEGIN
    
    OPEN CV_1 FOR
        SELECT TO_CHAR(CD_NIT_EPS_RPE) CD_NIT_EPS_RPE, 
            CD_CODI_REG_RPE, 
            NU_AFIL_RPE,
            reg.CD_CODI_ALT_REG
        FROM R_PAC_EPS RPE
        INNER JOIN REGIMEN reg 
            ON RPE.CD_CODI_REG_RPE = reg.CD_CODI_REG
        WHERE RPE.NU_HIST_PAC_RPE = V_NumHIST
            AND NU_ESTA_REP=0
            AND NU_ESTA_RPE=1
        ORDER BY NU_AFIL_RPE;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;    	