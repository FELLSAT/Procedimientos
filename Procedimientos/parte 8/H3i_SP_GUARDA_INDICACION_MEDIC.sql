CREATE OR REPLACE PROCEDURE H3i_SP_GUARDA_INDICACION_MEDIC 
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NoHICL IN NUMBER,
  v_Descripcion IN VARCHAR2,
  v_NoHEVO_HIND IN NUMBER,
  v_NU_LABO_EVOL IN NUMBER DEFAULT NULL 
)
AS

BEGIN

   	INSERT INTO HIST_INDI( 
   		DE_DESC_HIND, NU_NUME_HEVO_HIND, 
   		NU_NUME_HICL_HIND, NU_LABO_EVOL)
    VALUES ( 
     	v_Descripcion, v_NoHEVO_HIND, 
     	v_NoHICL, v_NU_LABO_EVOL );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;