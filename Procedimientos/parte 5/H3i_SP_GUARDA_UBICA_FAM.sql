CREATE OR REPLACE PROCEDURE H3i_SP_GUARDA_UBICA_FAM --PROCEDIMIENTO ENCARGADO DE GUARDAR LAS UBICACIONES FAMILIARES DE UNA FAMILIA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COLOR IN VARCHAR2,
  v_ANIO IN VARCHAR2,
  v_NU_NUME_ARB IN NUMBER,
  v_NU_NUME_UBICA OUT NUMBER
)
AS

BEGIN

   	INSERT INTO HIST_GENO_UBICA_FAM
    (NU_NUME_ARB, COLOR, ANIO )
    VALUES ( v_NU_NUME_ARB, v_COLOR, v_ANIO );

    SELECT NU_NUME_UBICA 
	INTO v_NU_NUME_UBICA 
    FROM HIST_GENO_UBICA_FAM
    WHERE NU_NUME_UBICA = (SELECT MAX(NU_NUME_UBICA) FROM HIST_GENO_UBICA_FAM);

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;