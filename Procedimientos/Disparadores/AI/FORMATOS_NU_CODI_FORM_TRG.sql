CREATE OR REPLACE TRIGGER FORMATOS_NU_CODI_FORM_TRG BEFORE INSERT ON FORMATOS
FOR EACH ROW
DECLARE 
   
BEGIN
  SELECT FORMATOS_NU_CODI_FORM_SEQ.NEXTVAL
    INTO   :NEW.NU_CODI_FORM
    FROM   dual;
END;