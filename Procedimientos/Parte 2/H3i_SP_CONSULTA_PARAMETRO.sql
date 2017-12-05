CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_PARAMETRO /*
	PROCEDIMIENTO ALMACENADO QUE PERMITE OBTENER EL VALOR DE UN PARAMETRO EN PARTICULAR
	@@CLAVE: CONCEPTO BUSCADO
*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CLAVE IN NVARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT DE_DESC_CONT ,
             VL_VALO_CONT 
        FROM CONTROL 
       WHERE  CD_CONC_CONT = v_CLAVE ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_PARAMETRO;