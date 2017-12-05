CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_VALOR_TABLA /*PROCEDIMIENTO ALMACENADO QUE RECUPERA LOS VALORES DE LAS TABLAS DE SEGRIMIENTO RESULTADOS LABORATORIO */
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NoHistoriaClinica IN NUMBER,
  v_NoFila IN NUMBER,
  v_NoColumna IN NUMBER,
  v_IDTabla IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_GRID_VAL 
        FROM HIST_GRIP 
       WHERE  NU_NUME_HICL_HITE = v_NoHistoriaClinica
                AND NU_GRID_COL = v_NoColumna
                AND NU_GRID_ROW = v_NoFila
                AND v_IDTabla = NU_INDI_HITE ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;