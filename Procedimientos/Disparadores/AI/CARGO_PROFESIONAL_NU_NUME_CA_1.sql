CREATE OR REPLACE TRIGGER CARGO_PROFESIONAL_NU_NUME_CA_1 BEFORE INSERT ON CARGO_PROFESIONAL
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT CARGO_PROFESIONAL_NU_NUME_CAR_.NEXTVAL
    INTO   :NEW.NU_NUME_CAR
    FROM   dual;
END;