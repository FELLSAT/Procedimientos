CREATE OR REPLACE PROCEDURE ACT_PROC_MUES_ENTRE_LAB_CLIN
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CD_CODI_PRM IN NUMBER,
    v_FE_FECH_ENTR_MUES_PRM IN DATE,
    v_HO_HORA_ENTR_MUES_PRM IN VARCHAR2,
    v_CD_MEDI_ENTR_PRM IN VARCHAR2,
    v_TX_OBSER_ENTR_MUES_PRM IN VARCHAR2
)
AS

BEGIN

    UPDATE PROCESAMIENTO_MUESTRA
    SET FE_FECH_ENTR_MUES_PRM = v_FE_FECH_ENTR_MUES_PRM,
        HO_HORA_ENTR_MUES_PRM = v_HO_HORA_ENTR_MUES_PRM,
        CD_MEDI_ENTR_PRM = v_CD_MEDI_ENTR_PRM,
        CD_CODI_ESM_PRM = '4',
        TX_OBSER_ENTR_MUES_PRM = v_TX_OBSER_ENTR_MUES_PRM
    WHERE  CD_CODI_PRM = v_CD_CODI_PRM;
   

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;