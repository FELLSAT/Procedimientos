
CREATE OR REPLACE TRIGGER H3i_TRGUPD_PACIENTES
AFTER UPDATE      
ON PACIENTES
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
DECLARE
    V_PrimaryKeyField VARCHAR2(1000);
    V_PrimaryKeyValue vARCHAR2(1000);
    V_NU_ESTA_PAAU PARAMETRIZACION_AUDITORIA.NU_ESTA_PAAU%TYPE;
    V_USER_NAME VARCHAR2(30);
    V_USER_ID NUMBER;
BEGIN  
    ------------------------------------------------------
    SELECT COLS.COLUMN_NAME
    INTO V_PrimaryKeyField
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = 'PACIENTES'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;    
    ------------------------------------------------------
    IF (V_PrimaryKeyField IS NOT NULL) THEN
        BEGIN      
            SELECT :NEW.NU_HIST_PAC 
            INTO V_PrimaryKeyValue
            FROM DUAL;
        END;
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA
    WHERE DE_NOMTABLA_PAAU = 'PACIENTES'
        AND ROWNUM <=1;
    ------------------------------------------------------
    IF (V_NU_ESTA_PAAU > 0) THEN
        BEGIN 
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            IF (:OLD.NU_SEXO_PAC <> :NEW.NU_SEXO_PAC) THEN
                DECLARE
                    V_OLDNU_SEXO_PAC vARCHAR2(100);
                    V_NEWNU_SEXO_PAC vARCHAR2(100); 
                BEGIN                     
                    SELECT :OLD.NU_SEXO_PAC 
                    INTO V_OLDNU_SEXO_PAC
                    FROM DUAL;
                    
                    SELECT :NEW.NU_SEXO_PAC 
                    INTO V_NEWNU_SEXO_PAC
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION ) 
                    VALUES ('U','PACIENTES',
                        'NU_HIST_PAC', V_PrimaryKeyValue , 
                        'NU_SEXO_PAC', V_OLDNU_SEXO_PAC, 
                        V_NEWNU_SEXO_PAC, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
        END;
    END IF;
END;