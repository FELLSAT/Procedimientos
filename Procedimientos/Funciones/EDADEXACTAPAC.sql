CREATE OR REPLACE FUNCTION EDADEXACTAPAC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_HistPac IN VARCHAR2,
    v_FECHACOMPARA IN DATE
)
RETURN VARCHAR2
AS
    v_FECHA VARCHAR2(200);

BEGIN

    SELECT FE_NACI_PAC 
    INTO v_FECHA
    FROM PACIENTES 
    WHERE  NU_HIST_PAC = v_HistPac;

    IF (v_FECHA <> NULL ) THEN
        DECLARE
            v_Años NUMBER(10,0);
            v_MESES NUMBER(10,0);
            v_DIAS NUMBER(10,0);
   
        BEGIN
            v_AÑOS := (TO_CHAR(v_FECHACOMPARA,'DD') - TO_CHAR(v_fecha,'DD')) / 365.25 ;
            v_DIAS := MOD((TO_CHAR(v_FECHACOMPARA,'DD') - TO_CHAR(v_fecha,'DD')), 365.25) ;
            v_MESES := v_DIAS / (365.25 / 12) ;
            v_DIAS := MOD(v_DIAS, (365.25 / 12)) ;
            RETURN TO_CHAR(v_Años) || ' Años ' || TO_CHAR(v_MESES) || ' Meses ' || TO_CHAR(v_DIAS) || ' Días';   
        END;
   END IF;
   
   RETURN NULL;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;