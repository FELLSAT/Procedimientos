CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_TURNOS_EST
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_FECHAINICIAL IN DATE,
  v_FECHAFINAL IN DATE,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT FE_FECH_TUME ,
             FE_HOIN_TUME ,
             FE_HOFI_TUME ,
             NU_TIEMCIT_TUME ,
             ID_DISP_TUME ,
             CD_CODI_CONS_TUME ,
             NU_NUME_TUME ,
             TX_MOTINHA_TUME ,
             TX_CODI_EQUI_TUME ,
             NU_AUTO_TIPO_TUME_TUME ,
             CD_MED_TUME ,
             TX_DESC_TIPO_TUME ,
             NU_AUTO_HOGR_TUME 
        FROM TURNOS_MEDICOS 
               INNER JOIN MEDICOS    ON CD_MED_TUME = CD_CODI_MED
               LEFT JOIN TIPO_TURNO_MED    ON ( NU_AUTO_TIPO_TUME_TUME = NU_AUTO_TIPO_TUME )
       WHERE  FE_HOIN_TUME >= v_FECHAINICIAL
                AND FE_HOFI_TUME <= v_FECHAFINAL
                AND ID_DISP_TUME = 1
                AND NU_TIPO_MEDI = 2 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;