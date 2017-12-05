CREATE OR REPLACE PROCEDURE H3i_ICEBERGSERPORCOD_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_CD_CODI_SER IN VARCHAR2,
	V_CD_CODI_ESP IN VARCHAR2,
	CV_1 OUT SYS_REFCURSOR
)

AS
	V_CODIGO NUMBER;
BEGIN

	SELECT COUNT(1) 
	INTO V_CODIGO 
	FROM ICEBERG_SERVICIOS ISER 
	INNER JOIN ICEBERG_REFERENCIAS IREF 
		ON ISER.CD_CODI_ICEBERG = IREF.CD_CODI_ICEBERG
	INNER JOIN SERVICIOS SER 
		ON ISER.CD_CODI_SER = SER.CD_CODI_SER
	WHERE ISER.CD_CODI_SER = V_CD_CODI_SER;


	IF (V_CODIGO = 1) THEN

		BEGIN
			OPEN CV_1 FOR
				SELECT ISER.CD_CODI_SER,SER.NO_NOMB_SER,
					ISER.CD_CODI_ICEBERG,IREF.NO_NOMB_ICEBERG,
					ISER.CD_CECOS_ICEBERG,0 ESTADO
				FROM ICEBERG_SERVICIOS ISER 
				INNER JOIN ICEBERG_REFERENCIAS IREF 
					ON ISER.CD_CODI_ICEBERG = IREF.CD_CODI_ICEBERG
				INNER JOIN SERVICIOS SER 
					ON ISER.CD_CODI_SER = SER.CD_CODI_SER
				WHERE ISER.CD_CODI_SER = V_CD_CODI_SER;
		END;

	ELSE

		BEGIN
			OPEN CV_1 FOR
				SELECT CD_CODI_SER,NO_NOMB_SER,
					' ' CD_CODI_ICEBERG,' ' NO_NOMB_ICEBERG,
					' ' CD_CECOS_ICEBERG,1 ESTADO
				FROM SERVICIOS 
				INNER JOIN R_esp_ser RES 
					ON CD_CODI_SER_RES = CD_CODI_SER 
				WHERE RES.CD_CODI_ESP_RES = V_CD_CODI_ESP
					AND CD_CODI_SER = V_CD_CODI_SER;
		END;

	END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);	
END;