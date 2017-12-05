CREATE OR REPLACE PROCEDURE QyR3i_SP_REC_RESPUESTAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

	OPEN  cv_1 FOR
		SELECT NU_NUME_RR ,
			TX_NOMB_RR ,
			FE_FECH_RR 
		FROM QYR_RESPUESTA  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;