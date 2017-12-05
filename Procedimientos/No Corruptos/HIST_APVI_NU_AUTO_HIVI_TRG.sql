CREATE OR REPLACE TRIGGER HIMS.HIST_APVI_NU_AUTO_HIVI_TRG BEFORE INSERT ON HIMS.HIST_APVI FOR EACH ROW
DECLARE

BEGIN
    SELECT HIST_APVI_NU_AUTO_HIVI_SEQ.NEXTVAL
    INTO :NEW.NU_AUTO_HIVI
    FROM DUAL;
END;
/