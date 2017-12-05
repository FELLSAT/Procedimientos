CREATE OR REPLACE PROCEDURE H3i_SP_BUSCAR_SUBPROG_UNAL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_CODI_SUBP ,
             TX_NOMB_SUBP ,
             DE_DESC_SUBP ,
             NU_ESTA_SUBP 
        FROM SUBPROGRAMAS_SALUD_UNAL  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_BUSCAR_SUBPROG_UNAL;