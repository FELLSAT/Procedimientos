CREATE OR REPLACE FUNCTION CentroCostoxCargo  
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NU_NUME_MOVI IN NUMBER,
    v_SubCentroCosto IN NUMBER
)
RETURN VARCHAR2
AS
    v_CENTRO VARCHAR2(20);
    v_SUBCENTRO VARCHAR2(20);
    v_RTA VARCHAR2(20);
BEGIN
   --CENTRO Y SUB CENTRO DE COSTO
    SELECT DISTINCT CD_CODI_CC_RLD_RDES ,
        CD_CODI_SUBCC_RDES
    INTO v_CENTRO,
        v_SUBCENTRO
    FROM R_DEP_ESP_SER ,
        MOVI_CARGOS ,
        R_LUAT_DEPE ,
        LABORATORIO 
    WHERE  NU_NUME_MOVI_LABO = NU_NUME_MOVI
        AND CD_CODI_SER_RDES = CD_CODI_SER_LABO
        AND CD_CODI_LUAT_MOVI = CD_CODI_LUAT_RLD
        AND CD_CODI_CECO_MOVI = CD_CODI_CECO_RLD
        AND NU_NUME_MOVI = v_NU_NUME_MOVI;


    IF v_SubCentroCosto = 1 THEN
        v_RTA := v_SUBCENTRO ;
    ELSE
        v_RTA := v_CENTRO ;
    END IF;


    RETURN v_RTA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;