CREATE OR REPLACE TRIGGER AUDI_REPO_GENE_NU_ID_GEN_REP_T BEFORE INSERT ON AUDI_REPO_GENE
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT AUDI_REPO_GENE_NU_ID_GEN_REP_S.NEXTVAL
    INTO   :NEW.NU_ID_GEN_REP
    FROM   dual;
END;