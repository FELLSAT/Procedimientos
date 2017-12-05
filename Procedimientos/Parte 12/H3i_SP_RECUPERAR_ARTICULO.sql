CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_ARTICULO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NO_NOMB_ARTI IN VARCHAR2 DEFAULT NULL ,
  v_ID_TIPO_ARTI IN NUMBER DEFAULT NULL ,
  v_CD_CODI_ARTI IN VARCHAR2 DEFAULT NULL ,
  v_CD_CODI_SER_RAS IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_ARTI ,
            NO_NOMB_ARTI ,
            DE_DESC_ARTI ,
            ID_TIPO_ARTI 
        FROM ARTICULO 
        WHERE  CD_CODI_ARTI = NVL(v_CD_CODI_ARTI, CD_CODI_ARTI)
            AND NVL(NO_NOMB_ARTI, '-1') LIKE '%' || NVL(v_NO_NOMB_ARTI, NVL(NO_NOMB_ARTI, '-1')) || '%'
            AND ID_TIPO_ARTI = NVL(v_ID_TIPO_ARTI, ID_TIPO_ARTI)
            AND CD_CODI_ARTI NOT IN ( SELECT CD_CODI_ARTI_RAS 
                                      FROM R_ART_SER 
                                      WHERE  CD_CODI_SER_RAS = NVL(v_CD_CODI_SER_RAS, CD_CODI_SER_RAS));

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;