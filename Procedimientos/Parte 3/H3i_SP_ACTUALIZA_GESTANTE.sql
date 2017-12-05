CREATE OR REPLACE PROCEDURE H3i_SP_ACTUALIZA_GESTANTE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_HIST_PAC IN VARCHAR2,
  v_NU_GEST_PAC IN NUMBER
)
AS

BEGIN

   UPDATE PACIENTES
      SET NU_GEST_PAC = v_NU_GEST_PAC
    WHERE  NU_HIST_PAC = v_NU_HIST_PAC;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;