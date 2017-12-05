CREATE OR REPLACE PROCEDURE SP_aCOMER_FACTURA_PUESTOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
 (
 	IN_CODIGO_MESA IN VEN0104.MESCOD%TYPE, -- CODIGO DE LA MESA
 	OUT_CURSOR_PUESTOS OUT SYS_REFCURSOR   -- CURSOR CON LOS PUESTOS QUE FALTAN POR FACTURAR
 )
 AS 
 BEGIN
 	OPEN OUT_CURSOR_PUESTOS FOR
	 	SELECT DISTINCT SUBSTR(CCOCOD,2)  CCOCOD
		FROM VEN0004 A
		INNER JOIN VEN0104 B
		    ON A.PEDNRO = B.PEDNRO
		    AND B.MESCOD = IN_CODIGO_MESA
		WHERE PEDSAL NOT IN ('F')
		    ORDER BY CCOCOD; 
 END;