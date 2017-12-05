CREATE OR REPLACE PROCEDURE H3i_SP_PLANTILLA_HIST_INS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NoPlantilla IN NUMBER,
  v_Tipo IN VARCHAR2,
  v_EdadInicial IN NUMBER,
  v_TipoEdadInicial IN NUMBER,
  v_EdadFinal IN NUMBER,
  v_TipoEdadFinal IN NUMBER,
  v_Sexo IN NUMBER,
  v_Post_guard IN NUMBER,
  v_Condi_gesta IN NUMBER
)
AS
   v_NUMPLANTILLA_R NUMBER;

BEGIN

   SELECT NU_NUME_PLHI_R 

     INTO v_NUMPLANTILLA_R
     FROM R_PLANTILLA_HIST 
    WHERE  NU_NUME_PLHI_R = v_NoPlantilla;
   IF v_NUMPLANTILLA_R IS NULL THEN
    
   BEGIN
      INSERT INTO R_PLANTILLA_HIST
        ( NU_NUME_PLHI_R, NU_PRCO_PLHI, NU_REDI_PLHI, NU_TIEDI_PLHI, NU_REDF_PLHI, NU_TIEDF_PLHI, NU_GENE_PLHI, NU_MODI_PLHI, NU_CGES_PLHI )
        VALUES ( v_NoPlantilla, v_Tipo, v_EdadInicial, v_TipoEdadInicial, v_EdadFinal, v_TipoEdadFinal, v_Sexo, v_Post_guard, v_Condi_gesta );
   
   END;
   ELSE
      UPDATE R_PLANTILLA_HIST
         SET NU_PRCO_PLHI = v_Tipo,
             NU_REDI_PLHI = v_EdadInicial,
             NU_TIEDI_PLHI = v_TipoEdadInicial,
             NU_REDF_PLHI = v_EdadFinal,
             NU_TIEDF_PLHI = v_TipoEdadFinal,
             NU_GENE_PLHI = v_Sexo,
             NU_MODI_PLHI = v_Post_guard,
             NU_CGES_PLHI = v_Condi_gesta
       WHERE  NU_NUME_PLHI_R = v_NoPlantilla;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;