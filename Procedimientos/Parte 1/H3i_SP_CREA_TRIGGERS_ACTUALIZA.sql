CREATE OR REPLACE PROCEDURE H3i_SP_CREA_TRIGGERS_ACTUALIZA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TABLA IN VARCHAR2,
  v_COLUMNAS IN VARCHAR2
)
AS
   v_SQL VARCHAR2(4000);
   v_PrimaryKeyField VARCHAR2(100);
   v_conteo NUMBER(10,0);
   v_filas NUMBER(10,0);
   v_Columna VARCHAR2(100);

BEGIN
    v_SQL := 'CREATE TRIGGER H3i_TRGUPD_' || v_TABLA ;
    v_SQL := v_SQL || ' ON ' || v_TABLA || '        
        FOR UPDATE      
        AS       
          PrimaryKeyField varchar(1000);
          PrimaryKeyValue varchar(1000);
        BEGIN' ;
   
    /*SELECT column_name 
    INTO v_PrimaryKeyField
    FROM all_tab_columns
    WHERE   OBJECTPROPERTY(OBJECT_ID(constraint_name), 'IsPrimaryKey')  = 1 --identificador no valido
             AND table_name = v_TABLA;*/

    SELECT column_name
    INTO v_PrimaryKeyField
    FROM all_cons_columns 
    WHERE constraint_name = (SELECT constraint_name
                             FROM user_constraints 
                             WHERE table_name = v_TABLA 
                             AND constraint_type = 'P');


    IF ( v_PrimaryKeyField != ' ' ) THEN
    
   BEGIN
      v_SQL := v_SQL || 'SELECT column_name
            INTO v_PrimaryKeyField
            FROM all_cons_columns 
            WHERE constraint_name = (SELECT constraint_name
                                     FROM user_constraints 
                                     WHERE table_name = '|| v_TABLA || 
                                     'AND constraint_type = P)

            IF ( v_PrimaryKeyField != ' ' ) THEN    
              begin      
               select into Pr     
              end;
            end if;'


      v_SQL := v_SQL || 'PrimaryKeyField = (SELECT column_name      
           FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE      
           WHERE OBJECTPROPERTY(OBJECT_ID(constraint_name), ''IsPrimaryKey'') = 1      
           AND table_name = ''' || v_TABLA || ''')      
                    
           if (@PrimaryKeyField is not null)      
          begin      
           Select @PrimaryKeyValue = ' || v_PrimaryKeyField || ' from inserted      
          end ' ;
   
   END;
   END IF;
   v_SQL := v_SQL || 'if ((select TOP 1 NU_ESTA_PAAU from PARAMETRIZACION_AUDITORIA  
         where DE_NOMTABLA_PAAU = ''' || v_TABLA || ''') > 0)  
        Begin ' ;

   SELECT ROW_NUMBER() OVER ( ORDER BY item  ) as Consecutivo, 
   INTO tt_Columna                                 
   FROM TABLE(fnSplit(v_COLUMNAS, ',')) ;
        
   v_conteo := 0;

     SELECT COUNT(1) 
     INTO v_filas
     FROM tt_Columna;

   WHILE ( v_conteo != v_filas ) 
   LOOP 
      
      BEGIN
         SELECT item 

           INTO v_Columna
           FROM tt_Columna
          WHERE  Consecutivo = v_conteo + 1;
         v_SQL := v_SQL || 'IF (UPDATE (' || v_Columna || ' ))BEGIN ' ;
         v_SQL := v_SQL || 'Declare @OLD' || v_Columna || ' Varchar(100) ' ;
         v_SQL := v_SQL || 'SET @OLD' || v_Columna || ' = (SELECT ' || v_Columna || ' FROM DELETED) ' ;
         v_SQL := v_SQL || 'Declare @NEW' || v_Columna || ' Varchar(100) ' ;
         v_SQL := v_SQL || 'SET @NEW' || v_Columna || ' = (SELECT ' || v_Columna || ' FROM INSERTED) ' ;
         v_SQL := v_SQL || 'INSERT INTO Audit3i ' ;
         v_SQL := v_SQL || 'Values (''U'',''' || v_TABLA || ''',''' || v_PrimaryKeyField || ''', @PrimaryKeyValue , ''' || v_Columna || ''', @OLD' || v_Columna || ', @NEW' || v_Columna || ', getdate(), SYSTEM_USER , @@spid , 0 )' ;
         v_SQL := v_SQL || 'End ' ;
         v_conteo := v_conteo + 1 ;
      
      END;
   END LOOP;
   v_SQL := v_SQL || 'END ' ;
   v_SQL := v_SQL || 'END' ;
   DBMS_OUTPUT.PUT_LINE(v_SQL);
   EXECUTE IMMEDIATE v_SQL;

EXCEPTION WHEN OTHERS THEN utils.handleerror(SQLCODE,SQLERRM);
END H3i_SP_CREA_TRIGGERS_ACTUALIZA;