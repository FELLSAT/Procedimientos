CREATE OR REPLACE PROCEDURE H3i_SP_CONS_GENGLOSA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   	OPEN  cv_1 FOR
      	SELECT TX_CODIGO_GEGL ,
             TX_NOMBRE_GEGL ,
             NU_ESTADO_GEGL 
        FROM GENERAL_GLOSA3i ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;