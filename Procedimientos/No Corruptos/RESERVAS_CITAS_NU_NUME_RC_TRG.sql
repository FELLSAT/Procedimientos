CREATE OR REPLACE TRIGGER HIMS.RESERVAS_CITAS_NU_NUME_RC_TRG BEFORE INSERT ON HIMS.RESERVAS_CITAS FOR EACH ROW
DECLARE

BEGIN
    SELECT RESERVAS_CITAS_NU_NUME_RC_SEQ.NEXTVAL
    INTO :NEW.NU_NUME_RC
    FROM DUAL;
END;