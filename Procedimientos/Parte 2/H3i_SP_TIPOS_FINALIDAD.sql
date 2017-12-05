CREATE OR REPLACE PROCEDURE H3i_SP_TIPOS_FINALIDAD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT TX_CODI_RRTT CODIGO  ,
             ID_CODI_TIPR_RRTT ,
             TX_CODI_TPRF_RRTT ,
             TX_DESC_RRTT NOMBRE  
        FROM R_TIPROC_TIPROCF  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_TIPOS_FINALIDAD;