CREATE OR REPLACE TRIGGER H3i_TRGUPD_TURNOS_MEDICOS         
AFTER UPDATE 
ON TURNOS_MEDICOS
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
    WHERE COLS.TABLE_NAME = 'TURNOS_MEDICOS'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
    ------------------------------------------------------    
    IF (V_PrimaryKeyField IS NOT NULL) THEN      
        BEGIN      
            SELECT :NEW.NU_NUME_TUME
            INTO V_PrimaryKeyValue
            FROM DUAL;
        END;
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA
    WHERE DE_NOMTABLA_PAAU = 'TURNOS_MEDICOS'
        AND ROWNUM <= 1;
    ------------------------------------------------------
    IF (V_NU_ESTA_PAAU > 0) THEN
        BEGIN
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            IF (:OLD.CD_CODI_CONS_TUME <> :NEW.CD_CODI_CONS_TUME) THEN
                DECLARE
                    V_OLDCD_CODI_CONS_TUME VARCHAR2(100);
                    V_NEWCD_CODI_CONS_TUME VARCHAR2(100); 
                BEGIN                     
                    SELECT :OLD.CD_CODI_CONS_TUME 
                    INTO V_OLDCD_CODI_CONS_TUME
                    FROM DUAL;
                    
                    SELECT :NEW.CD_CODI_CONS_TUME 
                    INTO V_NEWCD_CODI_CONS_TUME
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION ) 
                    VALUES ('U','TURNOS_MEDICOS',
                        'NU_NUME_TUME', V_PrimaryKeyValue , 
                        'CD_CODI_CONS_TUME', V_OLDCD_CODI_CONS_TUME, 
                        V_NEWCD_CODI_CONS_TUME, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.CD_MED_TUME <> :NEW.CD_MED_TUME) THEN
                DECLARE
                    V_OLDCD_MED_TUME VARCHAR2(100);
                    V_NEWCD_MED_TUME VARCHAR2(100);
                BEGIN                     
                    SELECT :OLD.CD_MED_TUME 
                    INTO V_OLDCD_MED_TUME
                    FROM DUAL;
                    
                    SELECT :NEW.CD_MED_TUME 
                    INTO V_NEWCD_MED_TUME
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION ) 
                    VALUES ('U','TURNOS_MEDICOS',
                        'NU_NUME_TUME', V_PrimaryKeyValue , 
                        'CD_MED_TUME', V_OLDCD_MED_TUME, 
                        V_NEWCD_MED_TUME, SYSDATE, 
                        V_USER_NAME, V_USER_ID,  
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.FE_FECH_TUME <> :NEW.FE_FECH_TUME) THEN
                DECLARE
                    V_OLDFE_FECH_TUME VARCHAR2(100);
                    V_NEWFE_FECH_TUME VARCHAR2(100);
                BEGIN                     
                    SELECT :OLD.FE_FECH_TUME
                    INTO V_OLDFE_FECH_TUME
                    FROM DUAL;
                    
                    SELECT :NEW.FE_FECH_TUME 
                    INTO V_NEWFE_FECH_TUME
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION ) 
                    VALUES ('U','TURNOS_MEDICOS',
                        'NU_NUME_TUME', V_PrimaryKeyValue , 
                        'FE_FECH_TUME', V_OLDFE_FECH_TUME, 
                        V_NEWFE_FECH_TUME, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.FE_HOFI_TUME <> :NEW.FE_HOFI_TUME) THEN
                DECLARE
                    V_OLDFE_HOFI_TUME VARCHAR2(100); 
                    V_NEWFE_HOFI_TUME VARCHAR2(100);
                BEGIN                
                    SELECT :OLD.FE_HOFI_TUME 
                    INTO V_OLDFE_HOFI_TUME
                    FROM DUAL;
                    
                    SELECT :NEW.FE_HOFI_TUME 
                    INTO V_NEWFE_HOFI_TUME
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION ) 
                    VALUES('U','TURNOS_MEDICOS',
                        'NU_NUME_TUME', V_PrimaryKeyValue , 
                        'FE_HOFI_TUME', V_OLDFE_HOFI_TUME, 
                        V_NEWFE_HOFI_TUME, SYSDATE, 
                        V_USER_NAME, V_USER_ID,  
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.FE_HOIN_TUME <> :NEW.FE_HOIN_TUME) THEN
                DECLARE
                    V_OLDFE_HOIN_TUME VARCHAR2(100);
                    V_NEWFE_HOIN_TUME VARCHAR2(100);
                BEGIN                     
                    SELECT :OLD.FE_HOIN_TUME 
                    INTO V_OLDFE_HOIN_TUME
                    FROM DUAL;

                    SELECT :NEW.FE_HOIN_TUME
                    INTO V_NEWFE_HOIN_TUME
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION )
                    VALUES('U','TURNOS_MEDICOS',
                        'NU_NUME_TUME', V_PrimaryKeyValue , 
                        'FE_HOIN_TUME', V_OLDFE_HOIN_TUME, 
                        V_NEWFE_HOIN_TUME, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_NUME_TUME <> :NEW.NU_NUME_TUME) THEN
                DECLARE
                    V_OLDNU_NUME_TUME VARCHAR2(100);
                    V_NEWNU_NUME_TUME VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_NUME_TUME 
                    INTO V_OLDNU_NUME_TUME
                    FROM DUAL;
                    
                    SELECT :NEW.NU_NUME_TUME 
                    INTO V_NEWNU_NUME_TUME
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION )
                    VALUES ('U','TURNOS_MEDICOS',
                        'NU_NUME_TUME', V_PrimaryKeyValue , 
                        'NU_NUME_TUME', V_OLDNU_NUME_TUME, 
                        V_NEWNU_NUME_TUME, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);

                END; 
            END IF;
        END;
    END IF;
END;