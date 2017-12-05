CREATE OR REPLACE PROCEDURE H3i_SP_HIGIENE_PIEZAS_CON
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumHicl IN NUMBER,
    v_ORDEN IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_NUME_HICL_HINU ,
            NU_INDI_HINU ,
            NU_DESC_HINU 
        FROM HIST_NUME 
        WHERE  NU_NUME_HICL_HINU = v_NumHicl
            AND NU_INDI_HINU = v_ORDEN ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;