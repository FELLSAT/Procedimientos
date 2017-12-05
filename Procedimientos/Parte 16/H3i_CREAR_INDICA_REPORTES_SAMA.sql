CREATE OR REPLACE PROCEDURE H3i_CREAR_INDICA_REPORTES_SAMA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_CD_COD_IRS IN NUMBER DEFAULT -1,
	V_MAYORCOSTO_IRS IN VARCHAR2 DEFAULT NULL,
	V_CIE_IRS IN VARCHAR2 DEFAULT NULL,
	V_MEDICO_FORMULA_IRS IN VARCHAR2 DEFAULT NULL,
	V_MEDICO_FORMULA_COSTO_IRS IN VARCHAR2 DEFAULT NULL,
	V_PACIENTE_POLI_FORMULARIO_IRS IN VARCHAR2 DEFAULT NULL,
	V_COSTO_MES_IRS IN VARCHAR2 DEFAULT NULL,
	V_CONSUMO_CONS_PACI_IRS IN VARCHAR2 DEFAULT NULL,
	V_PORCENTAJE_PENDIENTE_IRS IN VARCHAR2 DEFAULT NULL,
	V_VALOR_PENDIENTE_IRS IN VARCHAR2 DEFAULT NULL,
	V_ATEP_IRS IN VARCHAR2 DEFAULT NULL,
	V_SOAT_IRS IN VARCHAR2 DEFAULT NULL,
	V_ECAT_IRS IN VARCHAR2 DEFAULT NULL,
	V_PYP_IRS IN VARCHAR2 DEFAULT NULL,
	V_NIVEL1_IRS IN VARCHAR2 DEFAULT NULL,
	V_NIVEL2_IRS IN VARCHAR2 DEFAULT NULL,
	V_NIVEL3_IRS IN VARCHAR2 DEFAULT NULL,
	V_ALTO_COSTO_IRS IN VARCHAR2 DEFAULT NULL,
	V_CONCLUSION1_IRS IN VARCHAR2 DEFAULT NULL,
	V_CONCLUSION2_IRS IN VARCHAR2 DEFAULT NULL,
	V_CONCLUSION3_IRS IN VARCHAR2 DEFAULT NULL,
	V_CONCLUSION4_IRS IN VARCHAR2 DEFAULT NULL,
	V_CONCLUSION5_IRS IN VARCHAR2 DEFAULT NULL,
	V_DIFICULTAD1_IRS IN VARCHAR2 DEFAULT NULL,
	V_DIFICULTAD2_IRS IN VARCHAR2 DEFAULT NULL,
	V_DIFICULTAD3_IRS IN VARCHAR2 DEFAULT NULL,
	V_DIFICULTAD4_IRS IN VARCHAR2 DEFAULT NULL,
	V_DIFICULTAD5_IRS IN VARCHAR2 DEFAULT NULL,
	V_SUGERENCIA1_IRS IN VARCHAR2 DEFAULT NULL,
	V_SUGERENCIA2_IRS IN VARCHAR2 DEFAULT NULL,
	V_SUGERENCIA3_IRS IN VARCHAR2 DEFAULT NULL,
	V_SUGERENCIA4_IRS IN VARCHAR2 DEFAULT NULL,
	V_SUGERENCIA5_IRS IN VARCHAR2 DEFAULT NULL,
	V_AUDITOR_IRS IN VARCHAR2 DEFAULT NULL,
	V_NUMEREPORHIS IN NUMBER
)
	
AS
	V_EXISTE NUMBER;
