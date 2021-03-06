CREATE OR REPLACE PROCEDURE H3i_OBT_ULTCONSENT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS
	V_NU_NUME_HCONSENT HIST_CONSENT.NU_NUME_HCONSENT%TYPE;
BEGIN
	SELECT NU_NUME_HCONSENT 
	INTO V_NU_NUME_HCONSENT 
	FROM HIST_CONSENT
	WHERE NU_NUME_HCONSENT = (SELECT MAX(NU_NUME_HCONSENT) FROM HIST_CONSENT);

   OPEN  cv_1 FOR
      	SELECT TO_NUMBER(V_NU_NUME_HCONSENT) NU_NUME_HCONSENT  
        FROM DUAL  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;