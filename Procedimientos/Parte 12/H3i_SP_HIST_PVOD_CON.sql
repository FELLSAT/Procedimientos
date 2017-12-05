CREATE OR REPLACE PROCEDURE H3i_SP_HIST_PVOD_CON
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
        SELECT NU_NUME_HICL_HIPV ,
            NU_ORDEN_HIPV ,
            NU_DIENTE_HIPV ,
            NU_AUTO_PRVI_HITP ,
            NU_VITAL_PRVI 
        FROM HIST_PVOD 
        WHERE  NU_NUME_HICL_HIPV = v_NOHICL
            AND NU_ORDEN_HIPV = v_ORDEN
            AND NU_DIENTE_HIPV = v_DIENTE ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;