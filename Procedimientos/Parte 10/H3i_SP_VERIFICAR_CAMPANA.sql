CREATE OR REPLACE PROCEDURE H3i_SP_VERIFICAR_CAMPANA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_CAMP IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_RELACIONADOS NUMBER(10,0);

BEGIN

   SELECT NVL(( SELECT COUNT(*)  
                FROM R_MOVICA_CAMP 
                 WHERE  CD_CODI_CAMP_RMC = v_CD_CODI_CAMP ), 0)

     INTO v_RELACIONADOS
     FROM DUAL ;
   IF v_RELACIONADOS > 0 THEN
    
   BEGIN
      OPEN  cv_1 FOR
         SELECT 0 RESULT  
           FROM DUAL  ;
   
   END;
   ELSE
   
   BEGIN
      OPEN  cv_1 FOR
         SELECT 1 RESULT  
           FROM DUAL  ;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;