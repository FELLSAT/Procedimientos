CREATE OR REPLACE TRIGGER ESM_REPORTESAMA_CD_REPO_CODI_1 BEFORE INSERT ON ESM_REPORTESAMA
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT ESM_REPORTESAMA_CD_REPO_CODI_E.NEXTVAL
    INTO   :NEW.CD_REPO_CODI_ESM
    FROM   dual;
END;