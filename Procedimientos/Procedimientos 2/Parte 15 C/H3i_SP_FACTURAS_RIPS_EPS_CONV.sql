CREATE OR REPLACE PROCEDURE H3i_SP_FACTURAS_RIPS_EPS_CONV
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_EPS IN VARCHAR2,
    v_CODIGO_PRESTADOR IN VARCHAR2,
    v_FECHA_INI IN DATE,
    v_FECHA_FIN IN DATE,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
      SELECT NU_NUME_FACO ,
             FE_FECH_FACO ,
             CD_CODI_CONV 
        FROM FACTURAS_CONTADO 
               JOIN MOVI_CARGOS    ON NU_NUME_FACO = NU_NUME_FACO_MOVI
               JOIN CONVENIOS    ON NU_NUME_CONV_MOVI = NU_NUME_CONV
               JOIN EPS    ON CD_NIT_EPS_CONV = CD_NIT_EPS
       WHERE  NU_NUME_CONV = v_CODIGO_PRESTADOR
                AND CD_NIT_EPS = v_EPS
                AND
                --FE_FECH_FACO BETWEEN @FECHA_INI AND @FECHA_FIN
               ( 
                  FE_FECH_FACO BETWEEN 
                      TO_DATE((v_FECHA_INI - TO_CHAR(v_FECHA_INI,'HH') / 24) + (-TO_CHAR(v_FECHA_INI,'MI')) / 1440)
                  AND 
                      TO_DATE((v_FECHA_FIN - TO_CHAR(v_FECHA_FIN,'HH') / 24) + 23 / 24)
                )
                AND NU_ESTA_FACO = 2
        GROUP BY NU_NUME_FACO,FE_FECH_FACO,CD_CODI_CONV ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;