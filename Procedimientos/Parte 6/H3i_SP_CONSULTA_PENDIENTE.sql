CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_PENDIENTE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_IDREG IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT FE_FECH_MOVI ,
             CD_CODI_SER ,
             NO_NOMB_SER ,
             NU_NUME_IND_SER ES_PYP_SER  ,
             NU_NUME_MOVI ,
             NU_NUME_LABO ,
             CD_CODI_ESP ,
             E.NO_NOMB_ESP ,
             ME.CD_CODI_MED ,
             ME.NO_NOMB_MED ,
             NU_NUME_FACO_MOVI ,
             NU_NUME_FAC_MOVI ,
             EPS.NO_NOMB_EPS ,
             C.CD_CODI_CONV ,
             (CASE M.NU_TIPO_MOVI
                                 WHEN 4 THEN 0
             ELSE 1
                END) TIPO  ,
             NU_NUME_REG_MOVI ,
             CD_CODI_MEDI_EST_LABO COD_PROF_EST  ,
             ME_EST.NO_NOMB_MED NOM_PROF_EST  ,
             NVL(( SELECT DISTINCT CD_CODI_MED_REEMP_RMRH 
                   FROM R_MEDI_REEMP_HOGR RMRH
                    WHERE  RMRH.CD_CODI_MED_ASIG_RMRH = ME.CD_CODI_MED
                             AND ( M.FE_FECH_MOVI BETWEEN RMRH.FE_FECH_REEMP_RMRH AND (RMRH.FE_FECH_REEMP_RMRH + 1)) AND ROWNUM <= 1 ), ' ') COD_PROF_REEMP  ,
             NVL(( SELECT NO_NOMB_MED 
                   FROM R_MEDI_REEMP_HOGR RMRH
                          INNER JOIN MEDICOS    ON CD_CODI_MED_REEMP_RMRH = CD_CODI_MED
                    WHERE  RMRH.CD_CODI_MED_ASIG_RMRH = ME.CD_CODI_MED
                             AND ( M.FE_FECH_MOVI BETWEEN RMRH.FE_FECH_REEMP_RMRH AND (RMRH.FE_FECH_REEMP_RMRH + 1)) AND ROWNUM <= 1 ), ' ') NOM_PROF_REEMP  
        FROM LABORATORIO L
               INNER JOIN MOVI_CARGOS M   ON L.NU_NUME_MOVI_LABO = M.NU_NUME_MOVI
               INNER JOIN SERVICIOS S   ON L.CD_CODI_SER_LABO = S.CD_CODI_SER
               INNER JOIN ESPECIALIDADES E   ON L.CD_CODI_ESP_LABO = E.CD_CODI_ESP
               INNER JOIN MEDICOS ME   ON L.CD_CODI_MEDI_LABO = ME.CD_CODI_MED
               INNER JOIN CONVENIOS C   ON M.NU_NUME_CONV_MOVI = C.NU_NUME_CONV
               INNER JOIN EPS    ON C.CD_NIT_EPS_CONV = EPS.CD_NIT_EPS
               LEFT JOIN HISTORIACLINICA H   ON L.NU_NUME_LABO = H.NU_NUME_LABO_HICL
               LEFT JOIN MEDICOS ME_EST   ON ME_EST.CD_CODI_MED = L.CD_CODI_MEDI_EST_LABO
       WHERE  NU_ESTA_LABO <> 2
                AND NU_ESTA_MOVI <> 2
                AND ID_ESTA_ASIS_LABO = 0
                AND H.NU_NUME_HICL IS NULL
                AND NU_NUME_REG_MOVI = v_IDREG ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;