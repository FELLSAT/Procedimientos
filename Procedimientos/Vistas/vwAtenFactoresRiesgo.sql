CREATE OR REPLACE VIEW vwAtenFactoresRiesgo
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS
		SELECT DISTINCT 
			CASE P.NU_TIPD_PAC 
				WHEN 0 THEN ('CC ' + P.NU_DOCU_PAC) 
				WHEN 1 THEN ('TI ' + P.NU_DOCU_PAC) 
				WHEN 2 THEN ('RC ' + P.NU_DOCU_PAC) 
				WHEN 3 THEN ('CE ' + P.NU_DOCU_PAC) 
				WHEN 4 THEN ('PA ' + P.NU_DOCU_PAC) 
				WHEN 5 THEN ('AS ' + P.NU_DOCU_PAC) 
				WHEN 6 THEN ('MS ' + P.NU_DOCU_PAC) 
				WHEN 7 THEN ('NU ' + P.NU_DOCU_PAC) 
			END NU_TIPD_PAC, 
			p.NU_DOCU_PAC, 
			P.TX_NOMBRECOMPLETO_PAC, 
			------------------------------------------------------
			NVL(
					(	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS')
						FROM (  SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS'), NU_NUME_PLHI_HICL, 
									NU_HIST_PAC
								FROM HISTORIACLINICA 
								INNER JOIN LABORATORIO 
									ON NU_NUME_LABO = NU_NUME_LABO_HICL 
								INNER JOIN MOVI_CARGOS 
									ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
								INNER JOIN PACIENTES 
									ON NU_HIST_PAC = NU_HIST_PAC_MOVI								
								ORDER BY FE_FECH_HICL DESC)
						WHERE NU_NUME_PLHI_HICL = 1778 
							AND NU_HIST_PAC = P.NU_HIST_PAC
							AND ROWNUM <= 1)
				, '') Perfil_Salud, 
			------------------------------------------------------
			NVL(
					(	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS')
						FROM (	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS'), NU_NUME_PLHI_HICL, 
									NU_HIST_PAC
								FROM HISTORIACLINICA 
								INNER JOIN LABORATORIO 
									ON NU_NUME_LABO = NU_NUME_LABO_HICL 
								INNER JOIN MOVI_CARGOS 
									ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
								INNER JOIN PACIENTES 
									ON NU_HIST_PAC = NU_HIST_PAC_MOVI								
								ORDER BY FE_FECH_HICL DESC)
						WHERE NU_NUME_PLHI_HICL = 1962
							AND NU_HIST_PAC = P.NU_HIST_PAC
							AND ROWNUM <= 1)
				, NVL(
						(	SELECT 
								CASE NU_ESTA_CIT 
									WHEN 0 THEN 'Asignada' 
									WHEN 1 THEN 'Asistio' 
									WHEN 2 THEN 'No_Asistio' 
									WHEN 3 THEN 'Asignada_normal' 
									WHEN 4 THEN 'Asignada_prioritaria'
									WHEN 5 THEN 'Asignada_reasignada' 
									WHEN 6 THEN 'Asistio_puntual' 
									WHEN 7 THEN 'Asistio_retardo' 
									WHEN 8 THEN 'Anulado' 
									WHEN 9 THEN 'Atentida' 
								END
							FROM CITAS_MEDICAS
							WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
								AND CD_CODI_ESP_CIT = 'MGE'
								AND ROWNUM <= 1)
						, '')
				) Examen_Medico, 
			------------------------------------------------------
			NVL(
					(	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS')
						FROM (	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS'), NU_NUME_PLHI_HICL, 
									NU_HIST_PAC
								FROM HISTORIACLINICA 
								INNER JOIN LABORATORIO 
									ON NU_NUME_LABO = NU_NUME_LABO_HICL 
								INNER JOIN MOVI_CARGOS 
									ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
								INNER JOIN PACIENTES 
									ON NU_HIST_PAC = NU_HIST_PAC_MOVI								
								ORDER BY FE_FECH_HICL DESC)
						WHERE NU_NUME_PLHI_HICL = 1507
							AND NU_HIST_PAC = P.NU_HIST_PAC
							AND ROWNUM <= 1)
				, NVL(
						(	SELECT 
								CASE NU_ESTA_CIT 
									WHEN 0 THEN 'Asignada' 
									WHEN 1 THEN 'Asistio' 
									WHEN 2 THEN 'No_Asistio' 
									WHEN 3 THEN 'Asignada_normal' 
									WHEN 4 THEN 'Asignada_prioritaria'
									WHEN 5 THEN 'Asignada_reasignada' 
									WHEN 6 THEN 'Asistio_puntual' 
									WHEN 7 THEN 'Asistio_retardo' 
									WHEN 8 THEN 'Anulado' 
									WHEN 9 THEN 'Atentida' 
								END
							FROM CITAS_MEDICAS 
							WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
								AND CD_CODI_ESP_CIT = 'FON'
								AND ROWNUM <= 1)
						, '')
				) Examen_Auditivo,
			------------------------------------------------------ 
			NVL(
					(	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS')
						FROM (	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS'), NU_NUME_PLHI_HICL, 
									NU_HIST_PAC
								FROM HISTORIACLINICA 
								INNER JOIN LABORATORIO 
									ON NU_NUME_LABO = NU_NUME_LABO_HICL 
								INNER JOIN MOVI_CARGOS 
									ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
								INNER JOIN PACIENTES 
									ON NU_HIST_PAC = NU_HIST_PAC_MOVI								
								ORDER BY FE_FECH_HICL DESC)
						WHERE NU_NUME_PLHI_HICL = 1638 
							AND NU_HIST_PAC = P.NU_HIST_PAC
							AND ROWNUM <= 1)
				, NVL(
						(	SELECT 
								CASE NU_ESTA_CIT 
									WHEN 0 THEN 'Asignada' 
									WHEN 1 THEN 'Asistio' 
									WHEN 2 THEN 'No_Asistio' 
									WHEN 3 THEN 'Asignada_normal' 
									WHEN 4 THEN 'Asignada_prioritaria'
									WHEN 5 THEN 'Asignada_reasignada' 
									WHEN 6 THEN 'Asistio_puntual' 
									WHEN 7 THEN 'Asistio_retardo' 
									WHEN 8 THEN 'Anulado' 
									WHEN 9 THEN 'Atentida' 
								END
							FROM CITAS_MEDICAS
							WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
								AND CD_CODI_ESP_CIT = '01'
								AND ROWNUM <= 1)
						, '')
				) Examen_Odontologico, 
			------------------------------------------------------
			NVL(
				(	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS')
					FROM (	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS'), NU_NUME_PLHI_HICL, 
									NU_HIST_PAC
							FROM HISTORIACLINICA 
							INNER JOIN LABORATORIO 
								ON NU_NUME_LABO = NU_NUME_LABO_HICL 
							INNER JOIN MOVI_CARGOS 
								ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
							INNER JOIN PACIENTES 
								ON NU_HIST_PAC = NU_HIST_PAC_MOVI							
							ORDER BY FE_FECH_HICL DESC)
					WHERE NU_NUME_PLHI_HICL = 1958 
						AND NU_HIST_PAC = P.NU_HIST_PAC
						AND ROWNUM <= 1)
				, NVL(
						(	SELECT
								CASE NU_ESTA_CIT 
									WHEN 0 THEN 'Asignada' 
									WHEN 1 THEN 'Asistio' 
									WHEN 2 THEN 'No_Asistio' 
									WHEN 3 THEN 'Asignada_normal' 
									WHEN 4 THEN 'Asignada_prioritaria'
									WHEN 5 THEN 'Asignada_reasignada' 
									WHEN 6 THEN 'Asistio_puntual' 
									WHEN 7 THEN 'Asistio_retardo' 
									WHEN 8 THEN 'Anulado' 
									WHEN 9 THEN 'Atentida' 
								END
							FROM CITAS_MEDICAS
							WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
								AND CD_CODI_ESP_CIT IN ('MPS', 'TSO', 'NUT', 'OPT')
								AND ROWNUM <= 1)
						, '')
				) Asesoria_Seguimiento_FR,
			------------------------------------------------------
			TX_CONVO_PAU, 
			TX_APERTURA_PAU		
		FROM HISTORIACLINICA 
		INNER JOIN LABORATORIO 
			ON LABORATORIO.NU_NUME_LABO = HISTORIACLINICA.NU_NUME_LABO_HICL 
		INNER JOIN MOVI_CARGOS 
			ON MOVI_CARGOS.NU_NUME_MOVI = LABORATORIO.NU_NUME_MOVI_LABO 
		INNER JOIN PACIENTES P 
			ON P.NU_HIST_PAC = MOVI_CARGOS.NU_HIST_PAC_MOVI 
		LEFT JOIN PACIENTES_ANEXO_UNAL PU 
			ON P.NU_HIST_PAC = PU.NU_HIST_PAC_PAU			
		WHERE NU_NUME_PLHI_HICL = 1778

	/* aumentando para recuperar los diligenciados por MIHIMS (Perfil) y los que tienen los otros diligenciados*/ 
	UNION ALL

		SELECT DISTINCT 
			CASE P.NU_TIPD_PAC
				WHEN 0 THEN ('CC ' + P.NU_DOCU_PAC) 
				WHEN 1 THEN ('TI ' + P.NU_DOCU_PAC) 
				WHEN 2 THEN ('RC ' + P.NU_DOCU_PAC) 
				WHEN 3 THEN ('CE ' + P.NU_DOCU_PAC) 
				WHEN 4 THEN ('PA ' + P.NU_DOCU_PAC) 
				WHEN 5 THEN ('AS ' + P.NU_DOCU_PAC) 
				WHEN 6 THEN ('MS ' + P.NU_DOCU_PAC) 
				WHEN 7 THEN ('NU ' + P.NU_DOCU_PAC) 
			END NU_TIPD_PAC, 
			p.NU_DOCU_PAC, 
			P.TX_NOMBRECOMPLETO_PAC, 
			------------------------------------------------------
			NVL(
					(	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS')
						FROM (	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS'), NU_NUME_PLHI_HICL, 
									NU_HIST_PAC
								FROM HISTORIACLINICA 
								INNER JOIN R_PAC_HICL_MIHIMS 
									ON NU_NUME_HICL = NU_NUME_HICL_RPACHICL 
								INNER JOIN PACIENTES 
									ON NU_HIST_PAC = NU_HIST_PAC_RPACHCL								
								ORDER BY FE_FECH_HICL DESC)
						WHERE NU_NUME_PLHI_HICL = 1778 
							AND NU_HIST_PAC = P.NU_HIST_PAC
							AND ROWNUM <= 1)
					, ''
				) Perfil_Salud, 
			------------------------------------------------------
			NVL(
					( 	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS')
						FROM (	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS'), NU_NUME_PLHI_HICL, 
									NU_HIST_PAC							
								FROM HISTORIACLINICA 
								INNER JOIN	LABORATORIO 
									ON NU_NUME_LABO = NU_NUME_LABO_HICL 
								INNER JOIN MOVI_CARGOS 
									ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
								INNER JOIN PACIENTES 
									ON NU_HIST_PAC = NU_HIST_PAC_MOVI								
								ORDER BY FE_FECH_HICL DESC)
						WHERE NU_NUME_PLHI_HICL = 1962 
							AND NU_HIST_PAC = P.NU_HIST_PAC
							AND ROWNUM <= 1)
				, NVL(
						(	SELECT 
								CASE NU_ESTA_CIT 
									WHEN 0 THEN 'Asignada' 
									WHEN 1 THEN 'Asistio' 
									WHEN 2 THEN 'No_Asistio' 
									WHEN 3 THEN 'Asignada_normal' 
									WHEN 4 THEN 'Asignada_prioritaria'
									WHEN 5 THEN 'Asignada_reasignada' 
									WHEN 6 THEN 'Asistio_puntual' 
									WHEN 7 THEN 'Asistio_retardo' 
									WHEN 8 THEN 'Anulado' 
									WHEN 9 THEN 'Atentida' 
								END
							FROM CITAS_MEDICAS
							WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
								AND CD_CODI_ESP_CIT = 'MGE'
								AND ROWNUM <= 1)
						, '')
				) Examen_Medico, 
			------------------------------------------------------
			NVL(
					(	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS')
						FROM (	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS'), NU_NUME_PLHI_HICL, 
									NU_HIST_PAC
								FROM HISTORIACLINICA 
								INNER JOIN LABORATORIO 
									ON NU_NUME_LABO = NU_NUME_LABO_HICL 
								INNER JOIN MOVI_CARGOS 
									ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
								INNER JOIN PACIENTES 
									ON NU_HIST_PAC = NU_HIST_PAC_MOVI								
								ORDER BY FE_FECH_HICL DESC)
						WHERE NU_NUME_PLHI_HICL = 1507 
							AND NU_HIST_PAC = P.NU_HIST_PAC
							AND ROWNUM <= 1)
				, NVL(
						(	SELECT  
								CASE NU_ESTA_CIT 
									WHEN 0 THEN 'Asignada' 
									WHEN 1 THEN 'Asistio' 
									WHEN 2 THEN 'No_Asistio' 
									WHEN 3 THEN 'Asignada_normal' 
									WHEN 4 THEN 'Asignada_prioritaria'
									WHEN 5 THEN 'Asignada_reasignada' 
									WHEN 6 THEN 'Asistio_puntual' 
									WHEN 7 THEN 'Asistio_retardo' 
									WHEN 8 THEN 'Anulado' 
									WHEN 9 THEN 'Atentida' 
								END
							FROM CITAS_MEDICAS
							WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
								AND CD_CODI_ESP_CIT = 'FON'
								AND ROWNUM <= 1)
						, '')
				) Examen_Auditivo, 
			------------------------------------------------------
			NVL(
					(	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS')
						FROM (	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS'), NU_NUME_PLHI_HICL, 
									NU_HIST_PAC
								FROM HISTORIACLINICA 
								INNER JOIN LABORATORIO 
									ON NU_NUME_LABO = NU_NUME_LABO_HICL 
								INNER JOIN MOVI_CARGOS 
									ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
								INNER JOIN PACIENTES 
									ON NU_HIST_PAC = NU_HIST_PAC_MOVI								
								ORDER BY FE_FECH_HICL DESC)
						WHERE NU_NUME_PLHI_HICL = 1638 
							AND NU_HIST_PAC = P.NU_HIST_PAC
							AND ROWNUM <= 1)	
				, NVL(
						(	SELECT  
								CASE NU_ESTA_CIT 
									WHEN 0 THEN 'Asignada' 
									WHEN 1 THEN 'Asistio' 
									WHEN 2 THEN 'No_Asistio' 
									WHEN 3 THEN 'Asignada_normal' 
									WHEN 4 THEN 'Asignada_prioritaria'
									WHEN 5 THEN 'Asignada_reasignada' 
									WHEN 6 THEN 'Asistio_puntual' 
									WHEN 7 THEN 'Asistio_retardo' 
									WHEN 8 THEN 'Anulado' 
									WHEN 9 THEN 'Atentida' 
								END
							FROM CITAS_MEDICAS
							WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
								AND CD_CODI_ESP_CIT = '01'
								AND ROWNUM <= 1)
						, '')
				) Examen_Odontologico, 
			------------------------------------------------------
			NVL(
					(	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYYy HH:MI:SS')
						FROM (	SELECT TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS'), NU_NUME_PLHI_HICL, 
									NU_HIST_PAC
								FROM HISTORIACLINICA 
								INNER JOIN LABORATORIO 
									ON NU_NUME_LABO = NU_NUME_LABO_HICL 
								INNER JOIN MOVI_CARGOS 
									ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
								INNER JOIN PACIENTES 
									ON NU_HIST_PAC = NU_HIST_PAC_MOVI								
								ORDER BY FE_FECH_HICL DESC)
						WHERE NU_NUME_PLHI_HICL = 1958 
							AND NU_HIST_PAC = P.NU_HIST_PAC
							AND ROWNUM <= 1)
				, NVL(
						(	SELECT  
								CASE NU_ESTA_CIT 
									WHEN 0 THEN 'Asignada' 
									WHEN 1 THEN 'Asistio' 
									WHEN 2 THEN 'No_Asistio' 
									WHEN 3 THEN 'Asignada_normal' 
									WHEN 4 THEN 'Asignada_prioritaria'
									WHEN 5 THEN 'Asignada_reasignada' 
									WHEN 6 THEN 'Asistio_puntual' 
									WHEN 7 THEN 'Asistio_retardo' 
									WHEN 8 THEN 'Anulado' 
									WHEN 9 THEN 'Atentida' 
								END
							FROM CITAS_MEDICAS
							WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
								AND CD_CODI_ESP_CIT IN ('MPS', 'TSO', 'NUT', 'OPT')
								AND ROWNUM <= 1)
						, '')
				) Asesoria_Seguimiento_FR,
			------------------------------------------------------	
			TX_CONVO_PAU, 
			TX_APERTURA_PAU		
		FROM HISTORIACLINICA 
		INNER JOIN R_PAC_HICL_MIHIMS 
			ON NU_NUME_HICL = NU_NUME_HICL_RPACHICL 
		INNER JOIN PACIENTES P 
			ON NU_HIST_PAC = NU_HIST_PAC_RPACHCL 
		INNER JOIN PACIENTES_ANEXO_UNAL PU 
			ON P.NU_HIST_PAC = PU.NU_HIST_PAC_PAU

	/* aumentando para recuperar los diligenciados por MIHIMS que no tienen nada mas diligenciado*/ 
	UNION ALL

		SELECT DISTINCT 
			CASE P.NU_TIPD_PAC 
				WHEN 0 THEN ('CC ' + P.NU_DOCU_PAC) 
				WHEN 1 THEN ('TI ' + P.NU_DOCU_PAC) 
				WHEN 2 THEN ('RC ' + P.NU_DOCU_PAC) 
				WHEN 3 THEN ('CE ' + P.NU_DOCU_PAC) 
				WHEN 4 THEN ('PA ' + P.NU_DOCU_PAC) 
				WHEN 5 THEN ('AS ' + P.NU_DOCU_PAC) 
				WHEN 6 THEN ('MS ' + P.NU_DOCU_PAC) 
				WHEN 7 THEN ('NU ' + P.NU_DOCU_PAC) 
			END NU_TIPD_PAC, 
			p.NU_DOCU_PAC, 
			P.TX_NOMBRECOMPLETO_PAC,
			TO_CHAR(FE_FECH_HICL, 'DD/MM/YYYY HH:MI:SS') Perfil_Salud,
			------------------------------------------------------ 
			NVL(
					(	SELECT 
							CASE NU_ESTA_CIT 
								WHEN 0 THEN 'Asignada' 
								WHEN 1 THEN 'Asistio' 
								WHEN 2 THEN 'No_Asistio' 
								WHEN 3 THEN 'Asignada_normal' 
								WHEN 4 THEN 'Asignada_prioritaria'
								WHEN 5 THEN 'Asignada_reasignada' 
								WHEN 6 THEN 'Asistio_puntual' 
								WHEN 7 THEN 'Asistio_retardo' 
								WHEN 8 THEN 'Anulado' 
								WHEN 9 THEN 'Atentida' 
							END
						FROM CITAS_MEDICAS
						WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
							AND CD_CODI_ESP_CIT = 'MGE'
							AND ROWNUM <= 1)
					, ''
				) Examen_Medico, 
			------------------------------------------------------
			NVL(
					(	SELECT 
							CASE NU_ESTA_CIT 
								WHEN 0 THEN 'Asignada' 
								WHEN 1 THEN 'Asistio' 
								WHEN 2 THEN 'No_Asistio' 
								WHEN 3 THEN 'Asignada_normal' 
								WHEN 4 THEN 'Asignada_prioritaria'
								WHEN 5 THEN 'Asignada_reasignada' 
								WHEN 6 THEN 'Asistio_puntual' 
								WHEN 7 THEN 'Asistio_retardo' 
								WHEN 8 THEN 'Anulado' 
								WHEN 9 THEN 'Atentida' 
							END
						FROM CITAS_MEDICAS
						WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
							AND CD_CODI_ESP_CIT = 'FON'
							AND ROWNUM <= 1)
					, ''
				) Examen_Auditivo, 
			------------------------------------------------------
			NVL(
					(	SELECT  
							CASE NU_ESTA_CIT 
								WHEN 0 THEN 'Asignada' 
								WHEN 1 THEN 'Asistio' 
								WHEN 2 THEN 'No_Asistio' 
								WHEN 3 THEN 'Asignada_normal' 
								WHEN 4 THEN 'Asignada_prioritaria'
								WHEN 5 THEN 'Asignada_reasignada' 
								WHEN 6 THEN 'Asistio_puntual' 
								WHEN 7 THEN 'Asistio_retardo' 
								WHEN 8 THEN 'Anulado' 
								WHEN 9 THEN 'Atentida' 
							END
						FROM CITAS_MEDICAS
						WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
							AND CD_CODI_ESP_CIT = '01'
							AND ROWNUM <= 1)
					, ''
				) Examen_Odontologico,
			------------------------------------------------------ 
			NVL(
					(	SELECT  
							CASE NU_ESTA_CIT 	
								WHEN 0 THEN 'Asignada' 
								WHEN 1 THEN 'Asistio' 
								WHEN 2 THEN 'No_Asistio' 
								WHEN 3 THEN 'Asignada_normal' 
								WHEN 4 THEN 'Asignada_prioritaria'
								WHEN 5 THEN 'Asignada_reasignada' 
								WHEN 6 THEN 'Asistio_puntual' 
								WHEN 7 THEN 'Asistio_retardo' 
								WHEN 8 THEN 'Anulado' 
								WHEN 9 THEN 'Atentida' 
							END
						FROM CITAS_MEDICAS
						WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
							AND CD_CODI_ESP_CIT IN ('MPS', 'TSO', 'NUT', 'OPT')
							AND ROWNUM <= 1)
					, ''
				) Asesoria_Seguimiento_FR, 
			------------------------------------------------------
			TX_CONVO_PAU, 
			TX_APERTURA_PAU
		FROM HISTORIACLINICA 
		INNER JOIN R_PAC_HICL_MIHIMS 
			ON NU_NUME_HICL = NU_NUME_HICL_RPACHICL 
		INNER JOIN PACIENTES P 
			ON NU_HIST_PAC = NU_HIST_PAC_RPACHCL 
		INNER JOIN PACIENTES_ANEXO_UNAL PU 
			ON P.NU_HIST_PAC = PU.NU_HIST_PAC_PAU
		WHERE NU_HIST_PAC NOT IN (	SELECT DISTINCT NU_HIST_PAC_MOVI AS NU_HIST_PAC
									FROM MOVI_CARGOS 
									INNER JOIN LABORATORIO 
										ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
									INNER JOIN HISTORIACLINICA 
										ON NU_NUME_LABO = NU_NUME_LABO_HICL 
									INNER JOIN PACIENTES_ANEXO_UNAL 
										ON NU_HIST_PAC_PAU = NU_HIST_PAC_MOVI
									WHERE NU_NUME_PLHI_HICL IN (1962, 1507, 1638, 1958))	
	
	UNION ALL
	/* AUMENTANDO PACIENTES DE LA CONVOCATORIA QUE NO HAYAN DILIGENCIADO*/ 
	
		SELECT DISTINCT 
			CASE P.NU_TIPD_PAC 
				WHEN 0 THEN ('CC ' + P.NU_DOCU_PAC) 
				WHEN 1 THEN ('TI ' + P.NU_DOCU_PAC) 
				WHEN 2 THEN ('RC ' + P.NU_DOCU_PAC) 
				WHEN 3 THEN ('CE ' + P.NU_DOCU_PAC) 
				WHEN 4 THEN ('PA ' + P.NU_DOCU_PAC) 
				WHEN 5 THEN ('AS ' + P.NU_DOCU_PAC) 
				WHEN 6 THEN ('MS ' + P.NU_DOCU_PAC) 
				WHEN 7 THEN ('NU ' + P.NU_DOCU_PAC) 
			END NU_TIPD_PAC, 
			p.NU_DOCU_PAC, 
			P.TX_NOMBRECOMPLETO_PAC, 
			'' Perfil_Salud, 
			------------------------------------------------------
			NVL(
					(	SELECT 
							CASE NU_ESTA_CIT 
								WHEN 0 THEN 'Asignada' 
								WHEN 1 THEN 'Asistio' 
								WHEN 2 THEN 'No_Asistio' 
								WHEN 3 THEN 'Asignada_normal' 
								WHEN 4 THEN 'Asignada_prioritaria'
								WHEN 5 THEN 'Asignada_reasignada' 
								WHEN 6 THEN 'Asistio_puntual' 
								WHEN 7 THEN 'Asistio_retardo' 
								WHEN 8 THEN 'Anulado' 
								WHEN 9 THEN 'Atentida' 
							END
						FROM CITAS_MEDICAS
						WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
							AND CD_CODI_ESP_CIT = 'MGE'
							AND ROWNUM <= 1)
					, ''
				) Examen_Medico, 
			------------------------------------------------------
			NVL(
					(	SELECT 
							CASE NU_ESTA_CIT 
								WHEN 0 THEN 'Asignada' 
								WHEN 1 THEN 'Asistio' 
								WHEN 2 THEN 'No_Asistio' 
								WHEN 3 THEN 'Asignada_normal' 
								WHEN 4 THEN 'Asignada_prioritaria'
								WHEN 5 THEN 'Asignada_reasignada' 
								WHEN 6 THEN 'Asistio_puntual' 
								WHEN 7 THEN 'Asistio_retardo' 
								WHEN 8 THEN 'Anulado' 
								WHEN 9 THEN 'Atentida' 
							END
						FROM CITAS_MEDICAS
						WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
							AND CD_CODI_ESP_CIT = 'FON'
							AND ROWNUM <= 1)
					, ''
				) Examen_Auditivo, 
			------------------------------------------------------
			NVL(
					(	SELECT
							CASE NU_ESTA_CIT 
								WHEN 0 THEN 'Asignada' 
								WHEN 1 THEN 'Asistio' 
								WHEN 2 THEN 'No_Asistio' 
								WHEN 3 THEN 'Asignada_normal' 
								WHEN 4 THEN 'Asignada_prioritaria'
								WHEN 5 THEN 'Asignada_reasignada' 
								WHEN 6 THEN 'Asistio_puntual' 
								WHEN 7 THEN 'Asistio_retardo' 
								WHEN 8 THEN 'Anulado' 
								WHEN 9 THEN 'Atentida' 
							END
						FROM CITAS_MEDICAS
						WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
							AND CD_CODI_ESP_CIT = '01'
							AND ROWNUM <= 1)
					, ''
				) Examen_Odontologico, 
			------------------------------------------------------
			NVL(
					(	SELECT 
							CASE NU_ESTA_CIT 
								WHEN 0 THEN 'Asignada' 
								WHEN 1 THEN 'Asistio' 
								WHEN 2 THEN 'No_Asistio' 
								WHEN 3 THEN 'Asignada_normal' 
								WHEN 4 THEN 'Asignada_prioritaria'
								WHEN 5 THEN 'Asignada_reasignada' 
								WHEN 6 THEN 'Asistio_puntual' 
								WHEN 7 THEN 'Asistio_retardo' 
								WHEN 8 THEN 'Anulado' 
								WHEN 9 THEN 'Atentida' 
							END
						FROM CITAS_MEDICAS
						WHERE NU_HIST_PAC_CIT = P.NU_HIST_PAC 
							AND CD_CODI_ESP_CIT IN ('MPS', 'TSO', 'NUT', 'OPT')
							AND ROWNUM <= 1)
					, ''
				) Asesoria_Seguimiento_FR,
			------------------------------------------------------
			TX_CONVO_PAU, 
			TX_APERTURA_PAU
		FROM PACIENTES P 
		INNER JOIN PACIENTES_ANEXO_UNAL PU 
			ON P.NU_HIST_PAC = PU.NU_HIST_PAC_PAU
		WHERE NU_HIST_PAC NOT IN (	SELECT DISTINCT NU_HIST_PAC_MOVI AS NU_HIST_PAC
									FROM MOVI_CARGOS 
									INNER JOIN LABORATORIO 
										ON NU_NUME_MOVI = NU_NUME_MOVI_LABO 
									INNER JOIN HISTORIACLINICA 
										ON NU_NUME_LABO = NU_NUME_LABO_HICL
									WHERE NU_NUME_PLHI_HICL IN (1778, 1962, 1507, 1638, 1958)) 
			AND NU_HIST_PAC NOT IN (SELECT DISTINCT NU_HIST_PAC_RPACHCL AS NU_HIST_PAC
									FROM R_PAC_HICL_MIHIMS);