CREATE OR REPLACE PROCEDURE H3i_SP_OBT_PACIENTES_ASIG_CAMA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TipoDoc IN VARCHAR2 DEFAULT NULL ,
  v_NumHist IN VARCHAR2 DEFAULT NULL ,
  v_NombrePac IN VARCHAR2 DEFAULT NULL ,
  v_BuscarPor IN NUMBER DEFAULT 0 ,
  v_MaxReg IN NUMBER DEFAULT NULL ,
  v_EstaReg IN NUMBER,
  v_CodigoLugarAtencion IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   IF v_BuscarPor = 0 THEN
    
   BEGIN
      DELETE FROM tt_tmpPac;
      UTILS.IDENTITY_RESET('tt_tmpPac');
      
      INSERT INTO tt_tmpPac ( 
      	SELECT UTILS.CONVERT_TO_NUMBER(NU_TIPD_PAC,10,0) NU_TIPD_PAC  ,
              RTRIM(LTRIM(NU_DOCU_PAC)) NU_DOCU_PAC  ,
              DE_PRAP_PAC ,
              DE_SGAP_PAC ,
              NO_NOMB_PAC ,
              NO_SGNO_PAC ,
              FE_NACI_PAC ,
              NVL(NU_NUME_REG_PAC, 0) NU_NUME_REG_PAC  ,
              CASE 
                   WHEN NVL(NU_NUME_REG_PAC, 0) = 0 THEN '1'
              ELSE ( SELECT NU_TIAT_REG 
                     FROM REGISTRO 
                      WHERE  NU_NUME_REG = NU_NUME_REG_PAC )
                 END AMBITO_ATENCION  ,
              UTILS.CONVERT_TO_NUMBER(NU_SEXO_PAC,10,0) NU_SEXO_PAC  ,
              CD_CODI_LUAT_PAC ,
              CD_CODI_DPTO_PAC ,
              CD_CODI_MUNI_PAC ,
              DE_DIRE_PAC ,
              DE_TELE_PAC ,
              NU_ESCI_PAC ,
              FE_HIST_PAC ,
              CD_CODI_CAM_PAC ,
              NU_ESTA_PAC ,
              CD_CODI_ZORE_PAC ,
              DE_EMAIL_PAC ,
              CD_CODI_OCUP_PAC ,
              NVL(NU_CONS_HIST_PAC, 0) NU_CONS_HIST_PAC  ,
              NVL(NU_TIPO_PAC, 0) NU_TIPO_PAC  ,
              CD_CODI_RELI_PAC ,
              CD_CODI_BAR_PAC ,
              NVL(NU_GEST_PAC, 0) NU_GEST_PAC  ,
              CD_CODI_DPTO_TRAB_PAC ,
              CD_CODI_MUNI_TRAB_PAC ,
              CD_CODI_DPTO_NACI_PAC ,
              CD_CODI_MUNI_NACI_PAC ,
              TX_TELTRAB_PAC ,
              TX_DIRTRAB_PAC ,
              TX_NOMBRESP_PAC ,
              CD_CODI_PARE_PAC ,
              TX_DIRRESP_PAC ,
              TX_TELRESP_PAC ,
              ME_INFOAD_PAC ,
              NU_FALLE_PAC ,
              NU_HIST_PAC ,
              CD_CODI_PAIS_PAC ,
              CD_CODI_PAIS_TRAB_PAC ,
              CD_CODI_PAIS_NACI_PAC ,
              CD_CODI_ESCO_PAC ,
              NU_ACTI_EPS_PAC ,
              NU_TERC_PAC ,
              NU_DATOS_EXT_PAC ,
              DE_CELU_PAC ,
              CalcularEdad(FE_NACI_PAC, SYSDATE, 0) Edad  ,
              CalcularEdad(FE_NACI_PAC, SYSDATE, 1) UME  ,
              TX_CODIGO_ETNI_PACI ,
              TX_DISCAPACIDAD_PACI ,
              NU_AUTO_TIRH ,
              INFO_PAC_COMPLETA 
      	  FROM PACIENTES 
                JOIN REGISTRO    ON NU_HIST_PAC = NU_HIST_PAC_REG
      	 WHERE  NU_ESCU_REG = v_EstaReg
                 AND ( CD_CODI_CAM_PAC IS NULL
                 OR CD_CODI_CAM_PAC = ' ' )
                 AND CD_CODI_LUAT_REG = v_CodigoLugarAtencion
                 AND NU_TIPD_PAC = (CASE v_BuscarPor
                                                    WHEN 0 THEN v_TipoDoc
               ELSE NU_TIPD_PAC
                  END)
                 AND NU_DOCU_PAC LIKE (CASE v_BuscarPor
                                                       WHEN 0 THEN (v_NumHist)
               ELSE NU_DOCU_PAC
                  END) AND ROWNUM <= NVL(v_MaxReg, 999999999) );
   
   END;
   ELSE
   
   BEGIN
      IF v_BuscarPor = 1 THEN
       
      BEGIN
         DELETE FROM tt_tmpPacN;
         UTILS.IDENTITY_RESET('tt_tmpPacN');
         
         INSERT INTO tt_tmpPacN ( 
         	SELECT UTILS.CONVERT_TO_NUMBER(NU_TIPD_PAC,10,0) NU_TIPD_PAC  ,
                 RTRIM(LTRIM(NU_DOCU_PAC)) NU_DOCU_PAC  ,
                 DE_PRAP_PAC ,
                 DE_SGAP_PAC ,
                 NO_NOMB_PAC ,
                 NO_SGNO_PAC ,
                 FE_NACI_PAC ,
                 NVL(NU_NUME_REG_PAC, 0) NU_NUME_REG_PAC  ,
                 CASE 
                      WHEN NVL(NU_NUME_REG_PAC, 0) = 0 THEN '1'
                 ELSE ( SELECT NU_TIAT_REG 
                        FROM REGISTRO 
                         WHERE  NU_NUME_REG = NU_NUME_REG_PAC )
                    END AMBITO_ATENCION  ,
                 UTILS.CONVERT_TO_NUMBER(NU_SEXO_PAC,10,0) NU_SEXO_PAC  ,
                 CD_CODI_LUAT_PAC ,
                 CD_CODI_DPTO_PAC ,
                 CD_CODI_MUNI_PAC ,
                 DE_DIRE_PAC ,
                 DE_TELE_PAC ,
                 NU_ESCI_PAC ,
                 FE_HIST_PAC ,
                 CD_CODI_CAM_PAC ,
                 NU_ESTA_PAC ,
                 CD_CODI_ZORE_PAC ,
                 DE_EMAIL_PAC ,
                 CD_CODI_OCUP_PAC ,
                 NVL(NU_CONS_HIST_PAC, 0) NU_CONS_HIST_PAC  ,
                 NVL(NU_TIPO_PAC, 0) NU_TIPO_PAC  ,
                 CD_CODI_RELI_PAC ,
                 CD_CODI_BAR_PAC ,
                 NVL(NU_GEST_PAC, 0) NU_GEST_PAC  ,
                 CD_CODI_DPTO_TRAB_PAC ,
                 CD_CODI_MUNI_TRAB_PAC ,
                 CD_CODI_DPTO_NACI_PAC ,
                 CD_CODI_MUNI_NACI_PAC ,
                 TX_TELTRAB_PAC ,
                 TX_DIRTRAB_PAC ,
                 TX_NOMBRESP_PAC ,
                 CD_CODI_PARE_PAC ,
                 TX_DIRRESP_PAC ,
                 TX_TELRESP_PAC ,
                 ME_INFOAD_PAC ,
                 NU_FALLE_PAC ,
                 NU_HIST_PAC ,
                 CD_CODI_PAIS_PAC ,
                 CD_CODI_PAIS_TRAB_PAC ,
                 CD_CODI_PAIS_NACI_PAC ,
                 CD_CODI_ESCO_PAC ,
                 NU_ACTI_EPS_PAC ,
                 NU_TERC_PAC ,
                 NU_DATOS_EXT_PAC ,
                 DE_CELU_PAC ,
                 CalcularEdad(FE_NACI_PAC, SYSDATE, 0) Edad  ,
                 CalcularEdad(FE_NACI_PAC, SYSDATE, 1) UME  ,
                 TX_CODIGO_ETNI_PACI ,
                 TX_DISCAPACIDAD_PACI ,
                 NU_AUTO_TIRH ,
                 INFO_PAC_COMPLETA 
         	  FROM PACIENTES 
                   JOIN REGISTRO    ON NU_HIST_PAC = NU_HIST_PAC_REG
         	 WHERE  NU_ESCU_REG = v_EstaReg
                    AND ( CD_CODI_CAM_PAC IS NULL
                    OR CD_CODI_CAM_PAC = ' ' )
                    AND CD_CODI_LUAT_REG = v_CodigoLugarAtencion
                    AND TX_NOMBRECOMPLETO_PAC LIKE (CASE v_BuscarPor
                                                                    WHEN 1 THEN ('%' || v_NombrePac || '%')
                  ELSE TX_NOMBRECOMPLETO_PAC
                     END) AND ROWNUM <= NVL(v_MaxReg, 999999999) );
      
      END;
      ELSE
      
      BEGIN
         DELETE FROM tt_tmpPacH;
         UTILS.IDENTITY_RESET('tt_tmpPacH');
         
         INSERT INTO tt_tmpPacH ( 
         	SELECT UTILS.CONVERT_TO_NUMBER(NU_TIPD_PAC,10,0) NU_TIPD_PAC  ,
                 RTRIM(LTRIM(NU_DOCU_PAC)) NU_DOCU_PAC  ,
                 DE_PRAP_PAC ,
                 DE_SGAP_PAC ,
                 NO_NOMB_PAC ,
                 NO_SGNO_PAC ,
                 FE_NACI_PAC ,
                 NVL(NU_NUME_REG_PAC, 0) NU_NUME_REG_PAC  ,
                 CASE 
                      WHEN NVL(NU_NUME_REG_PAC, 0) = 0 THEN '1'
                 ELSE ( SELECT NU_TIAT_REG 
                        FROM REGISTRO 
                         WHERE  NU_NUME_REG = NU_NUME_REG_PAC )
                    END AMBITO_ATENCION  ,
                 UTILS.CONVERT_TO_NUMBER(NU_SEXO_PAC,10,0) NU_SEXO_PAC  ,
                 CD_CODI_LUAT_PAC ,
                 CD_CODI_DPTO_PAC ,
                 CD_CODI_MUNI_PAC ,
                 DE_DIRE_PAC ,
                 DE_TELE_PAC ,
                 NU_ESCI_PAC ,
                 FE_HIST_PAC ,
                 CD_CODI_CAM_PAC ,
                 NU_ESTA_PAC ,
                 CD_CODI_ZORE_PAC ,
                 DE_EMAIL_PAC ,
                 CD_CODI_OCUP_PAC ,
                 NVL(NU_CONS_HIST_PAC, 0) NU_CONS_HIST_PAC  ,
                 NVL(NU_TIPO_PAC, 0) NU_TIPO_PAC  ,
                 CD_CODI_RELI_PAC ,
                 CD_CODI_BAR_PAC ,
                 NVL(NU_GEST_PAC, 0) NU_GEST_PAC  ,
                 CD_CODI_DPTO_TRAB_PAC ,
                 CD_CODI_MUNI_TRAB_PAC ,
                 CD_CODI_DPTO_NACI_PAC ,
                 CD_CODI_MUNI_NACI_PAC ,
                 TX_TELTRAB_PAC ,
                 TX_DIRTRAB_PAC ,
                 TX_NOMBRESP_PAC ,
                 CD_CODI_PARE_PAC ,
                 TX_DIRRESP_PAC ,
                 TX_TELRESP_PAC ,
                 ME_INFOAD_PAC ,
                 NU_FALLE_PAC ,
                 NU_HIST_PAC ,
                 CD_CODI_PAIS_PAC ,
                 CD_CODI_PAIS_TRAB_PAC ,
                 CD_CODI_PAIS_NACI_PAC ,
                 CD_CODI_ESCO_PAC ,
                 NU_ACTI_EPS_PAC ,
                 NU_TERC_PAC ,
                 NU_DATOS_EXT_PAC ,
                 DE_CELU_PAC ,
                 CalcularEdad(FE_NACI_PAC, SYSDATE, 0) Edad  ,
                 CalcularEdad(FE_NACI_PAC, SYSDATE, 1) UME  ,
                 TX_CODIGO_ETNI_PACI ,
                 TX_DISCAPACIDAD_PACI ,
                 NU_AUTO_TIRH ,
                 INFO_PAC_COMPLETA 
         	  FROM PACIENTES 
                   JOIN REGISTRO    ON NU_HIST_PAC = NU_HIST_PAC_REG
         	 WHERE  NU_ESCU_REG = v_EstaReg
                    AND ( CD_CODI_CAM_PAC IS NULL
                    OR CD_CODI_CAM_PAC = ' ' )
                    AND CD_CODI_LUAT_PAC = v_CodigoLugarAtencion
                    AND NU_HIST_PAC = v_NumHist
                    AND CD_CODI_LUAT_REG = v_CodigoLugarAtencion AND ROWNUM <= NVL(v_MaxReg, 999999999) );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_BuscarPor = 1 THEN
    
   BEGIN
      OPEN  cv_1 FOR
         SELECT * 
           FROM tt_tmpPacN 
           ORDER BY DE_PRAP_PAC,
                    DE_SGAP_PAC,
                    NO_NOMB_PAC,
                    NO_SGNO_PAC ;
   
   END;
   ELSE
   
   BEGIN
      IF v_BuscarPor = 0 THEN
       
      BEGIN
         OPEN  cv_1 FOR
            SELECT * 
              FROM tt_tmpPac 
              ORDER BY NU_TIPD_PAC,
                       NU_DOCU_PAC ;
      
      END;
      ELSE
      
      BEGIN
         OPEN  cv_1 FOR
            SELECT * 
              FROM tt_tmpPacH 
              ORDER BY NU_TIPD_PAC,
                       NU_DOCU_PAC ;
      
      END;
      END IF;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;