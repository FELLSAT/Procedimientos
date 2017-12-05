CREATE OR REPLACE PROCEDURE QyR3i_SP_CRE_SOLIC_RES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_SOLICITUD IN NUMBER,
  v_RESPUESTA IN NUMBER
)
AS

BEGIN

	INSERT INTO QYR_SOLICITUD_RESPUESTA(
		NU_NUME_SOL_SR, NU_NUME_RR_SR )
	VALUES ( 
		v_SOLICITUD, v_RESPUESTA );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;