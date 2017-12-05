CREATE OR REPLACE TRIGGER TGTIPODATO 
AFTER INSERT
ON CONEXIONES 
FoR EACH ROW
-- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
DECLARE
	V_Dato NUMBER;
BEGIN 
 
	IF (:OLD.NU_OPC_CONE <> :NEW.NU_OPC_CONE) THEN
		BEGIN			
			SELECT :NEW.NU_OPC_CONE 
			INTO V_Dato
			FROM DUAL;

			IF V_DATO = 1 THEN
				BEGIN
					SELECT :NEW.NU_NUME_CONE 
					INTO V_Dato
					FROM DUAL;

					INSERT INTO TMPCONE 
					VALUES(
						V_Dato);					  
				END;
			END IF;
		END;
	END IF;
END;