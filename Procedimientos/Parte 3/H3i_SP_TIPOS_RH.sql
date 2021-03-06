CREATE OR REPLACE PROCEDURE H3i_SP_TIPOS_RH /*PROCEDIMIENTO ALMACENADO QUE PERMITE RECUPERAR LAS ASIGNACIONES DE ESPECIALIDADES DE UN USUARIO*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_AUTO_TIRH ,
             TX_NOMBRE_TIRH 
        FROM TIPORH  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_TIPOS_RH;