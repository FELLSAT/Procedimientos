CREATE OR REPLACE TRIGGER NOPOS_MEDI_NU_AUTO_NOPM_TRG BEFORE INSERT ON NOPOS_MEDI
FOR EACH ROW
DECLARE 
     
BEGIN
    SELECT NOPOS_MEDI_NU_AUTO_NOPM_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_NOPM
    FROM   dual;
END;