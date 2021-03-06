CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_R_ART_SER
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_ARTI_RAS IN VARCHAR2 DEFAULT NULL ,
  v_CD_CODI_SER_RAS IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_ARTI_RAS ,
            CD_CODI_SER_RAS ,
            CD_CODI_MED_RAS ,
            NU_CANTIDAD_RAS ,
            TX_OB_R_ART_SER 
        FROM R_ART_SER 
        WHERE  CD_CODI_ARTI_RAS = NVL(v_CD_CODI_ARTI_RAS, CD_CODI_ARTI_RAS)
            AND CD_CODI_SER_RAS = NVL(v_CD_CODI_SER_RAS, CD_CODI_SER_RAS) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;