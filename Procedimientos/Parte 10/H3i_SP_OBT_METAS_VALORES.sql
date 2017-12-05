CREATE OR REPLACE PROCEDURE H3i_SP_OBT_METAS_VALORES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT R.NU_CONS_RSA_RRT ,
             R.ID_CODI_TIUS_RRT ,
             R.NU_META_RRT 
        FROM R_RSA_TIUS R
        ORDER BY R.NU_CONS_RSA_RRT,
                 R.ID_CODI_TIUS_RRT ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;