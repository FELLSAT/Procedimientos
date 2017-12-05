CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_CAMPOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(v_Object_id IN NUMBER, cv_1 OUT SYS_REFCURSOR)
IS
BEGIN
    OPEN  cv_1 FOR    
    Select C.Column_Id,Column_Name from All_Objects O
    Inner Join All_Types T on T.TypeCode = O.Object_Type
    Inner Join All_Tab_Columns C on C.Table_Name = O.Object_Name
    Where O.Object_Id = v_Object_id and T.Type_Name not in ('ntext','text','image');  
Exception
    When Others Then
    RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;