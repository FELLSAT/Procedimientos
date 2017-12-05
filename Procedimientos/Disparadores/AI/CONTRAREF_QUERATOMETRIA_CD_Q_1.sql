CREATE OR REPLACE TRIGGER CONTRAREF_QUERATOMETRIA_CD_Q_1 BEFORE INSERT ON CONTRAREF_QUERATOMETRIA
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT CONTRAREF_QUERATOMETRIA_CD_QUE.NEXTVAL
    INTO   :NEW.CD_QUERATOMETRIA
    FROM   dual;
END;