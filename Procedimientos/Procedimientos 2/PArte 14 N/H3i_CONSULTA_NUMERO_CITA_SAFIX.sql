CREATE OR REPLACE PROCEDURE H3i_CONSULTA_NUMERO_CITA_SAFIX
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NU_NUME_MOVI IN NUMBER,
    CV_1 OUT SYS_REFCURSOR
)

AS
  
BEGIN

    OPEN CV_1 FOR
        SELECT NU_NUME_CITA_DFT        
        FROM R_HCP_MOVI
        WHERE NU_NUME_MOVI = V_NU_NUME_MOVI;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;