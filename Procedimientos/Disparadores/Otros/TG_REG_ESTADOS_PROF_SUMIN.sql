CREATE OR REPLACE TRIGGER TG_REG_ESTADOS_PROF_SUMIN  
AFTER INSERT OR UPDATE
ON AUDITAR_CATALOGO_PROFE_SUMIN
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
DECLARE
	V_COD_CATAL_PS NUMBER;
	V_NU_ESTADO_PS NUMBER;
	V_COUNT NUMBER;
BEGIN
	SELECT :NEW.COD_CATAL_PS, :NEW.NU_ESTADO_PS
	INTO V_COD_CATAL_PS, V_NU_ESTADO_PS
	FROM DUAL;
	------------------------------------------------------
	SELECT COUNT(COD_NUM_ESTA_AEFCPS) 
	INTO V_COUNT
	FROM AUDITAR_ESTA_FECHA_CAT_PROFE_S 
	WHERE COD_CATAL_PS_AEFCPS = V_COD_CATAL_PS;
	------------------------------------------------------
	IF (V_COUNT = 0) THEN

		BEGIN
			INSERT INTO AUDITAR_ESTA_FECHA_CAT_PROFE_S(
				COD_CATAL_PS_AEFCPS, NU_ESTA_AEFCOS,
		        FE_FECHA_INI_AEFCOS, FE_FECHA_FIN_AEFCOS)
		    VALUES(
		    	V_COD_CATAL_PS, V_NU_ESTADO_PS,
		    	SYSDATE, NULL);
		END;

	ELSE

		DECLARE
			V_COD_NUM_ESTA_AEFCPS NUMBER;
			V_NU_ESTA_AEFCOS NUMBER;
		BEGIN
			SELECT COD_NUM_ESTA_AEFCPS, NU_ESTA_AEFCOS  
			INTO V_COD_NUM_ESTA_AEFCPS, V_NU_ESTA_AEFCOS
			FROM AUDITAR_ESTA_FECHA_CAT_PROFE_S 
			WHERE COD_CATAL_PS_AEFCPS = V_COD_CATAL_PS 
				AND FE_FECHA_FIN_AEFCOS IS NULL;
			------------------------------------------------------
			IF(V_NU_ESTA_AEFCOS <> V_NU_ESTADO_PS) THEN
				BEGIN 
					UPDATE AUDITAR_ESTA_FECHA_CAT_PROFE_S
					SET FE_FECHA_FIN_AEFCOS = SYSDATE
					WHERE COD_NUM_ESTA_AEFCPS = V_COD_NUM_ESTA_AEFCPS;
					------------------------------------------------------
					INSERT INTO AUDITAR_ESTA_FECHA_CAT_PROFE_S(
						COD_CATAL_PS_AEFCPS, NU_ESTA_AEFCOS,
			            FE_FECHA_INI_AEFCOS, FE_FECHA_FIN_AEFCOS)
					VALUES(
						V_COD_CATAL_PS, V_NU_ESTADO_PS,
						SYSDATE, NULL);
				END;
			END IF;
		END;
	END IF;
END;