CREATE OR REPLACE PROCEDURE H3i_SP_RECU_SECCIONES_X_EXAMEN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO_EXAM IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT S.CD_CODI_SEC ,
            NO_NOMB_SEC ,
            NO_DESC_SEC ,
            CODIGO_ARLAB_SEC ,
            ESTADO_SEC 
        FROM SECCIONES S
        INNER JOIN R_SERV_SEC RSS   
            ON S.CD_CODI_SEC = RSS.CD_CODI_SEC
        WHERE  CD_CODI_SER = v_CODIGO_EXAM ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;