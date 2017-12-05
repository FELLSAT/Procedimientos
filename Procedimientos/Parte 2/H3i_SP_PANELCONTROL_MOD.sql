CREATE OR REPLACE PROCEDURE H3i_SP_PANELCONTROL_MOD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN VARCHAR2,
  v_VALOR IN VARCHAR2
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE EXISTS ( SELECT * 
                      FROM CONTROL 
                       WHERE  CD_CONC_CONT = v_CODIGO );
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      UPDATE CONTROL
         SET VL_VALO_CONT = v_VALOR
       WHERE  CD_CONC_CONT = v_CODIGO;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_PANELCONTROL_MOD;