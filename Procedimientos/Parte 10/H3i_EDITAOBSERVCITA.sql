CREATE OR REPLACE PROCEDURE H3i_EDITAOBSERVCITA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_numerocita IN NUMBER,
  v_observacion IN VARCHAR2
)
AS

BEGIN

   UPDATE CITAS_MEDICAS
      SET DE_DESC_CIT = v_observacion
    WHERE  NU_NUME_CIT = v_numerocita;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;