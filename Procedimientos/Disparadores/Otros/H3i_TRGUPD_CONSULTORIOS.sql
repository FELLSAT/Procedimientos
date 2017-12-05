CREATE OR REPLACE TRIGGER H3i_TRGUPD_CONSULTORIOS 
AFTER UPDATE      
ON CONSULTORIOS        
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
    WHERE COLS.TABLE_NAME = 'CONSULTORIOS'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
    ------------------------------------------------------
    IF(V_PrimaryKeyField IS NOT NULL) THEN
        SELECT :NEW.CD_CODI_CONS
        INTO V_PrimaryKeyValue
        FROM DUAL;
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU 
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA    
    WHERE DE_NOMTABLA_PAAU = 'CONSULTORIOS'
      AND ROWNUM<=1;
    ------------------------------------------------------
    IF(V_NU_ESTA_PAAU > 0) THEN
        BEGIN
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            IF (:OLD.CD_CODI_CONS <> :NEW.CD_CODI_CONS) THEN
                DECLARE
                    V_OLDCD_CODI_CONS VARCHAR2(100);
                    V_NEWCD_CODI_CONS VARCHAR2(100); 
                BEGIN 
                    SELECT :OLD.CD_CODI_CONS 
                    INTO V_OLDCD_CODI_CONS
                    FROM DUAL;
                    
                    SELECT :NEW.CD_CODI_CONS 
                    INTO V_NEWCD_CODI_CONS
                    FROM DUAL;
                    
                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION )
                    VALUES('U','CONSULTORIOS',
                        'CD_CODI_CONS', V_PrimaryKeyValue , 
                        'CD_CODI_CONS', V_OLDCD_CODI_CONS, 
                        V_NEWCD_CODI_CONS, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END;
            END IF;
            ------------------------------------------------------
             IF (:OLD.CD_CODI_LUAT_CONS <> :NEW.CD_CODI_LUAT_CONS) THEN
                DECLARE
                    V_OLDCD_CODI_LUAT_CONS VARCHAR2(100); 
                    V_NEWCD_CODI_LUAT_CONS VARCHAR2(100); 
                BEGIN 
                    SELECT :OLD.CD_CODI_LUAT_CONS 
                    INTO V_OLDCD_CODI_LUAT_CONS
                    FROM DUAL;
                    
                    SELECT :NEW.CD_CODI_LUAT_CONS 
                    INTO V_NEWCD_CODI_LUAT_CONS
                    FROM DUAL;
                     
                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION )
                    VALUES('U','CONSULTORIOS',
                        'CD_CODI_CONS', V_PrimaryKeyValue , 
                        'CD_CODI_LUAT_CONS', V_OLDCD_CODI_LUAT_CONS, 
                        V_NEWCD_CODI_LUAT_CONS, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.DE_DESC_CONS <> :NEW.DE_DESC_CONS) THEN
                DECLARE
                    V_OLDDE_DESC_CONS VARCHAR2(100);
                    V_NEWDE_DESC_CONS VARCHAR2(100); 
                BEGIN       
                    SELECT :OLD.DE_DESC_CONS 
                    INTO V_OLDDE_DESC_CONS
                    FROM DUAL;

                    SELECT :NEW.DE_DESC_CONS
                    INTO V_NEWDE_DESC_CONS
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION ) 
                    VALUES ('U','CONSULTORIOS',
                        'CD_CODI_CONS', V_PrimaryKeyValue , 
                        'DE_DESC_CONS', V_OLDDE_DESC_CONS, 
                        V_NEWDE_DESC_CONS, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.DE_UBIC_CONS <> :NEW.DE_UBIC_CONS) THEN
                DECLARE
                    V_OLDDE_UBIC_CONS VARCHAR2(100);
                    V_NEWDE_UBIC_CONS VARCHAR2(100); 
                BEGIN 
                    SELECT :OLD.DE_UBIC_CONS
                    INTO V_OLDDE_UBIC_CONS
                    FROM DUAL;

                    SELECT :NEW.DE_UBIC_CONS 
                    INTO V_NEWDE_UBIC_CONS
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION )
                    VALUES('U','CONSULTORIOS',
                        'CD_CODI_CONS', V_PrimaryKeyValue , 
                        'DE_UBIC_CONS', V_OLDDE_UBIC_CONS, 
                        V_NEWDE_UBIC_CONS, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_TIPO_ATENCION <> :NEW.NU_TIPO_ATENCION) THEN
                DECLARE
                    V_OLDNU_TIPO_ATENCION VARCHAR2(100);
                    V_NEWNU_TIPO_ATENCION VARCHAR2(100);
                BEGIN 
                    
                    SELECT :OLD.NU_TIPO_ATENCION 
                    INTO V_OLDNU_TIPO_ATENCION
                    FROM DUAL;
                    
                    SELECT :NEW.NU_TIPO_ATENCION
                    INTO V_NEWNU_TIPO_ATENCION
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                        PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                        FIELDNAME,OLDVALUE, 
                        NEWVALUE,UPDATEDATE,
                        USERNAME,IDSESIONSERVER,
                        NOCONEXION ) 
                    VALUES ('U','CONSULTORIOS',
                        'CD_CODI_CONS', V_PrimaryKeyValue , 
                        'NU_TIPO_ATENCION', V_OLDNU_TIPO_ATENCION, 
                        V_NEWNU_TIPO_ATENCION, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
        END;
    END IF;
END;