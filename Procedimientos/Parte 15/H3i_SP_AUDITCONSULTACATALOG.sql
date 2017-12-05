CREATE OR REPLACE PROCEDURE H3i_SP_AUDITCONSULTACATALOG
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
 
    v_COD_INTERNO IN VARCHAR2 DEFAULT NULL ,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    OPEN  cv_1 FOR
        SELECT CODIGO_GENERICO_CCM ,
            NOMBRE_GENERICO_CCM ,
            CODIGO_LABORATORIO_CCM ,
            NOMBRE_LABORATORIO_CCM ,
            CODIGO_REFERENCIA_CCM ,
            NOMBRE_REFERENCIA_CCM ,
            REFERENCIA_CUM_CCM ,
            REFERENCIA_INVIMA_CCM ,
            REFERENCIA_CONTROLADA_CCM ,
            REFERENCIA_REGULADA_CCM ,
            REFERENCIA_ALTO_COSTO_CCM ,
            REFERENCIA_CADENA_FRIO_CCM ,
            REFERENCIA_CODIGO_BARRAS_CCM ,
            REFERENCIA_CONCENTRACION_CCM ,
            REFERENCIA_LINEA_CODIGO_CCM ,
            REFERENCIA_LINEA_NOMBRE_CCM ,
            REFERENC_PORCENTAJE_IVA ,
            CODIGO_INTERNO_CCM ,
            CODIGO_HOMIC_CCM ,
            PRESENTACION_CCM ,
            VIA_ADMINISTRACION_CCM ,
            UNIDAD_MEDIDA_CCM ,
            ES_CTC_TUTELA_CCM ,
            TIENE_IVA_CCM ,
            PRECIO_DROSERVICIOS ,
            PRECIO_ANIO_INFLACION 
      FROM AUDITAR_CATALOGO_MEDICAMENTO 
      LEFT JOIN AUDITAR_PRECIO_ANIO_MEDICAM    
          ON ( COD_CATAL_MEDICAM_CPAM = COD_CATAL_MEDICAM
          AND ANIO_CAT_MED = TO_CHAR(SYSDATE,'YYYY') )
      WHERE  CODIGO_INTERNO_CCM = NVL(v_COD_INTERNO, CODIGO_INTERNO_CCM) ;--AND CODIGO_REFERENCIA_CCM = ISNULL(@CODIGO_REFERENCIA,CODIGO_REFERENCIA_CCM)
   --AND CODIGO_GENERICO_CCM = ISNULL(@CODIGO_GENERICO,CODIGO_GENERICO_CCM)
   --AND CODIGO_HOMIC_CCM = ISNULL(@CODIGO_HOMIC,CODIGO_HOMIC_CCM)

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;