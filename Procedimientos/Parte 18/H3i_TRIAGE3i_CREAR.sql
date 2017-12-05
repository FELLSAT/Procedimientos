CREATE OR REPLACE PROCEDURE H3i_TRIAGE3i_CREAR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    -- -- 23-FEB-2012  INSERTO EN triage3I--   
    v_NU_HIST_PAC_TRIA IN VARCHAR2,
    v_FE_INIAT_TRIA IN DATE,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    INSERT INTO TRIAGE3i( 
        NU_HIST_PAC_TRIA, FE_INIAT_TRIA )
    VALUES( 
        v_NU_HIST_PAC_TRIA, TO_DATE(v_FE_INIAT_TRIA,'dd/mm/yyyy') );
    
    OPEN  cv_1 FOR
      SELECT NU_AUTO_TRIA 
      FROM TRIAGE3i
      WHERE NU_AUTO_TRIA = (SELECT MAX(NU_AUTO_TRIA) FROM TRIAGE3i);

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;