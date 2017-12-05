CREATE OR REPLACE PROCEDURE H3i_SP_AUDI_GUARDA_LOG_SINCRO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_FECHA_SINCRO IN DATE,
  v_CANTIDAD_REGISTROS IN NUMBER,
  v_NUMERO_RADICADO IN NUMBER
)
AS

BEGIN

	INSERT INTO AUDITAR_LOG_SINCRO_DOCU( 
		FE_FECHA_SINCR_ALSD, NU_NUME_RADICA_ALSD, NU_CANT_REGS_ALSD )
	VALUES ( 
		v_FECHA_SINCRO, v_NUMERO_RADICADO, v_CANTIDAD_REGISTROS );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;