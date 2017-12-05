CREATE OR REPLACE TRIGGER ActR_PLANT_HIST 
AFTER INSERT OR UPDATE OR DELETE 
ON R_PLAN_CONC
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
DECLARE
	v_Edita NUMBER;
	V_NumForma NUMBER;
	V_Contador NUMBER;
BEGIN
	-------------------------
 	SELECT :NEW.NU_EDITA_RPC
 	INTO v_Edita
 	FROM DUAL;
 	-------------------------
 	SELECT :NEW.NU_NUME_PLHI_RPC
 	INTO V_NumForma
 	FROM DUAL;
 	-------------------------
		
	IF 	V_Edita = 1 THEN

		BEGIN
			UPDATE R_PLANTILLA_HIST
			SET	   NU_MODI_PLHI = 1	
			WHERE  NU_NUME_PLHI_R =	V_NumForma;
		END;

	ELSE

		BEGIN
			SELECT COUNT(*)
			INTO V_Contador
			FROM R_PLAN_CONC
			WHERE V_NumForma= NU_NUME_PLHI_RPC 
				AND NU_EDITA_RPC = 1;
			-------------------------------------
			IF V_Contador > 0 THEN

				BEGIN
					UPDATE R_PLANTILLA_HIST
					SET	   NU_MODI_PLHI = 1	
					WHERE  NU_NUME_PLHI_R =	V_NumForma;
				END;

			ELSE

				BEGIN
					UPDATE R_PLANTILLA_HIST
					SET	   NU_MODI_PLHI = 0
					WHERE  NU_NUME_PLHI_R =	V_NumForma;
				END;

			END IF;

		END;

	END IF;
END;