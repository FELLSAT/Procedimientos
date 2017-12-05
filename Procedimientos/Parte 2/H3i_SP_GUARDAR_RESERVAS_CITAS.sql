CREATE OR REPLACE PROCEDURE H3i_SP_GUARDAR_RESERVAS_CITAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_HIST_PAC_RC IN VARCHAR2,
  v_NU_NUME_CONV_RC IN NUMBER,
  v_CD_CODI_ESP_RC IN VARCHAR2,
  v_CD_CODI_MED_RC IN VARCHAR2,
  v_CD_CODI_MED_ORDENA_RC IN VARCHAR2,
  v_CD_CODI_DEPENDENCIA IN VARCHAR2,
  v_CD_CODI_PROCEDIMIENTO IN VARCHAR2,
  v_OBSERVACION IN NVARCHAR2 DEFAULT NULL ,
  v_FECHA_HORA_RESERVA IN DATE,
  v_FECHA_HORA_REGISTRADA IN DATE
)
AS

BEGIN

   INSERT INTO RESERVAS_CITAS
     ( NU_HIST_PAC_RC, NU_NUME_CONV_RC, CD_CODI_ESP_RC, CD_CODI_MED_RC, CD_CODI_MED_ORDENA_RC, CD_CODI_DEPENDENCIA, CD_CODI_PROCEDIMIENTO, OBSERVACION, FECHA_HORA_RESERVA, FECHA_HORA_REGISTRADA )
     VALUES ( v_NU_HIST_PAC_RC, v_NU_NUME_CONV_RC, v_CD_CODI_ESP_RC, v_CD_CODI_MED_RC, v_CD_CODI_MED_ORDENA_RC, v_CD_CODI_DEPENDENCIA, v_CD_CODI_PROCEDIMIENTO, v_OBSERVACION, TO_DATE(v_FECHA_HORA_RESERVA,'dd/mm/yyyy'), TO_DATE(v_FECHA_HORA_REGISTRADA,'dd/mm/yyyy') );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);

END H3i_SP_GUARDAR_RESERVAS_CITAS;