CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_PLAN_DE_PAGOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NO_HISTORIA IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_PLP ,
            NU_HIST_PAC_PLP ,
            NU_NUME_FAC_PLP ,
            FE_FECH_PLP ,
            VL_VAL_MONTO ,
            NU_CANT_CUOTAS ,
            FE_INI_PAGOS ,
            FE_FIN_PAGOS ,
            NU_NUME_ESTADO ,
            NU_CONE_PLP ,
            VL_VAL_MONTO_FAC ,
            TX_USUARIO ,
            TX_PACIENTE 
        FROM PLAN_PAGOS 
        WHERE NU_HIST_PAC_PLP = v_NO_HISTORIA ;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;