CREATE OR REPLACE TRIGGER RECIENNACIDO_NU_NUME_NACE_TRG BEFORE INSERT ON RECIENNACIDO
FOR EACH ROW
DECLARE 
  
BEGIN
    SELECT RECIENNACIDO_NU_NUME_NACE_SEQ.NEXTVAL
    INTO   :NEW.NU_NUME_NACE
    FROM   dual;
END;