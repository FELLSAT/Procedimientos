CREATE OR REPLACE PROCEDURE H3i_SP_CONS_REGISTRO_ADMISION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_NU_NUME_REG IN NUMBER,
	CV_1 OUT SYS_REFCURSOR
)
	
AS
BEGIN
	OPEN CV_1 FOR
		SELECT *
		FROM REGISTRO
		WHERE NU_NUME_REG = V_NU_NUME_REG;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;