 -- =============================================      
 -- Tabla temporal que usa el procedimiento H3i_SP_RPT_PAI_NOPAI_P
 -- =============================================
CREATE GLOBAL TEMPORARY TABLE TEMP
(
	VACUNA VARCHAR2(150),
	DOSIS NUMBER,
	REGIMEN VARCHAR2(150),
	Tipo VARCHAR2(10),
	FechaNacimiento DATE,
	FechaVacunacion DATE,
	EDAD NUMBER,
	UME NUMBER,
	DESPLAZADO VARCHAR2(1)		
) ON COMMIT DELETE ROWS;