CREATE OR REPLACE PROCEDURE H3i_SP_CONS_PROFESIONAL_APRUEB
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
 (
 		V_NUHICL IN NUMBER,
 		CV_1 OUT SYS_REFCURSOR
 )
	
AS
BEGIN
	OPEN CV_1 FOR
		SELECT CD_DOCENTE_APRUEBA FROM HIST_ADENDUM WHERE NU_NUME_HICL = V_NUHICL;
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;