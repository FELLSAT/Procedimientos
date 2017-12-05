CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_CODIGOS_ICDAS-- PROCEDIMIENTO ALMACENADO PARA RECUPERACION DE CODIGOS ICDAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_ICDAS ,
             NU_VALOR ,
             NU_POS_DIGITO ,
             DE_DESCRIPCION ,
             BOOL_COMB_ESP 
        FROM HIST_ODONTO_ICDAS  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;