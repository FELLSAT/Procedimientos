CREATE OR REPLACE TRIGGER HIMS.R_HIT_ITT_NU_AUTO_RHI_TRG BEFORE INSERT ON HIMS.R_HIT_ITT FOR EACH ROW
DECLARE

BEGIN
	SELECT R_HIT_ITT_NU_AUTO_RHI_SEQ.NEXTVAL
	INTO :NEW.NU_AUTO_RHI
	FROM DUAL;
END;