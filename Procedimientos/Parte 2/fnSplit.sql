CREATE OR REPLACE FUNCTION fnSplit
-- =============================================      
-- Author:  Carlos Castro Agudelo
-- =============================================
(V_InputList IN VARCHAR2, V_Delimiter IN VARCHAR2) 
RETURN VARCHAR2
IS
    V_Item VARCHAR(8000);       V_List VARCHAR(8000);       V_Cant NUMBER(3);       V_InList VARCHAR(8000);
BEGIN
    V_List := '';       V_InList := V_InputList;
    WHILE INSTR(V_Delimiter,V_InList,0) <> 0 LOOP
        V_Cant := INSTR(V_Delimiter,V_InList,0);
        V_Item := SUBSTR(V_InList,1,V_Cant);
        V_InList := SUBSTR(V_InList,(V_Cant + LENGTH(V_Delimiter)),LENGTH(V_InList));    
        
        IF LENGTH(V_Item) > 0 THEN     
            V_List := V_List || V_Item;
        END IF;
        
        IF LENGTH(V_InList) > 0 THEN     
            V_List := V_List || V_InList;
        END IF;                    
    END LOOP;       
    RETURN V_List;
Exception
    When Others Then RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);            
END;