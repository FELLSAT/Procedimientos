CREATE OR REPLACE TRIGGER ORDENINGRESO_ID_ORIN_TRG BEFORE INSERT ON ORDENINGRESO
FOR EACH ROW
DECLARE 
    
BEGIN
  SELECT ORDENINGRESO_ID_ORIN_SEQ.NEXTVAL
    INTO   :NEW.ID_ORIN
    FROM   dual;
END;