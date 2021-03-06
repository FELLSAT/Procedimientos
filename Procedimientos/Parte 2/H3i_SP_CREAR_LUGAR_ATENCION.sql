CREATE OR REPLACE PROCEDURE H3i_SP_CREAR_LUGAR_ATENCION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN VARCHAR2,
  v_NOMBRE IN VARCHAR2,
  v_DIRECCION IN VARCHAR2,
  v_TELEFONO IN VARCHAR2,
  v_MINIMO IN NUMBER,
  v_MAXIMO IN NUMBER,
  v_ENTIDAD IN NUMBER,
  v_UPGD IN NVARCHAR2,
  v_DEPARTAMENTO IN NVARCHAR2,
  v_MUNICIPIO IN NVARCHAR2,
  v_PAIS IN NVARCHAR2,
  v_CODIGO_PADRE IN VARCHAR2,
  v_CD_CODI_TLUAT IN VARCHAR2
)
AS

BEGIN

   INSERT INTO LUGAR_ATENCION
     ( CD_CODI_LUAT, NO_NOMB_LUAT, DE_DIRE_LUAT, DE_TELE_LUAT, NU_RANG_MIN, NU_RANG_MAX, NU_AUTO_ENTI_LUAT, DE_UPGD_LUAT, CD_CODI_DPTO_LUAT, CD_CODI_MUNI_LUAT, CD_CODI_PAIS_LUAT, CD_CODI_LUAT_PADRE, CD_CODI_TLUAT )
     VALUES ( v_CODIGO, v_NOMBRE, v_DIRECCION, v_TELEFONO, v_MINIMO, v_MAXIMO, v_ENTIDAD, v_UPGD, v_DEPARTAMENTO, v_MUNICIPIO, v_PAIS, v_CODIGO_PADRE, v_CD_CODI_TLUAT );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CREAR_LUGAR_ATENCION;