CREATE OR REPLACE TRIGGER ITEM_GLOSA_NU_NUME_ITGL_TRG BEFORE INSERT ON ITEM_GLOSA
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT ITEM_GLOSA_NU_NUME_ITGL_SEQ.NEXTVAL
    INTO   :NEW.NU_NUME_ITGL
    FROM   dual;
END;