CREATE OR REPLACE TRIGGER AUDITAR_TIPO_DOCU_ITEM_CD_CO_1 BEFORE INSERT ON AUDITAR_TIPO_DOCU_ITEM
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT AUDITAR_TIPO_DOCU_ITEM_CD_CODI.NEXTVAL
    INTO   :NEW.CD_CODI_ATDI
    FROM   dual;
END;