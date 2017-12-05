CREATE OR REPLACE PROCEDURE QyR3i_SP_BUSCAR_USUARIOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_KEY IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
        SELECT ID_IDEN_USUA ,
            PS_PASS_USUA ,
            NO_NOMB_USUA ,
            NU_TIPD_USUA ,
            NU_DOCU_USUA ,
            CD_CODI_PERF_USUA ,
            CD_CODI_GRUP_USUA ,
            NU_FIRMA ,
            NU_ULCON_USUA ,
            CD_CODI_PERIN_USUA ,
            NU_CAMBCLAVE_USUA ,
            NU_ESTADO_USUA ,
            TX_NOMBRE1_USUA ,
            TX_NOMBRE2_USUA ,
            TX_APELLIDO1_USUA ,
            TX_APELLIDO2_USUA ,
            NU_AUTO_ENTI_USUA ,
            CD_CODI_LUAT_FACO ,
            CA_PASSWORD 
        FROM USUARIOS 
        WHERE  UPPER(NO_NOMB_USUA) LIKE v_KEY || '%' AND ROWNUM <= 10 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;