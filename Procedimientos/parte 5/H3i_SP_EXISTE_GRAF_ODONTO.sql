CREATE OR REPLACE PROCEDURE H3i_SP_EXISTE_GRAF_ODONTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NOMB_GRAF IN VARCHAR2,
  v_CODI_GRAF IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR,
  cv_2 OUT SYS_REFCURSOR
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   
   BEGIN
      IF v_CODI_GRAF IS NULL THEN
       DECLARE
         v_temp NUMBER(1, 0) := 0;
      
      BEGIN
         BEGIN
            SELECT 1 INTO v_temp
              FROM DUAL
             WHERE EXISTS ( SELECT * 
                            FROM GRAF_ODONTO 
                             WHERE  NO_NOMB_GRAF = v_NOMB_GRAF );
         EXCEPTION
            WHEN OTHERS THEN
               NULL;
         END;
            
         IF v_temp = 1 THEN
          
         BEGIN
            OPEN  cv_1 FOR
               SELECT 1 EXISTE  
                 FROM DUAL  ;
         
         END;
         ELSE
         
         BEGIN
            OPEN  cv_1 FOR
               SELECT 0 EXISTE  
                 FROM DUAL  ;
         
         END;
         END IF;
      
      END;
      ELSE
      DECLARE
         v_temp NUMBER(1, 0) := 0;
      
      BEGIN
         BEGIN
            SELECT 1 INTO v_temp
              FROM DUAL
             WHERE EXISTS ( SELECT * 
                            FROM GRAF_ODONTO 
                             WHERE  NO_NOMB_GRAF = v_NOMB_GRAF
                                      AND CD_CODI_GRAF <> v_CODI_GRAF );
         EXCEPTION
            WHEN OTHERS THEN
               NULL;
         END;
            
         IF v_temp = 1 THEN
          
         BEGIN
            OPEN  cv_2 FOR
               SELECT 1 EXISTE  
                 FROM DUAL  ;
         
         END;
         ELSE
         
         BEGIN
            OPEN  cv_2 FOR
               SELECT 0 EXISTE  
                 FROM DUAL  ;
         
         END;
         END IF;
      
      END;
      END IF;
   
   END;
   -- 2. Crea el procedimiento almacenado: H3i_SP_CREA_GRAF_ODONTO
   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE EXISTS ( SELECT *
                      FROM   ALL_SOURCE
                      WHERE NAME  = 'H3i_SP_CREA_GRAF_ODONTO' AND TYPE = 'PROCEDURE');
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      EXECUTE IMMEDIATE 'DROP PROCEDURE H3i_SP_CREA_GRAF_ODONTO';
      DBMS_OUTPUT.PUT_LINE('SE HA ELIMINADO EL PROCEDIMIENTO ALMACENADO H3i_SP_CREA_GRAF_ODONTO');
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;