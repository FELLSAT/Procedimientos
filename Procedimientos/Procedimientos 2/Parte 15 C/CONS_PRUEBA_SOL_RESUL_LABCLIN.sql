CREATE OR REPLACE PROCEDURE CONS_PRUEBA_SOL_RESUL_LABCLIN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CD_CODI_PRM IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT TX_NOMBRECOMPLETO_PAC ,
            HO_HORA_RECE_MUES_PRM ,
            NO_NOMB_MED ,
            NO_NOMB_SEC ,
            CD_CODI_SER ,
            NO_NOMB_SER ,
            DE_NOTA_RESU ,
            NU_NUME_REPE_RESU ,
            NU_NUME_RESU ,
            NU_ESTA_RESU 
        FROM PROCESAMIENTO_MUESTRA 
        INNER JOIN PACIENTES    
            ON NU_HIST_PAC = NU_HIST_PAC_PRM
        INNER JOIN MEDICOS    
            ON CD_CODI_MED = CD_MEDI_RECI_PRM
        INNER JOIN SECCIONES    
            ON CD_CODI_SEC = CD_CODI_SEC_PRM
        INNER JOIN SERVICIOS    
            ON CD_CODI_SER = CD_CODI_SER_PRM
        LEFT JOIN RESULTADOS1    
            ON CD_CODI_PRM = CD_CODI_PRM_RESU
        WHERE  ( CD_CODI_ESM_PRM = 1
            OR CD_CODI_ESM_PRM = 2 )
            AND CD_CODI_PRM = v_CD_CODI_PRM
            AND NU_NUME_RESU_REPE_RESU IS NULL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;