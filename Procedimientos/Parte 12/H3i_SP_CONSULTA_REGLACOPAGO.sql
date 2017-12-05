CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_REGLACOPAGO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ADMIN IN VARCHAR2 DEFAULT NULL ,
  v_REGIMEN IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_CONS_RRE ,
            VL_CONS_RRE ,
            NU_PROC_RRE ,
            VL_PROC_RRE ,
            NU_AYDX_RRE ,
            VL_AYDX_RRE ,
            NU_ELEM_RRE ,
            VL_ELEM_RRE ,
            VL_MAXI_RRE ,
            NU_COEL_EPS ,
            NU_COLA_EPS ,
            NU_PRQU_RRE ,
            VL_PRQU_RRE ,
            VL_MAXF_RRE ,
            VL_MAXA_RRE ,
            CD_CODI_REG_RRE 
        FROM R_REG_EPS ,
            EPS 
        WHERE  R_REG_EPS.CD_NIT_EPS_RRE = EPS.CD_NIT_EPS
            AND CD_NIT_EPS_RRE = NVL(v_ADMIN, CD_NIT_EPS_RRE)
            AND CD_CODI_REG_RRE = NVL(v_REGIMEN, CD_CODI_REG_RRE) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;