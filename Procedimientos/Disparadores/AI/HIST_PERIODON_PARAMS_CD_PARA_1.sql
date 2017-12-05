CREATE OR REPLACE TRIGGER HIST_PERIODON_PARAMS_CD_PARA_1 BEFORE INSERT ON HIST_PERIODON_PARAMS
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT HIST_PERIODON_PARAMS_CD_PARAM_.NEXTVAL
    INTO   :NEW.CD_PARAM_PERIOD
    FROM   dual;
END;