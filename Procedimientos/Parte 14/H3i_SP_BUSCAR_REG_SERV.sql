CREATE OR REPLACE PROCEDURE H3i_SP_BUSCAR_REG_SERV
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CD_REG_ADSC IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT S.CD_CODI_SER ,
            S.CD_CODI_TISE_SER ,
            S.NO_NOMB_SER ,
            S.NU_OPCI_SER ,--add
            NULL DESC_  
        FROM R_REGIS_ADSCR_SERV R
        INNER JOIN SERVICIOS S   
            ON R.CD_SERV_READ = S.CD_CODI_SER
        WHERE  R.CD_REG_ADSC = v_CD_REG_ADSC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;