CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_SERVICIOS_NOM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NOMBRE IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_SER CODIGO  ,
             NO_NOMB_SER NOMBRE  ,
             CD_CODI_CUEN_SER ,
             NU_OPCI_SER TIPO  ,
             NU_NIVE_SER NIVEL  ,
             NU_APLI_SER GENERO  ,
             NU_EDIN_SER EDAD_INICIAL  ,
             NU_EDFI_SER EDAD_FINAL  ,
             NU_ESTA_SER ESTADO  ,
             NU_TITA_SER TIPO_CODIGO  ,
             DE_OBSE_SER OBSERVACIONES  ,
             CD_CODI_COSE_SER CODIGO_CONCEPTO  ,
             CD_CODI_TISE_SER CODIGO_TIPO_SERVICIO  ,
             ID_CITA_SER CITA  ,
             NU_MICO_SER DURACION  ,
             ID_GCIT_SER GENERAR_CITA  ,
             NU_NUME_IND_SER ESPYP  ,
             NU_VACU_SER ESVACUNA  ,
             NU_CLAS_SER CLASE  ,
             NU_EVOL_SER ESEVOLUCIONABLE  ,
             DX_PREDET DIAGNOSTICO  ,
             FINALIDAD FINALIDAD  ,
             SIN_COPAGO SINCOPAGO  ,
             NU_HOME_SER HONORARIO  ,
             NU_ESGRUPAL_SER CITA_GRUPAL  ,
             NU_MAXPACGRU_SER PACIENTES  ,
             NU_AUTRIPS_SER RIPS  ,
             NU_NOPOS_SER ESNOPOS  ,
             NU_NOFACT_SER ESNOFACTURABLE  ,
             NU_NORIPS_SER GENERA_RIPS  ,
             NVL(NU_REQAUT_SER, 0) AUTORIZACION  ,
             NVL(IS_SERV_ODONT, 0) ESODONTOLOGICO  ,
             NVL(ES_SERV_WEB_SER, 0) ES_SERV_WEB_SER  ,
             MEDIDA_TIEMPO MEDIDA_TIEMPO  ,
             MENSAJE_SERVICIO 
        FROM SERVICIOS 
       WHERE  NO_NOMB_SER LIKE '%' || v_NOMBRE || '%'
        ORDER BY NO_NOMB_SER ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_RECUPERAR_SERVICIOS_NOM;