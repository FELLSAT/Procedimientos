CREATE OR REPLACE PROCEDURE H3i_SP_LISTAHC_PAC_CLAP --recupera formatos registrados
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NUMHISTPAC IN VARCHAR2,
  v_FECHAINI IN DATE DEFAULT NULL ,
  v_FECHAFIN IN DATE DEFAULT NULL ,
  v_NUMREG IN NUMBER DEFAULT NULL ,
  v_NUMFORMPRIN IN VARCHAR2 DEFAULT NULL ,
  v_NUMFORMSEC IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   IF ( v_NUMFORMSEC IS NULL ) THEN
    
   BEGIN
      OPEN  cv_1 FOR
         SELECT NU_NUME_HICL ,
                NU_NUME_PLHI_HICL ,
                CD_NOMB_FIN ,
                FE_FECH_HICL ,
                CD_CODI_SER ,
                NO_NOMB_SER ,
                CD_MED_REAL_HICL ,
                NO_NOMB_MED ,
                CD_CODI_ESP ,
                NO_NOMB_ESP ,
                NU_NUME_REG_MOVI ,
                NU_NUME_LABO ,
                NU_NUME_MOVI ,
                PL.NU_AUTO_ENPL_PLHI ,
                NU_ESGU_HICL 
           FROM HISTORIACLINICA 
                  INNER JOIN LABORATORIO    ON NU_NUME_LABO = NU_NUME_LABO_HICL
                  INNER JOIN MOVI_CARGOS    ON NU_NUME_MOVI_LABO = NU_NUME_MOVI
                  INNER JOIN SERVICIOS    ON CD_CODI_SER = CD_CODI_SER_LABO
                  INNER JOIN R_PLANTILLA_HIST    ON NU_NUME_PLHI_HICL = NU_NUME_PLHI_R
                  INNER JOIN PLANTILLA_HIST PL   ON PL.NU_NUME_PLHI = R_PLANTILLA_HIST.NU_NUME_PLHI_R
                  INNER JOIN FINALIDAD_HIST    ON NU_FINA_PLHI = FINALIDAD_HIST.CD_CODI_FIN
                  INNER JOIN MEDICOS    ON CD_CODI_MED = CD_MED_REAL_HICL
                  INNER JOIN ESPECIALIDADES    ON CD_CODI_ESP_LABO = CD_CODI_ESP
          WHERE  NU_ESTA_LABO <> 2
                   AND NU_ESTA_MOVI <> 2
                   AND NU_HIST_PAC_MOVI = v_NUMHISTPAC
                   AND FE_FECH_HICL >= NVL(v_FECHAINI, FE_FECH_HICL)
                   AND FE_FECH_HICL <= NVL(v_FECHAFIN, FE_FECH_HICL)
                   AND NU_NUME_REG_MOVI = NVL(CASE 
                                                   WHEN v_NUMREG = 0 THEN NULL
                                              ELSE v_NUMREG
                                                 END, NU_NUME_REG_MOVI)
                   AND NU_NUME_HICL = v_NUMFORMPRIN
           ORDER BY NU_NUME_HICL DESC ;
   
   END;
   ELSE
   
   BEGIN
      OPEN  cv_1 FOR
         SELECT NU_NUME_HICL ,
                NU_NUME_PLHI_HICL ,
                CD_NOMB_FIN ,
                FE_FECH_HICL ,
                CD_CODI_SER ,
                NO_NOMB_SER ,
                CD_MED_REAL_HICL ,
                NO_NOMB_MED ,
                CD_CODI_ESP ,
                NO_NOMB_ESP ,
                NU_NUME_REG_MOVI ,
                NU_NUME_LABO ,
                NU_NUME_MOVI ,
                PL.NU_AUTO_ENPL_PLHI ,
                NU_ESGU_HICL 
           FROM HISTORIACLINICA 
                  INNER JOIN LABORATORIO    ON NU_NUME_LABO = NU_NUME_LABO_HICL
                  INNER JOIN MOVI_CARGOS    ON NU_NUME_MOVI_LABO = NU_NUME_MOVI
                  INNER JOIN SERVICIOS    ON CD_CODI_SER = CD_CODI_SER_LABO
                  INNER JOIN R_PLANTILLA_HIST    ON NU_NUME_PLHI_HICL = NU_NUME_PLHI_R
                  INNER JOIN PLANTILLA_HIST PL   ON PL.NU_NUME_PLHI = R_PLANTILLA_HIST.NU_NUME_PLHI_R
                  INNER JOIN FINALIDAD_HIST    ON NU_FINA_PLHI = FINALIDAD_HIST.CD_CODI_FIN
                  INNER JOIN MEDICOS    ON CD_CODI_MED = CD_MED_REAL_HICL
                  INNER JOIN ESPECIALIDADES    ON CD_CODI_ESP_LABO = CD_CODI_ESP
          WHERE  NU_ESTA_LABO <> 2
                   AND NU_ESTA_MOVI <> 2
                   AND NU_HIST_PAC_MOVI = v_NUMHISTPAC
                   AND FE_FECH_HICL >= NVL(v_FECHAINI, FE_FECH_HICL)
                   AND FE_FECH_HICL <= NVL(v_FECHAFIN, FE_FECH_HICL)
                   AND NU_NUME_REG_MOVI = NVL(CASE 
                                                   WHEN v_NUMREG = 0 THEN NULL
                                              ELSE v_NUMREG
                                                 END, NU_NUME_REG_MOVI)
                   AND ( NU_NUME_HICL = v_NUMFORMPRIN
                   OR NU_NUME_HICL = v_NUMFORMSEC )
           ORDER BY NU_NUME_HICL DESC ;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;