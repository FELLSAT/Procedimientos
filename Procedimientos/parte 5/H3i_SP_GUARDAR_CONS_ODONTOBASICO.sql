CREATE OR REPLACE PROCEDURE H3i_SP_GUARD_CONS_ODONTOBASICO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_CD_INS_UP_CONSULTA OUT NUMBER,
	V_NUM_HCLI IN VARCHAR2,
	V_FECHA_CONS IN DATE,
	V_NUM_LABO IN NUMBER,
	V_PRES_COP IN VARCHAR2,
	V_SANO_COP IN VARCHAR2,
	V_CAR_COP IN VARCHAR2,
	V_OBT_COP IN VARCHAR2,
	V_PERD_COP IN VARCHAR2,
	V_TOTAL_COP IN VARCHAR2,
	V_PRES_CEO IN VARCHAR2,
	V_SANO_CEO IN VARCHAR2,
	V_CAR_CEO IN VARCHAR2,
	V_OBT_CEO IN VARCHAR2,
	V_PERD_CEO IN VARCHAR2,
	V_TOTAL_CEO IN VARCHAR2
)	
AS
BEGIN
	INSERT INTO HIST_ODO_CONSULTAS(
			NU_HCLI_PAC_ODO, FE_CONS_ODO,
			CD_NUM_LABO, VAL_PRESEN_COP,
			VAL_SANOS_COP, VAL_CARIAD_COP,
			VAL_OBTUR_COP, VAL_PERDID_COP,
			VAL_COP, VAL_PRESEN_CEO,
			VAL_SANOS_CEO, VAL_CARIAD_CEO,
			VAL_OBTUR_CEO, VAL_PERDID_CEO,
			VAL_CEO) 
	VALUES (V_NUM_HCLI, V_FECHA_CONS,
			V_NUM_LABO,	V_PRES_COP,
			V_SANO_COP,	V_CAR_COP,
			V_OBT_COP, V_PERD_COP,
			V_TOTAL_COP, V_PRES_CEO,
			V_SANO_CEO,	V_CAR_CEO,
			V_OBT_CEO, V_PERD_CEO,
			V_TOTAL_CEO);
	
	SELECT CD_CONS_ODO 
	INTO V_CD_INS_UP_CONSULTA 
    FROM HIST_ODO_CONSULTAS
    WHERE CD_CONS_ODO = (SELECT MAX(CD_CONS_ODO) FROM HIST_ODO_CONSULTAS);


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;