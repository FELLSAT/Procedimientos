CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_LST_CLIENT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CODIGO_CLIENTE_APP ,
             NOMBRE_CLIENTE_APP ,
             URL_IMG_REP_CLI_APP ,
             URL_IMG_LOGO_CLI_APP 
        FROM CLIENTES_APP  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_OBTENER_LST_CLIENT;