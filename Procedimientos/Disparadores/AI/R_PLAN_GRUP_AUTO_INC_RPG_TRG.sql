CREATE OR REPLACE TRIGGER R_PLAN_GRUP_AUTO_INC_RPG_TRG BEFORE INSERT ON R_PLAN_GRUP
FOR EACH ROW
DECLARE 
    
BEGIN
    SELECT R_PLAN_GRUP_AUTO_INC_RPG_SEQ.NEXTVAL
    INTO   :NEW.AUTO_INC_RPG
    FROM   dual;
END;