CREATE OR REPLACE PROCEDURE H3i_SP_REC_NUHISTPAC_X_TD_D
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_DOCU_PAC IN VARCHAR2,
  v_NU_TIPD_PAC IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_HIST_PAC 
        FROM PACIENTES 
       WHERE  NU_DOCU_PAC = v_NU_DOCU_PAC
                AND NU_TIPD_PAC = v_NU_TIPD_PAC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_REC_NUHISTPAC_X_TD_D;