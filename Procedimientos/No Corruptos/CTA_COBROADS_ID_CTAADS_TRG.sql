CREATE OR REPLACE TRIGGER HIMS.CTA_COBROADS_ID_CTAADS_TRG BEFORE INSERT ON HIMS.CTA_COBROADS FOR EACH ROW
DECLARE

BEGIN
    SELECT CTA_COBROADS_ID_CTAADS_SEQ.NEXTVAL
    INTO :NEW.ID_CTAADS
    FROM DUAL;
END;
/