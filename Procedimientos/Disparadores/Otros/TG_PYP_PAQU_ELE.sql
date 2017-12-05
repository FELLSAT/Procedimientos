CREATE OR REPLACE TRIGGER TG_PYP_PAQU_ELE 
AFTER INSERT
ON FORMULAS 
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
DECLARE
	V_VALIDAR VARCHAR2(4000);
BEGIN	
	SELECT TO_CHAR(VL_VALO_CONT) 	
	INTO V_VALIDAR
	FROM CONTROL 
	WHERE CD_CONC_CONT='PYP_PAQU'  
		AND TO_CHAR(VL_VALO_CONT) = '1';
	------------------------------------------------------
	IF (V_VALIDAR = '1') THEN
		DECLARE
			V_FACO_SERV NUMBER;
			V_NUMPAQU NUMBER; 
			V_NUMSER NUMBER; 
			V_CODPAQU VARCHAR2(50);   
			V_FACO_PAQU NUMBER;
		BEGIN
			SELECT NU_NUME_PAQU_MOVI 
			INTO V_NUMPAQU
			FROM DUAL 
			INNER JOIN MOVI_CARGOS 
				ON NU_NUME_MOVI = :NEW.NU_NUME_MOVI_FORM;
			------------------------------------------------------
			SELECT MOVI_CARGOS.NU_NUME_FACO_MOVI, 
				:NEW.NU_NUME_MOVI_FORM 
			INTO V_FACO_SERV,V_NUMSER
			FROM DUAL
			INNER JOIN MOVI_CARGOS 
				ON MOVI_CARGOS.NU_NUME_MOVI = :NEW.NU_NUME_MOVI_FORM;
			------------------------------------------------------

			IF (V_NUMPAQU <> 0) THEN -- SOLO SI SE ESTA PAQUETIZANDO ' XA VALIDAR PYP
				DECLARE
					V_EXISTE  NUMBER;
				BEGIN
					SELECT COUNT(NU_INDPYP_ARTI) 
					INTO V_EXISTE
					FROM  DUAL
					INNER JOIN ARTICULO 
						ON :NEW.CD_CODI_ELE_FORM = CD_CODI_ARTI 
					WHERE :NEW.NU_NUME_MOVI_FORM = V_NUMSER 
						AND NU_INDPYP_ARTI = 1; 
					------------------------------------------------------
					IF (V_EXISTE >= 1) THEN --SI EL CARGO CORRESPONDE A PYP
						DECLARE
							V_NOMART VARCHAR2(255);
						BEGIN							
							SELECT NO_NOMB_ARTI 
							INTO V_NOMART
							FROM DUAL
							INNER JOIN ARTICULO 
								ON :NEW.CD_CODI_ELE_FORM = CD_CODI_ARTI 
							WHERE :NEW.NU_NUME_MOVI_FORM = V_NUMSER ;
							
							RAISE_APPLICATION_ERROR(16,'NO SE PUEDE PAQUETIZAR %S POR QUE ES UN ELEMENTO MARCADO COMO PYP '||V_NOMART);
						END;
					END IF;
				END;
			END IF;
		END;
	END IF;
END;
--END TG5