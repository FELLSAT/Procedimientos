CREATE OR REPLACE PROCEDURE H3i_SP_CONTROL_LIBERAHC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT VL_VALO_CONT 
        FROM CONTROL 
       WHERE  CD_CONC_CONT = 'TIEMPO_LIBERA_HC' ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;