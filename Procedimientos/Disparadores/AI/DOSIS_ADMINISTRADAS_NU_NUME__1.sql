CREATE OR REPLACE TRIGGER DOSIS_ADMINISTRADAS_NU_NUME__1 BEFORE INSERT ON DOSIS_ADMINISTRADAS
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT DOSIS_ADMINISTRADAS_NU_NUME_DA.NEXTVAL
    INTO   :NEW.NU_NUME_DADMI
    FROM   dual;
END;