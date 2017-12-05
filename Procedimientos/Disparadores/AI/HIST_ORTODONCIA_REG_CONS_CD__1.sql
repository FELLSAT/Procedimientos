CREATE OR REPLACE TRIGGER HIST_ORTODONCIA_REG_CONS_CD__1 BEFORE INSERT ON HIST_ORTODONCIA_REG_CONS
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT HIST_ORTODONCIA_REG_CONS_CD_RE.NEXTVAL
    INTO   :NEW.CD_REGISTRO_CONS
    FROM   dual;
END;