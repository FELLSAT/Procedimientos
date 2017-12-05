CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_TARIFAS_ELEMENT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   	OPEN  cv_1 FOR
      	SELECT * 
        FROM TARIFAS  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;