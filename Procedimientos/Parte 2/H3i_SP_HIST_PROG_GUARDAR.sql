CREATE OR REPLACE PROCEDURE H3i_SP_HIST_PROG_GUARDAR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_HIST_PAC_HIPR IN VARCHAR2,
  v_NU_CODI_PRSA_HIPR IN NUMBER,
  v_NU_CODI_SUBP_HIPR IN NUMBER,
  v_NU_CODI_ACSA_HIPR IN NUMBER,
  v_NU_NUME_CONE_HIPR IN NUMBER
)
AS

BEGIN

   INSERT INTO HIST_PROG
     ( NU_HIST_PAC_HIPR, NU_CODI_PRSA_HIPR, NU_CODI_SUBP_HIPR, NU_CODI_ACSA_HIPR, FE_MATRICULA_HIPR, NU_NUME_CONE_HIPR, ES_ACT_PYP_HIRP )
     VALUES ( v_NU_HIST_PAC_HIPR, v_NU_CODI_PRSA_HIPR, v_NU_CODI_SUBP_HIPR, v_NU_CODI_ACSA_HIPR, SYSDATE, v_NU_NUME_CONE_HIPR, 0 );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_HIST_PROG_GUARDAR;