CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTAR_ACTI_SERV
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_ACTI IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT * 
        FROM R_SER_ACTI 
       WHERE  CD_CODI_ACTI_RSA = v_COD_ACTI ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;