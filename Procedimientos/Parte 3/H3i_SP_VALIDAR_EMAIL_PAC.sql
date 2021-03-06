CREATE OR REPLACE PROCEDURE H3i_SP_VALIDAR_EMAIL_PAC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
 	V_DE_EMAIL_PAC VARCHAR2,
 	CV_1 OUT SYS_REFCURSOR
)
AS
BEGIN
 	OPEN CV_1 FOR
 		SELECT DE_EMAIL_PAC
		FROM PACIENTES
		WHERE DE_EMAIL_PAC = V_DE_EMAIL_PAC;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;