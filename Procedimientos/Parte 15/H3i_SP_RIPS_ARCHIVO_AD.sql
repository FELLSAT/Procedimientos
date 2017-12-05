CREATE OR REPLACE PROCEDURE H3i_SP_RIPS_ARCHIVO_AD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_FECHA_INI IN VARCHAR2,
    v_FECHA_FIN IN VARCHAR2,
    v_EPS IN VARCHAR2,--ID_EPS
    v_NUM_FACTURAS IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_NUME_FACO ,
            CD_CODI_PSS_ENTI ,
            CD_CODI_COSE_SER ,
            COUNT(NU_NUME_MOVI)  CANTIDAD  ,
            SUM(VL_UNID_MOVI)  VALOR_UNITARIO  ,
            (SUM(VL_UNID_MOVI)  - SUM(VL_COPA_MOVI) ) VALOR_TOTAL  
        FROM FACTURAS_CONTADO 
        INNER JOIN MOVI_CARGOS    
            ON NU_NUME_FACO_MOVI = NU_NUME_FACO
        INNER JOIN LABORATORIO    
            ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
        INNER JOIN SERVICIOS    
            ON CD_CODI_SER = CD_CODI_SER_LABO
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC_MOVI = NU_HIST_PAC
        INNER JOIN LUGAR_ATENCION    
            ON CD_CODI_LUAT = CD_CODI_LUAT_PAC
        INNER JOIN ENTIDAD    
            ON NU_AUTO_ENTI = NU_AUTO_ENTI_LUAT
        INNER JOIN CONVENIOS    
            ON NU_NUME_CONV_MOVI = NU_NUME_CONV
        INNER JOIN EPS    
            ON CD_NIT_EPS_CONV = CD_NIT_EPS
        WHERE (
                FE_FECH_FACO BETWEEN 
                    TO_DATE((v_FECHA_INI - TO_CHAR(v_FECHA_INI,'HH') / 24) + (-TO_CHAR(v_FECHA_INI,'MI')) / 1440)
            AND (
                   TO_DATE((v_FECHA_FIN - TO_CHAR(v_FECHA_FIN,'HH') / 24) + 23 / 24)
                ))                        
            -- BETWEEN @FECHA_INI AND @FECHA_FIN
            AND NU_ESTA_FACO = 2
            AND NU_NUME_FACO IN(  SELECT ITEM 
                                  FROM TABLE(FNSPLIT(v_NUM_FACTURAS, ','))  )
            AND CD_NIT_EPS = v_EPS
        GROUP BY NU_NUME_FACO,CD_CODI_COSE_SER,CD_CODI_PSS_ENTI ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;