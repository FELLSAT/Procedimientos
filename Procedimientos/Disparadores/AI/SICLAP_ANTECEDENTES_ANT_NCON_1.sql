CREATE OR REPLACE TRIGGER SICLAP_ANTECEDENTES_ANT_NCON_1 BEFORE INSERT ON SICLAP_ANTECEDENTES
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT SICLAP_ANTECEDENTES_ant_nconse.NEXTVAL
    INTO   :NEW.ant_nconsecutivo
    FROM   dual;
END;