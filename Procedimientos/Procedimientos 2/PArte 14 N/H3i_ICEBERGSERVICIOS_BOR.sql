CREATE OR REPLACE PROCEDURE H3i_ICEBERGSERVICIOS_BOR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_CD_CODI_SER IN VARCHAR2
)
AS

BEGIN
	
	DELETE FROM ICEBERG_SERVICIOS 
	WHERE CD_CODI_SER = V_CD_CODI_SER;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
