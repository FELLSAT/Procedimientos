CREATE OR REPLACE PROCEDURE H3i_SP_RECU_EXAMEN_X_SECCION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGO_SEC IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT S.CD_CODI_SER ,
            S.NO_NOMB_SER ,
            RSS.CD_CODI_SEC 
        FROM SERVICIOS S
        LEFT JOIN R_SERV_SEC RSS   
            ON S.CD_CODI_SER = RSS.CD_CODI_SER
            AND RSS.CD_CODI_SEC = v_CODIGO_SEC
        WHERE  RSS.CD_CODI_SEC = v_CODIGO_SEC
            OR RSS.CD_CODI_SEC IS NULL
            AND S.NU_OPCI_SER = 2
            AND S.NU_ESTA_SER = 1
        ORDER BY S.NO_NOMB_SER ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;