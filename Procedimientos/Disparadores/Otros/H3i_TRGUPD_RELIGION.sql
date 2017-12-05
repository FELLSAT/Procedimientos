CREATE OR REPLACE TRIGGER H3i_TRGUPD_RELIGION 
AFTER UPDATE      
ON RELIGION
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================  
DECLARE
    V_PrimaryKeyField VARCHAR2(1000);     
    V_PrimaryKeyValue VARCHAR2(1000);
    V_NU_ESTA_PAAU PARAMETRIZACION_AUDITORIA.NU_ESTA_PAAU%TYPE;
    V_USER_NAME VARCHAR2(30);
    V_USER_ID NUMBER;     
BEGIN  
    ------------------------------------------------------
    SELECT COLS.COLUMN_NAME
    INTO V_PrimaryKeyField
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = 'RELIGION'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;    
    ------------------------------------------------------
    IF (V_PrimaryKeyField IS NOT NULL) THEN
        BEGIN      
            SELECT :NEW.CD_CODI_RELI 
            INTO V_PrimaryKeyValue
            FROM DUAL;
        END; 
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU 
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA    
    WHERE DE_NOMTABLA_PAAU = 'RELIGION'
        AND ROWNUM<=1;
    ------------------------------------------------------
    IF (V_NU_ESTA_PAAU > 0) THEN
        BEGIN 
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            IF (:OLD.CD_CODI_RELI <> :NEW.CD_CODI_RELI) THEN
                DECLARE
                    V_OLDCD_CODI_RELI VARCHAR2(100);
                    V_NEWCD_CODI_RELI VARCHAR2(100);
                BEGIN                     
                    SELECT :OLD.CD_CODI_RELI 
                    INTO V_OLDCD_CODI_RELI
                    FROM DUAL;
                    
                    SELECT :NEW.CD_CODI_RELI 
                    INTO V_NEWCD_CODI_RELI
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION )
                    VALUES ('U','RELIGION',
                        'CD_CODI_RELI', V_PrimaryKeyValue, 
                        'CD_CODI_RELI', V_OLDCD_CODI_RELI, 
                        V_NEWCD_CODI_RELI, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.DE_DESC_RELI <> :NEW.DE_DESC_RELI) THEN
                DECLARE
                    V_OLDDE_DESC_RELI VARCHAR2(100);
                    V_NEWDE_DESC_RELI VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.DE_DESC_RELI 
                    INTO V_OLDDE_DESC_RELI
                    FROM DUAL;
                    
                    SELECT :NEW.DE_DESC_RELI 
                    INTO V_NEWDE_DESC_RELI
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION )
                    VALUES('U','RELIGION',
                        'CD_CODI_RELI', V_PrimaryKeyValue , 
                        'DE_DESC_RELI', V_OLDDE_DESC_RELI, 
                        V_NEWDE_DESC_RELI, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
        END; 
    END IF;
END;