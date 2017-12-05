CREATE OR REPLACE PROCEDURE H3i_SP_RECUPERAR_CARGO_PROFESI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

	OPEN  cv_1 FOR
	    SELECT NU_NUME_CAR ,
	           DES_CAR_PRO ,
	           ESTADO 
	    FROM CARGO_PROFESIONAL 
	    ORDER BY DES_CAR_PRO ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_RECUPERAR_CARGO_PROFESI;