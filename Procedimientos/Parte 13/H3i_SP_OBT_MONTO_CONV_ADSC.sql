CREATE OR REPLACE PROCEDURE H3i_SP_OBT_MONTO_CONV_ADSC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	  v_CON_CONV_ADSC IN VARCHAR2,
	  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   	OPEN  cv_1 FOR
      	SELECT VL_SALD_COAD MONTO_ACTUAL  
        FROM CONVENIO_ADSC 
       	WHERE  NU_NUME_COAD = v_CON_CONV_ADSC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;