CREATE OR REPLACE PROCEDURE H3i_SP_CONS_ESPGLOSA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================	
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

	OPEN  cv_1 FOR
		SELECT TX_CODIGO_ESGL ,
			TX_NOMBRE_ESGL ,
			NU_ESTADO_ESGL 
		FROM ESPECIFICO_GLOSA3i ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;