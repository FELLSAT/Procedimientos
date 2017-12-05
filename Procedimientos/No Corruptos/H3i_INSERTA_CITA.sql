CREATE OR REPLACE PROCEDURE HIMS.H3i_INSERTA_CITA
-- =============================================      
-- Author:  Carlos Castro Agudelo
-- =============================================  
(v_CodMed IN VARCHAR2,
  v_CodSer IN VARCHAR2,
  v_HisPac IN VARCHAR2,
  v_Duracion IN NUMBER,
  v_FechaElaboraCita IN DATE,
  v_FechaCita IN DATE,
  v_NoMovimiento IN NUMBER,
  v_PrimeraCita IN NUMBER,
  v_FechaHoraCita_Texto IN VARCHAR2,
  v_EstadoCita IN NUMBER,
  v_NoConexion IN NUMBER,
  v_NoConexionCall IN NUMBER,
  v_CodEspe IN VARCHAR2,
  v_NoConsultorio IN VARCHAR2,
  v_NoConvenio IN NUMBER,
  v_TipoCita IN NUMBER,
  v_Descipcion IN VARCHAR2,
  v_CodMedOrdena IN VARCHAR2,
  v_DuracionServicio IN NUMBER,
  v_CodMedEst IN VARCHAR2,
  v_IDHorarioAcademico IN NUMBER,
  v_CD_CODI_DEPEND_CIT IN VARCHAR2)
IS
    v_NUMTUME NUMBER;
    
    CURSOR crTURNO IS 
    SELECT NU_NUME_TUME FROM TURNOS_MEDICOS 
    WHERE  EXTRACT(YEAR FROM FE_FECH_TUME) = EXTRACT(YEAR FROM v_FechaCita) AND EXTRACT(MONTH FROM FE_FECH_TUME) = EXTRACT(MONTH FROM v_FechaCita) 
    AND EXTRACT(DAY FROM FE_FECH_TUME) = EXTRACT(DAY FROM v_FechaCita) AND CD_MED_TUME = v_CODMED AND ID_DISP_TUME = 1;
BEGIN
    INSERT INTO CITAS_MEDICAS(CD_CODI_MED_CIT, CD_CODI_SER_CIT, NU_HIST_PAC_CIT, NU_DURA_CIT, FE_ELAB_CIT, FE_FECH_CIT, NU_NUME_MOVI_CIT, NU_PRIM_CIT, FE_HORA_CIT, NU_ESTA_CIT, NU_NUME_CONE_CIT, NU_CONE_CALL_CIT,
    CD_CODI_ESP_CIT, CD_CODI_CONS_CIT, NU_NUME_CONV_CIT, NU_TIPO_CIT, DE_DESC_CIT, CD_MEDI_ORDE_CIT, NU_DURA_DEFE_CIT, CD_CODI_MED_EST_CIT, NU_AUTO_HOGR_CIME, CD_CODI_DEPEND_CIT )
    VALUES ( v_CodMed, v_CodSer, v_HisPac, v_Duracion, TO_DATE(v_FechaElaboraCita,'dd/mm/yyyy'), TO_DATE(v_FechaCita,'dd/mm/yyyy'), v_NoMovimiento, v_PrimeraCita, v_FechaHoraCita_Texto, v_EstadoCita, v_NoConexion, v_NoConexionCall, v_CodEspe,
    v_NoConsultorio, v_NoConvenio, v_TipoCita, v_Descipcion, v_CodMedOrdena, v_DuracionServicio, v_CodMedEst, v_IDHorarioAcademico, v_CD_CODI_DEPEND_CIT );
    
    IF ( v_TipoCita = 0 ) THEN
        BEGIN
            OPEN crTURNO;
            FETCH crTURNO INTO v_NUMTUME; 
            LOOP 
            EXIT WHEN crTURNO%FOUND;
                BEGIN
                    H3i_SP_ACT_CITASDISPONIBLES(v_NUMTUME) ;
                    FETCH crTURNO INTO v_NUMTUME;
                END;
            END LOOP;
            CLOSE crTURNO;
        END;
    END IF;
Exception
    When Others Then
    RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
/