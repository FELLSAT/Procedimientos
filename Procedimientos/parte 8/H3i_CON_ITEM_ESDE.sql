CREATE OR REPLACE PROCEDURE H3i_CON_ITEM_ESDE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TIPO IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_AUTO_ITES ,
             NU_TIPO_ITES ,
             NU_ITEM_ITES ,
             NU_MINEDAD_ITES ,
             NU_MAXEDAD_ITES ,
             TX_RANGO_ITES ,
             TX_DESCRIBE_ITES ,
             NU_PESO_ITES 
        FROM ITEM_ESDE 
       WHERE  NU_TIPO_ITES = v_TIPO
        ORDER BY NU_ITEM_ITES ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;