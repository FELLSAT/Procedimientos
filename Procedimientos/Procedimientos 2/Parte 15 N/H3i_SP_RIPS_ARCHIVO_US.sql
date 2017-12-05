CREATE OR REPLACE PROCEDURE H3i_SP_RIPS_ARCHIVO_US
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
        SELECT 
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
            CD_CODI_EPS ,
            CASE DE_DESC_TIUS
                WHEN 'CONTRIBUTIVO' THEN 1
                WHEN 'SUBSIDIADO' THEN 2
                WHEN 'VINCULADO' THEN 3
                WHEN 'PARTICULAR' THEN 4
                ELSE 5
            END TIP_USUARIO  ,
            DE_PRAP_PAC ,
            DE_SGAP_PAC ,
            NO_NOMB_PAC ,
            NO_SGNO_PAC ,
            CalcularEdad(FE_NACI_PAC, SYSDATE, 0) EDAD  ,
            CalcularEdad(FE_NACI_PAC, SYSDATE, 1) UME  ,
            CASE NU_SEXO_PAC
                WHEN 1 THEN 'M'
                WHEN 0 THEN 'F'   
            END SEXO  ,
            CD_CODI_DPTO_PAC ,
            CD_CODI_MUNI_PAC ,
            CD_CODI_ZORE_PAC 
        FROM MOVI_CARGOS 
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC_MOVI = NU_HIST_PAC
        INNER JOIN CONVENIOS    
            ON NU_NUME_CONV_MOVI = NU_NUME_CONV
        INNER JOIN R_PAC_EPS    
            ON NU_HIST_PAC_RPE = NU_HIST_PAC
            AND CD_NIT_EPS_RPE = CD_NIT_EPS_CONV
        INNER JOIN EPS    
            ON CD_NIT_EPS_CONV = CD_NIT_EPS
        INNER JOIN FACTURAS_CONTADO    
            ON NU_NUME_FACO_MOVI = NU_NUME_FACO
        INNER JOIN R_REG_EPS    
            ON CD_NIT_EPS_RRE = CD_NIT_EPS_CONV
        INNER JOIN REGIMEN    
            ON CD_CODI_REG = CD_CODI_REG_RRE
            AND CD_CODI_REG = CD_CODI_REG_RPE
        INNER JOIN TIPOUSUARIO    
            ON ID_CODI_TIUS = ID_CODI_TIUS_REG
        WHERE  ( FE_FECH_FACO BETWEEN 
                    TO_DATE((v_FECHA_INI - TO_CHAR(v_FECHA_INI,'HH') / 24) + (-TO_CHAR(v_FECHA_INI,'MI')) / 1440)
                AND 
                    TO_DATE((v_FECHA_FIN - TO_CHAR(v_FECHA_FIN,'HH') / 24) + 23 / 24)
                )                
            AND NU_ESTA_FACO = 2
            AND NU_NUME_FACO IN ( SELECT ITEM 
                                  FROM TABLE(FNSPLIT(v_NUM_FACTURAS, ','))  )
            AND CD_NIT_EPS = v_EPS
        GROUP BY NU_TIPD_PAC,NU_DOCU_PAC,
            DE_PRAP_PAC,DE_SGAP_PAC,
            NO_NOMB_PAC,NO_SGNO_PAC,
            FE_NACI_PAC,NU_SEXO_PAC,
            CD_CODI_DPTO_PAC,CD_CODI_MUNI_PAC,
            CD_CODI_ZORE_PAC,DE_DESC_TIUS,
            CD_CODI_EPS ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;