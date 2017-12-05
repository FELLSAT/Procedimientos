CREATE GLOBAL TEMPORARY TABLE TT_TMPAGENDADIA2(
	FE_HORA_CIT VARCHAR2(18) NOT NULL,
	NU_HIST_PAC VARCHAR2(20) NOT NULL, 
	NOMB_PAC VARCHAR(300) NOT NULL,
	NU_TIPD_PAC VARCHAR2(22) NOT NULL, 
	NU_DOCU_PAC VARCHAR2(20) NOT NULL,
	NU_SEXO_PAC VARCHAR2(22) NOT NULL, 
	FE_NACI_PAC DATE NOT NULL,
	DE_TELE_PAC VARCHAR2(30) NOT NULL, 
	NU_ESTA_CIT NUMBER(22) NOT NULL,
	NO_NOMB_EPS VARCHAR2(100) NOT NULL, 
	NO_NOMB_SER VARCHAR2(255) NOT NULL,
	NO_NOMB_MED VARCHAR2(70) NOT NULL, 
	NO_NOMB_USUA VARCHAR2(170) NOT NULL,
	DE_DESC_CIT VARCHAR(255), 
	NU_TIPO_CIT VARCHAR2(22), 
	NU_NUME_CIT NUMBER(22) NOT NULL, 
	TX_OBSFIN_CIT VARCHAR2(3000),  
	NU_CONFIR_CIT NUMBER(22) NOT NULL, 
	NU_NUME_MOVI_CIT NUMBER(22), 
	FE_FECH_CIT DATE, 
	NU_DURA_CIT NUMBER(22), 
	CD_CODI_SER_CIT VARCHAR2(12), 
	CD_CODI_ESP_CIT VARCHAR2(3),
	TX_CAUSA_INASISTENCIA VARCHAR2(255), 
	CD_CODI_MEDI_EST_ACDE VARCHAR2(10),
	NOM_EST_AUT VARCHAR2(70) NOT NULL,
	CD_CODI_MED_EST_CIT VARCHAR2(10),
	NOM_EST_CITA VARCHAR2(70) NOT NULL,
	NU_NUME_IND_SER NUMBER(22) NOT NULL,
	CD_CODI_PLANTILLA NUMBER(22)
) ON COMMIT DELETE ROWS;