BEGIN

	SELECT COUNT(MAYORCOSTO_IRS)
	INTO V_EXISTE
	FROM INDICADORES_REPORTES_SAMA 
	WHERE CD_COD_IRS = V_CD_COD_IRS;

	IF(V_EXISTE >= 1) THEN
		BEGIN
			UPDATE INDICADORES_REPORTES_SAMA 
			SET 
				MAYORCOSTO_IRS = V_MAYORCOSTO_IRS,
				CIE_IRS = V_CIE_IRS,
				MEDICO_FORMULA_IRS = V_MEDICO_FORMULA_IRS,
				MEDICO_FORMULA_COSTO_IRS = V_MEDICO_FORMULA_COSTO_IRS,
				PACIENTE_POLI_FORMULARIO_IRS = V_PACIENTE_POLI_FORMULARIO_IRS,
				COSTO_MES_IRS = V_COSTO_MES_IRS,
				CONSUMO_CONSULTA_PACIENTE_IRS = V_CONSUMO_CONS_PACI_IRS,
				PORCENTAJE_PENDIENTE_IRS = V_PORCENTAJE_PENDIENTE_IRS,
				VALOR_PENDIENTE_IRS = V_VALOR_PENDIENTE_IRS,
				ATEP_IRS = V_ATEP_IRS,
				SOAT_IRS = V_SOAT_IRS,
				ECAT_IRS = V_ECAT_IRS,
				PYP_IRS = V_PYP_IRS,
				NIVEL1_IRS = V_NIVEL1_IRS,
				NIVEL2_IRS = V_NIVEL2_IRS,
				NIVEL3_IRS = V_NIVEL3_IRS,
				ALTO_COSTO_IRS = V_ALTO_COSTO_IRS,
				CONCLUSION1_IRS = V_CONCLUSION1_IRS,
				CONCLUSION2_IRS = V_CONCLUSION2_IRS,
				CONCLUSION3_IRS = V_CONCLUSION3_IRS,
				CONCLUSION4_IRS = V_CONCLUSION4_IRS,
				CONCLUSION5_IRS = V_CONCLUSION5_IRS,
				DIFICULTAD1_IRS = V_DIFICULTAD1_IRS,
				DIFICULTAD2_IRS = V_DIFICULTAD2_IRS,
				DIFICULTAD3_IRS = V_DIFICULTAD3_IRS,
				DIFICULTAD4_IRS = V_DIFICULTAD4_IRS,
				DIFICULTAD5_IRS = V_DIFICULTAD5_IRS,
				SUGERENCIA1_IRS = V_SUGERENCIA1_IRS,
				SUGERENCIA2_IRS = V_SUGERENCIA2_IRS,
				SUGERENCIA3_IRS = V_SUGERENCIA3_IRS,
				SUGERENCIA4_IRS = V_SUGERENCIA4_IRS,
				SUGERENCIA5_IRS = V_SUGERENCIA5_IRS,
				AUDITOR_IRS = V_AUDITOR_IRS
			WHERE	CD_COD_IRS = V_CD_COD_IRS;
		END;

	ELSE
		BEGIN
			INSERT INTO INDICADORES_REPORTES_SAMA (
				MAYORCOSTO_IRS,	CIE_IRS,
				MEDICO_FORMULA_IRS,	MEDICO_FORMULA_COSTO_IRS,
				PACIENTE_POLI_FORMULARIO_IRS, COSTO_MES_IRS,
				CONSUMO_CONSULTA_PACIENTE_IRS,	PORCENTAJE_PENDIENTE_IRS,
				VALOR_PENDIENTE_IRS, ATEP_IRS,
				SOAT_IRS, ECAT_IRS,
				PYP_IRS, NIVEL1_IRS,
				NIVEL2_IRS, NIVEL3_IRS,
				ALTO_COSTO_IRS, CONCLUSION1_IRS,
				CONCLUSION2_IRS, CONCLUSION3_IRS,
				CONCLUSION4_IRS, CONCLUSION5_IRS,
				DIFICULTAD1_IRS, DIFICULTAD2_IRS,
				DIFICULTAD3_IRS, DIFICULTAD4_IRS,
				DIFICULTAD5_IRS, SUGERENCIA1_IRS,
				SUGERENCIA2_IRS, SUGERENCIA3_IRS,
				SUGERENCIA4_IRS, SUGERENCIA5_IRS,
				AUDITOR_IRS, NU_AUTO_INDI_HIST)
      		VALUES (
	  			V_MAYORCOSTO_IRS, V_CIE_IRS,
				V_MEDICO_FORMULA_IRS, V_MEDICO_FORMULA_COSTO_IRS,
				V_PACIENTE_POLI_FORMULARIO_IRS, V_COSTO_MES_IRS,
				V_CONSUMO_CONS_PACI_IRS, V_PORCENTAJE_PENDIENTE_IRS,
				V_VALOR_PENDIENTE_IRS, V_ATEP_IRS,
				V_SOAT_IRS, V_ECAT_IRS,
				V_PYP_IRS, V_NIVEL1_IRS,
				V_NIVEL2_IRS, V_NIVEL3_IRS,
				V_ALTO_COSTO_IRS, V_CONCLUSION1_IRS,
				V_CONCLUSION2_IRS, V_CONCLUSION3_IRS,
				V_CONCLUSION4_IRS, V_CONCLUSION5_IRS,
				V_DIFICULTAD1_IRS, V_DIFICULTAD2_IRS,
				V_DIFICULTAD3_IRS, V_DIFICULTAD4_IRS,
				V_DIFICULTAD5_IRS, V_SUGERENCIA1_IRS,
				V_SUGERENCIA2_IRS, V_SUGERENCIA3_IRS,
				V_SUGERENCIA4_IRS, V_SUGERENCIA5_IRS,
				V_AUDITOR_IRS, V_NUMEREPORHIS);
		END;
	END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;