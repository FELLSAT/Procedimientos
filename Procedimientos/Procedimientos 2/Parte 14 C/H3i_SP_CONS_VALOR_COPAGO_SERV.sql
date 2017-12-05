CREATE OR REPLACE PROCEDURE H3i_SP_CONS_VALOR_COPAGO_SERV
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_CONVENIO IN NUMBER,
    v_AMBITO_ATENCION IN NUMBER,
    v_CD_CODI_SER IN VARCHAR2,
    v_VALOR_SERVICIO IN NUMBER,
    v_TIPO_SERVICIO IN NUMBER,
    v_HIS_PACIENTE IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS      ----------  
     v_SER_PYP NUMBER(3,0);
     v_SER_SIN_COPAGO NUMBER(3,0);
     v_temp NUMBER(1, 0) := 0;
BEGIN

   DELETE FROM tt_RESULTADO_10;
   --SI ES AMBULATORIO  
   IF ( v_AMBITO_ATENCION = 1 ) THEN
    
   BEGIN
      INSERT INTO tt_RESULTADO_11
        ( TipoCuotaCopago, VALOR_AYDX, VALOR_ELEM, VALOR_CONSULTA, VALOR_OTROS_PROC, VALOR_PROC_QUIRURGICOS, NU_COGN_CONV, GESTANTE, NU_COPRICONS_CONV, CONVENIO_PYP, CD_NIT_EPS )
        ( SELECT rrc.NU_LICO_RECO ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(RRE.VL_AYDX_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(RRE.VL_ELEM_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(RRE.VL_CONS_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(RRE.VL_PROC_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(RRE.VL_PRQU_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CON.NU_COGN_CONV ,
                 NVL(PAC.NU_GEST_PAC, 0) ,
                 NVL(CON.NU_COPRICONS_CONV, 0) ,
                 NVL(CON.NU_INDPYP_CONV, 0) ,
                 EP.CD_NIT_EPS 
          FROM HIMS2.PACIENTES PAC
                 JOIN HIMS2.R_PAC_EPS RPE   ON PAC.NU_HIST_PAC = RPE.NU_HIST_PAC_RPE
                 JOIN HIMS2.REGISTRO REG   ON RPE.NU_HIST_PAC_RPE = REG.NU_HIST_PAC_REG
                 JOIN R_REGISTRO_CONV RRC   ON reg.NU_NUME_REG = nu_nume_reg_reco
                 JOIN HIMS2.CONVENIOS CON   ON RRC.NU_NUME_CONV_RECO = CON.NU_NUME_CONV
                 JOIN HIMS2.EPS EP   ON CON.CD_NIT_EPS_CONV = EP.CD_NIT_EPS
                 JOIN HIMS2.R_REG_EPS RRE   ON RPE.CD_CODI_REG_RPE = RRE.CD_CODI_REG_RRE
                 AND RPE.CD_NIT_EPS_RPE = RRE.CD_NIT_EPS_RRE
           WHERE  CON.NU_NUME_CONV = v_NU_CONVENIO
                    AND RPE.NU_ESTA_REP <> 1 AND ROWNUM <= 1 );
   
   END;
   END IF;
   --SI ES HOSPITALIZACION  
   IF v_AMBITO_ATENCION = 2 THEN
    
   BEGIN
      INSERT INTO tt_RESULTADO_11
        ( TipoCuotaCopago, VALOR_AYDX, VALOR_ELEM, VALOR_CONSULTA, VALOR_OTROS_PROC, VALOR_PROC_QUIRURGICOS, NU_COGN_CONV, GESTANTE, NU_COPRICONS_CONV, CONVENIO_PYP, CD_NIT_EPS )
        ( SELECT rrc.NU_LICO_RECO ,
                 --si el TipoLiquidacionCopago = regimen debe tomar el valor del copago diferente a que si es copago o cuotamoderadora  
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(REH.VL_AYDX_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(REH.VL_ELEM_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(REH.VL_CONS_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(REH.VL_PROC_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(REH.VL_PRQU_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CON.NU_COGN_CONV ,
                 NVL(PAC.NU_GEST_PAC, 0) ,
                 NVL(CON.NU_COPRICONS_CONV, 0) ,
                 NVL(CON.NU_INDPYP_CONV, 0) ,
                 EP.CD_NIT_EPS 
          FROM HIMS2.PACIENTES PAC
                 JOIN HIMS2.R_PAC_EPS RPE   ON PAC.NU_HIST_PAC = RPE.NU_HIST_PAC_RPE
                 JOIN HIMS2.REGISTRO REG   ON RPE.NU_HIST_PAC_RPE = REG.NU_HIST_PAC_REG
                 JOIN R_REGISTRO_CONV RRC   ON reg.NU_NUME_REG = nu_nume_reg_reco
                 JOIN HIMS2.CONVENIOS CON   ON RRC.NU_NUME_CONV_RECO = CON.NU_NUME_CONV
                 JOIN HIMS2.EPS EP   ON CON.CD_NIT_EPS_CONV = EP.CD_NIT_EPS
                 JOIN HIMS2.R_REG_EPS_H REH   ON REH.CD_NIT_EPS_RRE = EP.CD_NIT_EPS
                 AND RPE.CD_CODI_REG_RPE = REH.CD_CODI_REG_RRE
           WHERE  CON.NU_NUME_CONV = v_NU_CONVENIO
                    AND RPE.NU_ESTA_REP <> 1 AND ROWNUM <= 1 );
   
   END;
   ELSE
   
   BEGIN
      --URGENCIAS  
      INSERT INTO tt_RESULTADO_11
        ( TipoCuotaCopago, VALOR_AYDX, VALOR_ELEM, VALOR_CONSULTA, VALOR_OTROS_PROC, VALOR_PROC_QUIRURGICOS, NU_COGN_CONV, GESTANTE, NU_COPRICONS_CONV, CONVENIO_PYP, CD_NIT_EPS )
        ( SELECT rrc.NU_LICO_RECO ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(REU.VL_AYDX_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(REU.VL_ELEM_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(REU.VL_CONS_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(REU.VL_PROC_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CASE 
                      WHEN RRC.NU_LICO_RECO = 2 THEN NVL(REU.VL_PRQU_RRE, 0)
                 ELSE NVL(RRC.VL_COPA_RECO, 0)
                    END col  ,
                 CON.NU_COGN_CONV ,
                 NVL(PAC.NU_GEST_PAC, 0) ,
                 NVL(CON.NU_COPRICONS_CONV, 0) ,
                 NVL(CON.NU_INDPYP_CONV, 0) ,
                 EP.CD_NIT_EPS 
          FROM HIMS2.PACIENTES PAC
                 JOIN HIMS2.R_PAC_EPS RPE   ON PAC.NU_HIST_PAC = RPE.NU_HIST_PAC_RPE
                 JOIN HIMS2.REGISTRO REG   ON RPE.NU_HIST_PAC_RPE = REG.NU_HIST_PAC_REG
                 JOIN R_REGISTRO_CONV RRC   ON reg.NU_NUME_REG = nu_nume_reg_reco
                 JOIN HIMS2.CONVENIOS CON   ON RRC.NU_NUME_CONV_RECO = CON.NU_NUME_CONV
                 JOIN HIMS2.EPS EP   ON CON.CD_NIT_EPS_CONV = EP.CD_NIT_EPS
                 JOIN HIMS2.R_REG_EPS_U REU   ON REU.CD_NIT_EPS_RRE = EP.CD_NIT_EPS
                 AND RPE.CD_CODI_REG_RPE = REU.CD_CODI_REG_RRE
           WHERE  CON.NU_NUME_CONV = v_NU_CONVENIO
                    AND RPE.NU_ESTA_REP <> 1 AND ROWNUM <= 1 );
   
   END;
   END IF;
   --APOYO DX.  
   IF ( v_TIPO_SERVICIO = 2 ) THEN
    
   BEGIN
      UPDATE tt_RESULTADO_10
         SET VALORTOTAL_COPAGO = CASE 
                                      WHEN TipoCuotaCopago = 0 THEN (v_VALOR_SERVICIO * VALOR_AYDX) / 100
             ELSE VALOR_AYDX
                END
       WHERE  NU_COGN_CONV IS NULL
        OR ( NU_COGN_CONV IS NOT NULL
        AND GESTANTE = 0 );
   
   END;
   END IF;
   --CONSULTAS - INTERCONSULTAS  
   IF ( v_TIPO_SERVICIO = 1 ) THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      UPDATE tt_RESULTADO_10
         SET VALORTOTAL_COPAGO = CASE 
                                      WHEN TipoCuotaCopago = 0 THEN (v_VALOR_SERVICIO * VALOR_CONSULTA) / 100
             ELSE VALOR_CONSULTA
                END
       WHERE  NU_COGN_CONV IS NULL
        OR ( NU_COGN_CONV IS NOT NULL
        AND GESTANTE = 0 );
      --COBRAR COPAGO A LA PRIMERA CONSULTA  
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE ( SELECT COUNT(*)  
                  FROM HIMS2.MOVI_CARGOS 
                   WHERE  NU_HIST_PAC_MOVI = v_HIS_PACIENTE
                            AND NU_NUME_CONV_MOVI = v_NU_CONVENIO
                            AND NU_TIPO_MOVI = v_TIPO_SERVICIO
                            AND NU_ESTA_MOVI <> 2 ) > 0;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE tt_RESULTADO_10
            SET VALORTOTAL_COPAGO = 0
          WHERE  NU_COPRICONS_CONV = 1;
      
      END;
      END IF;
   
   END;
   END IF;
   --OTROS PRODEDIMIENTOS  
   IF ( v_TIPO_SERVICIO = 4 ) THEN
    
   BEGIN
      UPDATE tt_RESULTADO_10
         SET VALORTOTAL_COPAGO = CASE 
                                      WHEN TipoCuotaCopago = 0 THEN (v_VALOR_SERVICIO * VALOR_OTROS_PROC) / 100
             ELSE VALOR_OTROS_PROC
                END
       WHERE  NU_COGN_CONV IS NULL
        OR ( NU_COGN_CONV IS NOT NULL
        AND GESTANTE = 0 );
   
   END;
   END IF;
   --PRODEDIMIENTOS QUIRURGICOS  
   IF ( v_TIPO_SERVICIO = 3 ) THEN
    
   BEGIN
      UPDATE tt_RESULTADO_10
         SET VALORTOTAL_COPAGO = CASE 
                                      WHEN TipoCuotaCopago = 0 THEN (v_VALOR_SERVICIO * VALOR_PROC_QUIRURGICOS) / 100
             ELSE VALOR_PROC_QUIRURGICOS
                END
       WHERE  NU_COGN_CONV IS NULL
        OR ( NU_COGN_CONV IS NOT NULL
        AND GESTANTE = 0 );
   
   END;
   END IF;
   SELECT NVL(NU_NUME_IND_SER, 0) ,
          NVL(SIN_COPAGO, 0) 

     INTO v_SER_PYP,
          v_SER_SIN_COPAGO
     FROM HIMS2.SERVICIOS 
    WHERE  CD_CODI_SER = v_CD_CODI_SER;
   --SI EL SERVICIO ES PYP Y EL CONVENIO ES PYP  
   IF ( v_SER_PYP = 1 ) THEN
    
   BEGIN
      UPDATE tt_RESULTADO_10
         SET VALORTOTAL_COPAGO = 0
       WHERE  CONVENIO_PYP = 1;
   
   END;
   END IF;
   IF ( v_SER_SIN_COPAGO = 0 ) THEN
    
   BEGIN
      UPDATE tt_RESULTADO_10
         SET VALORTOTAL_COPAGO = 0
       WHERE  CD_NIT_EPS <> '000000000';--PARTICULARES  
   
   END;
   END IF;
   -------------  
   --SEMANAS COTIZADAS  
   --SELECT * FROM [dbo].[CONTROL] WHERE [CD_CONC_CONT] = 'SEMPERCAR'  
   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE ( SELECT COUNT(*)  
               FROM tt_RESULTADO_10  ) = 0;
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
    
   BEGIN
      INSERT INTO tt_RESULTADO_11
        ( TipoCuotaCopago, NU_COGN_CONV, GESTANTE, NU_COPRICONS_CONV, CONVENIO_PYP, CD_NIT_EPS )
        ( SELECT 2 ,
                 NULL ,
                 NULL ,
                 NULL ,
                 NULL ,
                 NULL 
            FROM DUAL  );
   
   END;
   END IF;
   OPEN  cv_1 FOR
      SELECT * 
        FROM tt_RESULTADO_10  ;

EXCEPTION WHEN OTHERS THEN utils.handleerror(SQLCODE,SQLERRM);
END;