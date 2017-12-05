CREATE OR REPLACE PROCEDURE H3i_SP_CONS_ESTADOGLOSA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   	OPEN  cv_1 FOR
      	SELECT NU_AUTO_ESGLO ,
             TX_NOMBRE_ESGLO 
        FROM ESTADO_GLOSA3i  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;