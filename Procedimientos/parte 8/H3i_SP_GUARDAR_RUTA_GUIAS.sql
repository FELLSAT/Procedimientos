CREATE OR REPLACE PROCEDURE H3i_SP_GUARDAR_RUTA_GUIAS -- PROCEDIMIENTO ALMACENADO QUE GUARDAR LA RUTA DE GUARDADO DE GUIAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_RUTA_BASE_GUIAS IN VARCHAR2
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE ( SELECT COUNT(CD_CONC_CONT)  
               FROM CONTROL 
                WHERE  CD_CONC_CONT = 'RUTA_GUIA_DIAG' ) = 0;
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      INSERT INTO CONTROL
        ( CD_CONC_CONT, DE_DESC_CONT, VL_VALO_CONT )
        VALUES ( 'RUTA_GUIA_DIAG', 'Ruta del servidor para guia de manejo', v_RUTA_BASE_GUIAS );
   
   END;
   ELSE
   
   BEGIN
      UPDATE CONTROL
         SET VL_VALO_CONT = v_RUTA_BASE_GUIAS
       WHERE  CD_CONC_CONT = 'RUTA_GUIA_DIAG';
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;