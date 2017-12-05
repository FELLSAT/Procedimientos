CREATE OR REPLACE TRIGGER TG_VAL_ESP_MEDI_LABO  
AFTER INSERT OR UPDATE
ON LABORATORIO
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
DECLARE
	V_CODI_ESPE VARCHAR2(3);
	V_CODI_MEDI VARCHAR(10);
	V_EXISTE NUMBER;
BEGIN
	SELECT COUNT(:NEW.CD_CODI_MEDI_LABO) + COUNT(:NEW.CD_CODI_ESP_LABO)
	INTO V_EXISTE
	FROM DUAL;
	------------------------------------------------------
	IF (V_EXISTE >= 1) THEN
		BEGIN
			SELECT :NEW.CD_CODI_MEDI_LABO, 
				:NEW.CD_CODI_ESP_LABO 
			INTO V_CODI_MEDI,V_CODI_ESPE
			FROM DUAL;
			------------------------------------------------------
			SELECT COUNT(*)
			INTO V_EXISTE 
			FROM R_MEDI_ESPE 
			WHERE CD_CODI_MED_RMP = V_CODI_MEDI 
				AND CD_CODI_ESP_RMP = V_CODI_ESPE;
			------------------------------------------------------	
			--SI DA 0 LA ESPECIALIDAD PARA ESE MEDICO NO EXISTE, ENTONCES SE LEVANTA EL ERROR
			IF (V_EXISTE <= 0) THEN
				BEGIN
					RAISE_APPLICATION_ERROR(16,'El doctor de código '||V_CODI_MEDI||' no tiene la especialidad '||V_CODI_ESPE||'. No se puede completar la operación en la tabla laboratorio');
				  	ROLLBACK;
				END;
			END IF;
		END;
	END IF;
END;