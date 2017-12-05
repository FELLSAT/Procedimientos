CREATE OR REPLACE PROCEDURE H3i_SP_HIST_APOD_INS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NumHicl IN NUMBER,
  v_Orden IN NUMBER,
  v_Diente IN NUMBER,
  v_Alteracion IN NUMBER,
  v_NumAuto OUT NUMBER
)
AS

BEGIN

   	INSERT INTO HIST_APOD( 
   		NU_NUME_HICL_HIAP, NU_ORDEN_HIAP, NU_DIENTE_HIAO, NU_AUTO_ALPU_HITP )
    VALUES( 
    	v_NumHicl, v_Orden, v_Diente, v_Alteracion );

   	SELECT NU_AUTO_HIAP 
  	INTO v_NumAuto 
  	FROM HIST_APOD
  	WHERE NU_AUTO_HIAP = (SELECT MAX(NU_AUTO_HIAP) FROM HIST_APOD);

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;