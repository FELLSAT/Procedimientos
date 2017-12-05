CREATE OR REPLACE PROCEDURE H3i_SP_ACT_AUDITORIA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NumConex IN NUMBER
)
AS

BEGIN

   UPDATE Audit3i
      SET NoConexion = v_NumConex
    WHERE  IDSesionServer = USERENV('sessionid')
     AND NoConexion = 0;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_ACT_AUDITORIA;