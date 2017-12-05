CREATE OR REPLACE PROCEDURE H3i_SP_RECU_PAC_NOM_COMP
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_DE_PRAP_PAC IN VARCHAR2,
  v_DE_SGAP_PAC IN VARCHAR2,
  v_NO_NOMB_PAC IN VARCHAR2,
  v_NO_SGNO_PAC IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

   OPEN  cv_1 FOR
      SELECT NU_TIPD_PAC ,
             NU_DOCU_PAC ,
             DE_PRAP_PAC ,
             NVL(DE_SGAP_PAC, ' ') DE_SGAP_PAC  ,
             NO_NOMB_PAC ,
             NVL(NO_SGNO_PAC, ' ') NO_SGNO_PAC  
        FROM PACIENTES 
       WHERE  DE_PRAP_PAC = v_DE_PRAP_PAC
                AND NVL(DE_SGAP_PAC, ' ') = v_DE_SGAP_PAC
                AND NO_NOMB_PAC = v_NO_NOMB_PAC
                AND NVL(NO_SGNO_PAC, ' ') = v_NO_SGNO_PAC ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_RECU_PAC_NOM_COMP;