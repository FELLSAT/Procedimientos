CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_MUNICIPIOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CRITERIO IN VARCHAR2 DEFAULT NULL ,
  v_BUSCARPOR IN NUMBER DEFAULT 0 ,
  v_CODIGOPAIS IN VARCHAR2 DEFAULT NULL ,
  v_CODIGODPTO IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CD_CODI_MUNI ,
             CD_CODI_DPTO_MUNI ,
             CD_CODI_PAIS_MUNI ,
             NO_NOMB_MUNI 
        FROM MUNICIPIOS 
       WHERE  CD_CODI_MUNI = CASE 
                                  WHEN v_BUSCARPOR = 0 THEN NVL(v_CRITERIO, CD_CODI_MUNI)
              ELSE CD_CODI_MUNI
                 END
                AND NO_NOMB_MUNI LIKE CASE 
                                           WHEN v_BUSCARPOR = 1 THEN '%' || NVL(v_CRITERIO, NO_NOMB_MUNI) || '%'
              ELSE NO_NOMB_MUNI
                 END
                AND CD_CODI_PAIS_MUNI = NVL(v_CODIGOPAIS, CD_CODI_PAIS_MUNI)
                AND CD_CODI_DPTO_MUNI = NVL(v_CODIGODPTO, CD_CODI_DPTO_MUNI)
        ORDER BY NO_NOMB_MUNI ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_MUNICIPIOS;