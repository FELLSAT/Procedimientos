--===============================
--Tabla temporal que usa el procedimiento H3i_SP_CONSULTA_ELEMENTOS
--===============================

CREATE GLOBAL TEMPORARY TABLE RESULTADO (
	CD_CODI_ARTI VARCHAR2(16) NOT NULL,
	NO_NOMB_ARTI VARCHAR2(60) NOT NULL,
	DE_UNME_ARTI VARCHAR2(30) NULL,
	DE_CTRA_ARTI VARCHAR2(30) NULL,
	DE_FOFA_ARTI VARCHAR2(60) NULL,
	CT_EXIS_DEAR FLOAT        DEFAULT (0) NOT NULL,
	CD_TARI_TAAR VARCHAR2(2) NOT NULL,
	VL_PREC_TAAR FLOAT        DEFAULT 0 NOT NULL,
	VALOR_COPAGO FLOAT        DEFAULT 0 NOT NULL,
	TIPO_COPAGO NUMBER NULL
) ON COMMIT DELETE ROWS;