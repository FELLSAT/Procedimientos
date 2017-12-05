CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_PROC_MUESTRAS
(
  v_NU_HIST_PAC IN VARCHAR2 DEFAULT NULL ,
  v_FECHA_INI IN DATE DEFAULT NULL ,
  v_FECHA_FIN IN DATE DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_PRM ,
            NU_NUME_MOVI ,
            CD_CODI_SER_PRM ,
            CD_CODI_SEC_PRM ,
            NU_DOCU_PAC_PRM ,
            CD_CODI_ESM_PRM ,
            NU_CONS_PRM ,
            NU_CTRL_PRM ,
            FE_FECH_RECE_MUES_PRM ,
            FE_FECH_RESU_MUES_PRM ,
            FE_FECH_IMPR_MUES_PRM ,
            FE_FECH_ENTR_MUES_PRM ,
            CD_MEDI_RECI_PRM ,
            HO_HORA_RECE_MUES_PRM ,
            HO_HORA_RESU_MUES_PRM ,
            HO_HORA_IMPR_MUES_PRM ,
            HO_HORA_ENTR_MUES_PRM ,
            BIT_EN_PROCESO_RESUL ,
            NO_NOMB_USU_EN_PRO_RESUL ,
            CD_MEDI_RESU_PRM ,
            CD_MEDI_IMPR_PRM ,
            CD_MEDI_ENTR_PRM ,
            NU_CANT_RECI_PRM ,
            NU_NUME_LABO_PRM ,
            NU_HIST_PAC_PRM ,
            FE_FECH_MOVI ,
            NO_NOMB_SER ,
            NO_NOMB_SEC ,
            TX_NOMBRECOMPLETO_PAC ,
            NU_NUME_HPRO 
        FROM PROCESAMIENTO_MUESTRA 
        RIGHT JOIN HIST_PROC    
            ON NU_NUME_MOVI_HPRO = NU_NUME_MOVI_HPRO
            AND NU_NUME_LABO_HPRO = NU_NUME_LABO_PRM
        LEFT JOIN MOVI_CARGOS    
            ON NU_NUME_MOVI = NU_NUME_MOVI_HPRO
        LEFT JOIN SERVICIOS    
            ON CD_CODI_SER = CD_CODI_SER_HPRO
        LEFT JOIN SECCIONES    
            ON CD_CODI_SEC = CD_CODI_SEC_PRM
        LEFT JOIN PACIENTES    
            ON NU_HIST_PAC = NU_HIST_PAC_PRM
        WHERE  NU_TIPO_HPRO = 2
            AND NU_HIST_PAC_MOVI = NVL(v_NU_HIST_PAC, NU_HIST_PAC_MOVI)
            AND FE_FECH_MOVI BETWEEN NVL(v_FECHA_INI, FE_FECH_MOVI) AND NVL(v_FECHA_FIN, FE_FECH_MOVI) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;