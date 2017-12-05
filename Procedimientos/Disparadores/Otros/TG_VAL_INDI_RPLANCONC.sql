CREATE OR REPLACE TRIGGER TG_VAL_INDI_RPLANCONC 
AFTER INSERT OR UPDATE
ON R_PLAN_CONC 
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
DECLARE
 	V_INDICE_INSERT NUMBER;
 	V_NUM_PLANTILLA NUMBER;
 	V_AUTO_INC NUMBER;
 	V_EXISTE NUMBER;
BEGIN
	SELECT COUNT(:NEW.NU_INDI_RPC) + COUNT(:NEW.NU_NUME_PLHI_RPC) + COUNT(:NEW.AUTO_INC_RPC)
	INTO V_EXISTE
	FROM DUAL;
	------------------------------------------------------
	IF (V_EXISTE >= 1) THEN
		BEGIN
			SELECT :NEW.NU_INDI_RPC, :NEW.NU_NUME_PLHI_RPC, 
				:NEW.AUTO_INC_RPC
			INTO V_INDICE_INSERT, V_NUM_PLANTILLA,
				V_AUTO_INC
			FROM DUAL;
			------------------------------------------------------
			SELECT COUNT(*) 
			INTO V_EXISTE
			FROM R_PLAN_CONC 
			WHERE NU_INDI_RPC = V_INDICE_INSERT 
				AND NU_NUME_PLHI_RPC = V_NUM_PLANTILLA 
				AND AUTO_INC_RPC != V_AUTO_INC;
			------------------------------------------------------
			-- SI EXISTE EL INDICE SE DISPARA
			IF (V_EXISTE >= 1) THEN
				BEGIN
					RAISE_APPLICATION_ERROR(16,'El indice '||V_INDICE_INSERT||' ya esta parametrizado para la plantilla '||V_NUM_PLANTILLA);
				  	ROLLBACK;
				END;
			END IF;
		END;
	END IF;
END;