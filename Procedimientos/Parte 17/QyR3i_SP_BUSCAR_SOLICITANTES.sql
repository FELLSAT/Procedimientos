CREATE OR REPLACE PROCEDURE QyR3i_SP_BUSCAR_SOLICITANTES
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
        SELECT ID_USUARIO ,
            NOMBRE ,
            IDENTIFICADOR ,
            DIRECCION ,
            TELEFONO ,
            EMAIL 
        FROM(     SELECT ID_IDEN_USUA ID_USUARIO  ,
                      NO_NOMB_USUA NOMBRE  ,
                      NVL(NU_DOCU_USUA, ' ') IDENTIFICADOR  ,
                      ' ' DIRECCION  ,
                      ' ' TELEFONO  ,
                      ' ' EMAIL  
                  FROM USUARIOS 
                  WHERE  UPPER(NO_NOMB_USUA) LIKE v_KEY || '%'
              UNION 
                  SELECT NU_HIST_PAC ID_USUARIO  ,
                      TX_NOMBRECOMPLETO_PAC NOMBRE  ,
                      NVL(NU_DOCU_PAC, ' ') IDENTIFICADOR  ,
                      NVL(DE_DIRE_PAC, ' ') DIRECCION  ,
                      NVL(DE_TELE_PAC, ' ') TELEFONO  ,
                      NVL(DE_EMAIL_PAC, ' ') EMAIL  
                  FROM PACIENTES 
                  WHERE  UPPER(TX_NOMBRECOMPLETO_PAC) LIKE v_KEY || '%'
              UNION 
                SELECT CD_CODI_MED ID_USUARIO  ,
                NO_NOMB_MED NOMBRE  ,
                NVL(NU_DOCU_MED, ' ') IDENTIFICADOR  ,
                NVL(DE_DIRE_MED, ' ') DIRECCION  ,
                NVL(DE_TELE_MED, ' ') TELEFONO  ,
                ' ' EMAIL  
                FROM MEDICOS 
                WHERE  UPPER(NO_NOMB_MED) LIKE v_KEY || '%' ) DATOS
          WHERE  UPPER(NOMBRE) LIKE v_KEY || '%' AND ROWNUM <= 10 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;