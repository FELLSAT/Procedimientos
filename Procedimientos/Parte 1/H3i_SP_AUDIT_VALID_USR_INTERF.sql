CREATE OR REPLACE PROCEDURE H3i_SP_AUDIT_VALID_USR_INTERF
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_LOGIN IN VARCHAR2,
  v_PASSWORD IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT LOGIN_USR_AUDIT ,
             PSWD_USR_AUDIT ,
             NO_NOMB_USR_AUDIT 
        FROM USUARIO_AUDIT 
       WHERE  LOGIN_USR_AUDIT = v_LOGIN
                AND PSWD_USR_AUDIT = v_PASSWORD ;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_AUDIT_VALID_USR_INTERF;