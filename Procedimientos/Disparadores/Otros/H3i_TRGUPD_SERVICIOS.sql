CREATE OR REPLACE TRIGGER H3i_TRGUPD_SERVICIOS 
AFTER UPDATE      
ON SERVICIOS        
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
    WHERE COLS.TABLE_NAME = 'SERVICIOS'
    AND CONS.CONSTRAINT_TYPE = 'P'
    AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
    AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;
    ------------------------------------------------------
    IF (V_PrimaryKeyField IS NOT NULL) THEN      
        BEGIN      
            SELECT :NEW.CD_CODI_SER 
            INTO V_PrimaryKeyValue
            FROM DUAL;
        END; 
    END IF;
    ------------------------------------------------------
    SELECT NU_ESTA_PAAU
    INTO V_NU_ESTA_PAAU
    FROM PARAMETRIZACION_AUDITORIA
    WHERE DE_NOMTABLA_PAAU = 'SERVICIOS'
        AND ROWNUM <= 1;
    ------------------------------------------------------    
    IF (V_NU_ESTA_PAAU > 0) THEN        
        BEGIN 
            SELECT USERNAME,USER_ID
            INTO V_USER_NAME, V_USER_ID
            FROM USER_USERS;
            ------------------------------------------------------
            IF (:OLD.CD_CODI_COSE_SER <> :NEW.CD_CODI_COSE_SER) THEN
                DECLARE
                    V_OLDCD_CODI_COSE_SER VARCHAR2(100);
                    V_NEWCD_CODI_COSE_SER VARCHAR2(100);
                BEGIN                     
                    SELECT :OLD.CD_CODI_COSE_SER 
                    INTO V_OLDCD_CODI_COSE_SER
                    FROM DUAL; 
                    
                    SELECT :NEW.CD_CODI_COSE_SER 
                    INTO V_NEWCD_CODI_COSE_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES(
                        'U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'CD_CODI_COSE_SER', V_OLDCD_CODI_COSE_SER, 
                        V_NEWCD_CODI_COSE_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.CD_CODI_CUEN_SER <> :NEW.CD_CODI_CUEN_SER) THEN
                DECLARE
                    V_OLDCD_CODI_CUEN_SER VARCHAR2(100);
                    V_NEWCD_CODI_CUEN_SER VARCHAR2(100);
                BEGIN                   
                    SELECT :OLD.CD_CODI_CUEN_SER 
                    INTO V_OLDCD_CODI_CUEN_SER
                    FROM DUAL;

                    
                    SELECT :NEW.CD_CODI_CUEN_SER 
                    INTO V_NEWCD_CODI_CUEN_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'CD_CODI_CUEN_SER', V_OLDCD_CODI_CUEN_SER, 
                        V_NEWCD_CODI_CUEN_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.CD_CODI_SER <> :NEW.CD_CODI_SER) THEN
                DECLARE
                    V_OLDCD_CODI_SER VARCHAR2(100);
                    V_NEWCD_CODI_SER VARCHAR2(100);
                BEGIN                     
                    SELECT :OLD.CD_CODI_SER
                    INTO V_OLDCD_CODI_SER 
                    FROM DUAL;
                    
                    SELECT :NEW.CD_CODI_SER 
                    INTO V_NEWCD_CODI_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'CD_CODI_SER', V_OLDCD_CODI_SER, 
                        V_NEWCD_CODI_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.CD_CODI_TISE_SER <> :NEW.CD_CODI_TISE_SER) THEN
                DECLARE
                    V_OLDCD_CODI_TISE_SER VARCHAR2(100);
                    V_NEWCD_CODI_TISE_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.CD_CODI_TISE_SER 
                    INTO V_OLDCD_CODI_TISE_SER
                    FROM DUAL;
                    
                    SELECT :NEW.CD_CODI_TISE_SER 
                    INTO V_NEWCD_CODI_TISE_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'CD_CODI_TISE_SER', V_OLDCD_CODI_TISE_SER, 
                        V_NEWCD_CODI_TISE_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.DE_OBSE_SER <> :NEW.DE_OBSE_SER) THEN
                DECLARE
                    V_OLDDE_OBSE_SER VARCHAR2(100);
                    V_NEWDE_OBSE_SER VARCHAR2(100); 
                BEGIN 
                    SELECT :OLD.DE_OBSE_SER 
                    INTO V_OLDDE_OBSE_SER
                    FROM DUAL;
                    
                    SELECT :NEW.DE_OBSE_SER 
                    INTO V_NEWDE_OBSE_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'DE_OBSE_SER', V_OLDDE_OBSE_SER, 
                        V_NEWDE_OBSE_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END;
          END IF; 
            ------------------------------------------------------
            IF (:OLD.DX_PREDET <> :NEW.DX_PREDET) THEN
                DECLARE
                    V_OLDDX_PREDET VARCHAR2(100);
                    V_NEWDX_PREDET VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.DX_PREDET 
                    INTO V_OLDDX_PREDET
                    FROM DUAL;
                    
                    SELECT :NEW.DX_PREDET 
                    INTO V_NEWDX_PREDET
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'DX_PREDET', V_OLDDX_PREDET, 
                        V_NEWDX_PREDET, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.ES_SERV_WEB_SER <> :NEW.ES_SERV_WEB_SER) THEN
                DECLARE
                    V_OLDES_SERV_WEB_SER VARCHAR2(100);
                    V_NEWES_SERV_WEB_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.ES_SERV_WEB_SER 
                    INTO V_OLDES_SERV_WEB_SER
                    FROM DUAL;
                     
                    SELECT :NEW.ES_SERV_WEB_SER 
                    INTO V_NEWES_SERV_WEB_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'ES_SERV_WEB_SER', V_OLDES_SERV_WEB_SER, 
                        V_NEWES_SERV_WEB_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.ESTADO <> :NEW.ESTADO) THEN
                DECLARE
                    V_OLDESTADO VARCHAR2(100);
                    V_NEWESTADO VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.ESTADO 
                    INTO V_OLDESTADO
                    FROM DUAL;
                    
                    SELECT :NEW.ESTADO 
                    INTO V_NEWESTADO
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'ESTADO', V_OLDESTADO, 
                        V_NEWESTADO, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.FINALIDAD <> :NEW.FINALIDAD) THEN
                DECLARE
                    V_OLDFINALIDAD VARCHAR2(100);
                    V_NEWFINALIDAD VARCHAR2(100); 
                BEGIN 
                    SELECT :OLD.FINALIDAD 
                    INTO V_OLDFINALIDAD
                    FROM DUAL;
                    
                    SELECT :NEW.FINALIDAD 
                    INTO V_NEWFINALIDAD
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'FINALIDAD', V_OLDFINALIDAD, 
                        V_NEWFINALIDAD, SYSDATE,
                        V_USER_NAME, V_USER_ID,
                        0);
                END;
            END IF; 
            ------------------------------------------------------
            IF (:OLD.ID_CITA_SER <> :NEW.ID_CITA_SER) THEN
                DECLARE
                    V_OLDID_CITA_SER VARCHAR2(100);
                    V_NEWID_CITA_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.ID_CITA_SER 
                    INTO V_OLDID_CITA_SER
                    FROM DUAL;
                    
                    SELECT :NEW.ID_CITA_SER 
                    INTO V_NEWID_CITA_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'ID_CITA_SER', V_OLDID_CITA_SER, 
                        V_NEWID_CITA_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.ID_GCIT_SER <> :NEW.ID_GCIT_SER) THEN
                DECLARE
                    V_OLDID_GCIT_SER VARCHAR2(100);
                    V_NEWID_GCIT_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.ID_GCIT_SER 
                    INTO V_OLDID_GCIT_SER
                    FROM DUAL;
                    
                    SELECT :NEW.ID_GCIT_SER 
                    INTO V_NEWID_GCIT_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue, 
                        'ID_GCIT_SER', V_OLDID_GCIT_SER, 
                        V_NEWID_GCIT_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.IS_SERV_ODONT <> :NEW.IS_SERV_ODONT) THEN
                DECLARE
                    V_OLDIS_SERV_ODONT VARCHAR2(100);
                    V_NEWIS_SERV_ODONT VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.IS_SERV_ODONT 
                    INTO V_OLDIS_SERV_ODONT
                    FROM DUAL;
                    
                    SELECT :NEW.IS_SERV_ODONT 
                    INTO V_NEWIS_SERV_ODONT
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'IS_SERV_ODONT', V_OLDIS_SERV_ODONT, 
                        V_NEWIS_SERV_ODONT, SYSDATE,
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.MEDIDA_TIEMPO <> :NEW.MEDIDA_TIEMPO) THEN
                DECLARE
                    V_OLDMEDIDA_TIEMPO VARCHAR2(100);
                    V_NEWMEDIDA_TIEMPO VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.MEDIDA_TIEMPO 
                    INTO V_OLDMEDIDA_TIEMPO 
                    FROM DUAL;
                    
                    SELECT :NEW.MEDIDA_TIEMPO 
                    INTO V_NEWMEDIDA_TIEMPO
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'MEDIDA_TIEMPO', V_OLDMEDIDA_TIEMPO, 
                        V_NEWMEDIDA_TIEMPO, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NO_NOMB_SER <> :NEW.NO_NOMB_SER) THEN
                DECLARE
                    V_OLDNO_NOMB_SER VARCHAR2(100);
                    V_NEWNO_NOMB_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NO_NOMB_SER 
                    INTO V_OLDNO_NOMB_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NO_NOMB_SER 
                    INTO V_NEWNO_NOMB_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NO_NOMB_SER', V_OLDNO_NOMB_SER, 
                        V_NEWNO_NOMB_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_APLI_SER <> :NEW.NU_APLI_SER) THEN
                DECLARE
                    V_OLDNU_APLI_SER VARCHAR2(100); 
                    V_NEWNU_APLI_SER VARCHAR2(100); 
                BEGIN 
                    SELECT :OLD.NU_APLI_SER 
                    INTO V_OLDNU_APLI_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_APLI_SER 
                    INTO V_NEWNU_APLI_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_APLI_SER', V_OLDNU_APLI_SER, 
                        V_NEWNU_APLI_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_AUTRIPS_SER < :NEW.NU_AUTRIPS_SER) THEN
                DECLARE
                    V_OLDNU_AUTRIPS_SER VARCHAR2(100);
                    V_NEWNU_AUTRIPS_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_AUTRIPS_SER 
                    INTO V_OLDNU_AUTRIPS_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_AUTRIPS_SER 
                    INTO V_NEWNU_AUTRIPS_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_AUTRIPS_SER', V_OLDNU_AUTRIPS_SER, 
                        V_NEWNU_AUTRIPS_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_CLAS_SER <> :NEW.NU_CLAS_SER) THEN
                DECLARE
                    V_OLDNU_CLAS_SER VARCHAR2(100);
                    V_NEWNU_CLAS_SER VARCHAR2(100); 
                BEGIN 
                    SELECT :OLD.NU_CLAS_SER 
                    INTO V_OLDNU_CLAS_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_CLAS_SER
                    INTO V_NEWNU_CLAS_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_CLAS_SER', V_OLDNU_CLAS_SER, 
                        V_NEWNU_CLAS_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_EDFI_SER <> :NEW.NU_EDFI_SER) THEN
                DECLARE
                    V_OLDNU_EDFI_SER VARCHAR2(100);
                    V_NEWNU_EDFI_SER VARCHAR2 (100);
                BEGIN 
                    SELECT :OLD.NU_EDFI_SER 
                    INTO V_OLDNU_EDFI_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_EDFI_SER
                    INTO V_NEWNU_EDFI_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_EDFI_SER', V_OLDNU_EDFI_SER, 
                        V_NEWNU_EDFI_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_EDIN_SER <> :NEW.NU_EDIN_SER) THEN
                DECLARE
                    V_OLDNU_EDIN_SER VARCHAR2(100);
                    V_NEWNU_EDIN_SER VARCHAR2(100); 
                BEGIN  
                    SELECT :OLD.NU_EDIN_SER 
                    INTO V_OLDNU_EDIN_SER
                    FROM DUAL;

                    SELECT :NEW.NU_EDIN_SER
                    INTO V_NEWNU_EDIN_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_EDIN_SER', V_OLDNU_EDIN_SER, 
                        V_NEWNU_EDIN_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_ESGRUPAL_SER <> :NEW.NU_ESGRUPAL_SER) THEN
                DECLARE
                    V_OLDNU_ESGRUPAL_SER VARCHAR2(100);
                    V_NEWNU_ESGRUPAL_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_ESGRUPAL_SER
                    INTO V_OLDNU_ESGRUPAL_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_ESGRUPAL_SER 
                    INTO V_NEWNU_ESGRUPAL_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_ESGRUPAL_SER', V_OLDNU_ESGRUPAL_SER, 
                        V_NEWNU_ESGRUPAL_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_ESTA_SER <> :NEW.NU_ESTA_SER) THEN
                DECLARE
                    V_OLDNU_ESTA_SER VARCHAR2(100);
                    V_NEWNU_ESTA_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_ESTA_SER 
                    INTO V_OLDNU_ESTA_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_ESTA_SER
                    INTO V_NEWNU_ESTA_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_ESTA_SER', V_OLDNU_ESTA_SER, 
                        V_NEWNU_ESTA_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_EVOL_SER <> :NEW.NU_EVOL_SER) THEN
                DECLARE
                    V_OLDNU_EVOL_SER VARCHAR2(100);
                    V_NEWNU_EVOL_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_EVOL_SER 
                    INTO V_OLDNU_EVOL_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_EVOL_SER 
                    INTO V_NEWNU_EVOL_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_EVOL_SER', V_OLDNU_EVOL_SER, 
                        V_NEWNU_EVOL_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_HOME_SER <> :NEW.NU_HOME_SER) THEN
                DECLARE
                    V_OLDNU_HOME_SER VARCHAR2(100);
                    V_NEWNU_HOME_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_HOME_SER 
                    INTO V_OLDNU_HOME_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_HOME_SER
                    INTO V_NEWNU_HOME_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_HOME_SER', V_OLDNU_HOME_SER, 
                        V_NEWNU_HOME_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_MAXPACGRU_SER <> :NEW.NU_MAXPACGRU_SER) THEN
                DECLARE
                    V_OLDNU_MAXPACGRU_SER VARCHAR2(100);
                    V_NEWNU_MAXPACGRU_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_MAXPACGRU_SER
                    INTO V_OLDNU_MAXPACGRU_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_MAXPACGRU_SER 
                    INTO V_NEWNU_MAXPACGRU_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue, 
                        'NU_MAXPACGRU_SER', V_OLDNU_MAXPACGRU_SER, 
                        V_NEWNU_MAXPACGRU_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_MICO_SER <> :NEW.NU_MICO_SER) THEN
                DECLARE
                    V_OLDNU_MICO_SER VARCHAR2(100);
                    V_NEWNU_MICO_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_MICO_SER
                    INTO V_OLDNU_MICO_SER
                    FROM DUAL;

                    SELECT :NEW.NU_MICO_SER 
                    INTO V_NEWNU_MICO_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_MICO_SER', V_OLDNU_MICO_SER, 
                        V_NEWNU_MICO_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_NIVE_SER <> :NEW.NU_NIVE_SER) THEN
                DECLARE
                    V_OLDNU_NIVE_SER VARCHAR2(100);
                    V_NEWNU_NIVE_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_NIVE_SER 
                    INTO V_OLDNU_NIVE_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_NIVE_SER 
                    INTO V_NEWNU_NIVE_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_NIVE_SER', V_OLDNU_NIVE_SER, 
                        V_NEWNU_NIVE_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID,
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_NO_ES_VIS_MIHIMS <> :NEW.NU_NO_ES_VIS_MIHIMS) THEN
                DECLARE
                    V_OLDNU_NO_ES_VIS_MIHIMS VARCHAR2(100);
                    V_NEWNU_NO_ES_VIS_MIHIMS VARCHAR2(100);
                BEGIN
                    SELECT :OLD.NU_NO_ES_VIS_MIHIMS
                    INTO V_OLDNU_NO_ES_VIS_MIHIMS
                    FROM DUAL;
                    
                    SELECT :NEW.NU_NO_ES_VIS_MIHIMS
                    INTO V_NEWNU_NO_ES_VIS_MIHIMS
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_NO_ES_VIS_MIHIMS', V_OLDNU_NO_ES_VIS_MIHIMS, 
                        V_NEWNU_NO_ES_VIS_MIHIMS, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_NOFACT_SER <> :NEW.NU_NOFACT_SER) THEN
                DECLARE
                    V_OLDNU_NOFACT_SER VARCHAR2(100);
                    V_NEWNU_NOFACT_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_NOFACT_SER
                    INTO V_OLDNU_NOFACT_SER
                    FROM DUAL;

                     
                    SELECT :NEW.NU_NOFACT_SER 
                    INTO V_NEWNU_NOFACT_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_NOFACT_SER', V_OLDNU_NOFACT_SER, 
                        V_NEWNU_NOFACT_SER, SYSDATE,
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_NOPOS_SER <> :NEW.NU_NOPOS_SER) THEN
                DECLARE
                    V_OLDNU_NOPOS_SER VARCHAR2(100);
                    V_NEWNU_NOPOS_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_NOPOS_SER 
                    INTO V_OLDNU_NOPOS_SER
                    FROM DUAL;

                    SELECT :NEW.NU_NOPOS_SER 
                    INTO V_NEWNU_NOPOS_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_NOPOS_SER', V_OLDNU_NOPOS_SER, 
                        V_NEWNU_NOPOS_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_NORIPS_SER <> :NEW.NU_NORIPS_SER) THEN
                DECLARE
                    V_OLDNU_NORIPS_SER VARCHAR2(100);
                    V_NEWNU_NORIPS_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_NORIPS_SER
                    INTO V_OLDNU_NORIPS_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_NORIPS_SER 
                    INTO V_NEWNU_NORIPS_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_NORIPS_SER', V_OLDNU_NORIPS_SER, 
                        V_NEWNU_NORIPS_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_NUME_IND_SER <> :NEW.NU_NUME_IND_SER) THEN
                DECLARE
                    V_OLDNU_NUME_IND_SER VARCHAR2(100); 
                    V_NEWNU_NUME_IND_SER VARCHAR2(100); 
                BEGIN 
                    SELECT :OLD.NU_NUME_IND_SER 
                    INTO V_OLDNU_NUME_IND_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_NUME_IND_SER 
                    INTO V_NEWNU_NUME_IND_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_NUME_IND_SER', V_OLDNU_NUME_IND_SER, 
                        V_NEWNU_NUME_IND_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END;
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_OPCI_SER <> :NEW.NU_OPCI_SER) THEN
                DECLARE
                    V_OLDNU_OPCI_SER VARCHAR2(100);
                    V_NEWNU_OPCI_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_OPCI_SER
                    INTO V_OLDNU_OPCI_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_OPCI_SER 
                    INTO V_NEWNU_OPCI_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_OPCI_SER', V_OLDNU_OPCI_SER, 
                        V_NEWNU_OPCI_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_REQAUT_SER <> :NEW.NU_REQAUT_SER) THEN
                DECLARE
                    V_OLDNU_REQAUT_SER VARCHAR2(100); 
                    V_NEWNU_REQAUT_SER VARCHAR2(100); 
                BEGIN 
                    SELECT :OLD.NU_REQAUT_SER 
                    INTO V_OLDNU_REQAUT_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_REQAUT_SER 
                    INTO V_NEWNU_REQAUT_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_REQAUT_SER', V_OLDNU_REQAUT_SER, 
                        V_NEWNU_REQAUT_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_TITA_SER <> :NEW.NU_TITA_SER) THEN
                DECLARE
                    V_OLDNU_TITA_SER VARCHAR2(100);
                    V_NEWNU_TITA_SER VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.NU_TITA_SER
                    INTO V_OLDNU_TITA_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_TITA_SER
                    INTO V_NEWNU_TITA_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_TITA_SER', V_OLDNU_TITA_SER, 
                        V_NEWNU_TITA_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.NU_VACU_SER <> :NEW.NU_VACU_SER) THEN
                DECLARE
                    V_OLDNU_VACU_SER Varchar(100);
                    V_NEWNU_VACU_SER Varchar(100);
                BEGIN 
                    SELECT :OLD.NU_VACU_SER
                    INTO V_OLDNU_VACU_SER
                    FROM DUAL;
                    
                    SELECT :NEW.NU_VACU_SER 
                    INTO V_NEWNU_VACU_SER
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'NU_VACU_SER', V_OLDNU_VACU_SER, 
                        V_NEWNU_VACU_SER, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
            ------------------------------------------------------
            IF (:OLD.SIN_COPAGO <> :NEW.SIN_COPAGO ) THEN
                DECLARE
                    V_OLDSIN_COPAGO VARCHAR2(100); 
                    V_NEWSIN_COPAGO VARCHAR2(100);
                BEGIN 
                    SELECT :OLD.SIN_COPAGO 
                    INTO V_OLDSIN_COPAGO
                    FROM DUAL;
                    
                    SELECT :NEW.SIN_COPAGO 
                    INTO V_NEWSIN_COPAGO
                    FROM DUAL;

                    INSERT INTO Audit3i(TYPE, TABLENAME,
                          PRIMARYKEYFIELD, PRIMARYKEYVALUE,
                          FIELDNAME,OLDVALUE, 
                          NEWVALUE,UPDATEDATE,
                          USERNAME,IDSESIONSERVER,
                          NOCONEXION ) 
                    VALUES ('U','SERVICIOS',
                        'CD_CODI_SER', V_PrimaryKeyValue , 
                        'SIN_COPAGO', V_OLDSIN_COPAGO, 
                        V_NEWSIN_COPAGO, SYSDATE, 
                        V_USER_NAME, V_USER_ID, 
                        0);
                END; 
            END IF;
        END;
    END IF; 
END;