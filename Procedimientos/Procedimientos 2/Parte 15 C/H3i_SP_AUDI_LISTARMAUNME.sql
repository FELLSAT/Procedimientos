CREATE OR REPLACE PROCEDURE H3i_SP_AUDI_LISTARMAUNME
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

	OPEN  cv_1 FOR
		SELECT CD_COD_MAUNME ,
			DESCRIPCION_MAUNME ,
			ESTADO_MAUNME 
		FROM AUDI_UNIDAD_MEDIDA  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;