CREATE OR REPLACE PROCEDURE H3i_SP_CONS_PABELLONES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CodPiso IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

	OPEN  cv_1 FOR
		SELECT CD_CODI_PABE ,
			DE_DESC_PABE ,
			CD_CODI_PISO_PABE 
		FROM PABELLONES 
		WHERE  CD_CODI_PISO_PABE = NVL(v_CodPiso, CD_CODI_PISO_PABE) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;