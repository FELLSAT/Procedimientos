CREATE OR REPLACE TRIGGER CULPABLE_GLOSA_NU_NUME_CUGL_TR BEFORE INSERT ON CULPABLE_GLOSA
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT CULPABLE_GLOSA_NU_NUME_CUGL_SE.NEXTVAL
    INTO   :NEW.NU_NUME_CUGL
    FROM   dual;
END;