CREATE OR REPLACE PROCEDURE H3i_AUDI_LISTARCONCENTRACIONES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

	OPEN  cv_1 FOR
		SELECT CD_COD_MACO ,
			DESCRIPCION_MACO ,
			ESTADO_MACO 
		FROM AUDI_CONCENTRACION  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;