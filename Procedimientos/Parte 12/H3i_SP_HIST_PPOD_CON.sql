CREATE OR REPLACE PROCEDURE H3i_SP_HIST_PPOD_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NOHICL IN NUMBER,
  v_ORDEN IN NUMBER,
  v_DIENTE IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_NUME_HICL_HIPP ,
            NU_ORDEN_HIPP ,
            NU_DIENTE_HIPP ,
            NU_AUTO_PRPE_HITP ,
            NU_VITAL_PRPE 
        FROM HIST_PPOD 
        WHERE  NU_NUME_HICL_HIPP = v_NOHICL
            AND NU_ORDEN_HIPP = v_ORDEN
            AND NU_DIENTE_HIPP = v_DIENTE ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;