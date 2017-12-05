CREATE OR REPLACE PROCEDURE H3i_SP_ACTUALIZA_CONF_FORM_AN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_CONF_FORM_ANESTESIA IN NUMBER,
  v_NU_PLHI_PREQUIRURGICO IN NUMBER,
  v_NU_PLHI_TRANSQUIRURGICO IN NUMBER,
  v_NU_PLHI_POSTQUIRURGICO IN NUMBER,
  v_NU_PLHI_NOTAQUIRURGICO IN NUMBER
)
AS

BEGIN

   UPDATE CONFIGURA_FORM_ANESTESIA
      SET NU_PLHI_PREQUIRURGICO = v_NU_PLHI_PREQUIRURGICO,
          NU_PLHI_TRANSQUIRURGICO = v_NU_PLHI_TRANSQUIRURGICO,
          NU_PLHI_POSTQUIRURGICO = v_NU_PLHI_POSTQUIRURGICO,
          NU_PLHI_NOTAQUIRURGICO = v_NU_PLHI_NOTAQUIRURGICO
    WHERE  COD_CONF_FORM_ANESTESIA = v_COD_CONF_FORM_ANESTESIA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;