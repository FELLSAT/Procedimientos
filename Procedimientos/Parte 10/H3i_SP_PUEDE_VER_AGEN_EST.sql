CREATE OR REPLACE PROCEDURE H3i_SP_PUEDE_VER_AGEN_EST /*PROCEDIMIENTO ALMACENADO QUE PERMITE ACTUALIZAR LOS CAMBIOS DE NUMERO Y TIPO DE DOCUMENTO DEL PACIENTE */
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT VL_VALO_CONT 
        FROM CONTROL 
       WHERE  CD_CONC_CONT = 'VER_AGENDA_EST' ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;