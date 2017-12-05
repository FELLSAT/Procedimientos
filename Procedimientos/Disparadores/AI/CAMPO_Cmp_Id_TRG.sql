CREATE OR REPLACE TRIGGER CAMPO_Cmp_Id_TRG BEFORE INSERT ON CAMPO
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT CAMPO_Cmp_Id_SEQ.NEXTVAL
    INTO   :NEW.Cmp_Id
    FROM   dual;
END;