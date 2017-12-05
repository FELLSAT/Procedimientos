CREATE OR REPLACE PROCEDURE H3i_SP_CONSUL_VALORAC_AUDIT_HC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_AUTO_VAAU_VAHC ,
             TX_Descripcion_VAHC 
        FROM VALORACION_AUDITORIA_HC  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;