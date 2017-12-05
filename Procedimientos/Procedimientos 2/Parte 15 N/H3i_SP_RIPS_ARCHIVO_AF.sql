CREATE OR REPLACE PROCEDURE H3i_SP_RIPS_ARCHIVO_AF
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
        SELECT CD_CODI_PSS_ENTI ,
            ENTIDAD ,
            ID_TIPO_IDEN_ENTI ,
            NIT ,
            NU_NUME_FACO ,
            FE_FECH_FACO ,
            FE_FECH_FACO ,
            FE_FECH_FACO ,
            CD_CODI_EPS ,
            NO_NOMB_EPS ,
            CD_CODI_CONV ,
            DE_DESC_PLAN ,
            0 NUM_POLIZA  ,
            SUM(VL_COPA_MOVI)  VAL_COPAGO  ,
            0 VAL_COMISION  ,
            0 VAL_DESCUENTO  ,
            (SUM(VL_UNID_MOVI) - SUM(VL_COPA_MOVI) ) VAL_TOTAL  
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
        INNER JOIN PLANES    
            ON CD_CODI_PLAN = CD_CODI_PLAN_CONV
        WHERE  ( 
                  FE_FECH_FACO BETWEEN 
                          TO_DATE((v_FECHA_INI - TO_CHAR(v_FECHA_INI,'HH') / 24) + (-TO_CHAR(v_FECHA_INI,'MI')) / 1440)
                      AND 
                          TO_DATE((v_FECHA_FIN - TO_CHAR(v_FECHA_FIN,'HH') / 24) + 23 / 24) 
                )                
            AND NU_ESTA_FACO = 2
            AND NU_NUME_FACO IN ( SELECT ITEM 
                                  FROM TABLE(FNSPLIT(v_NUM_FACTURAS, ',')))
            AND CD_NIT_EPS = v_EPS
        GROUP BY CD_CODI_PSS_ENTI,ENTIDAD,
            NU_NUME_FACO,FE_FECH_FACO,
            CD_CODI_EPS,NO_NOMB_EPS,
            CD_CODI_CONV,DE_DESC_PLAN,
            ID_TIPO_IDEN_ENTI,NIT ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;