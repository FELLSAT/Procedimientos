CREATE OR REPLACE PROCEDURE H3i_SP_RECU_PACMASUNAAFI
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  cv_1 OUT SYS_REFCURSOR
)
AS
  V_VL_VALO_CONT CONTROL.VL_VALO_CONT%TYPE;
BEGIN
  SELECT VL_VALO_CONT INTO V_VL_VALO_CONT FROM CONTROL WHERE  CD_CONC_CONT = 'COD_ESTA_AFILIA_ACTIVO';

   OPEN  cv_1 FOR
        SELECT COUNT(NU_HIST_PAC_RPE),
             NU_HIST_PAC_RPE ,
             NU_DOCU_PAC ,
             NU_TIPD_PAC ,
             TX_NOMBRECOMPLETO_PAC ,
             CD_NIT_EPS_RPE ,
             NO_NOMB_EPS ,
             CD_CODI_REG_RPE ,
             NO_NOMB_REG ,
             NU_AFIL_RPE ,
             CD_CODI_ESAF_RPE ,
             DE_DESCRIP_ESAF 
        FROM R_PAC_EPS 
            INNER JOIN EPS    
            ON CD_NIT_EPS = CD_NIT_EPS_RPE
            INNER JOIN REGIMEN    
            ON CD_CODI_REG = CD_CODI_REG_RPE
            INNER JOIN PACIENTES    
            ON NU_HIST_PAC = NU_HIST_PAC_RPE
            INNER JOIN ESTADOS_AFILIACION    
            ON CD_CODI_ESAF = CD_CODI_ESAF_RPE
        WHERE CD_CODI_ESAF_RPE IN ( SELECT FNSPLIT(V_VL_VALO_CONT, ',') FROM DUAL)
          AND NU_HIST_PAC_RPE IN ( 
                                    SELECT NU_HIST_PAC_RPE 
                                    FROM R_PAC_EPS 
                                    GROUP BY NU_HIST_PAC_RPE,CD_NIT_EPS_RPE
                                    HAVING COUNT(NU_HIST_PAC_RPE)  > 2 
                                  )
        GROUP BY NU_HIST_PAC_RPE,NU_DOCU_PAC,NU_TIPD_PAC,TX_NOMBRECOMPLETO_PAC,CD_NIT_EPS_RPE,NO_NOMB_EPS,CD_CODI_REG_RPE,NO_NOMB_REG,NU_AFIL_RPE,CD_CODI_ESAF_RPE,DE_DESCRIP_ESAF
        ORDER BY TX_NOMBRECOMPLETO_PAC ;
   DBMS_OUTPUT.PUT_LINE('SE HA CREADO EL PROCEDIMIENTO ALMACENADO H3i_SP_RECU_PACMASUNAAFI');

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_RECU_PACMASUNAAFI;