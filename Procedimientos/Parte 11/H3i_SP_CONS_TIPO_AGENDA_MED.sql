CREATE OR REPLACE PROCEDURE H3i_SP_CONS_TIPO_AGENDA_MED
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_HORA_INICIAL IN DATE,
  v_HORA_FINAL IN DATE,
  v_ID_MEDICO IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT * 
        FROM TURNOS_MEDICOS 
       WHERE  CD_MED_TUME = v_ID_MEDICO
                AND ( v_HORA_INICIAL >= FE_HOIN_TUME
                AND v_HORA_INICIAL <= FE_HOFI_TUME )
                AND ( v_HORA_FINAL >= FE_HOIN_TUME
                AND v_HORA_FINAL <= FE_HOFI_TUME ) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;