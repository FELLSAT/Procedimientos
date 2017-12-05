CREATE OR REPLACE PROCEDURE H3i_SP_GUAR_ESTADOS_AFILIACION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_CODIGO IN ESTADOS_AFILIACION.CD_CODI_ESAF%TYPE,
	V_DESCRIPCION IN ESTADOS_AFILIACION.DE_DESCRIP_ESAF%TYPE,
	V_ESTADO IN ESTADOS_AFILIACION.NU_ESTADO_ESAF%TYPE
)
AS 
	V_CANTIDAD_REG NUMBER;
BEGIN
	SELECT COUNT(*) INTO V_CANTIDAD_REG FROM ESTADOS_AFILIACION WHERE CD_CODI_ESAF = V_CODIGO;
	
	IF (V_CANTIDAD_REG >= 1) THEN
		BEGIN
			UPDATE ESTADOS_AFILIACION
			SET DE_DESCRIP_ESAF = V_DESCRIPCION,
				NU_ESTADO_ESAF = V_ESTADO
			WHERE CD_CODI_ESAF = V_CODIGO;
		END;
	ELSE
		BEGIN
			INSERT INTO ESTADOS_AFILIACION (CD_CODI_ESAF, DE_DESCRIP_ESAF, NU_ESTADO_ESAF)
     		VALUES (V_CODIGO, V_DESCRIPCION, V_ESTADO);
		END;
	END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_GUAR_ESTADOS_AFILIACION;
