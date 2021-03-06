CREATE OR REPLACE PROCEDURE H3i_SP_BUSCAR_ACT_SUBPROG_UNAL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================

(
  v_NU_CODI_SUBP_SUAC IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT act.NU_CODI_ACSA ,
             act.DE_NOMB_ACSA 
        FROM R_SUBPRO_ACTI_UNAL 
               JOIN ACTIVIDAD_SALUD_UNAL act   ON R_SUBPRO_ACTI_UNAL.NU_CODI_ACSA_SUAC = act.NU_CODI_ACSA
       WHERE  ( R_SUBPRO_ACTI_UNAL.NU_CODI_SUBP_SUAC = v_NU_CODI_SUBP_SUAC ) ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;