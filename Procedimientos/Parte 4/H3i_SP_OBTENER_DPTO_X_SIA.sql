CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_DPTO_X_SIA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CODIGO IN VARCHAR2,
  v_COD_PAIS IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   	OPEN  cv_1 FOR
      	SELECT CD_CODI_DPTO CODIGO  
        FROM DEPARTAMENTOS 
       	WHERE  COD_DEPTO_SIA = v_CODIGO
            AND CD_CODI_PAIS_DPTO = v_COD_PAIS ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;