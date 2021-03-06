CREATE OR REPLACE PROCEDURE REC_FEC_EST_CAT_PROF_SUMIN_AUD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_COD_CATAL_PS_AEFCPS IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT COD_NUM_ESTA_AEFCPS ,
            COD_CATAL_PS_AEFCPS ,
            NU_ESTA_AEFCOS ,
            FE_FECHA_INI_AEFCOS ,
            FE_FECHA_FIN_AEFCOS 
        FROM AUDITAR_ESTA_FECHA_CAT_PROFE_S 
        WHERE  COD_CATAL_PS_AEFCPS = v_COD_CATAL_PS_AEFCPS ;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;