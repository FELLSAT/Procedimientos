CREATE OR REPLACE PROCEDURE H3i_SP_CREAR_FACTURA_ADSCRITO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NUMERO_FACTURA IN VARCHAR2,
  v_ID_ADSCRITO IN NUMBER,
  v_ID_CONVENIO IN NUMBER,
  v_FECH_RECEPCION IN DATE,
  v_FECH_EXPE IN DATE,
  v_VALOR_TOTAL IN NUMBER
)
AS

BEGIN

   	INSERT INTO FACTURA_ADSCRITO( 
   		NU_NUME_FAAD, NU_CONSE_ADSC_FAAD, 
   		NU_NUME_COAD_FAAD, FE_RECEP_FAAD, 
   		FE_EXPED_FAAD, VL_TOTAL_FAAD )
    VALUES ( 
    	v_NUMERO_FACTURA, v_ID_ADSCRITO, 
    	v_ID_CONVENIO, TO_DATE(v_FECH_RECEPCION,'dd/mm/yyyy'), 
    	TO_DATE(v_FECH_EXPE,'dd/mm/yyyy'), v_VALOR_TOTAL );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;