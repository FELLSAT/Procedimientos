CREATE OR REPLACE PROCEDURE H3i_SP_RIPS_ARCHIVO_AC
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

    OPEN cv_1 FOR
        SELECT NU_NUME_FACO ,
            CD_CODI_PSS_ENTI ,
            CASE NU_TIPD_PAC
                WHEN 0 THEN 'CC'
                WHEN 1 THEN 'TI'
                WHEN 2 THEN 'RC'
                WHEN 3 THEN 'CE'
                WHEN 4 THEN 'PA'
                WHEN 5 THEN 'AS'
                WHEN 6 THEN 'MS'
                WHEN 7 THEN 'NU'   
            END NU_TIPD_PAC  ,
            NU_DOCU_PAC ,
            FE_FECH_HICL FE_FECH_FACO ,--FE_FECH_FACO, --se cambio por la fecha de atencion y no asi la de facturacio
            NU_AUTO_LABO ,
            NU_NUME_CONV ,
            CD_CODI_SER ,
            CD_ALTE_RST ,
            ID_CODI_CAEX_LABO ,
            CD_CODI_FICO_RFF ,
            ( SELECT DISTINCT CD_CODI_DIAG_RLAD 
              FROM R_LABO_DIAG 
              WHERE  NU_NUME_LABO_RLAD = NU_NUME_LABO
              AND ID_TIPO_DIAG_RLAD = 'PR' ) PR  ,
            ( SELECT DISTINCT CD_CODI_DIAG_RLAD 
              FROM R_LABO_DIAG 
              WHERE  NU_NUME_LABO_RLAD = NU_NUME_LABO
              AND ID_TIPO_DIAG_RLAD = 'R1' ) R1  ,
            ( SELECT DISTINCT CD_CODI_DIAG_RLAD 
              FROM R_LABO_DIAG 
              WHERE  NU_NUME_LABO_RLAD = NU_NUME_LABO
              AND ID_TIPO_DIAG_RLAD = 'R2' ) R2  ,
            ( SELECT DISTINCT CD_CODI_DIAG_RLAD 
              FROM R_LABO_DIAG 
              WHERE  NU_NUME_LABO_RLAD = NU_NUME_LABO
              AND ID_TIPO_DIAG_RLAD = 'R3' ) R3  ,
            ( SELECT DISTINCT ID_TIPO_RLAD 
              FROM R_LABO_DIAG 
              WHERE  NU_NUME_LABO_RLAD = NU_NUME_LABO
              AND ID_TIPO_DIAG_RLAD = 'PR' ) TIPO_DX_PR  ,
            SUM(VL_UNID_MOVI)  VALOR_CONSULTA  ,
            SUM(VL_COPA_LABO)  VALOR_COPAGO  ,
            SUM(VL_UNID_MOVI) - SUM(VL_COPA_LABO)  VALOR_TOTAL  
        FROM FACTURAS_CONTADO 
        INNER JOIN MOVI_CARGOS    
            ON NU_NUME_FACO_MOVI = NU_NUME_FACO
        INNER JOIN LABORATORIO    
            ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
        LEFT JOIN HISTORIACLINICA    
            ON NU_NUME_LABO = NU_NUME_LABO_HICL --aumentado para la fecha de atencion y no de factura
        INNER JOIN SERVICIOS    
            ON CD_CODI_SER = CD_CODI_SER_LABO
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC_MOVI = NU_HIST_PAC
        INNER JOIN LUGAR_ATENCION    
            ON CD_CODI_LUAT = CD_CODI_LUAT_PAC
        INNER JOIN ENTIDAD    
            ON NU_AUTO_ENTI = NU_AUTO_ENTI_LUAT
        INNER JOIN CONVENIOS    
            ON NU_NUME_CONV = NU_NUME_CONV_MOVI
        LEFT JOIN R_SER_TARB    
            ON CD_CODI_SER = CD_CODI_SER_RST
            AND CD_CODI_TARB_RST = CD_CODI_TARI_CONV
        INNER JOIN EPS    
            ON CD_NIT_EPS_CONV = CD_NIT_EPS
        INNER JOIN R_FICO_FICOF    
            ON TX_CODI_RFF_LABO = TX_CODI_RFF
        WHERE ( 
                FE_FECH_FACO BETWEEN 
                    TO_DATE((v_FECHA_INI - TO_CHAR(v_FECHA_INI,'HH') / 24) + (-TO_CHAR(v_FECHA_INI,'MI')) / 1440)
                AND 
                    TO_DATE((v_FECHA_FIN - TO_CHAR(v_FECHA_FIN,'HH') / 24) + 23 / 24) 
              )
            AND NU_ESTA_FACO = 2
            AND NU_NUME_FACO IN ( SELECT ITEM 
                                  FROM TABLE(FNSPLIT(v_NUM_FACTURAS, ',')))
            AND CD_NIT_EPS = v_EPS
            AND NU_TIPO_MOVI = 4 -- Procedimiento = 0, Elemento = 1, Laboratorio = 2, Quirurgico = 3, Consulta = 4, Paquete = 5, Otro = 6
        GROUP BY NU_NUME_FACO,CD_CODI_PSS_ENTI,
            NU_TIPD_PAC,NU_DOCU_PAC,
            FE_FECH_HICL,NU_AUTO_LABO,
            NU_NUME_CONV,CD_CODI_SER,
            CD_ALTE_RST,NU_NUME_LABO,
            CD_CODI_FICO_RFF,ID_CODI_CAEX_LABO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;