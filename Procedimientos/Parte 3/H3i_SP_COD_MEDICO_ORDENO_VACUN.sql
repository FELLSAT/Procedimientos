CREATE OR REPLACE PROCEDURE H3i_SP_COD_MEDICO_ORDENO_VACUN /*PROCEDIMIENTO ALMACENADO QUE PERMITE RECUPERAR LAS ASIGNACIONES DE ESPECIALIDADES DE UN USUARIO*/
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
       WHERE  CD_CONC_CONT = 'CODMEDVACU' ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_COD_MEDICO_ORDENO_VACUN;