CREATE OR REPLACE PROCEDURE H3i_SP_TABLA_ESTRUCT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NoPlantilla IN NUMBER,
  v_NoTabla IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   --@NoGrupo as int
   OPEN  cv_1 FOR
      SELECT * 
        FROM R_GRID_PLHI P
       WHERE  P.NU_NUME_PLHI_G = v_NoPlantilla
                AND P.NU_NUME_COHI_G = v_NoTabla
        ORDER BY NU_GRID_COL,
                 NU_GRID_ROW ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;