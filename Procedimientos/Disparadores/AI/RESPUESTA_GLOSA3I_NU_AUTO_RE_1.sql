CREATE OR REPLACE TRIGGER RESPUESTA_GLOSA3I_NU_AUTO_RE_1 BEFORE INSERT ON RESPUESTA_GLOSA3i
FOR EACH ROW
DECLARE 
    
BEGIN
  SELECT RESPUESTA_GLOSA3i_NU_AUTO_REGL.NEXTVAL
    INTO   :NEW.NU_AUTO_REGL
    FROM   dual;
END;