CREATE OR REPLACE PROCEDURE H3i_SP_CONS_MED_NEURAL_TERAPE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
 (
 	V_NUM_HIS_PAC IN VARCHAR2,
	V_INI IN DATE,
	V_FIN IN DATE,
	CV_1 OUT SYS_REFCURSOR
 )
				
AS
BEGIN
	OPEN CV_1 FOR
		 SELECT hist.FE_FECH_HICL,
		 		(SELECT TX_CODCOMPL_HITE
		  		 FROM HISTORIACLINICA
		  		 INNER JOIN R_PLAN_CONC 
		  		 	ON NU_NUME_PLHI_RPC = NU_NUME_PLHI_HICL
				 INNER JOIN CONCEPTO_HIST 
				 	ON NU_NUME_COHI = NU_NUME_COHI_RPC
				 INNER JOIN HIST_TEXT 
				 	ON NU_NUME_HICL = NU_NUME_HICL_HITE 
				 	AND NU_INDI_RPC = NU_INDI_HITE
		  		 WHERE NU_NUME_PLHI_HICL = '1558' 
		  		 	AND	NU_NUME_HICL = hist.NU_NUME_HICL
					AND NU_INDI_RPC = 241 ) AS DXNT,
		  		(SELECT TX_CODCOMPL_HITE
		  FROM HISTORIACLINICA 
		  INNER JOIN R_PLAN_CONC 
		  	 ON NU_NUME_PLHI_RPC = NU_NUME_PLHI_HICL
		  INNER JOIN CONCEPTO_HIST 
		  	 ON NU_NUME_COHI = NU_NUME_COHI_RPC
		  INNER JOIN HIST_TEXT 
		  	 ON NU_NUME_HICL = NU_NUME_HICL_HITE 
		  	 AND NU_INDI_RPC = NU_INDI_HITE
		  WHERE NU_NUME_PLHI_HICL = '1558' 
		  	 AND NU_NUME_HICL = hist.NU_NUME_HICL 
				and NU_INDI_RPC = 242 ) AS AMNT
		  FROM HISTORIACLINICA hist 
		  inner join LABORATORIO 
		  	 on NU_NUME_LABO_HICL = NU_NUME_LABO
		  inner join MOVI_CARGOS 
		  	 on NU_NUME_MOVI = NU_NUME_MOVI_LABO
		  inner join PACIENTES 
		  	 on NU_HIST_PAC = NU_HIST_PAC_MOVI 
		  WHERE NU_NUME_PLHI_HICL = '1558' AND
				NU_HIST_PAC = V_NUM_HIS_PAC AND
				hist.FE_FECINI_HICL BETWEEN V_INI AND V_FIN;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;