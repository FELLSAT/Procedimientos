CREATE OR REPLACE PROCEDURE H3i_CONSULTA_ESTADOS_MUESTRA 
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

	OPEN  cv_1 FOR
		SELECT CD_CODI_ESM ,
			NO_NOMB_ESM
		FROM ESTADOS_MUESTRA  ;
   
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
