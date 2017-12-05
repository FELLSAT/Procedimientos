CREATE OR REPLACE TRIGGER tr_facvac 
AFTER INSERT
ON FACTURAS_CONTADO
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
DECLARE
	V_LUGAR VARCHAR2(15);
BEGIN
	SELECT :NEW.CD_CODI_LUAT_FACO 
	INTO V_LUGAR
	FROM DUAL;
	------------------------------------------------------
	IF (V_LUGAR = '') THEN
		BEGIN
			RAISE_APPLICATION_ERROR(16,'Lugar de Atención sin parametrizar, consulta a sporte');			
		END;
	END IF;
END;