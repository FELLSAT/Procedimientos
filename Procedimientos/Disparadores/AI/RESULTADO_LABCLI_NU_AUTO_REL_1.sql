CREATE OR REPLACE TRIGGER RESULTADO_LABCLI_NU_AUTO_REL_1 BEFORE INSERT ON RESULTADO_LABCLI
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT RESULTADO_LABCLI_NU_AUTO_RELA_.NEXTVAL
    INTO   :NEW.NU_AUTO_RELA
    FROM   dual;
END;