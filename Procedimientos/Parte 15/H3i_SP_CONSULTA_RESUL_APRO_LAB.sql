CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_RESUL_APRO_LAB
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_HIST_PAC IN VARCHAR2 DEFAULT NULL ,
  v_CD_CODI_SER IN VARCHAR2 DEFAULT NULL ,
  v_CD_CODI_SEC IN VARCHAR2 DEFAULT NULL ,
  v_FECHA_INI IN DATE DEFAULT NULL ,
  v_FECHA_FIN IN DATE DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_PRM ,
            FE_FECH_MOVI ,
            NU_NUME_HPRO ,
            NO_NOMB_SER ,
            TX_NOMBRECOMPLETO_PAC ,
            NU_DOCU_PAC ,
            NO_NOMB_ESM ,
            NU_NUME_MOVI ,
            CD_CODI_ESM ,
            TX_OBSER_ENTR_MUES_PRM 
        FROM PROCESAMIENTO_MUESTRA 
        INNER JOIN HIST_PROC    
            ON NU_NUME_MOVI_HPRO = NU_NUME_MOVI_HPRO
            AND NU_NUME_LABO_HPRO = NU_NUME_LABO_PRM
        INNER JOIN MOVI_CARGOS    
            ON NU_NUME_MOVI = NU_NUME_MOVI_HPRO
        INNER JOIN SERVICIOS    
            ON CD_CODI_SER = CD_CODI_SER_HPRO
        INNER JOIN SECCIONES    
            ON CD_CODI_SEC = CD_CODI_SEC_PRM
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC = NU_HIST_PAC_PRM
        INNER JOIN RESULTADOS1    
            ON CD_CODI_PRM_RESU = CD_CODI_PRM
            AND NU_NUME_RESU_REPE_RESU IS NULL
        INNER JOIN ESTADOS_MUESTRA    
            ON CD_CODI_ESM = CD_CODI_ESM_PRM
        WHERE  NU_TIPO_HPRO = 2
            AND NU_ESTA_RESU = 1
            AND NU_HIST_PAC = NVL(v_NU_HIST_PAC, NU_HIST_PAC)
            AND CD_CODI_SER = NVL(v_CD_CODI_SER, CD_CODI_SER)
            AND CD_CODI_SEC = NVL(v_CD_CODI_SEC, CD_CODI_SEC)
            AND FE_FECH_MOVI BETWEEN NVL(v_FECHA_INI, FE_FECH_MOVI) AND NVL(v_FECHA_FIN, FE_FECH_MOVI) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;