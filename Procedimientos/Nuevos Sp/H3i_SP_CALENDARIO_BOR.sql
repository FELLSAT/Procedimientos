CREATE OR REPLACE PROCEDURE H3i_SP_CALENDARIO_BOR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_FECHA IN DATE DEFAULT NULL
)
AS
BEGIN

	DELETE CALENDARIO 
	WHERE FE_FECH_CALE = V_FECHA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
