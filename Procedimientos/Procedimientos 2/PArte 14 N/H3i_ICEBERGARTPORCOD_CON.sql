CREATE OR REPLACE PROCEDURE H3i_ICEBERGARTPORCOD_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_CD_CODI_ARTI IN VARCHAR2,
	CV_1 OUT SYS_REFCURSOR
)
 
AS
	V_CODIGO NUMBER;
BEGIN

	SELECT COUNT(1) 
	INTO V_CODIGO
	FROM ICEBERG_ARTICULOS IART 
	LEFT JOIN ICEBERG_REFERENCIAS IREF 
		ON IART.CD_CODI_ICEBERG = IREF.CD_CODI_ICEBERG
	INNER JOIN ARTICULO ART 
		ON IART.CD_CODI_ARTI = ART.CD_CODI_ARTI 
	WHERE IART.CD_CODI_ARTI = V_CD_CODI_ARTI;


	IF(V_CODIGO = 1) THEN

		BEGIN
			OPEN CV_1 FOR
				SELECT IART.CD_CODI_ARTI,ART.NO_NOMB_ARTI,
					IART.CD_CODI_ICEBERG,IREF.NO_NOMB_ICEBERG,
					IART.CD_CECOS_ICEBERG,0 ESTADO
				FROM ICEBERG_ARTICULOS IART 
				LEFT JOIN ICEBERG_REFERENCIAS IREF 
					ON IART.CD_CODI_ICEBERG = IREF.CD_CODI_ICEBERG
				INNER JOIN ARTICULO ART 
					ON IART.CD_CODI_ARTI = ART.CD_CODI_ARTI 
				WHERE IART.CD_CODI_ARTI = V_CD_CODI_ARTI;
		END;

	ELSE

		BEGIN	
			OPEN CV_1 FOR
				SELECT CD_CODI_ARTI,NO_NOMB_ARTI,' ' CD_CODI_ICEBERG,
				' ' NO_NOMB_ICEBERG,' ' CD_CECOS_ICEBERG,
				1 ESTADO
				FROM ARTICULO
				WHERE CD_CODI_ARTI = V_CD_CODI_ARTI;
		END;

	END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
end;