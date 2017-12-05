CREATE OR REPLACE PROCEDURE RECU_PROC_MUES_PRINT_LAB_CLIN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_HIST_PAC_PRM IN VARCHAR2 DEFAULT NULL ,
    v_NU_AUTO_NUME_DEP_PAC IN NUMBER DEFAULT NULL ,
    v_CD_CODI_PRM IN NUMBER DEFAULT NULL ,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_PRM ,
            NO_NOMB_SER ,
            NO_NOMB_DAEX ,
            DE_VALO_DARE ,
            DE_UNDM_DAEX ,
            VL_INRE_DARE ,
            VL_SURE_DARE ,
            DE_NOTA_RESU ,
            CD_CODI_ESM_PRM ,
            TX_NOMBRECOMPLETO_PAC ,
            NO_NOMB_SEC ,
            NOMBRE_ARLAB ,
            NO_NOMB_MED ,
            FE_FECH_IMPR_MUES_PRM ,
            ' ' TX_DESC_DEP  
        FROM PROCESAMIENTO_MUESTRA 
        INNER JOIN SERVICIOS    
            ON CD_CODI_SER = CD_CODI_SER_PRM
        INNER JOIN RESULTADOS1    
            ON CD_CODI_PRM = CD_CODI_PRM_RESU
        INNER JOIN DATOS_RESU    
            ON NU_NUME_RESU = NU_NUME_RESU_DARE
        INNER JOIN DATOS_EXAMEN    
            ON CD_CODI_DAEX = CD_CODI_DAEX_DARE
            AND CD_CODI_SER_DAEX = CD_CODI_SER
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC = NU_HIST_PAC_PRM
        INNER JOIN SECCIONES    
            ON CD_CODI_SEC = CD_CODI_SEC_PRM
        INNER JOIN AREA_LAB    
            ON CODIGO_ARLAB = CODIGO_ARLAB_SEC
        LEFT JOIN MEDICOS    
            ON CD_CODI_MED = CD_MEDI_IMPR_PRM
        WHERE  NU_NUME_RESU_REPE_RESU IS NULL
            AND NU_ESTA_RESU = 1
            AND NU_HIST_PAC_PRM = NVL(v_NU_HIST_PAC_PRM, NU_HIST_PAC_PRM)
            AND NVL(CD_CODI_PRM, -1) = NVL(v_CD_CODI_PRM, NVL(CD_CODI_PRM, -1)) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;