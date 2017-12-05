CREATE OR REPLACE PROCEDURE H3i_SOLICITUD_SERVS_PENDIENTES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_nu_auto_soli IN NUMBER,
	V_cd_serv_soli IN VARCHAR2,
	V_nu_hist_soli IN VARCHAR2,
	V_de_desc_soli IN VARCHAR2,
	V_cd_espe_soli IN VARCHAR2,
	V_nu_conv_soli IN NUMBER
)


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	INSERT INTO SOLICITUD_SERVICIOS(
		CD_SERV_SOSE, NU_HIST_PAC_SOSE,
		DE_SERV_SOSE, CD_CODI_ESP_SSOL,
		NU_CONV_PAC_REG, CD_ORAT_SOSE,
		CD_PRAT_SOSE, CD_UBIC_SOSE)
	VALUES(
		V_cd_serv_soli, V_nu_hist_soli,
		V_de_desc_soli, V_cd_espe_soli ,
		V_nu_conv_soli, '0', '', '');

	--INSERTA EN LA TABLA QUE RELACIONA LAS SOLICITUDES DE LOS SERVICIOS 
	INSERT INTO R_SOSE_SOLI(
		NU_AUTO_SOSE_RSO, NU_AUTO_SOLI_RSO)
	VALUES (
		(select max(NU_AUTO_SOSE) from SOLICITUD_SERVICIOS),
		V_nu_auto_soli);

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);	
END;