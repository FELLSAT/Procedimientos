CREATE OR REPLACE TRIGGER ESTADO_ASEGURAMIENTO_ID_ESTA_1 BEFORE INSERT ON ESTADO_ASEGURAMIENTO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT ESTADO_ASEGURAMIENTO_ID_ESTA_A.NEXTVAL
    INTO   :NEW.ID_ESTA_ASEGU
    FROM   dual;
END;