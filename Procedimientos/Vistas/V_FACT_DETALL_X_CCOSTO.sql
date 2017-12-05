CREATE OR REPLACE VIEW V_FACT_DETALL_X_CCOSTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
        SELECT 
            CASE 
                WHEN NU_CAPI_CONV = 0 
                    THEN 
                        CASE 
                            WHEN CD_NIT_EPS <> '800246953' THEN '1 - EVENTO'
                            ELSE '2 - FONDO FINANCIERO'
                        END
                ELSE '3 - CAPITACION'
            END TIPO_FACT,
            CD_CODI_CEN_COST_HIPO_RLEH, NO_NOMB_CEN_COST_HIPO_RLEH,
            NU_NUME_CONV, CD_CODI_CONV,
            CD_NIT_EPS, NO_NOMB_EPS,
            SUM(CT_CANT_LABO * VL_UNID_LABO) VL_TOTAL_SERV ,
            SUM(VL_COPA_LABO)  VL_COPAGO ,
            SUM((CT_CANT_LABO * VL_UNID_LABO) - VL_COPA_LABO)  VL_NETO_SERV ,
            NU_NUME_FACO_MOVI, NU_NUME_FAC_MOVI,
            TO_DATE(TO_CHAR(FE_FECH_MOVI,'DD/MM/YYYY'),'DD/MM/YYYY') FE_FECH_MOVI  
        FROM R_LUAT_ESP_HIPCR 
        INNER JOIN MOVI_CARGOS    
            ON CD_CODI_LUAT_MOVI = CD_CODI_LUAT_RLEH
            AND NU_TIAT_MOVI = CD_CODI_TIAT_RLEH
        INNER JOIN CONVENIOS    
            ON NU_NUME_CONV_MOVI = NU_NUME_CONV
        INNER JOIN EPS    
            ON CD_NIT_EPS_CONV = CD_NIT_EPS
        INNER JOIN LABORATORIO    
            ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
            AND CD_CODI_ESP_LABO = CD_CODI_ESP_RLEH
        WHERE  NU_ESTA_MOVI <> 2
            AND CD_CODI_ESELE_RLEH = 0
        GROUP BY CD_CODI_CEN_COST_HIPO_RLEH,NO_NOMB_CEN_COST_HIPO_RLEH,
            NU_NUME_CONV,CD_CODI_CONV,
            CD_NIT_EPS,NO_NOMB_EPS,
            NU_CAPI_CONV,NU_NUME_FACO_MOVI,
            NU_NUME_FAC_MOVI,TO_DATE(TO_CHAR(FE_FECH_MOVI,'DD/MM/YYYY'),'DD/MM/YYYY')

    UNION 

        SELECT 
            CASE 
                WHEN NU_CAPI_CONV = 0 
                    THEN 
                        CASE 
                              WHEN CD_NIT_EPS <> '800246953' THEN '1 - EVENTO'
                              ELSE '2 - FONDO FINANCIERO'
                        END
                ELSE '3 - CAPITACION'
            END TIPO_FACT,
            CD_CODI_CEN_COST_HIPO_RLEH, NO_NOMB_CEN_COST_HIPO_RLEH,
            NU_NUME_CONV, CD_CODI_CONV,
            CD_NIT_EPS, NO_NOMB_EPS,
            SUM(CT_CANT_FORM * VL_UNID_FORM) VL_TOTAL_SERV,
            SUM(VL_COPA_FORM)  vl_COPAGO,
            SUM((CT_CANT_FORM * VL_UNID_FORM) - VL_COPA_FORM)  VL_NETO_SERV,
            NU_NUME_FACO_MOVI, NU_NUME_FAC_MOVI,
            TO_DATE(TO_CHAR(FE_FECH_MOVI,'DD/MM/YYYY'),'DD/MM/YYYY') FE_FECH_MOVI  
        FROM R_LUAT_ESP_HIPCR 
        INNER JOIN MOVI_CARGOS    
            ON CD_CODI_LUAT_MOVI = CD_CODI_LUAT_RLEH
            AND NU_TIAT_MOVI = CD_CODI_TIAT_RLEH
        INNER JOIN CONVENIOS    
            ON NU_NUME_CONV_MOVI = NU_NUME_CONV
        INNER JOIN EPS   
            ON CD_NIT_EPS_CONV = CD_NIT_EPS
        INNER JOIN FORMULAS    
            ON NU_NUME_MOVI = NU_NUME_MOVI_FORM
            AND CD_CODI_ESP_FORM = CD_CODI_ESP_RLEH
        WHERE  NU_ESTA_MOVI <> 2
            AND CD_CODI_ESELE_RLEH = 1
        GROUP BY CD_CODI_CEN_COST_HIPO_RLEH,NO_NOMB_CEN_COST_HIPO_RLEH,
            NU_NUME_CONV,CD_CODI_CONV,
            CD_NIT_EPS,NO_NOMB_EPS,
            NU_CAPI_CONV,NU_NUME_FACO_MOVI,
            NU_NUME_FAC_MOVI,TO_DATE(TO_CHAR(FE_FECH_MOVI,'DD/MM/YYYY'),'DD/MM/YYYY');