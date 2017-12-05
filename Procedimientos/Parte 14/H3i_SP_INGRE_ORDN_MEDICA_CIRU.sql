CREATE OR REPLACE PROCEDURE H3i_SP_INGRE_ORDN_MEDICA_CIRU
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_NU_CIR_HMED IN NUMBER,
	V_NU_NUME_HEVO_HMED IN NUMBER,
	V_CD_CODI_ARTI_HMED IN VARCHAR2,
	V_NO_NOMB_ARTI_HMED IN VARCHAR2,
	V_NU_POSI_HMED IN NUMBER,
	V_DE_UNME_HMED IN VARCHAR2,
	V_DE_CTRA_HMED IN VARCHAR2,
	V_DE_DOSIS_HMED IN VARCHAR2,
	V_NU_CANT_HMED IN NUMBER,
	V_NU_ORDE_HMED IN NUMBER,
	V_DE_VIA_ADMIN_HMED IN VARCHAR2,
	V_DE_FREC_ADMIN_HMED IN VARCHAR2,
	V_NU_NUME_DUR_TRAT_HMED IN VARCHAR2,
	V_NU_UNFRE_HMED IN VARCHAR2,
	V_TX_OBSERV_HED IN VARCHAR2,
	V_NU_TIPO_HMED IN NUMBER,
	V_FE_FECH_FORM_HMED IN VARCHAR2,
	V_NU_LABO_EVOL IN NUMBER DEFAULT NULL
)

AS
BEGIN

	INSERT INTO HIST_MEDI (	
		NU_NUME_HICL_HMED, 
		NU_NUME_HEVO_HMED, 
		CD_CODI_ARTI_HMED, 
		NO_NOMB_ARTI_HMED, 
		NU_POSI_HMED, 
		DE_UNME_HMED, 
		DE_CTRA_HMED, 
		DE_DOSIS_HMED, 
		NU_CANT_HMED, 
		NU_ORDE_HMED, 
		DE_VIA_ADMIN_HMED, 
		DE_FREC_ADMIN_HMED, 
		NU_NUME_DUR_TRAT_HMED, 
		NU_UNFRE_HMED, 
		TX_OBSERV_HED, 
		NU_TIPO_HMED, 
		FE_FECH_FORM_HMED, 
		NU_ESTA_HMED,
		NU_LABO_EVOL,
		NU_CIR_HMED)
	VALUES	(	
		0, 
		V_NU_NUME_HEVO_HMED, 
		V_CD_CODI_ARTI_HMED, 
		V_NO_NOMB_ARTI_HMED, 
		V_NU_POSI_HMED, 
		V_DE_UNME_HMED, 
		V_DE_CTRA_HMED, 
		V_DE_DOSIS_HMED, 
		V_NU_CANT_HMED, 
		V_NU_ORDE_HMED, 
		V_DE_VIA_ADMIN_HMED, 
		V_DE_FREC_ADMIN_HMED, 
		V_NU_NUME_DUR_TRAT_HMED, 
		V_NU_UNFRE_HMED, 
		V_TX_OBSERV_HED, 
		V_NU_TIPO_HMED, 
		V_FE_FECH_FORM_HMED,
		1,
		V_NU_LABO_EVOL,
		V_NU_CIR_HMED);


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;

	