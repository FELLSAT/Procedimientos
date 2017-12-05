CREATE OR REPLACE PROCEDURE H3i_SP_GUARDA_APOYO_ECO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN VARCHAR2,
  --@MONTO FLOAT,
  v_DESCRIPCION IN VARCHAR2,
  v_ESTADO IN NUMBER
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE EXISTS ( SELECT * 
                      FROM APOYO_ECONOMICO 
                       WHERE  CD_CODI_APEC = v_CODIGO );
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      UPDATE APOYO_ECONOMICO
         SET --VL_VAL_MONTO = @MONTO,
       DE_DESCRIP_APEC = v_DESCRIPCION,
       NU_ESTADO_APEC = v_ESTADO
       WHERE  CD_CODI_APEC = v_CODIGO;
   
   END;
   ELSE
   
   BEGIN
      INSERT INTO APOYO_ECONOMICO
        ( CD_CODI_APEC
      --,VL_VAL_MONTO
      , DE_DESCRIP_APEC, NU_ESTADO_APEC )
        VALUES ( v_CODIGO, 
      --,@MONTO
      v_DESCRIPCION, v_ESTADO );
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_GUARDA_APOYO_ECO;