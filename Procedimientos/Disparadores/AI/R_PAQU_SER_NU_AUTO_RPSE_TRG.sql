CREATE OR REPLACE TRIGGER R_PAQU_SER_NU_AUTO_RPSE_TRG BEFORE INSERT ON R_PAQU_SER
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT R_PAQU_SER_NU_AUTO_RPSE_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_RPSE
    FROM   dual;
END;