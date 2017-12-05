CREATE OR REPLACE PROCEDURE H3i_SP_LISTARETNIAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT TX_CODIGO_ETNI CODIGO  ,
             TX_NOMBRE_ETNI DESCR  ,
             ESTADO ,
             CD_CODI_ALTERNA CODIGOALTER  
        FROM ETNIA  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;