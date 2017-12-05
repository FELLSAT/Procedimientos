CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_TURNO_MEDICO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TURNO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_MED_TUME ,
             FE_FECH_TUME ,
             FE_HOIN_TUME ,
             FE_HOFI_TUME ,
             ID_DISP_TUME ,
             CD_CODI_CONS_TUME ,
             NU_NUME_TUME ,
             TX_MOTINHA_TUME ,
             TX_CODI_EQUI_TUME ,
             NU_AUTO_TIPO_TUME_TUME ,
             NU_TIEMCIT_TUME 
        FROM TURNOS_MEDICOS 
       WHERE  NU_NUME_TUME = v_TURNO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;