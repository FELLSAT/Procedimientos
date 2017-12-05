CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_AGENDADIA_REEM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_MEDICO IN VARCHAR2,
	V_FECINICIAL IN DATE,
	V_FECFINAL IN DATE,
	CV_1 OUT SYS_REFCURSOR
)
AS
BEGIN
	INSERT INTO TT_TMPAGENDADIA
			SELECT FE_HORA_CIT,	NU_HIST_PAC, 
                DE_PRAP_PAC||' '||DE_SGAP_PAC||' '||NO_NOMB_PAC||' '||NO_SGNO_PAC AS NOMB_PAC,
                NU_TIPD_PAC, NU_DOCU_PAC,
                NU_SEXO_PAC, FE_NACI_PAC,
                DE_TELE_PAC, NU_ESTA_CIT,
                NO_NOMB_EPS, NO_NOMB_SER,
                MED_ORDE.NO_NOMB_MED, NO_NOMB_USUA,
                DE_DESC_CIT, NU_TIPO_CIT,
                NU_NUME_CIT, TX_OBSFIN_CIT, 
                NU_CONFIR_CIT, NU_NUME_MOVI_CIT, 
                FE_FECH_CIT, NU_DURA_CIT, 
                CD_CODI_SER_CIT, CD_CODI_ESP_CIT,
                TX_CAUSA_INASISTENCIA, CD_CODI_MEDI_EST_ACDE,
                (	SELECT DISTINCT NO_NOMB_MED 
                    FROM MEDICOS 
                    WHERE CD_CODI_MED = ACDE.CD_CODI_MEDI_EST_ACDE
                        AND ROWNUM = 1) AS NOM_EST_AUT,
                CD_CODI_MED_EST_CIT,
                (	SELECT DISTINCT NO_NOMB_MED 
                    FROM MEDICOS 
                    WHERE CD_CODI_MED = CITAS_MEDICAS.CD_CODI_MED_EST_CIT
                        AND ROWNUM = 1) AS NOM_EST_CITA,
                NU_NUME_IND_SER, -- ES SERVICIO PYP
                (	SELECT DISTINCT CD_CODI_PLANTILLA 
                    FROM R_SER_ACTI 
                    WHERE R_SER_ACTI.CD_CODI_SER_RSA = CD_CODI_SER
                        AND ROWNUM =1) AS CD_CODI_PLANTILLA -- PLANTILLA PYP SI FUE PARAMETRIZADA	
			FROM PACIENTES,	MEDICOS,
				CONVENIOS, EPS,
				SERVICIOS, CITAS_MEDICAS 
			LEFT JOIN MEDICOS MED_ORDE 
				ON CD_MEDI_ORDE_CIT = MED_ORDE.CD_CODI_MED
			LEFT JOIN ASIG_CITA_DOCENTE_ESTUDIANTE ACDE 
				ON ACDE.NU_NUME_CIT_ACDE = NU_NUME_CIT
			INNER JOIN CONEXIONES 
				ON NU_NUME_CONE_CIT = NU_NUME_CONE 
			LEFT JOIN USUARIOS 
				ON USUARIO = ID_IDEN_USUA
			WHERE	CD_CODI_MED_CIT = MEDICOS.CD_CODI_MED 
				AND NU_HIST_PAC_CIT = NU_HIST_PAC 
				AND NU_NUME_CONV_CIT = NU_NUME_CONV 
				AND CD_NIT_EPS_CONV = CD_NIT_EPS 
				AND CD_CODI_SER_CIT = CD_CODI_SER 
				AND FE_FECH_CIT >= V_FECINICIAL 
				AND FE_FECH_CIT <= V_FECFINAL
				AND ES_CITA_EXTRA = 0
				AND MEDICOS.CD_CODI_MED IN (SELECT CD_CODI_MED_ASIG_RMRH
											FROM R_MEDI_REEMP_HOGR
											WHERE NU_AUTO_HOGR_RMRH = NU_AUTO_HOGR_CIME 
												AND CD_CODI_MED_REEMP_RMRH = V_MEDICO
												AND FE_FECH_REEMP_RMRH = ((FE_FECH_CIT + (-TO_CHAR(FE_FECH_CIT,'HH')) / 24)) + (TO_CHAR(FE_FECH_CIT, 'MI')) / 1440)

		UNION ALL

			SELECT TB01.*, 
				TB02.NU_DURA_CIT , 
				CD_CODI_SER_CIT, 
				CD_CODI_ESP_CIT,
				TB02.TX_CAUSA_INASISTENCIA,
				ACDE.CD_CODI_MEDI_EST_ACDE,
				(	SELECT NO_NOMB_MED 
					FROM MEDICOS 
					WHERE CD_CODI_MED = ACDE.CD_CODI_MEDI_EST_ACDE) AS NOM_EST_AUT,
				CD_CODI_MED_EST_CIT,
				(	SELECT DISTINCT NO_NOMB_MED 
					FROM MEDICOS 
					WHERE CD_CODI_MED = TB02.CD_CODI_MED_EST_CIT
						AND ROWNUM = 1) AS NOM_EST_CITA,
				(	SELECT DISTINCT NU_NUME_IND_SER 
					FROM SERVICIOS 
					WHERE CD_CODI_SER_CIT = CD_CODI_SER
						AND ROWNUM = 1) AS NU_NUME_IND_SER, -- ES SERVICIO PYP
				(	SELECT DISTINCT CD_CODI_PLANTILLA 
					FROM R_SER_ACTI 
					WHERE R_SER_ACTI.CD_CODI_SER_RSA = CD_CODI_SER_CIT
						AND ROWNUM = 1) AS CD_CODI_PLANTILLA -- PLANTILLA PYP SI FUE PARAMETRIZADA
			FROM TABLE(FN_LISTACARGOSCONFIRMADOS(V_MEDICO,V_FECINICIAL,V_FECFINAL)) TB01
			INNER JOIN CITAS_MEDICAS TB02 
				ON TB01.NU_NUME_LABO = TB02.NU_NUME_CIT
			LEFT JOIN ASIG_CITA_DOCENTE_ESTUDIANTE ACDE 
				ON ACDE.NU_NUME_CIT_ACDE = TB02.NU_NUME_CIT
			WHERE ES_CITA_EXTRA = 0;
	

	OPEN CV_1 FOR
		SELECT	FE_HORA_CIT, NU_HIST_PAC, 
			SUM(NU_DURA_CIT) AS DURACION,
			NOMB_PAC, NU_TIPD_PAC,
			NU_DOCU_PAC, NU_SEXO_PAC,
			FE_NACI_PAC, DE_TELE_PAC,
			NU_ESTA_CIT, NO_NOMB_EPS,
			NO_NOMB_SER, NO_NOMB_MED,
			NO_NOMB_USUA, DE_DESC_CIT,
			NU_TIPO_CIT, CAST(MIN(NU_NUME_CIT) AS NUMBER) AS NU_NUME_CIT,
			TX_OBSFIN_CIT, NU_CONFIR_CIT, 
			CAST(MIN(NU_NUME_MOVI_CIT) AS NUMBER) AS NU_NUME_MOVI_CIT, 
			FE_FECH_CIT, CD_CODI_SER_CIT,
			CD_CODI_ESP_CIT, NO_NOMB_ESP,
			TX_CAUSA_INASISTENCIA,
			CAST(MIN(NVL(NU_NUME_LABO, 0)) AS NUMBER) AS NU_NUME_LABO,
			CD_CODI_MEDI_EST_ACDE, NOM_EST_AUT,
			CD_CODI_MED_EST_CIT, NOM_EST_CITA,
			NU_NUME_IND_SER, -- ES SERVICIO PYP
			CD_CODI_PLANTILLA -- PLANTILLA PYP SI FUE PARAMETRIZADA
		FROM TT_TMPAGENDADIA	 
		INNER JOIN ESPECIALIDADES 
			ON CD_CODI_ESP_CIT = CD_CODI_ESP
		LEFT JOIN LABORATORIO 
			ON NU_NUME_MOVI_CIT = NU_NUME_MOVI_LABO
		GROUP BY FE_HORA_CIT, NU_HIST_PAC, 
			NOMB_PAC, NU_TIPD_PAC,
			NU_DOCU_PAC,NU_SEXO_PAC,
			FE_NACI_PAC,DE_TELE_PAC,
			NU_ESTA_CIT,NO_NOMB_EPS,
			NO_NOMB_SER,NO_NOMB_MED,
			NO_NOMB_USUA,DE_DESC_CIT,
			NU_TIPO_CIT,TX_OBSFIN_CIT, 
			NU_CONFIR_CIT, FE_FECH_CIT, 
			CD_CODI_SER_CIT, CD_CODI_ESP_CIT, 
			NO_NOMB_ESP, TX_CAUSA_INASISTENCIA, 
			CD_CODI_MEDI_EST_ACDE, NOM_EST_AUT, 
			CD_CODI_MED_EST_CIT, NOM_EST_CITA, 
			NU_NUME_IND_SER, CD_CODI_PLANTILLA
		ORDER BY NU_TIPO_CIT ASC, FE_FECH_CIT, 
			FE_HORA_CIT;
END;