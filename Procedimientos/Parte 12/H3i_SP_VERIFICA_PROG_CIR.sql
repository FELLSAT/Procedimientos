CREATE OR REPLACE PROCEDURE H3i_SP_VERIFICA_PROG_CIR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_FECHA_INI IN DATE,
    v_FECHA_FIN IN DATE,
    v_CD_CODI_QUI IN NUMBER,
    v_ID_PROGR IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT COUNT(CD_CODI_PROG)  NUMERO_CITAS  
        FROM PROG_CIR 
        WHERE  CD_CODI_QUI = v_CD_CODI_QUI
            AND CD_CODI_PROG != v_ID_PROGR
            AND ( ( FEC_INI >= v_FECHA_INI
            AND FEC_INI <= v_FECHA_FIN )
                OR ( FEC_FIN >= v_FECHA_INI
            AND FEC_FIN <= v_FECHA_FIN ) ) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;