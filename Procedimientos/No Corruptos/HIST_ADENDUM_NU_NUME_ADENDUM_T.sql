CREATE OR REPLACE TRIGGER HIMS.HIST_ADENDUM_NU_NUME_ADENDUM_T BEFORE INSERT ON HIMS.HIST_ADENDUM FOR EACH ROW
DECLARE

BEGIN
    SELECT HIST_ADENDUM_NU_NUME_ADENDUM_S.NEXTVAL
    INTO :NEW.NU_NUME_ADENDUM
    FROM DUAL;
END;
/