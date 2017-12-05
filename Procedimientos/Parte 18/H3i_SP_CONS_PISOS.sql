CREATE OR REPLACE PROCEDURE H3i_SP_CONS_PISOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  	v_CodLuat IN VARCHAR2 DEFAULT NULL ,
  	cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   	OPEN  cv_1 FOR
      	SELECT CD_CODI_PISO ,
             DE_DESC_PISO ,
             CD_CODI_LUAT_PAIS 
        FROM PISOS 
       	WHERE  CD_CODI_LUAT_PAIS = NVL(v_CodLuat, CD_CODI_LUAT_PAIS) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;