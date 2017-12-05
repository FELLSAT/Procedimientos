CREATE OR REPLACE PROCEDURE H3i_EDITAHORACITA3
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_numerocita IN NUMBER,
  v_nuevafecha IN DATE,
  v_codnuevodoc IN VARCHAR2
)
AS

BEGIN

   UPDATE CITAS_MEDICAS
      SET FE_FECH_CIT = v_nuevafecha,
          CD_CODI_MED_CIT = v_codnuevodoc
    WHERE  NU_NUME_CIT = v_numerocita;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;