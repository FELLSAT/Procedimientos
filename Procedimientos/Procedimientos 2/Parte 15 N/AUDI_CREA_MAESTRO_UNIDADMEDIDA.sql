CREATE OR REPLACE PROCEDURE AUDI_CREA_MAESTRO_UNIDADMEDIDA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_CD_COD_MAUNME IN VARCHAR2,
	V_DESCRIPCION_MAUNME IN VARCHAR2,
	V_ESTADO_MAUNME IN NUMBER 
)

AS
	V_EXISTE NUMBER;
BEGIN
	SELECT DESCRIPCION_MAUNME 
	INTO V_EXISTE
	FROM AUDI_UNIDAD_MEDIDA 
	WHERE CD_COD_MAUNME = V_CD_COD_MAUNME;

	IF (V_EXISTE >= 1) THEN

		BEGIN
			UPDATE AUDI_UNIDAD_MEDIDA 
			SET DESCRIPCION_MAUNME = V_DESCRIPCION_MAUNME,
				ESTADO_MAUNME = V_ESTADO_MAUNME
			WHERE CD_COD_MAUNME = V_CD_COD_MAUNME;
		END;

	ELSE

		BEGIN
			INSERT INTO AUDI_UNIDAD_MEDIDA (
				CD_COD_MAUNME, DESCRIPCION_MAUNME,
                ESTADO_MAUNME)
      		VALUES (
      			V_CD_COD_MAUNME, V_DESCRIPCION_MAUNME, 
      			V_ESTADO_MAUNME);
		END;

	END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;