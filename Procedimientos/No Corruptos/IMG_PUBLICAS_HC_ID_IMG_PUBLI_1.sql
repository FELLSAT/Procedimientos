CREATE OR REPLACE TRIGGER HIMS.IMG_PUBLICAS_HC_ID_IMG_PUBLI_1 BEFORE INSERT ON HIMS.IMG_PUBLICAS_HC FOR EACH ROW
DECLARE

BEGIN
    SELECT IMG_PUBLICAS_HC_ID_IMG_PUBLICA.NEXTVAL
    INTO :NEW.ID_IMG_PUBLICAS_HC
    FROM DUAL;
END;