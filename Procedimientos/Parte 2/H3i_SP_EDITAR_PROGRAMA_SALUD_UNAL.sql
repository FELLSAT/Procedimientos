CREATE OR REPLACE PROCEDURE H3i_SP_EDIT_PROGRAM_SALUD_UNAL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_NU_CODI_PRSA	IN NU_CODI_PRSA,
	V_DE_NOMB_PRSA	IN DE_NOMB_PRSA,
	V_DE_DESC_PRSA	IN DE_DESC_PRSA,
	V_NU_ESTA_PRSA	IN NU_ESTA_PRSA,
	V_NU_CODI_SUBP_PRSU IN VARCHAR2
)
AS
BEGIN
	
	UPDATE PROGRAMA_SALUD_UNAL
	SET DE_NOMB_PRSA = V_DE_NOMB_PRSA,
		DE_DESC_PRSA = V_DE_DESC_PRSA,
		NU_ESTA_PRSA = V_NU_ESTA_PRSA
	WHERE NU_CODI_PRSA = V_NU_CODI_PRSA;


	DELETE R_PROG_SUBPROG_UNAL
	WHERE NU_CODI_PRSA_PRSU = V_NU_CODI_PRSA;


	INSERT INTO SubProgramas
	SELECT * FROM fnSplit(V_NU_CODI_SUBP_PRSU, ',');


	INSERT INTO R_PROG_SUBPROG_UNAL
	SELECT V_NU_CODI_PRSA, ITEM FROM SubProgramas


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_EDIT_PROGRAM_SALUD_UNAL;