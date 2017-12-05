CREATE OR REPLACE TRIGGER SP_CAMPO_NU_AUTO_CAMP_TRG BEFORE INSERT ON SP_CAMPO
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT SP_CAMPO_NU_AUTO_CAMP_SEQ.NEXTVAL
    INTO   :NEW.NU_AUTO_CAMP
    FROM   dual;
END;