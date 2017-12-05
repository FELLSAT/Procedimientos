CREATE OR REPLACE PROCEDURE H3i_SP_OBTENER_FACTORVAINDATA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_IDPLANTILLA IN NUMBER,
  v_IDCONCEPTOASOC IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT DISTINCT NU_AUTO_VAIN_FAVA ,
                      NU_NUME_PLHI_FAVA ,
                      NU_INDI_RPC_FAVA ,
                      NU_VALMIN_FAVA ,
                      NU_VALMAX_FAVA ,
                      NU_PESO_FAVA ,
                      NU_ID_CPTO_INDI_FAVA ,
                      NU_CPTO_ASOC_FAVA ,
                      BOOL_ES_FORMFIN_FAVA ,
                      NU_PLANT_EXT_FAVA ,
                      TX_DESCRIBE_VAIN ,
                      TX_CODIGO_VAIN ,
                      NU_ESTA_VAIN ,
                      CD_CODI_GRHI ,
                      CD_CODI_COHI ,
                      TX_TITULO_COHI ,
                      NU_TIPO_COHI 
        FROM FACTOR_VAIN 
               LEFT JOIN VARIABLE_INDICADOR    ON ( VARIABLE_INDICADOR.NU_AUTO_VAIN = FACTOR_VAIN.NU_AUTO_VAIN_FAVA )
               LEFT JOIN R_PLAN_CONC    ON ( NU_ID_CPTO_INDI_FAVA = NU_NUME_COHI_RPC )
               LEFT JOIN GRUPO_HIST    ON ( NU_NUME_GRHI_RPC = NU_NUME_GRHI )
               LEFT JOIN CONCEPTO_HIST    ON ( NU_NUME_COHI = NU_ID_CPTO_INDI_FAVA )
       WHERE
      -- NU_NUME_PLHI_RPC = @IDPLANTILLA AND
        NU_NUME_PLHI_FAVA = v_IDPLANTILLA
          AND NU_CPTO_ASOC_FAVA = v_IDCONCEPTOASOC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;