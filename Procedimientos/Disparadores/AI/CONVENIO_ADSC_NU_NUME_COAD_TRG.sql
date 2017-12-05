CREATE OR REPLACE TRIGGER CONVENIO_ADSC_NU_NUME_COAD_TRG BEFORE INSERT ON CONVENIO_ADSC
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT CONVENIO_ADSC_NU_NUME_COAD_SEQ.NEXTVAL
    INTO   :NEW.NU_NUME_COAD
    FROM   dual;
END;