CREATE OR REPLACE PROCEDURE H3I_ICEBERG_ARTICULOS_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_cd_codi_arti IN VARCHAR2,
	CV_1 OUT SYS_REFCURSOR
)
	
	
AS
BEGIN
	
	OPEN CV_1 FOR	
		SELECT ire.cd_codi_iceberg,ire.no_nomb_iceberg,art.cd_codi_arti,art.no_nomb_arti,
		iar.cd_cecos_iceberg
		FROM iceberg_articulos  iar 
		INNER JOIN iceberg_referencias ire 
			ON iar.cd_codi_iceberg = ire.cd_codi_iceberg
		INNER JOIN articulo art 
			ON iar.cd_codi_arti = art.cd_codi_arti
		WHERE iar.cd_codi_arti = V_cd_codi_arti;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
