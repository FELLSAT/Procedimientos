CREATE OR REPLACE TRIGGER CITAS_ANULADAS_ChangeTracking 
AFTER INSERT OR UPDATE OR DELETE
ON CITAS_ANULADAS 
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- ============================================= 
DECLARE
  	V_bit NUMBER;  
  	V_field NUMBER; 
  	V_maxfield NUMBER;  
  	V_char NUMBER;  
  	V_fieldname VARCHAR2(128); 
  	V_TableName VARCHAR2(128);
  	V_PKCols VARCHAR2(1000);
  	V_sql VARCHAR2(2000);
  	V_UpdateDate VARCHAR2(21);
  	V_UserName VARCHAR2(128);
  	V_Type VARCHAR2(1);
  	V_PKFieldSelect VARCHAR2(1000);
  	V_PKValueSelect VARCHAR2(1000);
    V_USER_NAME VARCHAR2(30);
    V_USER_ID NUMBER;
BEGIN
    SELECT USERNAME,USER_ID
    INTO V_USER_NAME, V_USER_ID
    FROM USER_USERS;
    ------------------------------------------------------
    V_TableName := 'CITAS_ANULADAS';   
    ------------------------------------------------------
    --date and user    
    V_UserName := V_USER_NAME; 
    V_UpdateDate := TO_CHAR(SYSDATE, 'YYYYMMDD') + ' ' + TO_CHAR(SYSTIMESTAMP, 'HH24:MI:SS:FF3');    
    ------------------------------------------------------
    /* Action*/  
    IF (INSERTING) THEN
        BEGIN
            IF (DELETING) THEN  
                V_Type := 'U' ;
            ELSE
                V_Type := 'I' ;
            END IF;
        END;
    ELSE
        BEGIN
            V_Type := 'D'; 
        END;   
    END IFL
    ------------------------------------------------------
  	/* get list of columns */  
    INSERT INTO INS                                                   --TEMPORAL
    VALUES(:NEW.CD_CODI_MED_CIAN, :NEW.CD_CODI_SER_CIAN,
        :NEW.NU_HIST_PAC_CIAN, :NEW.NU_DURA_CIAN,
        :NEW.FE_ELAB_CIAN, :NEW.FE_FECH_CIAN,
        :NEW.NU_DIA_CIAN, :NEW.NU_NUME_MOVI_CIAN,
        :NEW.NU_PRIM_CIAN, :NEW.FE_HORA_CIAN,
        :NEW.NU_NUME_CONE_CIAN, :NEW.NU_CONE_CALL_CIAN,
        :NEW.CD_CODI_ESP_CIAN, :NEW.CD_CODI_CONS_CIAN,
        :NEW.NU_NUME_CONV_CIAN, :NEW.NU_TIPO_CIAN,
        :NEW.DE_DESC_CIAN, :NEW.CD_CODI_MOTI_CIAN,
        :NEW.NU_CONE_ANUL_CIAN, :NEW.TX_USER_CIAN,
        :NEW.FE_MODIFI_CIAN, :NEW.TX_INDMOV_CIAN,
        :NEW.NU_NUME_CIT_CIAN, :NEW.CD_MEDI_ORDE_CIAN,
        :NEW.TX_CODI_EQUI_CIAN, :NEW.NU_TIPOJO_CIAN,
        :NEW.NU_CITEXT_CIAN, :NEW.NU_AUTO_CIAN,
        :NEW.ME_OBSMOD_CIAN, :NEW.CD_CODI_MED_EST_CIAN,
        :NEW.CD_CODI_MOANCI_CIT);
    
    INSERT INTO DEL                                                   --TEMPORAL
    VALUES (:OLD.CD_CODI_MED_CIAN, :OLD.CD_CODI_SER_CIAN,
        :OLD.NU_HIST_PAC_CIAN, :OLD.NU_DURA_CIAN,
        :OLD.FE_ELAB_CIAN, :OLD.FE_FECH_CIAN,
        :OLD.NU_DIA_CIAN, :OLD.NU_NUME_MOVI_CIAN,
        :OLD.NU_PRIM_CIAN, :OLD.FE_HORA_CIAN,
        :OLD.NU_NUME_CONE_CIAN, :OLD.NU_CONE_CALL_CIAN,
        :OLD.CD_CODI_ESP_CIAN, :OLD.CD_CODI_CONS_CIAN,
        :OLD.NU_NUME_CONV_CIAN, :OLD.NU_TIPO_CIAN,
        :OLD.DE_DESC_CIAN, :OLD.CD_CODI_MOTI_CIAN,
        :OLD.NU_CONE_ANUL_CIAN, :OLD.TX_USER_CIAN,
        :OLD.FE_MODIFI_CIAN, :OLD.TX_INDMOV_CIAN,
        :OLD.NU_NUME_CIT_CIAN, :OLD.CD_MEDI_ORDE_CIAN,
        :OLD.TX_CODI_EQUI_CIAN,:OLD.NU_TIPOJO_CIAN,
        :OLD.NU_CITEXT_CIAN, :OLD.U_AUTO_CIAN,
        :OLD.ME_OBSMOD_CIAN, :OLD.CD_CODI_MED_EST_CIAN,
        :OLD.CD_CODI_MOANCI_CIT);
    ------------------------------------------------------
    /* Get primary key columns for full outer join */   
    SELECT COALESCE(V_PKCols || ' and', ' on') || ' i.' || COLS.COLUMN_NAME || ' = d.' || COLS.COLUMN_NAME  
    INTO V_PKCols
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = V_TableName  
        AND CONS.CONSTRAINT_TYPE = 'P'
        AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
        AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;   
    ------------------------------------------------------
    /* Get primary key fields select for insert */    
    SELECT COALESCE(V_PKFieldSelect||'||','') || '''' || COLS.COLUMN_NAME || '|' || ''''  
    INTO V_PKFieldSelect
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = V_TableName  
        AND CONS.CONSTRAINT_TYPE = 'P'
        AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
        AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;   
    ------------------------------------------------------
    SELECT COALESCE(V_PKValueSelect||'||','') || 'TO_CHAR(coalesce(i.' || COLS.COLUMN_NAME || ',d.' || COLS.COLUMN_NAME || ')) || ''|'''  
    INTO V_PKValueSelect
    FROM ALL_CONSTRAINTS CONS, ALL_CONS_COLUMNS COLS
    WHERE COLS.TABLE_NAME = V_TableName  
        AND CONS.CONSTRAINT_TYPE = 'P'
        AND CONS.CONSTRAINT_NAME = COLS.CONSTRAINT_NAME
        AND CONS.OWNER = COLS.OWNER
    ORDER BY COLS.TABLE_NAME, COLS.POSITION;     
    ------------------------------------------------------
  	IF (V_PKCols IS NULL) THEN  
  		  BEGIN 
            RAISE_APPLICATION_ERROR(16,'no PK on table ' ||V_TableName);  
  	     		RETURN;
  			     /*set @PKValueSelect='null'   set @PKFieldSelect='null'   set @PKCols = 'null'*/  
        END;
    END IF;
    ------------------------------------------------------
    SELECT 0, max(COLUMN_ID) 
    INTO V_field, V_maxfield
    FROM ALL_TAB_COLUMNS 
    where TABLE_NAME = V_TableName;
    ------------------------------------------------------
    WHILE V_field < V_maxfield 
    LOOP
        BEGIN  
            SELECT V_field = min(ORDINAL_POSITION) 
            FROM ALL_TAB_COLUMNS
            WHERE TABLE_NAME = V_TableName 
                AND COLUMN_ID > V_field;
            ------------------------------------------------------
            V_bit = MOD((V_field - 1 ), 8) + 1;
            v_bit = POWER(2,v_bit - 1);
            v_har = ((v_field - 1) / 8) + 1;
            ------------------------------------------------------
            IF (SUBSTR(COLUMNS_UPDATED(),V_char, 1) AND V_bit > 0 OR V_Type IN ('I','D')) THEN
                BEGIN  
                    SELECT COLUMN_NAME 
                    INTO V_fieldname
                    FROM ALL_TAB_COLUMNS 
                    WHERE TABLE_NAME = V_TableName 
                        AND COLUMN_ID = V_field;
                    ------------------------------------------------------
                    V_sql := 'INSERT INTO Audit3i (Type, TableName, PrimaryKeyField, PrimaryKeyValue, FieldName, OldValue, NewValue, UpdateDate, UserName)'  
                    V_sql := @sql + ' select ''' + V_Type + ''''  
                    V_sql := @sql + ',''' + V_TableName + ''''  
                    V_sql := @sql + ',' + V_PKFieldSelect  
                    V_sql := @sql + ',' + V_PKValueSelect  
                    V_sql := @sql + ',''' + V_fieldname + ''''  
                    V_sql := @sql + ',convert(varchar(1000),d.' + V_fieldname + ')'  
                    V_sql := @sql + ',convert(varchar(1000),i.' + V_fieldname + ')'  
                    V_sql := @sql + ',''' + V_UpdateDate + ''''  
                    V_sql := @sql + ',''' + V_UserName + ''''  
                    V_sql := @sql + ' from #ins i full outer join #del d'  
                    V_sql := @sql + V_PKCols  
                    V_sql := @sql + ' where i.' + V_fieldname + ' <> d.' + V_fieldname  
                    V_sql := @sql + ' or (i.' + V_fieldname + ' is null and  d.' + V_fieldname + ' is not null)'  
                    V_sql := @sql + ' or (i.' + V_fieldname + ' is not null and  d.' + V_fieldname + ' is null)'  

                    exec (@sql)  
                END;  
            END IF;
        END;
    END LOOP;
