CREATE OR REPLACE PROCEDURE H3i_SP_CONS_SERVS_PENDIENTES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NumHistoria IN VARCHAR2,
    V_TipoServ IN VARCHAR2,
    CV_1 OUT SYS_REFCURSOR
)     
AS
BEGIN

END;
    INSERT INTO TT_RESULTADOS
        SELECT     
            NVL(REG.NU_NUME_REG, 0) NU_NUME_REG,
            SER.NU_OPCI_SER AS TIPOSERVICIO,
            PAC.NU_HIST_PAC, 
            HPR.NU_NUME_HPRO, 
            MCA.NU_NUME_MOVI, 
            LAB.NU_NUME_LABO, 
            PAC.NU_TIPD_PAC, 
            PAC.NU_DOCU_PAC, 
            PAC.DE_PRAP_PAC, 
            PAC.DE_SGAP_PAC, 
            PAC.NO_NOMB_PAC, 
            PAC.NO_SGNO_PAC, 
            HCL.NU_NUME_HICL, 
            HPR.NU_NUME_HEVO_HPRO, 
            HPR.NU_ORDE_HPRO, 
            CASE NU_NUME_HEVO_HPRO 
                WHEN 0 THEN FE_FECH_HICL 
                ELSE (  SELECT FE_FECH_HEVO 
                        FROM HIST_EVOLUCION 
                        WHERE NU_NUME_HEVO_HPRO = NU_NUME_HEVO) 
            END FECHA_ORDEN, 
            SER.CD_CODI_SER, 
            SER.NO_NOMB_SER, 
            HPR.NU_CANT_HPRO, 
            MEDORDENA.CD_CODI_MED AS CODIGOMEDICOORDENA, 
            MEDORDENA.NO_NOMB_MED AS MEDICOORDENA, 
            ESPORDENA.CD_CODI_ESP AS CODIGOESPECIALIDADORDENA, 
            ESPORDENA.NO_NOMB_ESP AS ESPECIALIDADORDENA, 
            CASE 
                WHEN ESP.CD_CODI_ESP IS NULL 
                THEN ProcedimientoUnicaEspe(SER.CD_CODI_SER, 1) 
                ELSE '1' 
            END CODIGOESPECIALIDADFIJA, 
            CASE 
                WHEN ESP.CD_CODI_ESP IS NULL 
                    THEN ProcedimientoUnicaEspe(SER.CD_CODI_SER, 2) 
                ELSE ESP.CD_CODI_ESP 
            END CODIGOESPECIALIDADREALIZA, 
            NVL(ESP.NO_NOMB_ESP, ProcedimientoUnicaEspe(SER.CD_CODI_SER, 3)) AS ESPECIALIDADREALIZANOMBRE, 
            NVL(MED.CD_CODI_MED,'') AS CODIGOMEDICOREALIZA, 
            NVL(MED.NO_NOMB_MED,'') AS MEDICOREALIZA,
            NVL(MCA.NU_TIAT_MOVI, 1) AS TIPOATENCION,
            NVL(MCA.NU_TIPO_MOVI, 1) AS TIPOCARGO,
            MCA.NU_NUME_CONV_MOVI,
            MCA.CD_REGIMEN_MOVI,
    		PAC.CD_CODI_LUAT_PAC,
    		HPR.DE_INDI_HPRO OBSERVACIONES,
    		HPR.NU_ESTA_HPRO   
        FROM  HIST_PROC HPR
        INNER JOIN SERVICIOS SER 
            ON HPR.CD_CODI_SER_HPRO = SER.CD_CODI_SER 
            AND (HPR.NU_NUME_LABO_HPRO IS NULL OR HPR.NU_NUME_LABO_HPRO = 0)
        INNER JOIN HISTORIACLINICA HCL 
            ON HPR.NU_NUME_HICL_HPRO = HCL.NU_NUME_HICL 
        INNER JOIN  MEDICOS MEDORDENA
            ON MEDORDENA.CD_CODI_MED = (CASE HPR.NU_NUME_HEVO_HPRO 
                                            WHEN 0 THEN HCL.CD_MED_REAL_HICL
                                            ELSE (  SELECT CD_CODI_MED_HEVO
                                                    FROM HIST_EVOLUCION
                                                    WHERE HPR.NU_NUME_HEVO_HPRO = NU_NUME_HEVO) 
                                        END)
        INNER JOIN LABORATORIO LAB 
            ON HCL.NU_NUME_LABO_HICL = LAB.NU_NUME_LABO 
        INNER JOIN MOVI_CARGOS MCA 
            ON LAB.NU_NUME_MOVI_LABO = MCA.NU_NUME_MOVI 
        INNER JOIN PACIENTES PAC 
            ON MCA.NU_HIST_PAC_MOVI = PAC.NU_HIST_PAC 
        INNER JOIN ESPECIALIDADES ESPORDENA 
            ON ESPORDENA.CD_CODI_ESP = (CASE HPR.NU_NUME_HEVO_HPRO 
                                            WHEN 0 THEN LAB.CD_CODI_ESP_LABO 
                                            ELSE (  SELECT CD_CODI_ESP_HEVO 
                                                    FROM HIST_EVOLUCION 
                                                    WHERE HPR.NU_NUME_HEVO_HPRO = NU_NUME_HEVO ) 
                                        END)
        LEFT JOIN REGISTRO REG 
            ON MCA.NU_NUME_REG_MOVI = REG.NU_NUME_REG
        LEFT JOIN ESPECIALIDADES ESP
            ON LAB.CD_CODI_ESP_LABO = ESP.CD_CODI_ESP
		LEFT JOIN  HIST_PROCONS HPRS 
            ON HPRS.NU_NUME_HPRO_HPCO = HPR.NU_NUME_HPRO
        LEFT JOIN  MEDICOS MED 
            ON MED.CD_CODI_MED = HPRS.CD_CODI_MED_HPCO
        WHERE PAC.NU_HIST_PAC LIKE V_NumHistoria
            AND NVL(REG.NU_ESCU_REG, 0) <> 2
        	AND	NVL(REG.ID_ESTA_ASIS_REG, 0) <> 1 
        	AND	MCA.NU_ESTA_MOVI<>2
        	AND SER.NU_OPCI_SER IN (SELECT IDTIPO 
                                    FROM TABLE(F_FILTRA_TIPOSERVICIOS (V_TipoServ)))
        	AND	HPR.NU_ESTA_HPRO <> 2
        GROUP BY
            REG.NU_NUME_REG,
            PAC.NU_HIST_PAC, 
            HPR.NU_NUME_HPRO, 
            MCA.NU_NUME_MOVI, 
            LAB.NU_NUME_LABO, 
            SER.NU_OPCI_SER, 
            PAC.NU_TIPD_PAC, 
            PAC.NU_DOCU_PAC, 
            PAC.DE_PRAP_PAC, 
            PAC.DE_SGAP_PAC, 
            PAC.NO_NOMB_PAC, 
            PAC.NO_SGNO_PAC, 
            HCL.NU_NUME_HICL, 
            HPR.NU_NUME_HEVO_HPRO, 
            HPR.NU_ORDE_HPRO,
            HCL.FE_FECH_HICL,
            SER.CD_CODI_SER, 
            SER.NO_NOMB_SER, 
            HPR.NU_CANT_HPRO, 
            MEDORDENA.CD_CODI_MED, 
            MEDORDENA.NO_NOMB_MED, 
            ESPORDENA.CD_CODI_ESP, 
            ESPORDENA.NO_NOMB_ESP, 
            ESP.CD_CODI_ESP,
            ESP.NO_NOMB_ESP, 
            MED.CD_CODI_MED, 
            MED.NO_NOMB_MED,
            MCA.NU_TIAT_MOVI,
            MCA.NU_TIPO_MOVI,
            MCA.NU_NUME_CONV_MOVI,
            MCA.CD_REGIMEN_MOVI,
    		PAC.CD_CODI_LUAT_PAC,
    		HPR.DE_INDI_HPRO,
    		HPR.NU_ESTA_HPRO;
    ------    

    OPEN CV_1 FOR
        SELECT *
        FROM TT_RESULTADOS
        ORDER BY TIPOSERVICIO, FECHA_ORDEN, NU_NUME_REG, NU_NUME_HICL, NU_NUME_HEVO_HPRO, NU_ORDE_HPRO;
END;
