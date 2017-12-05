CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_SINIESTRO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT COD_SIN_AMP ,
             DES_SIN_AMP ,
             VAL_SIN_AMP ,
             ESTADO 
        FROM SINIESTRO_AMPARADO  ;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_SINIESTRO;