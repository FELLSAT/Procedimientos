CREATE OR REPLACE TRIGGER TG_RIPS_PAQU 
AFTER UPDATE
ON MOVI_CARGOS	
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
DECLARE
	V_MOVSER NUMBER; 
	V_MOVPAQ NUMBER;	
	V_ESTADO NUMBER;	
BEGIN
	IF (:OLD.NU_NUME_PAQU_MOVI <> :NEW.NU_NUME_PAQU_MOVI) THEN
		BEGIN			
			IF (:NEW.NU_NUME_PAQU_MOVI <> 0) THEN --SE ESTA PAQUETIZANDO
				BEGIN
					SELECT :NEW.NU_NUME_PAQU_MOVI 
					INTO V_MOVPAQ
					FROM DUAL;
					------------------------------------------------------
					SELECT :NEW.NU_NUME_MOVI 
					INTO V_MOVSER
					FROM DUAL;
					------------------------------------------------------
					V_ESTADO := VALIDAPAQU(V_MOVSER,V_MOVPAQ,1);
					------------------------------------------------------
					UPDATE PAQUETES
					SET	ID_ESTA_ASIS_PAQU = V_ESTADO
					WHERE  NU_NUME_MOVI_PAQU = V_MOVPAQ;
					------------------------------------------------------
				END;
			ELSE
				BEGIN
					SELECT :OLD.NU_NUME_PAQU_MOVI 
					INTO V_MOVPAQ
					FROM DUAL;
					------------------------------------------------------
					SELECT :NEW.NU_NUME_MOVI 
					INTO V_MOVSER
					FROM DUAL;
					------------------------------------------------------
					V_ESTADO := VALIDAPAQU(V_MOVSER,V_MOVPAQ,0);
					------------------------------------------------------
					UPDATE PAQUETES
					SET	ID_ESTA_ASIS_PAQU = V_ESTADO
					WHERE NU_NUME_MOVI_PAQU = V_MOVPAQ;
				END;
			END IF;
		END;
	END IF;
END;