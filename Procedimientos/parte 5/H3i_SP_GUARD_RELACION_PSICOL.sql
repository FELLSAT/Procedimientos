CREATE OR REPLACE PROCEDURE H3i_SP_GUARD_RELACION_PSICOL -- CREANDO PROCEDIMIENTO ENCARGADO DE GUARDAR RELACIONES PSICOLOGICAS DE UNA PERSONA QUE CONFORMA EL GENOGRAMA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_PER IN NUMBER,
  v_NU_NUME_PER_MARIT IN NUMBER,
  v_NU_TIPO_REL IN NUMBER
)
AS

BEGIN

   INSERT INTO HIST_GENO_REL_FAM
     ( NU_NUME_PER_A, NU_NUME_PER_B, TIPO )
     VALUES ( v_NU_NUME_PER, v_NU_NUME_PER_MARIT, v_NU_TIPO_REL );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;