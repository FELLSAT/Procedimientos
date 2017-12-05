CREATE OR REPLACE PROCEDURE H3i_SP_TIPO_APLICACION_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT TO_NUMBER(NU_NUME_TIAP,10.0) NU_NUME_TIAP  ,
             TX_NOMBRE_TIAP 
        FROM TIPO_APLICACION  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_TIPO_APLICACION_CON;