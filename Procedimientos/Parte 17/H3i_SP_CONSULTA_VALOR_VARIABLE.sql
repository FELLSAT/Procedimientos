
CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_VALOR_VARIABLE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_HISTORIAPAC IN VARCHAR2,
	V_INDICECONC IN NUMBER,
	V_NUMEROPLANTILLA IN NUMBER,
	CV_1 OUT SYS_REFCURSOR
)
AS
BEGIN
	OPEN CV_1 FOR
		SELECT DISTINCT NU_DESC_HINU
		FROM MOVI_CARGOS
		INNER JOIN LABORATORIO LAB 
			ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
		INNER JOIN HISTORIACLINICA HC 
			ON NU_NUME_LABO_HICL = NU_NUME_LABO
		INNER JOIN HIST_NUME HN 
			ON NU_NUME_HICL_HINU = NU_NUME_HICL
		INNER JOIN R_PLAN_CONC 
			ON NU_INDI_RPC = HN.NU_INDI_HINU
		WHERE NU_HIST_PAC_MOVI = V_HISTORIAPAC 
			AND HN.NU_INDI_HINU = V_INDICECONC 
			AND HC.NU_NUME_PLHI_HICL = V_NUMEROPLANTILLA;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);		
END;

		