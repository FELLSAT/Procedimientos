CREATE OR REPLACE TRIGGER FORMULAS_COT_NU_NUME_FCOT_TRG BEFORE INSERT ON FORMULAS_COT
FOR EACH ROW
DECLARE 
   
BEGIN
    SELECT FORMULAS_COT_NU_NUME_FCOT_SEQ.NEXTVAL
    INTO   :NEW.NU_NUME_FCOT
    FROM   dual;
END;