CREATE OR REPLACE PROCEDURE H3i_SP_CREAR_REMISION_TRABAJO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_AUTORIZACION IN VARCHAR2,
  v_PACIENTE IN VARCHAR2,
  v_MOVIMIENTO IN NUMBER,
  v_ADSCRITO IN NUMBER,
  v_CONVENIO IN NUMBER,
  v_CONVENIO_ADSCRITO IN NUMBER,
  v_SERVICIO IN VARCHAR2,
  v_OBSERVACIONES IN VARCHAR2,
  v_MEDICO IN VARCHAR2,
  v_MEDICO_ESTUDIANTE IN VARCHAR2,
  v_FECHA_REMISION IN DATE,
  v_FECHA_VENCIMIENTO IN DATE,
  v_PREREGISTRO IN NUMBER,
  v_RECEPCIONADO IN NUMBER,
  v_MOVI_AUTORIZACION IN NUMBER
)
AS

BEGIN

   INSERT INTO REMISION_TRABAJO_ADSCRITO
     ( NU_AUTO_RETRA, NU_HIST_PAC_RETRA, NU_NUME_MOVI_RETRA, NU_CONSE_ADSC_RETRA, NU_NUME_CONV_RETRA, NU_NUME_COAD_RETRA, CD_CODI_SER_RETRA, TX_OBSE_RETRA, CD_CODI_MED_RETRA, CD_CODI_MED_EST_RETRA, FE_REMI_RETRA, FE_VENC_RETRA, NU_PRERE_RETRA, NU_RECEP_RETRA, NU_NUME_MOVI_AUTO_RETRA )
     VALUES ( v_AUTORIZACION, v_PACIENTE, v_MOVIMIENTO, v_ADSCRITO, v_CONVENIO, v_CONVENIO_ADSCRITO, v_SERVICIO, v_OBSERVACIONES, v_MEDICO, v_MEDICO_ESTUDIANTE, v_FECHA_REMISION, v_FECHA_VENCIMIENTO, v_PREREGISTRO, v_RECEPCIONADO, v_MOVI_AUTORIZACION );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;