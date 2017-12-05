CREATE OR REPLACE TRIGGER HIST_FOOP_NU_AUTO_HIFO_TRG BEFORE INSERT ON HIST_FOOP
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT HIST_FOOP_NU_AUTO_HIFO_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_HIFO
    FROM   dual;
END;