CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTAHUELLA_PAC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_HISTORIA IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT TX_HUELLA_HUPA 
        FROM HUELLA_PACIENTE 
       WHERE  NU_HIST_PAC_HUPA = v_HISTORIA ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTAHUELLA_PAC;