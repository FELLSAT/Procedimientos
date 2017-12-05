CREATE OR REPLACE PROCEDURE H3i_SP_EDITAR_PORCEN_AUX
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_ANTERIOR_CODIGO IN VARCHAR2,
  v_CODIGO IN VARCHAR2,
  v_PORCENTAJE IN FLOAT,
  v_NOMBRE IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE NOT EXISTS ( SELECT * 
                          FROM PORCEN_AUX 
                           WHERE  CD_CODI_PAUX = v_CODIGO
                                    AND CD_CODI_PAUX != v_ANTERIOR_CODIGO );
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      UPDATE PORCEN_AUX
         SET CD_CODI_PAUX = v_CODIGO,
             NU_PORC_PAUX = v_PORCENTAJE,
             NO_NOMB_PAUX = v_NOMBRE
       WHERE  CD_CODI_PAUX = v_ANTERIOR_CODIGO;
      OPEN  cv_1 FOR
         SELECT 1 ACTUALIZADO  
           FROM DUAL  ;
   
   END;
   ELSE
   
   BEGIN
      OPEN  cv_1 FOR
         SELECT -1 ACTUALIZADO  
           FROM DUAL  ;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;