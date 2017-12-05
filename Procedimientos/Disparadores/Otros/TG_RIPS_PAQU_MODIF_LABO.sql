CREATE OR REPLACE TRIGGER TG_RIPS_PAQU_MODIF_LABO 
AFTER UPDATE
ON LABORATORIO
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
DECLARE
	V_MOVPAQ NUMBER;
	V_MOVSER NUMBER;
	V_FACSER NUMBER;
	V_FACPAQ NUMBER;
	V_CODPAQ VARCHAR2(10); 
	V_CODSER VARCHAR2(10);
	V_ESTADO NUMBER;
BEGIN
	IF (:OLD.ID_ESTA_ASIS_LABO <> :NEW.ID_ESTA_ASIS_LABO) THEN
		BEGIN	
			SELECT NU_NUME_PAQU_MOVI, NU_NUME_FACO_MOVI
			INTO V_MOVPAQ, V_FACSER
			FROM DUAL
			INNER JOIN MOVI_CARGOS 
				ON NU_NUME_MOVI = :NEW.NU_NUME_MOVI_LABO;
		END;
	END IF;
	------------------------------------------------------
	IF (V_MOVPAQ <> 0) THEN  --SERVICIO PAQUETIZADO
		BEGIN
			SELECT :NEW.ID_ESTA_ASIS_LABO, :NEW.NU_NUME_MOVI_LABO, :NEW.CD_CODI_SER_LABO
			INTO V_ESTADO, V_MOVSER, V_CODSER
			FROM DUAL;
			------------------------------------------------------
			IF (V_ESTADO <> 0) THEN
				BEGIN
					V_ESTADO := VALIDAPAQU(V_MOVSER,V_MOVPAQ,0);
					------------------------------------------------------
					UPDATE PAQUETES 
					SET ID_ESTA_ASIS_PAQU = V_ESTADO 
					WHERE NU_NUME_MOVI_PAQU = V_MOVPAQ; 
				END;
			END IF;
			------------------------------------------------------
			IF (V_ESTADO = 1) THEN--SI SE COMPLETO RIPS, SE DEBE VALIDAR LA FACTURA
				BEGIN
					IF (V_FACSER <> 0) THEN -- SI EL SERVICIO TIENE FACTURA
						BEGIN
							SELECT NU_NUME_FACO_MOVI 
							INTO V_FACPAQ
							FROM MOVI_CARGOS 
							WHERE NU_NUME_MOVI = V_MOVPAQ;
							------------------------------------------------------
							IF (V_FACPAQ = 0) THEN -- SI EL PAQUETE NO TIENE FACTURA
								DECLARE
									V_EXISTE NUMBER;
								BEGIN
									SELECT CD_CODI_SER_PAQU 
									INTO V_CODPAQ
									FROM PAQUETES 
									WHERE NU_NUME_MOVI_PAQU = V_MOVPAQ;
									------------------------------------------------------
									SELECT DISTINCT 1 
									INTO V_EXISTE
									FROM R_PAQU_SER 
									WHERE CD_CODI_SER_RPSE = V_CODSER 
										AND CD_CODI_SER_PAQ_RPSE = V_CODPAQ 
										AND NU_OBLI_RPSE = 1;
									------------------------------------------------------
									IF (V_EXISTE >= 1) THEN -- SI EL SERVICIO ESTA MARCADO COMO OBLIGATORIO
										BEGIN
											UPDATE MOVI_CARGOS 
											SET NU_NUME_FACO_MOVI = V_FACSER 
											WHERE NU_NUME_MOVI = V_MOVPAQ;
										END;
									END IF;
								END;
							END IF;
						END;
					END IF;
				END;
			END IF;
		END;
	END IF;
END;