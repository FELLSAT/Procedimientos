CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_SERVICIO_ESPEC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_SERVICIO IN VARCHAR2 DEFAULT NULL ,
  v_COD_ESPECIALIDAD IN VARCHAR2 DEFAULT NULL ,
  v_NOM_SERVICIO IN VARCHAR2 DEFAULT NULL ,
  v_NOM_ESPECIALIDAD IN VARCHAR2 DEFAULT NULL ,
  v_TIPO IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR,
  cv_2 OUT SYS_REFCURSOR,
  cv_3 OUT SYS_REFCURSOR,
  cv_4 OUT SYS_REFCURSOR
)
AS

BEGIN

   IF v_TIPO = 'SERVICIO->ESPxCOD' THEN
    
   BEGIN
      OPEN  cv_1 FOR
         SELECT CD_CODI_ESP ,
                NO_NOMB_ESP 
           FROM ESPECIALIDADES 
                  JOIN R_ESP_SER    ON CD_CODI_ESP_RES = CD_CODI_ESP
          WHERE  CD_CODI_SER_RES = v_COD_SERVICIO
                   AND CD_CODI_ESP LIKE '%' || v_COD_ESPECIALIDAD || '%' ;
   
   END;
   END IF;
   IF v_TIPO = 'SERVICIO->ESPxNOM' THEN
    
   BEGIN
      OPEN  cv_2 FOR
         SELECT CD_CODI_ESP ,
                NO_NOMB_ESP 
           FROM ESPECIALIDADES 
                  JOIN R_ESP_SER    ON CD_CODI_ESP_RES = CD_CODI_ESP
          WHERE  CD_CODI_SER_RES = v_COD_SERVICIO
                   AND ESTADO = 1
                   AND NO_NOMB_ESP LIKE '%' || v_NOM_ESPECIALIDAD || '%' ;
   
   END;
   END IF;
   IF v_TIPO = 'ESPECIALIDAD->SERxCOD' THEN
    
   BEGIN
      OPEN  cv_3 FOR
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
                NU_REQAUT_SER ,
                NU_NO_ES_VIS_MIHIMS 
           FROM SERVICIOS 
                  JOIN R_ESP_SER    ON CD_CODI_SER_RES = CD_CODI_SER
          WHERE  CD_CODI_ESP_RES = v_COD_ESPECIALIDAD
                   AND CD_CODI_SER LIKE '%' || v_COD_SERVICIO || '%' ;
   
   END;
   END IF;
   IF v_TIPO = 'ESPECIALIDAD->SERxNOM' THEN
    
   BEGIN
      OPEN  cv_4 FOR
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
                NU_REQAUT_SER ,
                NU_NO_ES_VIS_MIHIMS 
           FROM SERVICIOS 
                  JOIN R_ESP_SER    ON CD_CODI_SER_RES = CD_CODI_SER
          WHERE  CD_CODI_ESP_RES = v_COD_ESPECIALIDAD
                   AND NO_NOMB_SER LIKE '%' || v_NOM_SERVICIO || '%' ;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_SERVICIO_ESPEC;