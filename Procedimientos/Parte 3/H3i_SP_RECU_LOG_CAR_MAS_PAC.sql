CREATE OR REPLACE PROCEDURE H3i_SP_RECU_LOG_CAR_MAS_PAC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_AUTO_NUME_LCMP ,
             FE_FECH_REG_LCMP ,
             TX_LOG_REG_LCMP 
        FROM LOG_CAR_MAS_PAC 
        ORDER BY FE_FECH_REG_LCMP DESC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_RECU_LOG_CAR_MAS_PAC;