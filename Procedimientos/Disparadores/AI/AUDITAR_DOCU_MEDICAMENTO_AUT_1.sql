CREATE OR REPLACE TRIGGER AUDITAR_DOCU_MEDICAMENTO_AUT_1 BEFORE INSERT ON AUDITAR_DOCU_MEDICAMENTO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT AUDITAR_DOCU_MEDICAMENTO_AUTO_.NEXTVAL
    INTO   :NEW.AUTO_DOCU_MEDI_ADM
    FROM   dual;
END;