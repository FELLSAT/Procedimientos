CREATE OR REPLACE TRIGGER AUDITAR_RESPUESTA_DOCU_OBJET_1 BEFORE INSERT ON AUDITAR_RESPUESTA_DOCU_OBJET
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT AUDITAR_RESPUESTA_DOCU_OBJET_A.NEXTVAL
    INTO   :NEW.AUTO_RESP_DOC_OBJ
    FROM   dual;
END;