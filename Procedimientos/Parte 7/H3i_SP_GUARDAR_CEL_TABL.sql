CREATE OR REPLACE PROCEDURE H3i_SP_GUARDAR_CEL_TABL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_IDPLANTILLA IN NUMBER,
  v_IDCONCEPTO IN NUMBER,
  v_IDGRUPO IN NUMBER,
  v_ID IN NUMBER,
  v_FILA IN NUMBER,
  v_COLUMNA IN NUMBER,
  v_TIPO IN NUMBER,
  v_VALOR IN VARCHAR2
)
AS

BEGIN

   IF v_ID = 0 THEN
    
   BEGIN
      INSERT INTO R_GRID_PLHI
        ( NU_NUME_PLHI_G, NU_GRID_COL, NU_GRID_ROW, NU_GRID_VAL, NU_NUME_COHI_G, NU_NUME_GRHI_GRID, NU_TIPO_RGP )
        VALUES ( v_IDPLANTILLA, v_COLUMNA, v_FILA, v_VALOR, v_IDCONCEPTO, v_IDGRUPO, v_TIPO );
   
   END;
   ELSE
   
   BEGIN
      UPDATE R_GRID_PLHI
         SET NU_NUME_PLHI_G = v_IDPLANTILLA,
             NU_GRID_COL = v_COLUMNA,
             NU_GRID_ROW = v_FILA,
             NU_GRID_VAL = v_VALOR,
             NU_NUME_COHI_G = v_IDCONCEPTO,
             NU_NUME_GRHI_GRID = v_IDGRUPO,
             NU_TIPO_RGP = v_TIPO
       WHERE  R_GRID_HICLI = v_ID;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;