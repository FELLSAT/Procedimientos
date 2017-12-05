CREATE OR REPLACE PROCEDURE H3i_SP_OBT_HERM_PER_FAM_PADRE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_PADRE IN NUMBER,
  v_CD_PERSONA IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT PER.NU_NUME_PER ,
             PER.NO_NOMB_PER ,
             PER.NO_SGNO_PER ,
             PER.NO_PRAP_PER ,
             PER.NO_SGAP_PER ,
             PER.NU_HIST_PAC ,
             PER.NU_NUME_PER_PADRE ,
             PER.NU_NUME_PER_MADRE ,
             PER.GEN_SEX ,
             PER.FEC_NACIM ,
             PER.FEC_MUERTE ,
             PER.NACIDO_VIVO ,
             PER.ES_BIOLOGICO ,
             PER_ARB.NU_POSX ,
             PER_ARB.NU_POSY ,
             PER_ARB.NU_NUME_ARBOL ,
             PADRE.NO_NOMB_PER NO_NOMB_PER_PADRE  ,
             PADRE.NO_SGNO_PER NO_SGNO_PER_PADRE  ,
             PADRE.NO_PRAP_PER NO_PRAP_PER_PADRE  ,
             PADRE.NO_SGAP_PER NO_SGAP_PER_PADRE  ,
             PADRE.NU_HIST_PAC NU_HIST_PAC_PADRE  ,
             PADRE.NU_NUME_PER_PADRE NU_NUME_PER_PADRE_PADRE  ,
             PADRE.NU_NUME_PER_MADRE NU_NUME_PER_MADRE_PADRE  ,
             PADRE.GEN_SEX GEN_SEX_PADRE  ,
             PADRE.FEC_NACIM FEC_NACIM_PADRE  ,
             PADRE.FEC_MUERTE FEC_MUERTE_PADRE  ,
             PADRE.NACIDO_VIVO NACIDO_VIVO_PADRE  ,
             PADRE.ES_BIOLOGICO ES_BIOLOGICO_PADRE  ,
             MADRE.NO_NOMB_PER NO_NOMB_PER_MADRE  ,
             MADRE.NO_SGNO_PER NO_SGNO_PER_MADRE  ,
             MADRE.NO_PRAP_PER NO_PRAP_PER_MADRE  ,
             MADRE.NO_SGAP_PER NO_SGAP_PER_MADRE  ,
             MADRE.NU_HIST_PAC NU_HIST_PAC_MADRE  ,
             MADRE.NU_NUME_PER_PADRE NU_NUME_PER_PADRE_MADRE  ,
             MADRE.NU_NUME_PER_MADRE NU_NUME_PER_MADRE_MADRE  ,
             MADRE.GEN_SEX GEN_SEX_MADRE  ,
             MADRE.FEC_NACIM FEC_NACIM_MADRE  ,
             MADRE.FEC_MUERTE FEC_MUERTE_MADRE  ,
             MADRE.NACIDO_VIVO NACIDO_VIVO_MADRE  ,
             MADRE.ES_BIOLOGICO ES_BIOLOGICO_MADRE  
        FROM HIST_GENO_PERSONA PER
               LEFT JOIN HIST_GENO_PERSONA_ARBOL PER_ARB   ON PER.NU_NUME_PER = PER_ARB.NU_NUME_PERS
               LEFT JOIN HIST_GENO_PERSONA MADRE   ON MADRE.NU_NUME_PER = PER.NU_NUME_PER_MADRE
               LEFT JOIN HIST_GENO_PERSONA PADRE   ON PADRE.NU_NUME_PER = PER.NU_NUME_PER_PADRE
       WHERE  PER.NU_NUME_PER_PADRE = v_CD_PADRE
                AND PER.NU_NUME_PER != v_CD_PERSONA
        ORDER BY PER.FEC_NACIM ASC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;