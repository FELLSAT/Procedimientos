CREATE OR REPLACE TRIGGER ORDENSALIDA_NU_AUTO_ORSA_TRG BEFORE INSERT ON ORDENSALIDA
FOR EACH ROW
DECLARE 
  
BEGIN
    SELECT ORDENSALIDA_NU_AUTO_ORSA_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_ORSA
    FROM   dual;
END;