CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_SERVICIO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN VARCHAR2 DEFAULT NULL ,
  v_NOMBRE IN VARCHAR2 DEFAULT NULL ,
  v_TIPO IN NUMBER DEFAULT NULL ,
  v_NIVEL IN NUMBER DEFAULT NULL ,
  v_SEXO_AL_QUE_APLICA IN NUMBER DEFAULT NULL ,
  v_EDAD_INICIAL IN NUMBER DEFAULT NULL ,
  v_EDAD_FINAL IN NUMBER DEFAULT NULL ,
  v_ESTADO IN NUMBER DEFAULT NULL ,
  v_TIPO_CODIGO IN NUMBER DEFAULT NULL ,
  v_OBSERVACIONES IN VARCHAR2 DEFAULT NULL ,
  v_CODIGO_CONCEPTO IN VARCHAR2 DEFAULT NULL ,
  v_ES_AGENDABLE IN VARCHAR2 DEFAULT NULL ,
  v_DURACION_CONSULTA IN NUMBER DEFAULT NULL ,
  v_GENERA_CARGO_CITA IN VARCHAR2 DEFAULT NULL ,
  v_ES_PYP IN NUMBER DEFAULT NULL ,
  v_ES_VACUNA IN NUMBER DEFAULT NULL ,
  v_CLASE_SERVICIO IN NUMBER DEFAULT NULL ,
  v_ES_EVOLUCIONABLE IN NUMBER DEFAULT NULL ,
  v_DX_PREDETERMINADO IN VARCHAR2 DEFAULT NULL ,
  v_COD_FINALIDAD_PREDETERMINADA IN VARCHAR2 DEFAULT NULL ,
  v_SIN_COPAGO IN NUMBER DEFAULT NULL ,
  v_COD_TIPO_SERVICIO IN VARCHAR2 DEFAULT NULL ,
  v_APLICA_HONORARIO_MEDICO IN NUMBER DEFAULT NULL ,
  v_ES_CITA_GRUPAL IN NUMBER DEFAULT NULL ,
  v_MAX_PACIENTES_X_CITA_GRUPAL IN NUMBER DEFAULT NULL ,
  v_RIPS_AUTOMATICOS IN NUMBER DEFAULT NULL ,
  v_ES_NOPOS IN NUMBER DEFAULT NULL ,
  v_ES_NOFACTURABLE IN NUMBER DEFAULT NULL ,
  v_NOGENERARIPS IN NUMBER DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

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
             ES_CONC_EDIT_SER ,
             VL_CONC_EDIT_SER ,
             NVL(SERVICIOS.ES_SERV_WEB_SER, 0) ES_SERV_WEB_SER  
        FROM SERVICIOS 
       WHERE  NVL(CD_CODI_SER, '-1') LIKE '%' || NVL(v_CODIGO, NVL(CD_CODI_SER, '-1')) || '%'
                AND NVL(NO_NOMB_SER, '-1') LIKE '%' || NVL(v_NOMBRE, NVL(NO_NOMB_SER, '-1')) || '%'
                AND NVL(NU_OPCI_SER, 255) = NVL(v_TIPO, NVL(NU_OPCI_SER, 255))
                AND NVL(NU_NIVE_SER, 255) = NVL(v_NIVEL, NVL(NU_NIVE_SER, 255))
                AND NVL(NU_APLI_SER, 255) = NVL(v_SEXO_AL_QUE_APLICA, NVL(NU_APLI_SER, 255))
                AND NVL(NU_EDIN_SER, 255) = NVL(v_EDAD_INICIAL, NVL(NU_EDIN_SER, 255))
                AND NVL(NU_EDFI_SER, 255) = NVL(v_EDAD_FINAL, NVL(NU_EDFI_SER, 255))
                AND NVL(NU_ESTA_SER, 255) = NVL(v_ESTADO, NVL(NU_ESTA_SER, 255))
                AND NVL(NU_TITA_SER, 255) = NVL(v_TIPO_CODIGO, NVL(NU_TITA_SER, 255))
                AND NVL(DE_OBSE_SER, '-1') = NVL(v_OBSERVACIONES, NVL(DE_OBSE_SER, '-1'))
                AND NVL(CD_CODI_COSE_SER, '-1') = NVL(v_CODIGO_CONCEPTO, NVL(CD_CODI_COSE_SER, '-1'))
                AND NVL(ID_CITA_SER, '-1') = NVL(v_ES_AGENDABLE, NVL(ID_CITA_SER, '-1'))
                AND NVL(NU_MICO_SER, 255) = NVL(v_DURACION_CONSULTA, NVL(NU_MICO_SER, 255))
                AND NVL(ID_GCIT_SER, '-1') = NVL(v_GENERA_CARGO_CITA, NVL(ID_GCIT_SER, '-1'))
                AND NVL(NU_NUME_IND_SER, 255) = NVL(v_ES_PYP, NVL(NU_NUME_IND_SER, 255))
                AND NVL(NU_VACU_SER, 255) = NVL(v_ES_VACUNA, NVL(NU_VACU_SER, 255))
                AND NVL(NU_CLAS_SER, 255) = NVL(v_CLASE_SERVICIO, NVL(NU_CLAS_SER, 255))
                AND NVL(NU_EVOL_SER, 255) = NVL(v_ES_EVOLUCIONABLE, NVL(NU_EVOL_SER, 255))
                AND NVL(DX_PREDET, '-1') = NVL(v_DX_PREDETERMINADO, NVL(DX_PREDET, '-1'))
                AND NVL(FINALIDAD, '-1') = NVL(v_COD_FINALIDAD_PREDETERMINADA, NVL(FINALIDAD, '-1'))
                AND NVL(SIN_COPAGO, 255) = NVL(v_SIN_COPAGO, NVL(SIN_COPAGO, 255))
                AND NVL(CD_CODI_TISE_SER, '-1') = NVL(v_COD_TIPO_SERVICIO, NVL(CD_CODI_TISE_SER, '-1'))
                AND NVL(NU_HOME_SER, 0) = NVL(v_APLICA_HONORARIO_MEDICO, NVL(NU_HOME_SER, 0))
                AND NVL(NU_ESGRUPAL_SER, 0) = NVL(v_ES_CITA_GRUPAL, NVL(NU_ESGRUPAL_SER, 0))
                AND NVL(NU_MAXPACGRU_SER, 1024) = NVL(v_MAX_PACIENTES_X_CITA_GRUPAL, NVL(NU_MAXPACGRU_SER, 1024))
                AND NVL(NU_AUTRIPS_SER, 1024) = NVL(v_RIPS_AUTOMATICOS, NVL(NU_AUTRIPS_SER, 1024))
                AND NVL(NU_NOPOS_SER, 1024) = NVL(v_ES_NOPOS, NVL(NU_NOPOS_SER, 1024))
                AND NVL(NU_NOFACT_SER, 1024) = NVL(v_ES_NOFACTURABLE, NVL(NU_NOFACT_SER, 1024))
                AND NVL(NU_NORIPS_SER, 1024) = NVL(v_NOGENERARIPS, NVL(NU_NORIPS_SER, 1024)) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_SERVICIO;