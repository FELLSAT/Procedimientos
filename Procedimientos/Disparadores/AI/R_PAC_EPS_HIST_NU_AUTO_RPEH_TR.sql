CREATE OR REPLACE TRIGGER R_PAC_EPS_HIST_NU_AUTO_RPEH_TR BEFORE INSERT ON R_PAC_EPS_HIST
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT R_PAC_EPS_HIST_NU_AUTO_RPEH_SE.NEXTVAL
    INTO   :NEW.NU_AUTO_RPEH
    FROM   dual;
END;