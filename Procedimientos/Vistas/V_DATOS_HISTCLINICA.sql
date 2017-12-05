CREATE OR REPLACE VIEW V_DATOS_HISTCLINICA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
    SELECT DISTINCT NU_NUME_HICL,  NU_NUME_LABO_HICL ,
        CD_MED_REAL_HICL, NU_NUME_PLHI ,
        NU_ESTA_PLHI, NU_PADRE_HIST ,
        NU_NUME_GRHI, CD_CODI_GRHI,
        NU_INDI_RPG, NU_INGR_RPG,
        NU_NUGR_RPG, NU_TIPO_COHI,
        NU_NUME_COHI, CD_CODI_COHI,
        NU_INDI_RPC, NU_INGR_RPC,
        NU_NUME_GRHI_RPC, NU_HEIGHT_RPC ,
        NU_WIDTH_RPC,
        TO_CHAR(NU_PATH_FILE) NU_PATH_FILE  ,
        TX_NOMBRPT_RPC, TX_FORMRPT_RPC,
        NU_EPIC_VAHI1, NU_PERPRINT_PLHI,
        HC.FE_FECH_HICL,
        CASE 
            WHEN NU_TIPO_COHI IN ( 1,7,13,98,99 )
                THEN TO_CHAR((SELECT DE_DESC_HITE 
                              FROM HIST_TEXT 
                              WHERE  NU_NUME_HICL_HITE = NU_NUME_HICL
                                  AND NU_INDI_HITE = NU_INDI_RPC ))
            WHEN NU_TIPO_COHI = 0 
                THEN TO_CHAR((SELECT NU_DESC_HINU 
                              FROM HIST_NUME 
                              WHERE NU_NUME_HICL_HINU = NU_NUME_HICL
                                  AND NU_INDI_HINU = NU_INDI_RPC ))
            WHEN NU_TIPO_COHI = 4 
                THEN NVL(TO_CHAR((SELECT NU_DESC_HINU 
                                  FROM HIST_NUME 
                                  WHERE  NU_NUME_HICL_HINU = NU_NUME_HICL
                                      AND NU_INDI_HINU = NU_INDI_RPC )),'0')
            WHEN NU_TIPO_COHI = 5 
                THEN TO_CHAR((SELECT 
                                  CASE 
                                      WHEN NU_DESC_HINU = 1 THEN 'SI'
                                      ELSE 'NO'
                                  END col  
                              FROM HIST_NUME 
                              WHERE  NU_NUME_HICL_HINU = NU_NUME_HICL
                                  AND NU_INDI_HINU = NU_INDI_RPC ),4000)
            WHEN NU_TIPO_COHI = 2 
                THEN TO_CHAR((SELECT FE_DESC_HIDA 
                              FROM HIST_DATE 
                              WHERE NU_NUME_HICL_HIDA = NU_NUME_HICL
                                  AND NU_INDI_HIDA = NU_INDI_RPC ))
            WHEN NU_TIPO_COHI = 3 
                THEN (SELECT TO_CHAR(DE_DESC_HIME) 
                      FROM HIST_MEMO 
                      WHERE  NU_NUME_HICL_HIME = NU_NUME_HICL
                      AND NU_INDI_HIME = NU_INDI_RPC )   
        END TX_VALOR_CONC  
    FROM PLANTILLA_HIST 
    INNER JOIN R_PLAN_CONC    
        ON NU_NUME_PLHI = NU_NUME_PLHI_RPC
    INNER JOIN CONCEPTO_HIST    
        ON NU_NUME_COHI_RPC = NU_NUME_COHI
    INNER JOIN R_PLAN_GRUP    
        ON NU_NUME_PLHI = NU_NUME_PLHI_RPG
        AND NU_NUME_GRHI_RPC = NU_NUME_GRHI_RPG
    INNER JOIN GRUPO_HIST    
        ON NU_NUME_GRHI_RPG = NU_NUME_GRHI
    INNER JOIN HISTORIACLINICA HC   
        ON NU_NUME_PLHI = NU_NUME_PLHI_HICL
    LEFT JOIN VALCONC_HIST1    
        ON NU_NUME_COHI = NU_NUME_COHI_VAHI1;