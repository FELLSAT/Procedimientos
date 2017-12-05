CREATE OR REPLACE PROCEDURE H3i_SP_CERRAR_FAC_CONT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_FAC_CON IN NUMBER,
  v_NU_FAC_CRE IN NUMBER
)
AS

BEGIN

  	UPDATE FACTURAS_CONTADO
    SET NU_AUTO_FCCR_FACO = v_NU_FAC_CRE,
          NU_ESTA_FACO = '2'
    WHERE  NU_NUME_FACO = v_NU_FAC_CON;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;