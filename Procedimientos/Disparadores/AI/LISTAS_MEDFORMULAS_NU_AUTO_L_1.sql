CREATE OR REPLACE TRIGGER LISTAS_MEDFORMULAS_NU_AUTO_L_1 BEFORE INSERT ON LISTAS_MEDFORMULAS
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT LISTAS_MEDFORMULAS_NU_AUTO_LMF.NEXTVAL
    INTO   :NEW.NU_AUTO_LMFO
    FROM   dual;
END;