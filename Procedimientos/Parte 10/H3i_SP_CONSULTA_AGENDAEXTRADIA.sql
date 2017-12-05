CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_AGENDAEXTRADIA
(
  v_MEDICO IN VARCHAR2,
  v_FECINICIAL IN DATE,
  v_FECFINAL IN DATE,
  v_ESESTUDIANTE IN NUMBER,
  cv_1 OUT SYS_REFCURSOR,
  cv_2 OUT SYS_REFCURSOR
)
AS

BEGIN

   DELETE FROM tt_TMPAGENDADIA_3;
   UTILS.IDENTITY_RESET('tt_TMPAGENDADIA_3');
   
   INSERT INTO tt_TMPAGENDADIA_3 ( 
   	SELECT FE_HORA_CIT ,
           NU_HIST_PAC ,
           DE_PRAP_PAC || ' ' || DE_SGAP_PAC || ' ' || NO_NOMB_PAC || ' ' || NO_SGNO_PAC NOMB_PAC  ,
           NU_TIPD_PAC ,
           NU_DOCU_PAC ,
           NU_SEXO_PAC ,
           FE_NACI_PAC ,
           DE_TELE_PAC ,
           NU_ESTA_CIT ,
           NO_NOMB_EPS ,
           NO_NOMB_SER ,
           MED_ORDE.NO_NOMB_MED ,
           NO_NOMB_USUA ,
           DE_DESC_CIT ,
           NU_TIPO_CIT ,
           NU_NUME_CIT ,
           TX_OBSFIN_CIT ,
           NU_CONFIR_CIT ,
           NU_NUME_MOVI_CIT ,
           FE_FECH_CIT ,
           NU_DURA_CIT ,
           CD_CODI_SER_CIT ,
           CD_CODI_ESP_CIT ,
           TX_CAUSA_INASISTENCIA ,
           CD_CODI_MEDI_EST_ACDE ,
           ( SELECT NO_NOMB_MED 
             FROM MEDICOS 
              WHERE  CD_CODI_MED = ACDE.CD_CODI_MEDI_EST_ACDE ) NOM_EST_AUT  ,
           CD_CODI_MED_EST_CIT ,
           ( SELECT NO_NOMB_MED 
             FROM MEDICOS 
              WHERE  CD_CODI_MED = CITAS_MEDICAS.CD_CODI_MED_EST_CIT ) NOM_EST_CITA  ,
           NU_NUME_IND_SER ,-- ES SERVICIO PYP

           ( SELECT CD_CODI_PLANTILLA 
             FROM R_SER_ACTI 
              WHERE  R_SER_ACTI.CD_CODI_SER_RSA = CD_CODI_SER ) CD_CODI_PLANTILLA -- PLANTILLA PYP SI FUE PARAMETRIZADA
             
   	  FROM PACIENTES ,
           MEDICOS ,
           CONVENIOS ,
           EPS ,
           SERVICIOS ,
           CITAS_MEDICAS 
             LEFT JOIN MEDICOS MED_ORDE   ON CD_MEDI_ORDE_CIT = MED_ORDE.CD_CODI_MED
             LEFT JOIN ASIG_CITA_DOCENTE_ESTUDIANTE ACDE   ON ACDE.NU_NUME_CIT_ACDE = NU_NUME_CIT
             INNER JOIN CONEXIONES    ON NU_NUME_CONE_CIT = NU_NUME_CONE
             LEFT JOIN USUARIOS    ON USUARIO = ID_IDEN_USUA
   	 WHERE  CD_CODI_MED_CIT = MEDICOS.CD_CODI_MED
              AND NU_HIST_PAC_CIT = NU_HIST_PAC
              AND FE_FECH_CIT >= v_FECINICIAL
              AND FE_FECH_CIT <= v_FECFINAL
              AND MEDICOS.CD_CODI_MED = v_MEDICO
              
              -- Se aumenta para filtrar por especialidad.
              AND CD_CODI_ESP_CIT IN ( SELECT CD_CODI_ESP_RMP CD_CODI_ESP_LABO  
                                       FROM R_MEDI_ESPE 
                                        WHERE  CD_CODI_MED_RMP = v_MEDICO
                                                 AND NU_ESTADO_RMP = 1 )

              AND NU_NUME_CONV_CIT = NU_NUME_CONV
              AND CD_NIT_EPS_CONV = CD_NIT_EPS
              AND CD_CODI_SER_CIT = CD_CODI_SER
              AND ES_CITA_EXTRA = 1
   	UNION ALL 
   	SELECT TB01.* ,
           TB02.NU_DURA_CIT ,
           CD_CODI_SER_CIT ,
           CD_CODI_ESP_CIT ,
           TB02.TX_CAUSA_INASISTENCIA ,
           ACDE.CD_CODI_MEDI_EST_ACDE ,
           ( SELECT NO_NOMB_MED 
             FROM MEDICOS 
              WHERE  CD_CODI_MED = ACDE.CD_CODI_MEDI_EST_ACDE ) NOM_EST_AUT  ,
           CD_CODI_MED_EST_CIT ,
           ( SELECT NO_NOMB_MED 
             FROM MEDICOS 
              WHERE  CD_CODI_MED = TB02.CD_CODI_MED_EST_CIT ) NOM_EST_CITA  ,
           ( SELECT NU_NUME_IND_SER 
             FROM SERVICIOS 
              WHERE  CD_CODI_SER_CIT = CD_CODI_SER ) NU_NUME_IND_SER ,-- ES SERVICIO PYP

           ( SELECT CD_CODI_PLANTILLA 
             FROM R_SER_ACTI 
              WHERE  R_SER_ACTI.CD_CODI_SER_RSA = CD_CODI_SER_CIT ) CD_CODI_PLANTILLA -- PLANTILLA PYP SI FUE PARAMETRIZADA
             
   	  FROM TABLE(FN_LISTACARGOSCONFIRMADOS(v_MEDICO, v_FECINICIAL, v_FECFINAL)) TB01
             INNER JOIN CITAS_MEDICAS TB02   ON TB01.NU_NUME_LABO = TB02.NU_NUME_CIT
             LEFT JOIN ASIG_CITA_DOCENTE_ESTUDIANTE ACDE   ON ACDE.NU_NUME_CIT_ACDE = TB02.NU_NUME_CIT
   	 WHERE  ES_CITA_EXTRA = 1 );
   OPEN  cv_1 FOR
      SELECT FE_HORA_CIT ,--MIN(SUBSTRING(FE_HORA_CIT,12,LEN(FE_HORA_CIT)-10)) AS FE_HORA_CIT, 

             NU_HIST_PAC ,
             SUM(NU_DURA_CIT)  DURACION  ,
             NOMB_PAC ,
             NU_TIPD_PAC ,
             NU_DOCU_PAC ,
             NU_SEXO_PAC ,
             FE_NACI_PAC ,
             DE_TELE_PAC ,
             NU_ESTA_CIT ,
             NO_NOMB_EPS ,
             NO_NOMB_SER ,
             NO_NOMB_MED ,
             NO_NOMB_USUA ,
             DE_DESC_CIT ,
             NU_TIPO_CIT ,
             UTILS.CONVERT_TO_NUMBER(MIN(NU_NUME_CIT) ,19,0) NU_NUME_CIT  ,
             TX_OBSFIN_CIT ,
             NU_CONFIR_CIT ,
             UTILS.CONVERT_TO_NUMBER(MIN(NU_NUME_MOVI_CIT) ,19,0) NU_NUME_MOVI_CIT  ,
             FE_FECH_CIT ,
             CD_CODI_SER_CIT ,
             CD_CODI_ESP_CIT ,
             NO_NOMB_ESP ,
             TX_CAUSA_INASISTENCIA ,
             UTILS.CONVERT_TO_NUMBER(MIN(NVL(NU_NUME_LABO, 0)) ,19,0) NU_NUME_LABO  ,
             CD_CODI_MEDI_EST_ACDE ,
             NOM_EST_AUT ,
             CD_CODI_MED_EST_CIT ,
             NOM_EST_CITA ,
             NU_NUME_IND_SER ,-- ES SERVICIO PYP

             CD_CODI_PLANTILLA -- PLANTILLA PYP SI FUE PARAMETRIZADA
              
        FROM tt_TMPAGENDADIA_3 
               INNER JOIN ESPECIALIDADES    ON CD_CODI_ESP_CIT = CD_CODI_ESP
               LEFT JOIN LABORATORIO    ON NU_NUME_MOVI_CIT = NU_NUME_MOVI_LABO
        GROUP BY FE_HORA_CIT,NU_HIST_PAC,NOMB_PAC,NU_TIPD_PAC,NU_DOCU_PAC,NU_SEXO_PAC,FE_NACI_PAC,DE_TELE_PAC,NU_ESTA_CIT,NO_NOMB_EPS,NO_NOMB_SER,NO_NOMB_MED,NO_NOMB_USUA,DE_DESC_CIT,NU_TIPO_CIT,TX_OBSFIN_CIT,NU_CONFIR_CIT,FE_FECH_CIT,CD_CODI_SER_CIT,CD_CODI_ESP_CIT,NO_NOMB_ESP,TX_CAUSA_INASISTENCIA,CD_CODI_MEDI_EST_ACDE,NOM_EST_AUT,CD_CODI_MED_EST_CIT,NOM_EST_CITA,NU_NUME_IND_SER,CD_CODI_PLANTILLA
        ORDER BY NU_TIPO_CIT ASC,
                 FE_FECH_CIT,
                 FE_HORA_CIT ;
   IF ( v_ESESTUDIANTE = 1 ) THEN
    
   BEGIN
      DELETE FROM tt_TMPAGENDADIA2_3;
      UTILS.IDENTITY_RESET('tt_TMPAGENDADIA2_3');
      
      INSERT INTO tt_TMPAGENDADIA2_3 ( 
      	SELECT FE_HORA_CIT ,
              NU_HIST_PAC ,
              DE_PRAP_PAC || ' ' || DE_SGAP_PAC || ' ' || NO_NOMB_PAC || ' ' || NO_SGNO_PAC NOMB_PAC  ,
              NU_TIPD_PAC ,
              NU_DOCU_PAC ,
              NU_SEXO_PAC ,
              FE_NACI_PAC ,
              DE_TELE_PAC ,
              NU_ESTA_CIT ,
              NO_NOMB_EPS ,
              NO_NOMB_SER ,
              MED_ORDE.NO_NOMB_MED ,
              NO_NOMB_USUA ,
              DE_DESC_CIT ,
              NU_TIPO_CIT ,
              NU_NUME_CIT ,
              TX_OBSFIN_CIT ,
              NU_CONFIR_CIT ,
              NU_NUME_MOVI_CIT ,
              FE_FECH_CIT ,
              NU_DURA_CIT ,
              CD_CODI_SER_CIT ,
              CD_CODI_ESP_CIT ,
              TX_CAUSA_INASISTENCIA ,
              ACDE.CD_CODI_MEDI_EST_ACDE ,
              ( SELECT NO_NOMB_MED 
                FROM MEDICOS 
                 WHERE  CD_CODI_MED = ACDE.CD_CODI_MEDI_EST_ACDE ) NOM_EST_AUT  ,
              CD_CODI_MED_EST_CIT ,
              ( SELECT NO_NOMB_MED 
                FROM MEDICOS 
                 WHERE  CD_CODI_MED = CITAS_MEDICAS.CD_CODI_MED_EST_CIT ) NOM_EST_CITA  ,
              NU_NUME_IND_SER ,-- ES SERVICIO PYP

              ( SELECT CD_CODI_PLANTILLA 
                FROM R_SER_ACTI 
                 WHERE  R_SER_ACTI.CD_CODI_SER_RSA = CD_CODI_SER ) CD_CODI_PLANTILLA -- PLANTILLA PYP SI FUE PARAMETRIZADA
                
      	  FROM PACIENTES ,
              MEDICOS ,
              CONVENIOS ,
              EPS ,
              CONEXIONES ,
              USUARIOS ,
              SERVICIOS ,
              CITAS_MEDICAS 
                LEFT JOIN MEDICOS MED_ORDE   ON CD_MEDI_ORDE_CIT = MED_ORDE.CD_CODI_MED
                LEFT JOIN ASIG_CITA_DOCENTE_ESTUDIANTE ACDE   ON ACDE.NU_NUME_CIT_ACDE = NU_NUME_CIT
      	 WHERE  CD_CODI_MED_CIT = MEDICOS.CD_CODI_MED
                 AND NU_HIST_PAC_CIT = NU_HIST_PAC
                 AND FE_FECH_CIT >= v_FECINICIAL
                 AND FE_FECH_CIT <= v_FECFINAL
                 
                 --	AND		MEDICOS.CD_CODI_MED = @MEDICO 
                 AND NU_NUME_CONV_CIT = NU_NUME_CONV
                 AND CD_NIT_EPS_CONV = CD_NIT_EPS
                 AND NU_NUME_CONE_CIT = NU_NUME_CONE
                 AND USUARIO = ID_IDEN_USUA
                 AND CD_CODI_SER_CIT = CD_CODI_SER
                 AND CD_CODI_MED_EST_CIT = v_MEDICO
                 AND ES_CITA_EXTRA = 1
      	UNION ALL 
      	SELECT TB01.* ,
              TB02.NU_DURA_CIT ,
              CD_CODI_SER_CIT ,
              CD_CODI_ESP_CIT ,
              TB02.TX_CAUSA_INASISTENCIA ,
              CD_CODI_MEDI_EST_ACDE ,
              ( SELECT NO_NOMB_MED 
                FROM MEDICOS 
                 WHERE  CD_CODI_MED = ACDE.CD_CODI_MEDI_EST_ACDE ) NOM_EST_AUT  ,
              CD_CODI_MED_EST_CIT ,
              ( SELECT NO_NOMB_MED 
                FROM MEDICOS 
                 WHERE  CD_CODI_MED = TB02.CD_CODI_MED_EST_CIT ) NOM_EST_CITA  ,
              ( SELECT NU_NUME_IND_SER 
                FROM SERVICIOS 
                 WHERE  CD_CODI_SER_CIT = CD_CODI_SER ) NU_NUME_IND_SER ,-- ES SERVICIO PYP

              ( SELECT CD_CODI_PLANTILLA 
                FROM R_SER_ACTI 
                 WHERE  R_SER_ACTI.CD_CODI_SER_RSA = CD_CODI_SER_CIT ) CD_CODI_PLANTILLA -- PLANTILLA PYP SI FUE PARAMETRIZADA
                
      	  FROM TABLE(FN_LISTACARGOSCONFIRMADOS(v_MEDICO, v_FECINICIAL, v_FECFINAL)) TB01
                JOIN CITAS_MEDICAS TB02   ON TB01.NU_NUME_LABO = TB02.NU_NUME_CIT
                LEFT JOIN ASIG_CITA_DOCENTE_ESTUDIANTE ACDE   ON ACDE.NU_NUME_CIT_ACDE = NU_NUME_CIT
      	 WHERE  ES_CITA_EXTRA = 1 );
      OPEN  cv_2 FOR
         SELECT FE_HORA_CIT ,--MIN(SUBSTRING(FE_HORA_CIT,12,LEN(FE_HORA_CIT)-10)) AS FE_HORA_CIT, 

                NU_HIST_PAC ,
                SUM(NU_DURA_CIT)  DURACION  ,
                NOMB_PAC ,
                NU_TIPD_PAC ,
                NU_DOCU_PAC ,
                NU_SEXO_PAC ,
                FE_NACI_PAC ,
                DE_TELE_PAC ,
                NU_ESTA_CIT ,
                NO_NOMB_EPS ,
                NO_NOMB_SER ,
                NO_NOMB_MED ,
                NO_NOMB_USUA ,
                DE_DESC_CIT ,
                NU_TIPO_CIT ,
                UTILS.CONVERT_TO_NUMBER(MIN(NU_NUME_CIT) ,19,0) NU_NUME_CIT  ,
                TX_OBSFIN_CIT ,
                NU_CONFIR_CIT ,
                UTILS.CONVERT_TO_NUMBER(MIN(NU_NUME_MOVI_CIT) ,19,0) NU_NUME_MOVI_CIT  ,
                FE_FECH_CIT ,
                CD_CODI_SER_CIT ,
                CD_CODI_ESP_CIT ,
                NO_NOMB_ESP ,
                TX_CAUSA_INASISTENCIA ,
                UTILS.CONVERT_TO_NUMBER(MIN(NVL(NU_NUME_LABO, 0)) ,19,0) NU_NUME_LABO  ,
                CD_CODI_MEDI_EST_ACDE ,
                NOM_EST_AUT ,
                CD_CODI_MED_EST_CIT ,
                NOM_EST_CITA ,
                NU_NUME_IND_SER ,-- ES SERVICIO PYP

                CD_CODI_PLANTILLA -- PLANTILLA PYP SI FUE PARAMETRIZADA
                 
           FROM tt_TMPAGENDADIA2_3 
                  JOIN ESPECIALIDADES    ON CD_CODI_ESP_CIT = CD_CODI_ESP
                  LEFT JOIN LABORATORIO    ON NU_NUME_MOVI_CIT = NU_NUME_MOVI_LABO
           GROUP BY FE_HORA_CIT,NU_HIST_PAC,NOMB_PAC,NU_TIPD_PAC,NU_DOCU_PAC,NU_SEXO_PAC,FE_NACI_PAC,DE_TELE_PAC,NU_ESTA_CIT,NO_NOMB_EPS,NO_NOMB_SER,NO_NOMB_MED,NO_NOMB_USUA,DE_DESC_CIT,NU_TIPO_CIT,TX_OBSFIN_CIT,NU_CONFIR_CIT,FE_FECH_CIT,CD_CODI_SER_CIT,CD_CODI_ESP_CIT,NO_NOMB_ESP,TX_CAUSA_INASISTENCIA,CD_CODI_MEDI_EST_ACDE,NOM_EST_AUT,CD_CODI_MED_EST_CIT,NOM_EST_CITA,NU_NUME_IND_SER,CD_CODI_PLANTILLA
           ORDER BY NU_TIPO_CIT ASC,
                    FE_FECH_CIT,
                    FE_HORA_CIT ;
   
   END;
   END IF;

EXCEPTION WHEN OTHERS THEN utils.handleerror(SQLCODE,SQLERRM);
END;