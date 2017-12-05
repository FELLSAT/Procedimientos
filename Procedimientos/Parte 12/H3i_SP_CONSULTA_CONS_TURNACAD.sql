CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_CONS_TURNACAD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  	v_NUM_TURNO IN NUMBER,
  	cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   	OPEN  cv_1 FOR
      	SELECT CD_CODI_CONS_RTE 
        FROM R_TUR_ESC 
       	WHERE  NU_NUME_TUME_RTE = v_NUM_TURNO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;