CREATE OR REPLACE PROCEDURE H3i_SP_BUSCADX_CODI_DIAG
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_DIAG IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT * 
        FROM DIAGNOSTICO 
       WHERE  CD_CODI_DIAG = v_CD_CODI_DIAG ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;