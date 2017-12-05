CREATE OR REPLACE PROCEDURE H3i_SP_ACTUALIZA_ORDENES_QUIR -- PROCEDIMIENTO ALMACENADO QUE PERMITE ACTUALIZAR EL ESTADO DE UNA ORDEN ASOCIADA A UNA SOLICITUD QUIRURGICA 
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_HICL_HPRO IN NUMBER,
  v_NU_NUME_SOL_CIR IN NUMBER
)
AS

BEGIN

   UPDATE HIST_PROC
      SET NU_NUME_SOLIC_HPRO = v_NU_NUME_SOL_CIR
    WHERE  NU_NUME_HICL_HPRO = v_NU_NUME_HICL_HPRO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;