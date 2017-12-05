CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_PERSONAS_ARBOL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_ARBOL IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT PER_ARB.NU_NUME_PER_ARB ,
             PER_ARB.NU_NUME_ARBOL ,
             PER_ARB.NU_NUME_PERS ,
             PER_ARB.NU_POSX ,
             PER_ARB.NU_POSY ,
             PER.NU_NUME_PER ,
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
             PER.TIPO_EMBARAZO ,
             PER.ES_GEMELO 
        FROM HIST_GENO_PERSONA_ARBOL PER_ARB
               LEFT JOIN HIST_GENO_PERSONA PER   ON PER_ARB.NU_NUME_PERS = PER.NU_NUME_PER
       WHERE  PER_ARB.NU_NUME_ARBOL = v_CD_ARBOL ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;