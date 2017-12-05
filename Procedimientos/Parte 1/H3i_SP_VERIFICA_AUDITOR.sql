CREATE OR REPLACE PROCEDURE H3i_SP_VERIFICA_AUDITOR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
(
    V_COD_PERFIL_USU IN VARCHAR2 DEFAULT NULL,
    CV_1 OUT SYS_REFCURSOR

)
AS
    V_TEMP NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO V_TEMP
    FROM USUARIO_PERFIL, CONTROL
    WHERE (USUARIO_PERFIL.ID_IDEN_USUA = V_COD_PERFIL_USU) 
      AND ((USUARIO_PERFIL.CD_CODI_PERF = CONTROL.VL_VALO_CONT) 
        AND (CONTROL.CD_CONC_CONT = 'PERFIL_AUDITOR'));
    ------------------------------------------------------
    IF(V_TEMP != 0) THEN
        OPEN CV_1 FOR
            SELECT 1
            FROM DUAL;
    ELSE
        OPEN CV_1 FOR
            SELECT 0
            FROM DUAL;
    END IF;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_VERIFICA_AUDITOR;