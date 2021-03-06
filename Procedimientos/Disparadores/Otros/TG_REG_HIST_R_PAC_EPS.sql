CREATE OR REPLACE TRIGGER TG_REG_HIST_R_PAC_EPS
AFTER INSERT OR UPDATE
ON R_PAC_EPS
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
DECLARE
	V_NU_HIST_PAC_RPE VARCHAR2(20);
	V_CD_NIT_EPS_RPE VARCHAR(11);
	V_CD_CODI_REG_RPE VARCHAR(2); 
	V_NU_AFIL_RPE NUMBER;
	V_CD_CODI_ESAF_RPE VARCHAR(4);
	V_CD_CODI_ESAF_RPE_ACTUAL VARCHAR(4);
BEGIN

	V_NU_HIST_PAC_RPE := :NEW.NU_HIST_PAC_RPE;
	V_CD_NIT_EPS_RPE := :NEW.CD_NIT_EPS_RPE;
	V_CD_CODI_REG_RPE := :NEW.CD_CODI_REG_RPE;
	V_NU_AFIL_RPE := :NEW.NU_AFIL_RPE;
	V_CD_CODI_ESAF_RPE := :NEW.CD_CODI_ESAF_RPE;

	SELECT CD_CODI_ESAF_RPE 
	INTO V_CD_CODI_ESAF_RPE_ACTUAL
	FROM R_PAC_EPS 
	WHERE NU_HIST_PAC_RPE = V_NU_HIST_PAC_RPE 
		AND CD_NIT_EPS_RPE = V_CD_NIT_EPS_RPE 
		AND	CD_CODI_REG_RPE = V_CD_CODI_REG_RPE 
		AND NU_AFIL_RPE = V_NU_AFIL_RPE;

	--RAISERROR('actual %s insertar %s.', 16, 1,@CD_CODI_ESAF_RPE_ACTUAL,@CD_CODI_ESAF_RPE)
	--rollback tran

	IF (NVL(V_CD_CODI_ESAF_RPE_ACTUAL, '') <> V_CD_CODI_ESAF_RPE) THEN
		BEGIN
			INSERT INTO R_PAC_EPS_HIST (FE_FECH_REG_RPEH,
				CD_CODI_REG_RPEH, CD_NIT_EPS_RPEH,
				CD_CODI_ESAF_RPEH, NU_HIST_PAC_RPEH)
		    VALUES (SYSDATE, :NEW.CD_CODI_REG_RPE,
				:NEW.CD_NIT_EPS_RPE, :NEW.CD_CODI_ESAF_RPE,
				:NEW.NU_HIST_PAC_RPE);			
		END;
	END IF;
END;