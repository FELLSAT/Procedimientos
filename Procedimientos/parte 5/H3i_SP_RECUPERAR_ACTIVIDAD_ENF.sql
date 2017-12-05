CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_ACTIVIDAD_ENF
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_TIPO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   	OPEN  cv_1 FOR
      	SELECT ID ,
             VALOR 
        FROM VAL_ACTIVI 
       	WHERE  TIPO_ID = v_COD_TIPO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;