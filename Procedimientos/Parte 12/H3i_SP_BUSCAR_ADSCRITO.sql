CREATE OR REPLACE PROCEDURE H3i_SP_BUSCAR_ADSCRITO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NOMBRE IN VARCHAR2,
    v_CODIGO IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_ADSC ,
            NU_CONSE_ADSC ,
            DE_NOMB_ADSC ,
            DE_DIREC_ADSC ,
            NU_TELE_ADSC ,
            NU_ESTA_ADSC ,
            CD_CODI_DPTO_ADSC ,
            CD_CODI_MUNI_ADSC ,
            NU_TIPCONT_ADSC ,
            NU_CALI_ADSC ,
            NU_TIPD_ADSC ,
            CD_CODIGO_ADSC ,
            NU_LABO_DENTAL 
        FROM ADSCRITOS 
        WHERE  UPPER(DE_NOMB_ADSC) LIKE NVL(v_NOMBRE, '%')
            AND UPPER(CD_CODI_ADSC) LIKE NVL(v_CODIGO, '%') ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;