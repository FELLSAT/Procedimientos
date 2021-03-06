CREATE OR REPLACE PROCEDURE H3i_SP_GUARDAR_PACIENTE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_NU_TIPD_PAC IN NUMBER,  
    V_NU_DOCU_PAC IN OUT VARCHAR2,  
    V_DE_PRAP_PAC IN VARCHAR2,  
    V_DE_SGAP_PAC IN VARCHAR2,  
    V_NO_NOMB_PAC IN VARCHAR2,  
    V_NO_SGNO_PAC IN VARCHAR2,  
    V_FE_NACI_PAC IN DATE,  
    V_NU_NUME_REG_PAC IN NUMBER,  
    V_NU_SEXO_PAC NUMBER,  
    V_CD_CODI_LUAT_PAC IN VARCHAR2,  
    V_CD_CODI_DPTO_PAC IN VARCHAR2,  
    V_CD_CODI_MUNI_PAC IN VARCHAR2,  
    V_DE_DIRE_PAC IN VARCHAR2,  
    V_DE_TELE_PAC IN VARCHAR2,  
    V_NU_ESCI_PAC IN NUMBER,  
    V_FE_HIST_PAC IN DATE,  
    V_CD_CODI_CAM_PAC IN VARCHAR2,  
    V_NU_ESTA_PAC IN NUMBER,  
    V_CD_CODI_ZORE_PAC IN VARCHAR2,  
    V_DE_EMAIL_PAC IN VARCHAR2,  
    V_CD_CODI_OCUP_PAC IN VARCHAR2,  
    V_NU_CONS_HIST_PAC IN VARCHAR2,  
    V_NU_TIPO_PAC IN NUMBER,  
    V_CD_CODI_RELI_PAC IN VARCHAR2,  
    V_CD_CODI_BAR_PAC IN VARCHAR2,  
    V_NU_GEST_PAC IN NUMBER,  
    V_CD_CODI_DPTO_TRAB_PAC IN VARCHAR2,  
    V_CD_CODI_MUNI_TRAB_PAC IN VARCHAR2,  
    V_CD_CODI_DPTO_NACI_PAC IN VARCHAR2,  
    V_CD_CODI_MUNI_NACI_PAC IN VARCHAR2,  
    V_TX_TELTRAB_PAC IN VARCHAR2,  
    V_TX_DIRTRAB_PAC IN VARCHAR2,  
    V_TX_NOMBRESP_PAC IN VARCHAR2,  
    V_CD_CODI_PARE_PAC IN VARCHAR2,  
    V_TX_DIRRESP_PAC IN VARCHAR2,  
    V_TX_TELRESP_PAC IN VARCHAR2,  
    V_ME_INFOAD_PAC IN VARCHAR2,  
    V_NU_FALLE_PAC IN NUMBER,  
    V_NU_HIST_PAC IN OUT VARCHAR2,  
    V_CD_CODI_PAIS_PAC IN VARCHAR2,  
    V_CD_CODI_PAIS_TRAB_PAC IN VARCHAR2,  
    V_CD_CODI_PAIS_NACI_PAC IN VARCHAR2,  
    V_CD_CODI_ESCO_PAC IN VARCHAR2,  
    V_NU_ACTI_EPS_PAC IN NUMBER,  
    V_NU_TERC_PAC IN NUMBER,  
    V_NU_DATOS_EXT_PAC IN NUMBER,  
    V_DE_CELU_PAC IN VARCHAR2,  
    V_CODIGOETNIA IN VARCHAR2 DEFAULT NULL,  
    V_DISCAPACIDAD IN VARCHAR2 DEFAULT NULL,  
    V_NU_AUTO_TIRH IN NUMBER,     
    V_CD_CODI_LOC_PAC IN VARCHAR2 DEFAULT NULL,  
    V_DE_OTRO_TELE_PAC IN VARCHAR2 DEFAULT NULL,
    V_NU_ISDESPLAZADO_PAC IN NUMBER,
	V_TX_CODIGO_TICO_PAC IN VARCHAR2 DEFAULT NULL,
	V_INASISTIO_CIT_PAC IN NUMBER, 
    V_NUEVO OUT NUMBER,
	V_NU_DOCU_PAC_NUEVO OUT VARCHAR2,
	V_NU_HIST_PAC_NUEVO OUT VARCHAR2
)
AS
	VV_NU_DOCU_PAC NUMBER;
	V_COUNT NUMBER;
