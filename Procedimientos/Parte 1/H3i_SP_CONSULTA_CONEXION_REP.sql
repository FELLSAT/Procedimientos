CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_CONEXION_REP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NumConex IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT USUARIO ,
             FECHA ,
             NOMBRE_PC ,
             FECHA_DESCONEXION ,
             ( SELECT CD_CODI_MED 
               FROM USUARIOS 
                      JOIN MEDICOS    ON NU_DOCU_MED = NU_DOCU_USUA
                WHERE  USUARIOS.ID_IDEN_USUA = USUARIO AND ROWNUM <= 1 ) codmedico  ,
             RTRIM(LTRIM(IS_LDAP)) IS_LDAP  ,
             TX_DAT_NAV ,
             NU_ESTA_CONE 
        FROM CONEXIONES 
       WHERE  NU_NUME_CONE = v_NumConex ;--AND NU_ESTA_CONE = 1 -- para reportes u obtener datos de la sesión de algun registro, no se necesita el estado, porque si se requiere la información

EXCEPTION
  WHEN OTHERS 
      THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_CONEXION_REP;