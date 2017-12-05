CREATE OR REPLACE PROCEDURE H3i_SP_RPT_HC_PSICOLOGICA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_INI IN VARCHAR2,
  v_FIN IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT CASE NU_TIPD_PAC
                             WHEN 0 THEN 'CC'
                             WHEN 1 THEN 'TI'
                             WHEN 2 THEN 'RC'
                             WHEN 3 THEN 'CE'
                             WHEN 4 THEN 'PA'
                             WHEN 5 THEN 'AS'
                             WHEN 6 THEN 'MS'
                             WHEN 7 THEN 'NU'   END NU_TIPD_PAC  ,
             NU_DOCU_PAC ,
             TX_NOMBRECOMPLETO_PAC ,
             FE_NACI_PAC ,
             CASE NU_SEXO_PAC
                             WHEN 0 THEN 'F'
                             WHEN 1 THEN 'M'   END NU_SEXO_PAC  ,
             TX_JORNADA_PAC ,
             DE_DESC_DEPE ,
             PR.DE_DESC_HITE PROBLEMATICA  ,
             IT.DE_DESC_HITE TIPO_INTERVENCION  ,
             CO.DE_DESC_HIME MOTIVO_CONSULTA  ,
             MA.DE_DESC_HITE MODALIDAD_ACADEMICA  
        FROM PACIENTES 
               INNER JOIN ( SELECT NU_HIST_PAC_MOVI ,
                             NU_NUME_HICL 
                      FROM HISTORIACLINICA 
                             INNER JOIN LABORATORIO    ON NU_NUME_LABO_HICL = NU_NUME_LABO
                             INNER JOIN MOVI_CARGOS    ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
                       WHERE  NU_ESTA_MOVI <> 2
                                AND FE_FECINI_HICL BETWEEN v_INI AND v_FIN
                                AND NU_NUME_PLHI_HICL = 1348 ) MC   ON NU_HIST_PAC = MC.NU_HIST_PAC_MOVI
               INNER JOIN DEPENDENCIA    ON NU_DEPENDENCIA_PAC = CD_CODI_DEPE
               LEFT JOIN CARGOS    ON CD_CODI_CARGO_PAC = CD_CODI_CARGO
               LEFT JOIN HIST_TEXT PR   ON PR.NU_NUME_HICL_HITE = MC.NU_NUME_HICL
               AND PR.NU_INDI_HITE = 63
               LEFT JOIN HIST_TEXT IT   ON IT.NU_NUME_HICL_HITE = MC.NU_NUME_HICL
               AND IT.NU_INDI_HITE = 64
               LEFT JOIN HIST_MEMO CO   ON CO.NU_NUME_HICL_HIME = MC.NU_NUME_HICL
               AND CO.NU_INDI_HIME = 28
               LEFT JOIN HIST_TEXT MA   ON MA.NU_NUME_HICL_HITE = MC.NU_NUME_HICL
               AND MA.NU_INDI_HITE = 4 ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;