CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTAR_CANAL_IGUANA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NOMBRE_CANAL IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   	OPEN  cv_1 FOR
      	SELECT NOMBRE_CANAL ,
               PORT ,
               HOST ,
               TIME_OUT 
        FROM IGUANA_CONTROL 
       	WHERE  NOMBRE_CANAL = v_NOMBRE_CANAL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;