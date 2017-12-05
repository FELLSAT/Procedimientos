CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTAR_TURNOS_Y_CITA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CodigoMedico IN VARCHAR2,
  v_Fecha IN DATE,
  v_Estado IN NUMBER,
  v_NumeroTurno IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT fe_fech_cit fechaini  ,
             (fe_fech_cit + nu_dura_cit / 1440) fechafin  ,
             0 NroTurno  ,
             'CITA' tipo  
        FROM CITAS_MEDICAS 
       WHERE  cd_codi_med_cit = v_CodigoMedico
                AND (fe_fech_cit + nu_dura_cit / 1440) > v_Fecha
                AND nu_esta_cit <> v_Estado
      UNION ALL 
      SELECT fe_hoin_tume fechaini  ,
             fe_hofi_tume fechafin  ,
             nu_nume_tume NroTurno  ,
             'TURNO' tipo  
        FROM TURNOS_MEDICOS 
       WHERE  fe_hofi_tume >= v_Fecha
                AND nu_nume_tume < v_NumeroTurno
                AND id_disp_tume = '0'
        ORDER BY fechaini,
                 fechafin ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;