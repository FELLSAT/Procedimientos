CREATE OR REPLACE PROCEDURE H3i_SP_RECU_TIP_ELEMENTO_COD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ID_TIP_ELEMENTO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

	OPEN  cv_1 FOR
		SELECT ID_TIP_ELEMENTO ,
			DESCRIPCION ,
			NU_SE_DEVUELVE 
		FROM PRES_TIP_ELEMENTO 
		WHERE  ID_TIP_ELEMENTO = v_ID_TIP_ELEMENTO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;