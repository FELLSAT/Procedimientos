CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_PLAN_SER_ES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_PLAN IN VARCHAR2 DEFAULT NULL ,
  v_COD_SERVICIO IN VARCHAR2 DEFAULT NULL ,
  v_COD_ESPECIALIDAD IN VARCHAR2 DEFAULT NULL ,
  v_NOM_SERVICIO IN VARCHAR2 DEFAULT NULL ,
  v_NOM_ESPECIALIDAD IN VARCHAR2 DEFAULT NULL ,
  v_TIPO IN VARCHAR2 DEFAULT NULL ,
  v_TIPO_SER IN NUMBER DEFAULT -1 ,
  v_ES_CITA_WEB IN NUMBER DEFAULT 0 ,
  v_NU_HIST_PAC IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR,
  cv_2 OUT SYS_REFCURSOR,
  cv_3 OUT SYS_REFCURSOR,
  cv_4 OUT SYS_REFCURSOR,
  cv_5 OUT SYS_REFCURSOR,
  cv_6 OUT SYS_REFCURSOR,
  cv_7 OUT SYS_REFCURSOR,
  cv_8 OUT SYS_REFCURSOR,
  cv_9 OUT SYS_REFCURSOR
)
AS

BEGIN

   IF v_TIPO = 'PLAN->SERxCOD' THEN
    
   BEGIN
      OPEN  cv_1 FOR
         SELECT CD_CODI_SER ,
                NO_NOMB_SER ,
                NU_OPCI_SER ,
                NU_NIVE_SER ,
                NU_APLI_SER ,
                NU_EDIN_SER ,
                NU_EDFI_SER ,
                NU_ESTA_SER ,
                NU_TITA_SER ,
                DE_OBSE_SER ,
                CD_CODI_COSE_SER ,
                ID_CITA_SER ,
                NU_MICO_SER ,
                ID_GCIT_SER ,
                NU_NUME_IND_SER ,
                NU_VACU_SER ,
                NU_CLAS_SER ,
                NU_EVOL_SER ,
                DX_PREDET ,
                FINALIDAD ,
                SIN_COPAGO ,
                CD_CODI_TISE_SER ,
                NU_HOME_SER ,
                NU_ESGRUPAL_SER ,
                NU_MAXPACGRU_SER ,
                NU_AUTRIPS_SER ,
                NU_NOPOS_SER ,
                NU_NOFACT_SER ,
                NU_NORIPS_SER ,
                NU_NO_ES_VIS_MIHIMS ,
                NU_REQAUT_SER ,
                IS_SERV_ODONT ,
                NVL(SERVICIOS.ES_SERV_WEB_SER, 0) ES_SERV_WEB_SER  ,
                ES_CONC_EDIT_SER ,
                VL_CONC_EDIT_SER 
           FROM SERVICIOS 
                  JOIN R_SER_PLAN    ON CD_CODI_SER = CD_CODI_SER_RSP
          WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                   AND CD_CODI_SER LIKE '%' || v_COD_SERVICIO || '%' ;
   
   END;
   END IF;
   IF v_TIPO = 'PLAN->SERxNOM' THEN
    
   BEGIN
      OPEN  cv_2 FOR
         SELECT CD_CODI_SER ,
                NO_NOMB_SER ,
                NU_OPCI_SER ,
                NU_NIVE_SER ,
                NU_APLI_SER ,
                NU_EDIN_SER ,
                NU_EDFI_SER ,
                NU_ESTA_SER ,
                NU_TITA_SER ,
                DE_OBSE_SER ,
                CD_CODI_COSE_SER ,
                ID_CITA_SER ,
                NU_MICO_SER ,
                ID_GCIT_SER ,
                NU_NUME_IND_SER ,
                NU_VACU_SER ,
                NU_CLAS_SER ,
                NU_EVOL_SER ,
                DX_PREDET ,
                FINALIDAD ,
                SIN_COPAGO ,
                CD_CODI_TISE_SER ,
                NU_HOME_SER ,
                NU_ESGRUPAL_SER ,
                NU_MAXPACGRU_SER ,
                NU_AUTRIPS_SER ,
                NU_NOPOS_SER ,
                NU_NOFACT_SER ,
                NU_NORIPS_SER ,
                NU_NO_ES_VIS_MIHIMS ,
                NU_REQAUT_SER ,
                IS_SERV_ODONT ,
                NVL(SERVICIOS.ES_SERV_WEB_SER, 0) ES_SERV_WEB_SER  ,
                ES_CONC_EDIT_SER ,
                VL_CONC_EDIT_SER 
           FROM SERVICIOS 
                  JOIN R_SER_PLAN    ON CD_CODI_SER = CD_CODI_SER_RSP
          WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                   AND NO_NOMB_SER LIKE '%' || v_NOM_SERVICIO || '%' ;
   
   END;
   END IF;
   IF v_TIPO = 'PLAN->ESPxCOD' THEN
    
   BEGIN
      OPEN  cv_3 FOR
         SELECT DISTINCT CD_CODI_ESP ,
                         NO_NOMB_ESP 
           FROM ESPECIALIDADES 
                  JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
          WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                   AND ESTADO = 1
                   AND CD_CODI_ESP LIKE '%' || v_COD_ESPECIALIDAD || '%' ;
   
   END;
   END IF;
   IF v_TIPO = 'PLAN->ESPxNOM' THEN
    
   BEGIN
      IF ( v_ES_CITA_WEB = 0 ) THEN
       
      BEGIN
         -- Selecciono las especialidades que solo tengan servicios del tipo CitaWeb = 0
         OPEN  cv_4 FOR
            SELECT DISTINCT CD_CODI_ESP ,
                            NO_NOMB_ESP ,
                            NVL(SERVICIOS.ES_SERV_WEB_SER, 0) ES_SERV_WEB_SER  
              FROM ESPECIALIDADES 
                     JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
                     JOIN SERVICIOS    ON CD_CODI_SER_RSP = CD_CODI_SER
                     JOIN R_ESP_SER    ON R_ESP_SER.CD_CODI_ESP_RES = CD_CODI_ESP_RSP
                     AND R_ESP_SER.CD_CODI_SER_RES = CD_CODI_SER
             WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                      AND ESPECIALIDADES.ESTADO = 1
                      AND NO_NOMB_ESP LIKE '%' || v_NOM_ESPECIALIDAD || '%'
                      AND NU_OPCI_SER = v_TIPO_SER
                      AND ( ES_SERV_WEB_SER = v_ES_CITA_WEB
                      OR ( ES_SERV_WEB_SER IS NULL
                      AND v_ES_CITA_WEB = 0 ) )
              GROUP BY CD_CODI_ESP,NO_NOMB_ESP,ES_SERV_WEB_SER
            UNION ALL 

            -- Aumento las especialidades que no se hayan seleccionado previamente
            SELECT DISTINCT CD_CODI_ESP ,
                            NO_NOMB_ESP ,
                            0 ES_SERV_WEB_SER  
              FROM ESPECIALIDADES 
                     JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
                     JOIN SERVICIOS    ON CD_CODI_SER_RSP = CD_CODI_SER
             WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                      AND NO_NOMB_ESP LIKE '%' || v_NOM_ESPECIALIDAD || '%'
                      AND NU_OPCI_SER = v_TIPO_SER
                      AND CD_CODI_ESP NOT IN ( SELECT DISTINCT CD_CODI_ESP 
                                               FROM ESPECIALIDADES 
                                                      JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
                                                      JOIN SERVICIOS    ON CD_CODI_SER_RSP = CD_CODI_SER
                                                      JOIN R_ESP_SER    ON R_ESP_SER.CD_CODI_ESP_RES = CD_CODI_ESP_RSP
                                                      AND R_ESP_SER.CD_CODI_SER_RES = CD_CODI_SER
                                                WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                                                         AND NU_OPCI_SER = v_TIPO_SER
                                                         AND NO_NOMB_ESP LIKE '%' || v_NOM_ESPECIALIDAD || '%'
                                                         AND ( ES_SERV_WEB_SER = 0
                                                         OR ( ES_SERV_WEB_SER IS NULL ) ) )

              GROUP BY CD_CODI_ESP,NO_NOMB_ESP ;
      
      END;
      ELSE
      
      BEGIN
         OPEN  cv_4 FOR
            SELECT DISTINCT CD_CODI_ESP ,
                            NO_NOMB_ESP ,
                            NVL(SERVICIOS.ES_SERV_WEB_SER, 0) ES_SERV_WEB_SER  
              FROM ESPECIALIDADES 
                     JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
                     JOIN SERVICIOS    ON CD_CODI_SER_RSP = CD_CODI_SER
                     JOIN R_ESP_SER    ON R_ESP_SER.CD_CODI_ESP_RES = CD_CODI_ESP_RSP
                     AND R_ESP_SER.CD_CODI_SER_RES = CD_CODI_SER
             WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                      AND NO_NOMB_ESP LIKE '%' || v_NOM_ESPECIALIDAD || '%'
                      AND ( ES_SERV_WEB_SER = v_ES_CITA_WEB
                      OR ( ES_SERV_WEB_SER IS NULL
                      AND v_ES_CITA_WEB = 0 ) )
              GROUP BY CD_CODI_ESP,NO_NOMB_ESP,ES_SERV_WEB_SER ;
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'PLAN->ESPxNOM2' THEN
    
   BEGIN
      IF ( v_ES_CITA_WEB = 0 ) THEN
       
      BEGIN
         -- Selecciono las especialidades que solo tengan servicios del tipo CitaWeb = 0
         OPEN  cv_5 FOR
            SELECT DISTINCT CD_CODI_ESP ,
                            NO_NOMB_ESP ,
                            NVL(SERVICIOS.ES_SERV_WEB_SER, 0) ES_SERV_WEB_SER  
              FROM ESPECIALIDADES 
                     JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
                     JOIN SERVICIOS    ON CD_CODI_SER_RSP = CD_CODI_SER
                     JOIN R_ESP_SER    ON R_ESP_SER.CD_CODI_ESP_RES = CD_CODI_ESP_RSP
                     AND R_ESP_SER.CD_CODI_SER_RES = CD_CODI_SER
             WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                      AND NO_NOMB_ESP LIKE '%' || v_NOM_ESPECIALIDAD || '%'
                      AND ( ES_SERV_WEB_SER = v_ES_CITA_WEB
                      OR ( ES_SERV_WEB_SER IS NULL
                      AND v_ES_CITA_WEB = 0 ) )
              GROUP BY CD_CODI_ESP,NO_NOMB_ESP,ES_SERV_WEB_SER
            UNION ALL 

            -- Aumento las especialidades que no se hayan seleccionado previamente
            SELECT DISTINCT CD_CODI_ESP ,
                            NO_NOMB_ESP ,
                            0 ES_SERV_WEB_SER  
              FROM ESPECIALIDADES 
                     JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
             WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                      AND NO_NOMB_ESP LIKE '%' || v_NOM_ESPECIALIDAD || '%'
                      AND CD_CODI_ESP NOT IN ( SELECT DISTINCT CD_CODI_ESP 
                                               FROM ESPECIALIDADES 
                                                      JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
                                                      JOIN SERVICIOS    ON CD_CODI_SER_RSP = CD_CODI_SER
                                                      JOIN R_ESP_SER    ON R_ESP_SER.CD_CODI_ESP_RES = CD_CODI_ESP_RSP
                                                      AND R_ESP_SER.CD_CODI_SER_RES = CD_CODI_SER
                                                WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                                                         AND NO_NOMB_ESP LIKE '%' || v_NOM_ESPECIALIDAD || '%'
                                                         AND ( ES_SERV_WEB_SER = 0
                                                         OR ( ES_SERV_WEB_SER IS NULL ) ) )

              GROUP BY CD_CODI_ESP,NO_NOMB_ESP ;
      
      END;
      ELSE
      
      BEGIN
         OPEN  cv_5 FOR
            SELECT DISTINCT CD_CODI_ESP ,
                            NO_NOMB_ESP ,
                            NVL(SERVICIOS.ES_SERV_WEB_SER, 0) ES_SERV_WEB_SER  
              FROM ESPECIALIDADES 
                     JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
                     JOIN SERVICIOS    ON CD_CODI_SER_RSP = CD_CODI_SER
                     JOIN R_ESP_SER    ON R_ESP_SER.CD_CODI_ESP_RES = CD_CODI_ESP_RSP
                     AND R_ESP_SER.CD_CODI_SER_RES = CD_CODI_SER
             WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                      AND NO_NOMB_ESP LIKE '%' || v_NOM_ESPECIALIDAD || '%'
                      AND ( ES_SERV_WEB_SER = v_ES_CITA_WEB
                      OR ( ES_SERV_WEB_SER IS NULL
                      AND v_ES_CITA_WEB = 0 ) )
              GROUP BY CD_CODI_ESP,NO_NOMB_ESP,ES_SERV_WEB_SER ;
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'PLAN->ESP->SERxCOD' THEN
    DECLARE
      v_EDAD NUMBER(10,0);
      v_SEXO NUMBER(10,0);
   
   BEGIN
      IF ( v_NU_HIST_PAC IS NULL ) THEN
       
      BEGIN
         v_SEXO := NULL ;
         v_EDAD := NULL ;
      
      END;
      ELSE
      DECLARE
         v_temp NUMBER(1, 0) := 0;
      
      BEGIN
         SELECT (CASE NU_SEXO_PAC
                                 WHEN 1 THEN 1
                ELSE 2
                   END) 

           INTO v_SEXO
           FROM PACIENTES 
          WHERE  NU_HIST_PAC = v_NU_HIST_PAC;
         BEGIN
            SELECT 1 INTO v_temp
              FROM DUAL
             WHERE ( ( SELECT CalcularEdad(FE_NACI_PAC, SYSDATE, 1) 
                       FROM PACIENTES 
                        WHERE  NU_HIST_PAC = v_NU_HIST_PAC ) = 1 );
         EXCEPTION
            WHEN OTHERS THEN
               NULL;
         END;
            
         IF v_temp = 1 THEN
          
         BEGIN
            SELECT CalcularEdad(FE_NACI_PAC, SYSDATE, 0) 

              INTO v_EDAD
              FROM PACIENTES 
             WHERE  NU_HIST_PAC = v_NU_HIST_PAC;
         
         END;
         ELSE
         
         BEGIN
            v_EDAD := 1 ;
         
         END;
         END IF;
      
      END;
      END IF;
      OPEN  cv_6 FOR
         SELECT CD_CODI_SER ,
                NO_NOMB_SER ,
                NU_OPCI_SER ,
                NU_NIVE_SER ,
                NU_APLI_SER ,
                NU_EDIN_SER ,
                NU_EDFI_SER ,
                NU_ESTA_SER ,
                NU_TITA_SER ,
                DE_OBSE_SER ,
                CD_CODI_COSE_SER ,
                ID_CITA_SER ,
                NU_MICO_SER ,
                ID_GCIT_SER ,
                NU_NUME_IND_SER ,
                NU_VACU_SER ,
                NU_CLAS_SER ,
                NU_EVOL_SER ,
                DX_PREDET ,
                FINALIDAD ,
                SIN_COPAGO ,
                CD_CODI_TISE_SER ,
                NU_HOME_SER ,
                NU_ESGRUPAL_SER ,
                NU_MAXPACGRU_SER ,
                NU_AUTRIPS_SER ,
                NU_NOPOS_SER ,
                NU_NOFACT_SER ,
                NU_NORIPS_SER ,
                NU_NO_ES_VIS_MIHIMS ,
                NU_REQAUT_SER ,
                IS_SERV_ODONT ,
                NVL(SERVICIOS.ES_SERV_WEB_SER, 0) ES_SERV_WEB_SER  ,
                ES_CONC_EDIT_SER ,
                VL_CONC_EDIT_SER 
           FROM SERVICIOS 
                  JOIN R_SER_PLAN    ON CD_CODI_SER = CD_CODI_SER_RSP
                  JOIN R_ESP_SER    ON R_ESP_SER.CD_CODI_ESP_RES = CD_CODI_ESP_RSP
                  AND R_ESP_SER.CD_CODI_SER_RES = CD_CODI_SER
          WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                   AND CD_CODI_ESP_RSP = v_COD_ESPECIALIDAD
                   AND CD_CODI_SER LIKE '%' || v_COD_SERVICIO || '%'
                   AND NU_ESTA_SER = 1
                   AND NU_OPCI_SER = v_TIPO_SER
                   AND ( NU_APLI_SER = 0
                   OR NU_APLI_SER = NVL(v_SEXO, NU_APLI_SER) )
                   AND ( NVL(v_EDAD, NU_EDIN_SER) BETWEEN NU_EDIN_SER AND NU_EDFI_SER ) ;
   
   END;
   END IF;
   IF v_TIPO = 'PLAN->ESP->SERxNOM' THEN
    DECLARE
      v_EDAD1 NUMBER(10,0);
      v_SEXO1 NUMBER(10,0);
   
   BEGIN
      IF ( v_NU_HIST_PAC IS NULL ) THEN
       
      BEGIN
         v_SEXO1 := NULL ;
         v_EDAD1 := NULL ;
      
      END;
      ELSE
      DECLARE
         v_temp NUMBER(1, 0) := 0;
      
      BEGIN
         SELECT (CASE NU_SEXO_PAC
                                 WHEN 1 THEN 1
                ELSE 2
                   END) 

           INTO v_SEXO1
           FROM PACIENTES 
          WHERE  NU_HIST_PAC = v_NU_HIST_PAC;
         BEGIN
            SELECT 1 INTO v_temp
              FROM DUAL
             WHERE ( ( SELECT CalcularEdad(FE_NACI_PAC, SYSDATE, 1) 
                       FROM PACIENTES 
                        WHERE  NU_HIST_PAC = v_NU_HIST_PAC ) = 1 );
         EXCEPTION
            WHEN OTHERS THEN
               NULL;
         END;
            
         IF v_temp = 1 THEN
          
         BEGIN
            SELECT CalcularEdad(FE_NACI_PAC, SYSDATE, 0) 

              INTO v_EDAD1
              FROM PACIENTES 
             WHERE  NU_HIST_PAC = v_NU_HIST_PAC;
         
         END;
         ELSE
         
         BEGIN
            v_EDAD1 := 1 ;
         
         END;
         END IF;
      
      END;
      END IF;
      OPEN  cv_7 FOR
         SELECT CD_CODI_SER ,
                NO_NOMB_SER ,
                NU_OPCI_SER ,
                NU_NIVE_SER ,
                NU_APLI_SER ,
                NU_EDIN_SER ,
                NU_EDFI_SER ,
                NU_ESTA_SER ,
                NU_TITA_SER ,
                DE_OBSE_SER ,
                CD_CODI_COSE_SER ,
                ID_CITA_SER ,
                NU_MICO_SER ,
                ID_GCIT_SER ,
                NU_NUME_IND_SER ,
                NU_VACU_SER ,
                NU_CLAS_SER ,
                NU_EVOL_SER ,
                DX_PREDET ,
                FINALIDAD ,
                SIN_COPAGO ,
                CD_CODI_TISE_SER ,
                NU_HOME_SER ,
                NU_ESGRUPAL_SER ,
                NU_MAXPACGRU_SER ,
                NU_AUTRIPS_SER ,
                NU_NOPOS_SER ,
                NU_NOFACT_SER ,
                NU_NORIPS_SER ,
                NU_NO_ES_VIS_MIHIMS ,
                NU_REQAUT_SER ,
                IS_SERV_ODONT ,
                NVL(SERVICIOS.ES_SERV_WEB_SER, 0) ES_SERV_WEB_SER  ,
                ES_CONC_EDIT_SER ,
                VL_CONC_EDIT_SER 
           FROM SERVICIOS 
                  JOIN R_SER_PLAN    ON CD_CODI_SER = CD_CODI_SER_RSP
                  JOIN R_ESP_SER    ON R_ESP_SER.CD_CODI_ESP_RES = CD_CODI_ESP_RSP
                  AND R_ESP_SER.CD_CODI_SER_RES = CD_CODI_SER
          WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                   AND CD_CODI_ESP_RSP = v_COD_ESPECIALIDAD
                   AND NO_NOMB_SER LIKE '%' || v_NOM_SERVICIO || '%'
                   AND NU_OPCI_SER = v_TIPO_SER
                   AND NU_ESTA_SER = 1
                   AND ( NU_APLI_SER = 0
                   OR NU_APLI_SER = NVL(v_SEXO1, NU_APLI_SER) )
                   AND ( NVL(v_EDAD1, NU_EDIN_SER) BETWEEN NU_EDIN_SER AND NU_EDFI_SER ) ;
   
   END;
   END IF;
   IF v_TIPO = 'PLAN->SER->ESPxCOD' THEN
    
   BEGIN
      OPEN  cv_8 FOR
         SELECT CD_CODI_ESP ,
                NO_NOMB_ESP 
           FROM ESPECIALIDADES 
                  JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
          WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                   AND CD_CODI_SER_RSP = v_COD_SERVICIO
                   AND CD_CODI_ESP LIKE '%' || v_COD_ESPECIALIDAD || '%' ;
   
   END;
   END IF;
   IF v_TIPO = 'PLAN->SER->ESPxNOM' THEN
    
   BEGIN
      OPEN  cv_9 FOR
         SELECT CD_CODI_ESP ,
                NO_NOMB_ESP 
           FROM ESPECIALIDADES 
                  JOIN R_SER_PLAN    ON CD_CODI_ESP_RSP = CD_CODI_ESP
          WHERE  CD_CODI_PLAN_RSP = v_COD_PLAN
                   AND CD_CODI_SER_RSP = v_COD_SERVICIO
                   AND NO_NOMB_ESP LIKE '%' || v_NOM_ESPECIALIDAD || '%' ;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_PLAN_SER_ES;