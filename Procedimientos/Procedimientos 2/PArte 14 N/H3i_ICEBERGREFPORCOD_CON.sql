CREATE OR REPLACE PROCEDURE H3i_ICEBERGREFPORCOD_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_CD_CODI_ICEBERG IN VARCHAR2,
	CV_1 OUT SYS_REFCURSOR
)

AS
BEGIN 
	OPEN CV_1 FOR
		SELECT CD_CODI_ICEBERG,
			NO_NOMB_ICEBERG,0 ESTADO 
		FROM ICEBERG_REFERENCIAS 
		WHERE CD_CODI_ICEBERG = V_CD_CODI_ICEBERG 
			OR V_CD_CODI_ICEBERG  IS NULL;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);			
END;