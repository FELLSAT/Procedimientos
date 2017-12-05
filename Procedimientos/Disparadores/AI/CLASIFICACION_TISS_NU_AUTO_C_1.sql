CREATE OR REPLACE TRIGGER CLASIFICACION_TISS_NU_AUTO_C_1 BEFORE INSERT ON CLASIFICACION_TISS
FOR EACH ROW
DECLARE 
  
BEGIN
    SELECT CLASIFICACION_TISS_NU_AUTO_CLT.NEXTVAL
    INTO   :NEW.NU_AUTO_CLTI
    FROM   dual;
END;