CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_LUGARS_ATEN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
      CV_1 OUT SYS_REFCURSOR
)
AS
BEGIN
      OPEN CV_1 FOR
            SELECT CD_CODI_LUAT AS CODIGO,
                   NO_NOMB_LUAT AS NOMBRE,
                   DE_DIRE_LUAT AS DIRECCION,
                   DE_TELE_LUAT AS TELEFONO,
                   CAST(NVL(NU_RANG_MIN,0) AS NUMBER(18,2)) AS MINIMO,
                   CAST(NVL(NU_RANG_MAX,0) AS NUMBER(18,2)) AS MAXIMO,
                   NU_AUTO_ENTI_LUAT AS ENTIDAD,
                   DE_UPGD_LUAT AS UPGD,
                   CD_CODI_DPTO_LUAT AS DEPARTAMENTO,
                   CD_CODI_MUNI_LUAT AS MUNICIPIO,
                   CD_CODI_PAIS_LUAT AS PAIS,
                   CD_CODI_LUAT_PADRE AS CODIGO_PADRE,
                   CD_CODI_TLUAT AS TIPO_LUAT,
                   CD_CODI_TLUAT
            FROM LUGAR_ATENCION;



EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_RECUPERAR_LUGARS_ATEN;