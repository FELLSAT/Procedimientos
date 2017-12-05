CREATE OR REPLACE TRIGGER HIST_GENO_PERSONA_NU_NUME_PE_1 BEFORE INSERT ON HIST_GENO_PERSONA
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT HIST_GENO_PERSONA_NU_NUME_PER_.NEXTVAL
    INTO   :NEW.NU_NUME_PER
    FROM   dual;
END;