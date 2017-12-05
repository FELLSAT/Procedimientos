CREATE OR REPLACE PROCEDURE H3i_SP_CONS_ATEN_REGIS_CIR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_PLHI_HICL IN NUMBER,
  v_CD_CODI_CIR_HICL IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_NUME_HICL ,
             NU_NUME_PLHI_HICL ,
             CD_NOMB_FIN ,
             FE_FECH_HICL ,
             ( SELECT CD_CODI_SER 
               FROM PROG_CIR 
                      INNER JOIN SOLI_CIR    ON CD_CODI_SOL = NU_NUME_SOL_CIR
                      INNER JOIN R_SER_CIR    ON NU_NUME_SOL_CIR = CD_CODI_CIR
                      INNER JOIN SERVICIOS    ON CD_CODI_SER = CD_CODI_PRO
                WHERE  CD_CODI_PROG = v_CD_CODI_CIR_HICL AND ROWNUM <= 1 ) CD_CODI_SER  ,
             ( SELECT NO_NOMB_SER 
               FROM PROG_CIR 
                      INNER JOIN SOLI_CIR    ON CD_CODI_SOL = NU_NUME_SOL_CIR
                      INNER JOIN R_SER_CIR    ON NU_NUME_SOL_CIR = CD_CODI_CIR
                      INNER JOIN SERVICIOS    ON CD_CODI_SER = CD_CODI_PRO
                WHERE  CD_CODI_PROG = v_CD_CODI_CIR_HICL AND ROWNUM <= 1 ) NO_NOMB_SER  ,
             CD_MED_REAL_HICL ,
             NO_NOMB_MED ,
             ( SELECT E.CD_CODI_ESP 
               FROM PROG_CIR 
                      INNER JOIN SOLI_CIR    ON CD_CODI_SOL = NU_NUME_SOL_CIR
                      INNER JOIN R_SER_CIR RSC   ON NU_NUME_SOL_CIR = CD_CODI_CIR
                      INNER JOIN ESPECIALIDADES E   ON RSC.CD_CODI_ESP = E.CD_CODI_ESP
                WHERE  CD_CODI_PROG = v_CD_CODI_CIR_HICL AND ROWNUM <= 1 ) CD_CODI_ESP  ,
             ( SELECT E.NO_NOMB_ESP 
               FROM PROG_CIR 
                      INNER JOIN SOLI_CIR    ON CD_CODI_SOL = NU_NUME_SOL_CIR
                      INNER JOIN R_SER_CIR RSC   ON NU_NUME_SOL_CIR = CD_CODI_CIR
                      INNER JOIN ESPECIALIDADES E   ON RSC.CD_CODI_ESP = E.CD_CODI_ESP
                WHERE  CD_CODI_PROG = v_CD_CODI_CIR_HICL AND ROWNUM <= 1 ) NO_NOMB_ESP  ,
             0 NU_NUME_REG_MOVI  ,
             0 NU_NUME_LABO  ,
             0 NU_NUME_MOVI  ,
             PL.NU_AUTO_ENPL_PLHI ,
             NU_ESGU_HICL ,
             NU_TIPO_MEDI_HICL 
        FROM HISTORIACLINICA 
               INNER JOIN R_PLANTILLA_HIST    ON NU_NUME_PLHI_HICL = NU_NUME_PLHI_R
               INNER JOIN PLANTILLA_HIST PL   ON PL.NU_NUME_PLHI = R_PLANTILLA_HIST.NU_NUME_PLHI_R
               INNER JOIN FINALIDAD_HIST    ON NU_FINA_PLHI = FINALIDAD_HIST.CD_CODI_FIN
               INNER JOIN MEDICOS    ON CD_CODI_MED = CD_MED_REAL_HICL
       WHERE  NU_NUME_LABO_HICL = 0
                AND NU_NUME_PLHI_HICL = v_NU_NUME_PLHI_HICL
                AND CD_CODI_CIR_HICL = v_CD_CODI_CIR_HICL
        ORDER BY NU_NUME_HICL DESC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;