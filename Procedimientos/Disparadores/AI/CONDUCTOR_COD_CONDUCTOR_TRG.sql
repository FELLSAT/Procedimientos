CREATE OR REPLACE TRIGGER CONDUCTOR_COD_CONDUCTOR_TRG BEFORE INSERT ON CONDUCTOR
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT CONDUCTOR_COD_CONDUCTOR_SEQ.NEXTVAL
    INTO   :NEW.COD_CONDUCTOR
    FROM   dual;
END;