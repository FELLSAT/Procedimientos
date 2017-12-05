CREATE OR REPLACE TRIGGER FORMULAS_NU_NUME_FORM_TRG BEFORE INSERT ON FORMULAS
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT FORMULAS_NU_NUME_FORM_SEQ.NEXTVAL
    INTO   :NEW.NU_NUME_FORM
    FROM   dual;
END;