BEGIN
	IF (V_NU_DOCU_PAC = 'X' AND  (V_NU_TIPD_PAC = 5 OR V_NU_TIPD_PAC = 6 OR V_NU_TIPD_PAC = 7)) THEN
		BEGIN
			SELECT MAX(CAST(NU_DOCU_PAC AS NUMBER))
			INTO VV_NU_DOCU_PAC
			FROM PACIENTES
			where NU_TIPD_PAC = V_NU_TIPD_PAC;

			V_NU_DOCU_PAC := NVL((VV_NU_DOCU_PAC),0) + 1;

			V_NU_DOCU_PAC_NUEVO := V_NU_DOCU_PAC;

			SELECT COUNT(NU_HIST_PAC) 
			INTO V_COUNT 
			FROM PACIENTES 
			WHERE NU_HIST_PAC = V_NU_DOCU_PAC;

			IF(V_COUNT = 0) THEN
				BEGIN 
					V_NU_HIST_PAC := V_NU_DOCU_PAC;
					V_NU_HIST_PAC_NUEVO := V_NU_HIST_PAC;
				END;
			ELSE
				BEGIN
					V_NU_HIST_PAC := V_NU_DOCU_PAC || '-' || MOSTRARTIPODOCUMENTO(V_NU_TIPD_PAC);
					V_NU_HIST_PAC_NUEVO := V_NU_HIST_PAC;
				END;
			END IF;
		END;

	ELSE

		BEGIN
			V_NU_HIST_PAC_NUEVO := V_NU_HIST_PAC;
			V_NU_DOCU_PAC_NUEVO := V_NU_DOCU_PAC;
		END;
	END IF;


	SELECT COUNT(NU_HIST_PAC) 
	INTO V_COUNT
	FROM PACIENTES 
	WHERE NU_HIST_PAC = V_NU_HIST_PAC;

	IF (V_COUNT = 0) THEN -- SE TRATA DE UN PACIENTE NUEVO  
		BEGIN
			INSERT INTO PACIENTES (
				NU_TIPD_PAC, NU_DOCU_PAC, 
				DE_PRAP_PAC, DE_SGAP_PAC, 
				NO_NOMB_PAC, NO_SGNO_PAC, 
				FE_NACI_PAC, NU_NUME_REG_PAC, 
				NU_SEXO_PAC,CD_CODI_LUAT_PAC, 
				CD_CODI_DPTO_PAC, CD_CODI_MUNI_PAC, 
				DE_DIRE_PAC, DE_TELE_PAC, 
				NU_ESCI_PAC, FE_HIST_PAC, 
				CD_CODI_CAM_PAC, NU_ESTA_PAC, 
				CD_CODI_ZORE_PAC, DE_EMAIL_PAC,   
				CD_CODI_OCUP_PAC, NU_CONS_HIST_PAC, 
				NU_TIPO_PAC, CD_CODI_RELI_PAC, 
				CD_CODI_BAR_PAC, NU_GEST_PAC,   
				CD_CODI_DPTO_TRAB_PAC, CD_CODI_MUNI_TRAB_PAC, 
				CD_CODI_DPTO_NACI_PAC, CD_CODI_MUNI_NACI_PAC, 
				TX_TELTRAB_PAC, TX_DIRTRAB_PAC, 
				TX_NOMBRESP_PAC, CD_CODI_PARE_PAC, 
				TX_DIRRESP_PAC, TX_TELRESP_PAC, 
				ME_INFOAD_PAC, NU_FALLE_PAC,  
				NU_HIST_PAC, CD_CODI_PAIS_PAC, 
				CD_CODI_PAIS_TRAB_PAC, CD_CODI_PAIS_NACI_PAC, 
				CD_CODI_ESCO_PAC, NU_ACTI_EPS_PAC,   
				NU_TERC_PAC, NU_DATOS_EXT_PAC, 
				DE_CELU_PAC, TX_CODIGO_ETNI_PACI, 
				TX_DISCAPACIDAD_PACI, NU_AUTO_TIRH, 
				CD_CODI_LOC_PAC, DE_OTRO_TELE_PAC, 
				NU_ISDESPLAZADO_PAC, TX_CODIGO_TICO_PAC, 
				INASISTIO_CIT_PAC)  	            
			VALUES (
				V_NU_TIPD_PAC, V_NU_DOCU_PAC, 
				V_DE_PRAP_PAC, V_DE_SGAP_PAC, 
				V_NO_NOMB_PAC, V_NO_SGNO_PAC, 
				V_FE_NACI_PAC, V_NU_NUME_REG_PAC, 
				V_NU_SEXO_PAC, V_CD_CODI_LUAT_PAC, 
				V_CD_CODI_DPTO_PAC, V_CD_CODI_MUNI_PAC, 
				V_DE_DIRE_PAC, V_DE_TELE_PAC, 
				V_NU_ESCI_PAC, V_FE_HIST_PAC, 
				V_CD_CODI_CAM_PAC, V_NU_ESTA_PAC, 
				V_CD_CODI_ZORE_PAC, V_DE_EMAIL_PAC,   
				V_CD_CODI_OCUP_PAC, V_NU_CONS_HIST_PAC, 
				V_NU_TIPO_PAC, V_CD_CODI_RELI_PAC, 
				V_CD_CODI_BAR_PAC, V_NU_GEST_PAC,   
				V_CD_CODI_DPTO_TRAB_PAC, V_CD_CODI_MUNI_TRAB_PAC, 
				V_CD_CODI_DPTO_NACI_PAC, V_CD_CODI_MUNI_NACI_PAC, 
				V_TX_TELTRAB_PAC, V_TX_DIRTRAB_PAC, 
				V_TX_NOMBRESP_PAC, V_CD_CODI_PARE_PAC, 
				V_TX_DIRRESP_PAC, V_TX_TELRESP_PAC, 
				V_ME_INFOAD_PAC, V_NU_FALLE_PAC,  
				V_NU_HIST_PAC, V_CD_CODI_PAIS_PAC, 
				V_CD_CODI_PAIS_TRAB_PAC, V_CD_CODI_PAIS_NACI_PAC, 
				V_CD_CODI_ESCO_PAC, V_NU_ACTI_EPS_PAC,   
				V_NU_TERC_PAC, V_NU_DATOS_EXT_PAC, 
				V_DE_CELU_PAC, V_CODIGOETNIA, 
				V_DISCAPACIDAD, V_NU_AUTO_TIRH, 
				V_CD_CODI_LOC_PAC, V_DE_OTRO_TELE_PAC,
				V_NU_ISDESPLAZADO_PAC, V_TX_CODIGO_TICO_PAC, 
				V_INASISTIO_CIT_PAC);

			V_NUEVO := 1;
		END;	
	ELSE
		BEGIN
			  
			UPDATE PACIENTES  
			SET  NU_TIPD_PAC = V_NU_TIPD_PAC,  
				NU_DOCU_PAC =V_NU_DOCU_PAC,  
				DE_PRAP_PAC =V_DE_PRAP_PAC,  
				DE_SGAP_PAC =V_DE_SGAP_PAC,  
				NO_NOMB_PAC=V_NO_NOMB_PAC,  
				NO_SGNO_PAC=V_NO_SGNO_PAC,  
				FE_NACI_PAC =V_FE_NACI_PAC ,  
				NU_NUME_REG_PAC =V_NU_NUME_REG_PAC ,  
				NU_SEXO_PAC =V_NU_SEXO_PAC ,  
				CD_CODI_LUAT_PAC =V_CD_CODI_LUAT_PAC ,  
				CD_CODI_DPTO_PAC =V_CD_CODI_DPTO_PAC ,  
				CD_CODI_MUNI_PAC =V_CD_CODI_MUNI_PAC ,  
				DE_DIRE_PAC =V_DE_DIRE_PAC ,  
				DE_TELE_PAC=V_DE_TELE_PAC,  
				NU_ESCI_PAC=V_NU_ESCI_PAC,  
				FE_HIST_PAC=V_FE_HIST_PAC,  
				CD_CODI_CAM_PAC=V_CD_CODI_CAM_PAC,  
				NU_ESTA_PAC=V_NU_ESTA_PAC,  
				CD_CODI_ZORE_PAC=V_CD_CODI_ZORE_PAC,  
				DE_EMAIL_PAC =V_DE_EMAIL_PAC ,  
				CD_CODI_OCUP_PAC=V_CD_CODI_OCUP_PAC,  
				NU_CONS_HIST_PAC=V_NU_CONS_HIST_PAC,  
				NU_TIPO_PAC=V_NU_TIPO_PAC,  
				CD_CODI_RELI_PAC =V_CD_CODI_RELI_PAC ,  
				CD_CODI_BAR_PAC=V_CD_CODI_BAR_PAC,  
				NU_GEST_PAC=V_NU_GEST_PAC,  
				CD_CODI_DPTO_TRAB_PAC=V_CD_CODI_DPTO_TRAB_PAC,  
				CD_CODI_MUNI_TRAB_PAC=V_CD_CODI_MUNI_TRAB_PAC,  
				CD_CODI_DPTO_NACI_PAC=V_CD_CODI_DPTO_NACI_PAC,  
				CD_CODI_MUNI_NACI_PAC=V_CD_CODI_MUNI_NACI_PAC,  
				TX_TELTRAB_PAC=V_TX_TELTRAB_PAC,  
				TX_DIRTRAB_PAC=V_TX_DIRTRAB_PAC,  
				TX_NOMBRESP_PAC=V_TX_NOMBRESP_PAC,  
				CD_CODI_PARE_PAC=V_CD_CODI_PARE_PAC,  
				TX_DIRRESP_PAC=V_TX_DIRRESP_PAC,  
				TX_TELRESP_PAC=V_TX_TELRESP_PAC,  
				ME_INFOAD_PAC=V_ME_INFOAD_PAC,  
				NU_FALLE_PAC=V_NU_FALLE_PAC,  
				CD_CODI_PAIS_PAC=V_CD_CODI_PAIS_PAC,  
				CD_CODI_PAIS_TRAB_PAC=V_CD_CODI_PAIS_TRAB_PAC,  
				CD_CODI_PAIS_NACI_PAC=V_CD_CODI_PAIS_NACI_PAC,  
				CD_CODI_ESCO_PAC=V_CD_CODI_ESCO_PAC,  
				NU_ACTI_EPS_PAC = V_NU_ACTI_EPS_PAC,  
				NU_TERC_PAC = V_NU_TERC_PAC,  
				NU_DATOS_EXT_PAC = V_NU_DATOS_EXT_PAC,  
				DE_CELU_PAC = V_DE_CELU_PAC ,  
				TX_CODIGO_ETNI_PACI = V_CODIGOETNIA,  
				TX_DISCAPACIDAD_PACI = V_DISCAPACIDAD,  
				NU_AUTO_TIRH = V_NU_AUTO_TIRH,  
				CD_CODI_LOC_PAC = V_CD_CODI_LOC_PAC,  
				INFO_PAC_COMPLETA = 1,  
				DE_OTRO_TELE_PAC = V_DE_OTRO_TELE_PAC,
				NU_ISDESPLAZADO_PAC = V_NU_ISDESPLAZADO_PAC,
				TX_CODIGO_TICO_PAC = V_TX_CODIGO_TICO_PAC,
				INASISTIO_CIT_PAC = V_INASISTIO_CIT_PAC
			WHERE NU_HIST_PAC=V_NU_HIST_PAC;  

			V_NUEVO := 0;	
		END;	
	END IF;

END;