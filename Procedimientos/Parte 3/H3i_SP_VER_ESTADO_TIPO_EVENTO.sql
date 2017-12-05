CREATE OR REPLACE PROCEDURE H3i_SP_VER_ESTADO_TIPO_EVENTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_TIPO_EVENTO IN NUMBER,
  v_NOM_EVENTO IN VARCHAR2,
  v_NUM_SECUENCIA_PADRE IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_ESTADO NUMBER(10,0) := 0;
   v_EVALUADO NUMBER(1,0) := 0;
   v_temp NUMBER(1, 0) := 0;

BEGIN

   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE ( SELECT NUM_SECUENCIA_PADRE 
               FROM TIPO_EVENTO_ADVERSO 
                WHERE  CD_TIPO_EVENTO = v_CD_TIPO_EVENTO AND ROWNUM <= 1 ) <> v_NUM_SECUENCIA_PADRE;
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM EVENTO_ADVERSO 
                          WHERE  TIPO_EVENTO = v_CD_TIPO_EVENTO )
        AND v_EVALUADO = 0;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         v_ESTADO := 1 ;
         v_EVALUADO := 1 ;
      
      END;
      END IF;
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM EVENTO_ADVERSO 
                          WHERE  CAUSA_EVENTO = v_CD_TIPO_EVENTO )
        AND v_EVALUADO = 0;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         v_ESTADO := 2 ;
         v_EVALUADO := 1 ;
      
      END;
      END IF;
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM TIPO_EVENTO_ADVERSO 
                          WHERE  NUM_SECUENCIA_PADRE IN ( SELECT NUM_SECUENCIA 
                                                          FROM TIPO_EVENTO_ADVERSO 
                                                           WHERE  CD_TIPO_EVENTO = v_CD_TIPO_EVENTO
                                                                    AND NUM_SECUENCIA_PADRE IS NULL )
       )
        AND v_EVALUADO = 0;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         v_ESTADO := 3 ;
         v_EVALUADO := 1 ;
      
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
                         FROM EVENTO_ADVERSO 
                          WHERE  TIPO_EVENTO = v_CD_TIPO_EVENTO )
        AND v_EVALUADO = 0;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         v_ESTADO := 1 ;
         v_EVALUADO := 1 ;
      
      END;
      END IF;
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM EVENTO_ADVERSO 
                          WHERE  CAUSA_EVENTO = v_CD_TIPO_EVENTO )
        AND v_EVALUADO = 0;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         v_ESTADO := 2 ;
         v_EVALUADO := 1 ;
      
      END;
      END IF;
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM TIPO_EVENTO_ADVERSO 
                          WHERE  NUM_SECUENCIA_PADRE IN ( SELECT NUM_SECUENCIA 
                                                          FROM TIPO_EVENTO_ADVERSO 
                                                           WHERE  CD_TIPO_EVENTO = v_CD_TIPO_EVENTO
                                                                    AND NUM_SECUENCIA_PADRE IS NULL )
       )
        AND v_EVALUADO = 0;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         v_ESTADO := 3 ;
         v_EVALUADO := 1 ;
      
      END;
      END IF;
   
   END;
   END IF;
   OPEN  cv_1 FOR
      SELECT v_ESTADO ESTADO  
        FROM DUAL  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_VER_ESTADO_TIPO_EVENTO;