CREATE OR REPLACE PROCEDURE H3i_SP_TIPOTURNO_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   --Busca los registros indicados
   OPEN  cv_1 FOR
      SELECT NU_AUTO_TIPO_TUME ,
             TX_DESC_TIPO_TUME 
        FROM TIPO_TURNO_MED 
        ORDER BY TX_DESC_TIPO_TUME ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;