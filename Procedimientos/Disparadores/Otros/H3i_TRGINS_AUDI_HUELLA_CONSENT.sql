CREATE OR REPLACE TRIGGER H3i_TRGINS_AUDI_HUELLA_CONSENT 
AFTER INSERT    
ON AUDI_HUELLA_CONSENT  
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================      
DECLARE
    V_PrimaryKeyField VARCHAR2(1000);
    V_PrimaryKeyValue VARCHAR2(1000);
    V_FECHA_VAL_CONSENT_AHC VARCHAR2(100);
    V_ValueFECHA_VAL_CONSENT_AHC VARCHAR2(100);
    V_NU_AUTO_AHC VARCHAR2(100);
    V_ValueNU_AUTO_AHC VARCHAR2(100);
    V_NU_HIST_PAC_AHC VARCHAR2(100);
    V_ValueNU_HIST_PAC_AHC VARCHAR2(100);
    V_NU_NUME_FOCO_AHC VARCHAR2(100);
    V_ValueNU_NUME_FOCO_AHC VARCHAR2(100);
    V_NU_ESTA_PAAU PARAMETRIZACION_AUDITORIA.NU_ESTA_PAAU%TYPE;
    V_USER_NAME VARCHAR2(30);
    V_USER_ID NUMBER;
BEGIN
    ------------------------------------------------------
    SELECT COLS.COLUMN_NAME
    INTO V_PrimaryKeyField
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = 'AUDI_HUELLA_CONSENT'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
    ------------------------------------------------------
    IF (V_PrimaryKeyField IS NOT NULL) THEN 
        SELECT :NEW.NU_AUTO_AHC 
        INTO V_PrimaryKeyValue
        FROM DUAL;
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU 
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA    
    WHERE DE_NOMTABLA_PAAU = 'AUDI_HUELLA_CONSENT'
      AND ROWNUM<=1;
    ------------------------------------------------------
    IF (V_NU_ESTA_PAAU > 0) THEN
        BEGIN
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            SELECT :NEW.FECHA_VAL_CONSENT_AHC 
            INTO V_ValueFECHA_VAL_CONSENT_AHC
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('I','AUDI_HUELLA_CONSENT',
                'NU_AUTO_AHC', V_PrimaryKeyValue , 
                'FECHA_VAL_CONSENT_AHC', '  ' , 
                V_ValueFECHA_VAL_CONSENT_AHC, SYSDATE,
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :NEW.NU_AUTO_AHC 
            INTO V_ValueNU_AUTO_AHC
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('I','AUDI_HUELLA_CONSENT',
                'NU_AUTO_AHC', V_PrimaryKeyValue , 
                'NU_AUTO_AHC', '  ' , 
                V_ValueNU_AUTO_AHC, SYSDATE, 
                V_USER_NAME, V_USER_ID,  
                0);
            ------------------------------------------------------
            SELECT :NEW.NU_HIST_PAC_AHC
            INTO V_ValueNU_HIST_PAC_AHC
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION )
            VALUES('I','AUDI_HUELLA_CONSENT',
                'NU_AUTO_AHC', V_PrimaryKeyValue , 
                'NU_HIST_PAC_AHC', '  ' , 
                V_ValueNU_HIST_PAC_AHC, SYSDATE, 
                V_USER_NAME, V_USER_ID, 
                0);
            ------------------------------------------------------
            SELECT :NEW.NU_NUME_FOCO_AHC
            INTO V_ValueNU_NUME_FOCO_AHC
            FROM DUAL;

            INSERT INTO Audit3i(TYPE, TABLENAME,
                PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                FIELDNAME,OLDVALUE, 
                NEWVALUE,UPDATEDATE,
                USERNAME,IDSESIONSERVER,
                NOCONEXION ) 
            VALUES('I','AUDI_HUELLA_CONSENT',
                'NU_AUTO_AHC', V_PrimaryKeyValue , 
                'NU_NUME_FOCO_AHC', '  ' , 
                V_ValueNU_NUME_FOCO_AHC, SYSDATE, 
                V_USER_NAME, V_USER_ID,
                0);
        END;
    END IF;
END;