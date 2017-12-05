CREATE OR REPLACE TRIGGER HIMS.HIST_TIIS_NU_AUTO_HITI_TRG BEFORE INSERT ON HIMS.HIST_TIIS FOR EACH ROW
DECLARE

BEGIN
    SELECT HIST_TIIS_NU_AUTO_HITI_SEQ.NEXTVAL
    INTO :NEW.NU_AUTO_HITI
    FROM DUAL;
END;
/