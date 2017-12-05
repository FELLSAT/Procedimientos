CREATE OR REPLACE PROCEDURE H3i_SP_AGAK_OBT_PERSASIGESP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODASIGNATURA IN VARCHAR2,
  v_CODESPECIALIDAD IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
            SELECT TX_NOMBRE_ASIG ,
                 'Docente' TIPO_MED  ,
                 NU_CODIGO_GRAP ,
                 TX_DENOMINA_PEAC ,
                 NO_NOMB_MED 
            FROM ASIGNATURA 
            INNER JOIN GRUPO_ASIGNATURA_PERIODO    
                ON TX_CODIGO_ASIG = TX_CODIGO_ASIG_GRAP
            INNER JOIN PERIODO_ACADEMICO    
                ON NU_AUTO_PEAC = NU_AUTO_PEAC_GRAP
            INNER JOIN R_GRU_DOC_2    
                ON NU_AUTO_GRAP_RGD = NU_AUTO_GRAP
            INNER JOIN MEDICOS    
                ON CD_CODI_MED_RGD = CD_CODI_MED
            WHERE  TX_CODIGO_ASIG = v_CODASIGNATURA
                AND SYSDATE <= FE_FINAL_PEAC
                AND CD_CODI_MED NOT IN( SELECT CD_CODI_MED 
                                        FROM MEDICOS 
                                        INNER JOIN R_MEDI_ESPE    
                                            ON CD_CODI_MED = CD_CODI_MED_RMP
                                        WHERE  CD_CODI_ESP_RMP = v_CODESPECIALIDAD )

        UNION ALL 

            SELECT TX_NOMBRE_ASIG ,
                'Estudiante' TIPO_MED  ,
                NU_CODIGO_GRAP ,
                TX_DENOMINA_PEAC ,
                NO_NOMB_MED 
            FROM ASIGNATURA 
            INNER JOIN GRUPO_ASIGNATURA_PERIODO    
                ON TX_CODIGO_ASIG = TX_CODIGO_ASIG_GRAP
            INNER JOIN PERIODO_ACADEMICO    
                ON NU_AUTO_PEAC = NU_AUTO_PEAC_GRAP
            INNER JOIN R_GRU_EST_2    
                ON NU_AUTO_GRAP_RGE = NU_AUTO_GRAP
            INNER JOIN MEDICOS    
                ON CD_CODI_MED_RGE = CD_CODI_MED
            WHERE  TX_CODIGO_ASIG = v_CODASIGNATURA
                AND SYSDATE <= FE_FINAL_PEAC
                AND CD_CODI_MED NOT IN( SELECT CD_CODI_MED 
                                        FROM MEDICOS 
                                        INNER JOIN R_MEDI_ESPE    
                                            ON CD_CODI_MED = CD_CODI_MED_RMP
                                        WHERE  CD_CODI_ESP_RMP = v_CODESPECIALIDAD );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;