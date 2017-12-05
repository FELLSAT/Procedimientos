CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_CONSECUTIVO_A
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT VL_VALO_CONT CONSECUTIVO  
        FROM CONTROL 
       WHERE  CD_CONC_CONT = 'AS_CONSECUTIVO' ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_RECUPERAR_CONSECUTIVO_A;