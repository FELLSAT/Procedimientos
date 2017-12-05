CREATE OR REPLACE PROCEDURE H3i_ICEBERGREFERENCIAS_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	CV_1 OUT SYS_REFCURSOR
)
AS
BEGIN
	OPEN CV_1 FOR
		SELECT CD_CODI_ICEBERG,NO_NOMB_ICEBERG 
		FROM iceberg_referencias;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;