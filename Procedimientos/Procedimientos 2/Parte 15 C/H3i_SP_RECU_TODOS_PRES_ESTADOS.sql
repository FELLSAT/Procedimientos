CREATE OR REPLACE PROCEDURE H3i_SP_RECU_TODOS_PRES_ESTADOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  	cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

	OPEN  cv_1 FOR
		SELECT ID_ESTADO ,
			DES_ESTADO 
		FROM PRES_ESTADOS  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;