CREATE OR REPLACE PROCEDURE H3i_SP_ELIM_SERVICIO_RESTRICC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  	v_CODIGO IN NUMBER
)
AS

BEGIN

   	DELETE SERVICIOS_RESTRICCION
    WHERE  ID_IDEN_SR = v_CODIGO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;