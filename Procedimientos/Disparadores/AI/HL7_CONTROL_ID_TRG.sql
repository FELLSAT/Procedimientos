CREATE OR REPLACE TRIGGER HL7_CONTROL_ID_TRG BEFORE INSERT ON HL7_CONTROL
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT HL7_CONTROL_ID_SEQ.NEXTVAL
    INTO   :NEW.ID
    FROM   dual;
END;