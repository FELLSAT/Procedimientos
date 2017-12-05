CREATE OR REPLACE PROCEDURE H3i_SP_CALC_TOD_INDI_OPORTUN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	iv_fechaInicial IN DATE,
	iv_fechaFinal IN DATE,
	CV_1 OUT SYS_REFCURSOR
)

AS
	V_FechaInicial DATE := iv_fechaInicial;
	V_FechaFinal DATE := iv_fechaFinal;
BEGIN	
	IF V_FechaInicial IS NULL THEN
		BEGIN
			V_FechaInicial := ADD_MONTHS(SYSDATE,-6);
		END;
	END IF;
	
	IF V_FechaFinal IS NULL THEN
		BEGIN
			V_FechaFinal := SYSDATE;
		END;
	END IF;	


	OPEN CV_1 FOR
		-- Proceso de calculo para especialidad medica Oftalmologia
		SELECT	concat('Oportunidad de la asignación de citas en ',E.NO_NOMB_ESP)  Titulo,
			NVL(SUM(TO_CHAR(CM.FE_FECH_CIT,'DD') - TO_CHAR(CM.FE_ELAB_CIT,'DD')),0) AS Numerador,
			COUNT(DISTINCT CM.NU_NUME_CIT) AS Denominador,
			NVL(SUM(TO_CHAR(CM.FE_FECH_CIT,'DD') - TO_CHAR(CM.FE_ELAB_CIT,'DD')) / 
					CASE	COUNT(DISTINCT CM.NU_NUME_CIT) 
						WHEN 0 THEN 
							0
						ELSE 
							CAST(COUNT(DISTINCT CM.NU_NUME_CIT) AS NUMERIC(4,0))
					END
				,0) AS Indicador
		FROM CITAS_MEDICAS CM 
		INNER JOIN SERVICIOS S 
			ON CM.CD_CODI_SER_CIT = S.CD_CODI_SER
		LEFT JOIN ESPECIALIDADES E 
			ON CM.CD_CODI_ESP_CIT = E.CD_CODI_ESP
		WHERE CM.FE_FECH_CIT BETWEEN V_FechaInicial AND V_FechaFinal
		AND	S.NU_OPCI_SER = 1
		GROUP BY E.NO_NOMB_ESP;
		
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;