CREATE OR REPLACE PROCEDURE H3i_SP_OBT_PACIENTE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_HIST_PAC IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT NU_TIPD_PAC ,
            NU_HIST_PAC ,
            FE_NACI_PAC ,
            NU_SEXO_PAC ,
            NU_TIPO_PAC ,
            TX_NOMBRECOMPLETO_PAC 
        FROM  PACIENTES 
        WHERE  NU_HIST_PAC = v_NU_HIST_PAC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;