CREATE OR REPLACE TRIGGER HIMS.HIST_SCOP_NU_NUME_HS_TRG BEFORE INSERT ON HIMS.HIST_SCOP FOR EACH ROW
DECLARE

BEGIN
    SELECT HIST_SCOP_NU_NUME_HS_SEQ.NEXTVAL
    INTO :NEW.NU_NUME_HS
    FROM DUAL;
END;
/