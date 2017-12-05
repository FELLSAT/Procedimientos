CREATE OR REPLACE PROCEDURE QyR3i_SP_REC_TIPO_SOLICITUD
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
		FROM QYR_TIPO_SOLICITUD  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;