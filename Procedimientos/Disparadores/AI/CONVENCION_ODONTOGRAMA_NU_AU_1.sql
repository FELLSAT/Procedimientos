CREATE OR REPLACE TRIGGER CONVENCION_ODONTOGRAMA_NU_AU_1 BEFORE INSERT ON CONVENCION_ODONTOGRAMA
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT CONVENCION_ODONTOGRAMA_NU_AUTO.NEXTVAL
    INTO   :NEW.NU_AUTO_COOD
    FROM   dual;
END;