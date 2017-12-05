CREATE OR REPLACE PROCEDURE H3i_COMPLETAR_MARCASRIPS_LABHC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NUMLABO IN NUMBER
)
AS

BEGIN

   UPDATE LABORATORIO
      SET NU_ESHI_LABO = 2,
          ID_ESTA_ASIS_LABO = 1
    WHERE  NU_NUME_LABO = v_NUMLABO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;