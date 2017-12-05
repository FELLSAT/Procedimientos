CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_USUARIO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_Login IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT UP.ID_IDEN_USUA ID_IDEN_USUA  ,
             NU_TIPD_USUA ,
             NU_DOCU_USUA ,
             NO_NOMB_USUA ,
             TX_APELLIDO1_USUA ,
             TX_APELLIDO2_USUA ,
             TX_NOMBRE1_USUA ,
             TX_NOMBRE2_USUA ,
             NU_AUTO_ENTI_USUA ,
             CD_CODI_PERF_USUA ,
             CD_CODI_PERIN_USUA ,
             CD_CODI_GRUP_USUA ,
             NU_ESTADO_USUA ,
             NU_CAMBCLAVE_USUA ,
             CD_CODI_LUAT_FACO ,
             CA_PASSWORD ,
             P.CD_CODI_PERF CD_CODI_PERF  ,
             NO_NOMB_PERF ,
             TX_DIRECCION ,
             TX_TELEFONO ,
             TX_TEL_CEL ,
             TX_CORREO ,
             CD_CODI_CARGO ,
             CD_CODI_MODALID ,
             CD_CODI_ROL ,
             DE_DESC_ROL ,
             NU_TRABAJO_AUDI 
        FROM USUARIOS U
               JOIN USUARIO_PERFIL UP   ON U.ID_IDEN_USUA = UP.ID_IDEN_USUA
               JOIN PERFILES P   ON P.CD_CODI_PERF = UP.CD_CODI_PERF
               LEFT JOIN ROLES R   ON R.CD_CODI_ROL = u.CD_CODI_ROL_USUA
       WHERE  U.ID_IDEN_USUA = NVL(v_Login, U.ID_IDEN_USUA) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_USUARIO;