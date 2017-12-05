CREATE OR REPLACE FUNCTION  MOSTRARTIPODOCUMENTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_DOCUMENTO IN VARCHAR2
)
RETURN VARCHAR2
AS
   v_TEXT VARCHAR2(2);

BEGIN
   v_TEXT := CASE v_DOCUMENTO
                             WHEN 0 THEN 'CC'
                             WHEN 1 THEN 'TI'
                             WHEN 2 THEN 'RC'
                             WHEN 3 THEN 'CE'
                             WHEN 4 THEN 'PA'
                             WHEN 5 THEN 'AS'
                             WHEN 5 THEN 'MS'
                             WHEN 6 THEN 'NU'   END ;
   RETURN (v_TEXT);

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;