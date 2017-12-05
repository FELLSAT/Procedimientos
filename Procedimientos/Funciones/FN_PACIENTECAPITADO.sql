CREATE OR REPLACE FUNCTION FN_PACIENTECAPITADO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	v_NUMHIST IN VARCHAR2,
	v_NITEPS IN VARCHAR2
)
RETURN NUMBER
AS

BEGIN

   RETURN 1;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;