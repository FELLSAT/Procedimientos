CREATE OR REPLACE PROCEDURE H3i_SP_LISTAR_GESTGLO_CERRADO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_AUTO_REGL ,
            NU_AUTO_GLOS ,
            FECH_RECEP_REGL ,
            FECH_REGIS_REGL ,
            USER_REGL ,
            CONE_REGL ,
            IMG_REGL ,
            CERRADO 
        FROM RESPUESTA_GLOSA3i 
        WHERE  CERRADO = 1 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
/