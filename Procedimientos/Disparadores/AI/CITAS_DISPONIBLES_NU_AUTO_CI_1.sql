CREATE OR REPLACE TRIGGER CITAS_DISPONIBLES_NU_AUTO_CI_1 BEFORE INSERT ON CITAS_DISPONIBLES
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT CITAS_DISPONIBLES_NU_AUTO_CIDI.NEXTVAL
    INTO   :NEW.NU_AUTO_CIDI
    FROM   dual;
END;