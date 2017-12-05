CREATE OR REPLACE PROCEDURE H3i_AUTORIZAR_SERVS_PENDIENTES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_nu_auto_soli IN NUMBER,
	V_cd_serv_soli IN VARCHAR2,
	V_nu_hist_soli IN VARCHAR2,
	V_fe_fech_soli IN VARCHAR2,
	V_usuario IN VARCHAR2,
	V_de_desc_soli IN VARCHAR2,
	V_nu_esta_soli IN VARCHAR2,
	V_cd_medi_soli IN VARCHAR2,
	V_cd_espe_soli IN VARCHAR2,
	V_CT_CANT_SOLI IN VARCHAR2,
	V_DE_JUST_soli IN VARCHAR2
)
AS
BEGIN
	INSERT INTO Solicitudes(
		nu_auto_soli, cd_serv_soli,
		nu_hist_soli, fe_fech_soli,
		usuario, de_desc_soli,
		nu_esta_soli, cd_medi_soli,
		cd_espe_soli, CT_CANT_SOLI,
		DE_JUST_soli)
	VALUES(
		V_nu_auto_soli, V_cd_serv_soli,
		V_nu_hist_soli,V_fe_fech_soli,
		V_usuario, V_de_desc_soli,
		V_nu_esta_soli, V_cd_medi_soli,
		V_cd_espe_soli, V_CT_CANT_SOLI,
		V_DE_JUST_soli);


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;