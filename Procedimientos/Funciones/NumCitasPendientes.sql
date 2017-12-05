CREATE OR REPLACE FUNCTION NumCitasPendientes
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_NumCit IN NUMBER
)
RETURN NUMBER
AS
    v_CodServicio VARCHAR2(20);
    v_NumAsignadas NUMBER;
    v_NumPendientes NUMBER;
    v_FechaCit VARCHAR2(20);
    v_CodMedico VARCHAR2(20);

BEGIN
    SELECT CD_CODI_SER_CIT ,
        FE_FECH_CIT ,
        CD_CODI_MED_CIT 
    INTO v_CodServicio,
        v_FechaCit,
        v_CodMedico
    FROM CITAS_MEDICAS 
    WHERE  NU_NUME_CIT = v_NumCit
    AND NU_ESTA_CIT <> 3;


    SELECT COUNT(NU_NUME_CIT)  
    INTO v_NumAsignadas
    FROM CITAS_MEDICAS 
    WHERE  CD_CODI_MED_CIT = v_CodMedico
        AND FE_FECH_CIT = v_FechaCit
        AND NU_ESTA_CIT <> 3;--QUE NO ESTE ANULADA

    SELECT SERVICIOS.NU_MAXPACGRU_SER - v_NumAsignadas
    INTO v_NumPendientes
    FROM SERVICIOS 
    WHERE  CD_CODI_SER = v_CodServicio
        AND NU_ESGRUPAL_SER = 1;

    IF v_NumPendientes IS NULL OR v_NumPendientes < 0 THEN
        v_NumPendientes := 0 ;
    END IF;

    
    RETURN v_NumPendientes;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;