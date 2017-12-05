CREATE OR REPLACE PROCEDURE H3i_SP_REP_FACT_CRE_ACTIVO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_FECHA_INI IN DATE,
    v_FECHA_FIN IN DATE,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT EPS.NO_NOMB_EPS ,
            NU_AUTO_FCCR ,
            CONVENIOS.CD_NOMB_CONV ,
            CASE NU_ESTADO_FCCR
                WHEN 1 THEN 
                    'ACTIVA'
                WHEN 0 THEN 
                    'ANULADO'
                WHEN 2 THEN 
                    'CERRADO'   
            END ESTADO  ,
            TX_CAJERO_FCCR ,
            NU_SVALDET_FCCR ,
            NU_SVALCUO_FCCR ,
            --  ROUND((SUM(VL_UNID_MOVI) - SUM(VL_COPA_MOVI)),0) VL_ADMIN,
            FE_FECH_FCCR 
        FROM FACTURAS_CONTADO_CREDITO 
            INNER JOIN EPS    
                ON TX_COD_EPS_FCCR = CD_NIT_EPS
            INNER JOIN CONVENIOS    
                ON NU_NUM_CONV_FCCR = NU_NUME_CONV
        WHERE  FE_FECH_FCCR BETWEEN v_FECHA_INI AND v_FECHA_FIN
            AND NU_ESTADO_FCCR = 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;