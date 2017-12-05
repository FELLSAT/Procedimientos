CREATE OR REPLACE PROCEDURE H3i_SP_CONS_AGEN_CITAS_INASIS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
 (
 	V_FECHAINICIAL IN DATE,
	V_FECHAFINAL IN DATE,
	V_NUMHIST IN VARCHAR2 DEFAULT NULL,
	V_CODMEDICO IN VARCHAR2 DEFAULT NULL,
	V_CODESP IN VARCHAR2 DEFAULT NULL,
	CV_1 OUT SYS_REFCURSOR
)
AS
BEGIN
	OPEN CV_1 FOR 
		SELECT CD_CODI_MED_CIT,
			CD_CODI_SER_CIT,
			NU_HIST_PAC_CIT,
			NU_DURA_CIT,
			FE_ELAB_CIT,
			FE_FECH_CIT,
			NU_DIA_CIT,
			TO_NUMBER(NU_NUME_MOVI_CIT) NU_NUME_MOVI_CIT,
			TO_NUMBER(NU_PRIM_CIT) NU_PRIM_CIT,
			FE_HORA_CIT,
			TO_NUMBER(NU_ESTA_CIT) NU_ESTA_CIT,
			TO_NUMBER(NU_NUME_CONE_CIT) NU_NUME_CONE_CIT,
			NU_CONE_CALL_CIT,
			CD_CODI_ESP_CIT,
			CD_CODI_CONS_CIT,
			TO_NUMBER(NU_NUME_CONV_CIT) NU_NUME_CONV_CIT,
			TO_NUMBER(NU_TIPO_CIT) NU_TIPO_CIT,
			DE_DESC_CIT,
			TO_NUMBER(CM.NU_NUME_CIT) NU_NUME_CIT,
			CD_MEDI_ORDE_CIT,
			TO_NUMBER(NU_CONFIR_CIT) NU_CONFIR_CIT,
			NO_NOMB_SER,
			NO_NOMB_ESP,
			NU_OPCI_SER, 
			NU_NIVE_SER,
			NU_ESGRUPAL_SER,
			CASE CD_CODI_MED_EST_CIT 
				WHEN NULL THEN 
					''
				ELSE(	SELECT NO_NOMB_MED
						FROM MEDICOS
						WHERE CD_CODI_MED = CD_CODI_MED_EST_CIT) 
			END AS NOM_ESTUD,
			CASE ACDE.CD_CODI_MEDI_EST_ACDE 
				WHEN NULL THEN 
					''
				ELSE(	SELECT NO_NOMB_MED
						FROM MEDICOS
						WHERE CD_CODI_MED = ACDE.CD_CODI_MEDI_EST_ACDE) 
			END AS NOM_ESTUD_ASIG,
			NVL(CC.NU_NUME_CC, -1) AS CONFIRMACION,
			CM.TX_CAUSA_INASISTENCIA,
			CX.USUARIO AS CAJERO
		FROM CITAS_MEDICAS CM 
		INNER JOIN SERVICIOS 
			ON CD_CODI_SER_CIT = CD_CODI_SER
		INNER JOIN ESPECIALIDADES 
			ON CD_CODI_ESP = CD_CODI_ESP_CIT			
		INNER JOIN CONEXIONES CX 
			ON CX.NU_NUME_CONE = CM.NU_NUME_CONE_CIT
		LEFT JOIN CITAS_CONFIRMADAS CC 
			ON CM.NU_NUME_CIT = CC.NU_NUME_CIT
		LEFT JOIN ASIG_CITA_DOCENTE_ESTUDIANTE ACDE 
			ON ACDE.NU_NUME_CIT_ACDE = CM.NU_NUME_CIT	
		WHERE FE_FECH_CIT BETWEEN V_FECHAINICIAL AND V_FECHAFINAL
			AND	NU_ESTA_CIT = 2	 	
			AND	CD_CODI_MED_CIT = NVL(V_CODMEDICO, CD_CODI_MED_CIT)
			AND	CD_CODI_ESP = NVL(V_CODESP, CD_CODI_ESP)
			AND	NU_HIST_PAC_CIT = NVL(V_NUMHIST, NU_HIST_PAC_CIT)
		ORDER	BY FE_FECH_CIT;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;