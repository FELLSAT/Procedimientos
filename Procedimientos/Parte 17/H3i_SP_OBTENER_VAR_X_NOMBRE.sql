CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_VAR_X_NOMBRE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TX_NOMBRE_VAR IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CD_CODI_VAR ,
            NU_AUTO_VAR ,
            TX_NOMBRE_VAR ,
            NU_ESTADO_VAR ,
            NU_TIPO_VAR ,
            TX_FORMU_VAR ,
            NU_AUTO_INDI_VAR 
        FROM INDICADOR_VARIABLE 
        WHERE  TX_NOMBRE_VAR = v_TX_NOMBRE_VAR ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;