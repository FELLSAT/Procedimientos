CREATE OR REPLACE PROCEDURE H3i_SP_LIST_HC_X_EXA_ADMIN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_FECHAINI IN DATE DEFAULT NULL ,
  v_FECHAFIN IN DATE DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT HISTORIACLINICA.FE_FECH_HICL ,
             CASE PACIENTES.NU_TIPD_PAC
                                       WHEN 0 THEN 'CC'
                                       WHEN 1 THEN 'TI'
                                       WHEN 2 THEN 'RC'
                                       WHEN 3 THEN 'CE'
                                       WHEN 4 THEN 'PA'
                                       WHEN 5 THEN 'AS'
                                       WHEN 6 THEN 'MS'
                                       WHEN 7 THEN 'NU'   END NU_TIPD_PAC  ,
             PACIENTES.NU_DOCU_PAC ,
             PACIENTES.TX_NOMBRECOMPLETO_PAC ,
             EdadPaciente(PACIENTES.NU_HIST_PAC, 1) EDAD  ,
             CASE PACIENTES.NU_SEXO_PAC
                                       WHEN 0 THEN 'F'
                                       WHEN 1 THEN 'M'   END NU_SEXO_PAC  ,
             BA.DE_DESC_BAR ,
             TU.DE_DESC_TIUS ,
             SERVICIOS.NO_NOMB_SER ,
             --FINALIDAD_HIST.CD_NOMB_FIN,
             TX_DESC_RFF CD_NOMB_FIN  ,
             CA.DE_DESC_CAEX ,
             CODP ,
             DESCRP ,--CODIGO Y DESCRIPCION DEL DIAGNOSTICO PRINCIPAL

             COD1 ,
             DESCR1 ,-- CODIGO Y DESCRIPCION DEL DIAGNOSTICO RELACIONADO 1

             COD2 ,
             DESCR2 ,-- CODIGO Y DESCRIPCION DEL DIAGNOSTICO RELACIONADO 2

             COD3 ,
             DESCR3 ,-- CODIGO Y DESCRIPCION DEL DIAGNOSTICO RELACIONADO 3

             DXPR.DE_DESC_TIDI ,
             ESPECIALIDADES.NO_NOMB_ESP ,
             MEDICOS.NO_NOMB_MED ,
             --MEDICOS.NU_TIPO_MEDI,*
             -------------CARRERAS---------------------------------------
             --,PA_UNAL.NU_CODI_CARR_PAU COD_CARRERA
             PA_UNAL.DE_NOM_CARR_PAU ,
             PACIENTES.DE_TELE_PAC 
        FROM HISTORIACLINICA 
               INNER JOIN LABORATORIO    ON NU_NUME_LABO = NU_NUME_LABO_HICL
               INNER JOIN MOVI_CARGOS    ON NU_NUME_MOVI_LABO = NU_NUME_MOVI
               INNER JOIN PACIENTES    ON PACIENTES.NU_HIST_PAC = MOVI_CARGOS.NU_HIST_PAC_MOVI
               INNER JOIN SERVICIOS    ON SERVICIOS.CD_CODI_SER = LABORATORIO.CD_CODI_SER_LABO
               INNER JOIN R_PLANTILLA_HIST    ON R_PLANTILLA_HIST.NU_NUME_PLHI_R = HISTORIACLINICA.NU_NUME_PLHI_HICL
               INNER JOIN FINALIDAD_HIST    ON FINALIDAD_HIST.CD_CODI_FIN = R_PLANTILLA_HIST.NU_FINA_PLHI
               INNER JOIN ESPECIALIDADES    ON LABORATORIO.CD_CODI_ESP_LABO = ESPECIALIDADES.CD_CODI_ESP
               INNER JOIN MEDICOS    ON MEDICOS.CD_CODI_MED = HISTORIACLINICA.CD_MED_REAL_HICL
               LEFT JOIN BARRIO BA   ON PACIENTES.CD_CODI_BAR_PAC = BA.CD_CODI_BAR
               LEFT JOIN TIPOUSUARIO TU   ON PACIENTES.NU_TIPO_PAC = TU.ID_CODI_TIUS
               LEFT JOIN CAUSAEXTERNA CA   ON LABORATORIO.ID_CODI_CAEX_LABO = CA.ID_CODI_CAEX
               LEFT JOIN ( SELECT NU_NUME_LABO_RLAD ,
                                  CD_CODI_DIAG_RLAD CODP  ,
                                  DE_DESC_DIAG DESCRP  ,
                                  DE_DESC_TIDI 
                           FROM R_LABO_DIAG 
                                  INNER JOIN DIAGNOSTICO    ON R_LABO_DIAG.CD_CODI_DIAG_RLAD = DIAGNOSTICO.CD_CODI_DIAG
                                  INNER JOIN TIPODIAGNOSTICO    ON R_LABO_DIAG.ID_TIPO_RLAD = TIPODIAGNOSTICO.ID_CODI_TIDI
                            
                           --WHERE ID_TIPO_RLAD = 1 AND  ID_TIPO_DIAG_RLAD ='PR'
                           WHERE  ID_TIPO_DIAG_RLAD = 'PR' ) DXPR   ON DXPR.NU_NUME_LABO_RLAD = LABORATORIO.NU_NUME_LABO
               LEFT JOIN ( SELECT NU_NUME_LABO_RLAD ,
                                  CD_CODI_DIAG_RLAD COD1  ,
                                  DE_DESC_DIAG DESCR1  
                           FROM R_LABO_DIAG 
                                  INNER JOIN DIAGNOSTICO    ON R_LABO_DIAG.CD_CODI_DIAG_RLAD = DIAGNOSTICO.CD_CODI_DIAG
                            
                           --WHERE ID_TIPO_RLAD = 1 AND  ID_TIPO_DIAG_RLAD ='R1'
                           WHERE  ID_TIPO_DIAG_RLAD = 'R1' ) DXR1   ON DXR1.NU_NUME_LABO_RLAD = LABORATORIO.NU_NUME_LABO
               LEFT JOIN ( SELECT NU_NUME_LABO_RLAD ,
                                  CD_CODI_DIAG_RLAD COD2  ,
                                  DE_DESC_DIAG DESCR2  
                           FROM R_LABO_DIAG 
                                  INNER JOIN DIAGNOSTICO    ON R_LABO_DIAG.CD_CODI_DIAG_RLAD = DIAGNOSTICO.CD_CODI_DIAG
                            
                           --WHERE ID_TIPO_RLAD = 1 AND  ID_TIPO_DIAG_RLAD ='R2'
                           WHERE  ID_TIPO_DIAG_RLAD = 'R2' ) DXR2   ON DXR2.NU_NUME_LABO_RLAD = LABORATORIO.NU_NUME_LABO
               LEFT JOIN ( SELECT NU_NUME_LABO_RLAD ,
                                  CD_CODI_DIAG_RLAD COD3  ,
                                  DE_DESC_DIAG DESCR3  
                           FROM R_LABO_DIAG 
                                  INNER JOIN DIAGNOSTICO    ON R_LABO_DIAG.CD_CODI_DIAG_RLAD = DIAGNOSTICO.CD_CODI_DIAG
                            
                           --WHERE ID_TIPO_RLAD = 1 AND  ID_TIPO_DIAG_RLAD ='R3'
                           WHERE  ID_TIPO_DIAG_RLAD = 'R3' ) DXR3   ON DXR3.NU_NUME_LABO_RLAD = LABORATORIO.NU_NUME_LABO
               LEFT JOIN PACIENTES_ANEXO_UNAL PA_UNAL   ON PACIENTES.NU_HIST_PAC = PA_UNAL.NU_HIST_PAC_PAU
               LEFT JOIN R_FICO_FICOF    ON TX_CODI_RFF_LABO = TX_CODI_RFF
       WHERE  LABORATORIO.NU_ESTA_LABO <> 2
                AND MOVI_CARGOS.NU_ESTA_MOVI <> 2
                
                ---filtros para la especialidad en particular	
                AND FE_FECH_HICL >= NVL(v_FECHAINI, FE_FECH_HICL)
                AND FE_FECH_HICL <= NVL(v_FECHAFIN, FE_FECH_HICL)
                AND HISTORIACLINICA.NU_NUME_PLHI_HICL IN ( 1962,1638,1507 )
    ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;