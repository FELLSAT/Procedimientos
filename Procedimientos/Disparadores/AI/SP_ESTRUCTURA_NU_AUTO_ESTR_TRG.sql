CREATE OR REPLACE TRIGGER SP_ESTRUCTURA_NU_AUTO_ESTR_TRG BEFORE INSERT ON SP_ESTRUCTURA
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT SP_ESTRUCTURA_NU_AUTO_ESTR_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_ESTR
    FROM   dual;
END;