CREATE OR REPLACE PROCEDURE H3i_SP_SELECT_TIPO_SEGUIM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ID IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   IF v_ID IS NULL THEN
    
     BEGIN
        OPEN  cv_1 FOR
           SELECT * 
             FROM TIPO_SEGUIMIENTO  ;
     
     END;
   ELSE
   
     BEGIN
        OPEN  cv_1 FOR
           SELECT * 
             FROM TIPO_SEGUIMIENTO 
            WHERE  ID = v_ID ;
     
     END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;