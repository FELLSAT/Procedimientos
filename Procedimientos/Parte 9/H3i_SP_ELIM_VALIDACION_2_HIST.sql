CREATE OR REPLACE PROCEDURE H3i_SP_ELIM_VALIDACION_2_HIST -- PROCEDIMIENTO PARA ELIMINA VALIDACIONES 2 DE CONCEPTOS PARA FORMATOS DE HISTORIA CLINICA 
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_COHI_VAHI2 IN NUMBER,
  v_NU_NUME_PLHI_VAHI2 IN NUMBER
)
AS

BEGIN

   DELETE VALCONC_HIST2

    WHERE  NU_NUME_COHI_VAHI2 = v_NU_NUME_COHI_VAHI2
             AND NU_NUME_PLHI_VAHI2 = v_NU_NUME_PLHI_VAHI2;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;