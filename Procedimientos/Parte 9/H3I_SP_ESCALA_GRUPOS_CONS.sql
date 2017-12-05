CREATE OR REPLACE PROCEDURE H3I_SP_ESCALA_GRUPOS_CONS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_AUTO_RAED CODIGO  ,
             TX_DESC_RAED DESCRIPCION  
        FROM ESCALA_RANGOEDAD 
        ORDER BY 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;