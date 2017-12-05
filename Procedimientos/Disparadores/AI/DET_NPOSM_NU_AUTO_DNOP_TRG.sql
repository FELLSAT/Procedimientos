CREATE OR REPLACE TRIGGER DET_NPOSM_NU_AUTO_DNOP_TRG BEFORE INSERT ON DET_NPOSM
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT DET_NPOSM_NU_AUTO_DNOP_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_DNOP
    FROM   dual;
END;