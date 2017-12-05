CREATE OR REPLACE PROCEDURE H3i_SP_RECU_SECCIONES_X_AREA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGO_AREA IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_SEC ,
            NO_NOMB_SEC ,
            NO_DESC_SEC ,
            CODIGO_ARLAB_SEC ,
            ESTADO_SEC 
        FROM SECCIONES 
        WHERE  CODIGO_ARLAB_SEC = NVL(v_CODIGO_AREA, CODIGO_ARLAB_SEC) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;