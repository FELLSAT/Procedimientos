CREATE OR REPLACE PROCEDURE H3i_SP_GUARDAR_REGCONS_PER
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CONSULTA IN NUMBER,
  v_NU_DIENTE IN NUMBER,
  v_SUP_DIENTE IN NUMBER,
  v_ESTADO_DIENTE IN NUMBER,
  v_MARGEN IN VARCHAR2,
  v_SURCO IN VARCHAR2,
  v_NIV_INSER IN VARCHAR2,
  v_MARGEN_REEV IN VARCHAR2,
  v_SURCO_REEV IN VARCHAR2,
  v_NIV_INSER_REEV IN VARCHAR2,
  v_FURCA IN VARCHAR2,
  v_MUCOGINGIVAL IN VARCHAR2,
  v_MOVILIDAD IN VARCHAR2,
  v_PRONOSTICO IN VARCHAR2,
  v_PLACA IN VARCHAR2,
  v_INFLAGING IN VARCHAR2,
  v_CALCUSUBGING IN VARCHAR2,
  v_HEMORRAGIA IN VARCHAR2,
  v_SUPURACION IN VARCHAR2,
  v_PTOSSANGRANTE IN VARCHAR2,
  v_FISTULAS IN VARCHAR2,
  v_EXUDADOSPURUL IN VARCHAR2,
  v_IMPALIMENTOS IN VARCHAR2,
  v_EXTRUSION IN VARCHAR2,
  v_INTRUSION IN VARCHAR2,
  v_EXTRACCION IN VARCHAR2,
  v_DIASTEMAS IN VARCHAR2,
  v_APINIAMIENTOS IN VARCHAR2,
  v_ROTACION IN VARCHAR2,
  v_CARIES IN VARCHAR2,
  v_FACETADESGASTE IN VARCHAR2,
  v_PROTESISREMOV IN VARCHAR2,
  v_OBTDESBORDANTES IN VARCHAR2,
  v_OBTPLASTICAS IN VARCHAR2,
  v_CONDUCTOSOBT IN VARCHAR2,
  v_LESAPICALES IN VARCHAR2,
  v_SURCOSBOLSAS IN VARCHAR2,
  v_INCLUIDO IN VARCHAR2
)
AS

BEGIN

    INSERT INTO HIST_PERIODONTO_REG_CONS( 
        CD_CONSULTA, NU_DIENTE, 
        SUP_DIENTE, ESTADO_DIENTE, 
        VAL_MARGEN, VAL_SURCO, 
        VAL_NIV_INSERCION, VAL_MARGEN_REEV, 
        VAL_SURCO_REEV, VAL_NIV_INSERC_REEV, 
        VAL_FURCA, VAL_MUCOGINGIVAL, 
        VAL_MOVILIDAD, VAL_PRONOSTICO, 
        VAL_PLACA, VAL_INFGINGIV, 
        VAL_CALCSUBGING, VAL_HENORRAGIA, 
        VAL_SUPURACION, VAL_PTOSSANGRANTE, 
        VAL_FISTULAS, VAL_EXUDADOSPURUL, 
        VAL_IMPALIMENTOS, VAL_EXTRUSION, 
        VAL_INTRUSION, VAL_EXTRACCION, 
        VAL_DIASTEMAS, VAL_APINIAMIENTOS, 
        VAL_ROTACION, VAL_CARIES, 
        VAL_FACETADESGASTE, VAL_PROTESISREMOV, 
        VAL_OBTDESBORDANTES, VAL_OBTPLASTICAS, 
        VAL_CONDUCTOSOBT, VAL_LESAPICALES, 
        VAL_SURCOSBOLSAS, VAL_INCLUIDO )
    VALUES ( v_CD_CONSULTA, v_NU_DIENTE, 
        v_SUP_DIENTE, v_ESTADO_DIENTE, 
        v_MARGEN, v_SURCO, 
        v_NIV_INSER, v_MARGEN_REEV, 
        v_SURCO_REEV, v_NIV_INSER_REEV, 
        v_FURCA, v_MUCOGINGIVAL, 
        v_MOVILIDAD, v_PRONOSTICO, 
        v_PLACA, v_INFLAGING, 
        v_CALCUSUBGING, v_HEMORRAGIA, 
        v_SUPURACION, v_PTOSSANGRANTE, 
        v_FISTULAS, v_EXUDADOSPURUL, 
        v_IMPALIMENTOS, v_EXTRUSION, 
        v_INTRUSION, v_EXTRACCION, 
        v_DIASTEMAS, v_APINIAMIENTOS, 
        v_ROTACION, v_CARIES, 
        v_FACETADESGASTE, v_PROTESISREMOV,
        v_OBTDESBORDANTES, v_OBTPLASTICAS, 
        v_CONDUCTOSOBT, v_LESAPICALES, 
        v_SURCOSBOLSAS, v_INCLUIDO);

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;