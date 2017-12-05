CREATE OR REPLACE PROCEDURE H3i_SP_LISTA_AUTORIZACIONADS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_AUTO_AUAD ,
            CD_CODI_AUTORIZA_AUAD ,
            FE_AUTORIZA_AUAD ,
            NU_ESTA_ANULA_AUAD ,
            NU_NUME_CONE_AUAD ,
            PORC_CUBRIMIENTO_AUAD ,
            VAL_PAGPAC_AUAD 
        FROM AUTORIZACION_ADSCRITOS  ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;