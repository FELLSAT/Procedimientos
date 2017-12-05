CREATE OR REPLACE FUNCTION MOSTRARDOCUMENTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_DOCUMENTO IN VARCHAR2
)
RETURN VARCHAR2
AS
    v_TEXT VARCHAR2(15);

BEGIN
    v_TEXT := CASE 
                  WHEN v_DOCUMENTO LIKE '%-CC'
                      OR v_DOCUMENTO LIKE '%-TI'
                      OR v_DOCUMENTO LIKE '%-CE'
                      OR v_DOCUMENTO LIKE '%-RC'
                      OR v_DOCUMENTO LIKE '%-MS'
                      OR v_DOCUMENTO LIKE '%-AS'
                      OR v_DOCUMENTO LIKE '%-NU' 
                          THEN SUBSTR(v_DOCUMENTO, 1, LENGTH(v_DOCUMENTO) - 3)
                   ELSE v_DOCUMENTO
              END ;

    RETURN (v_TEXT);

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;