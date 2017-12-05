CREATE OR REPLACE PROCEDURE H3i_SP_AUDI_OBT_MEDICAM_DOCUM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
      v_COD_DOCU_AUD IN NUMBER,
      cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

      OPEN  cv_1 FOR
            SELECT AUTO_DOCU_MEDI_ADM ,
                  COD_AUDI_DOCUM_ADM ,
                  DOCUMENTO_NUMERO_ITEM_ADM ,
                  ITEM_FECHA_INSERCION_ADM ,
                  ITEM_FECHA_ACTUALIZACION_ADM ,
                  GENERICO_CODIGO_ADM ,
                  GENERICO_NOMBRE_ADM ,
                  REFERENCIA_CODIGO_ADM ,
                  REFERENCIA_NOMBRE_ADM ,
                  REFERENCIA_REGULADA_ADM ,
                  CONCENTRACION_CODIGO_ADM ,
                  CONCENTRACION_NOMBRE_ADM ,
                  REFERENCIA_UNIDAD_EMPAQUE_ADM ,
                  CANTIDAD_PEDIDA_ADM ,
                  CANTIDAD_DESPACHADA_ADM ,
                  REFERENCIA_LOTE_ADM ,
                  LOTE_FECHA_VENCIMIENTO_ADM ,
                  POSOLOGIA_ADM ,
                  FRECUENCIA_ADM ,
                  FORMA_FARMACEUTICA_CODIGO_ADM ,
                  FORMA_FARMACEUTICA_NOMBRE_ADM ,
                  UNIDAD_MEDIDA_CODIGO_ADM ,
                  UNIDAD_MEDIDA_DESCRIPCION_ADM ,
                  VALOR_INTERMED_UNITARIO_ITEM_A ,
                  VALOR_IVA_UNITARIO_ITEM_ADM ,
                  VALOR_TOTAL_ITEM_ADM ,
                  REFERENCIA_PORCENTAJE_IVA_ITEM ,
                  LABORATORIO_CODIGO_ADM ,
                  LABORATORIO_NOMBRE_ADM ,
                  TIPO_FORMULA_CODIGO_ADM ,
                  TIPO_FORMULA_NOMBRE_ADM ,
                  TIPO_DISPENSACION_CODIGO_ADM ,
                  TIPO_DISPENSACION_NOMBRE_ADM ,
                  PRECIO_UNITARIO ,
                  PORCENTAJE_INTERMED ,
                  PORCENTAJE_IVA_INTERMED ,
                  VALOR_IVA_INTERMEDIACION ,
                  ID_REGISTRO ,
                  0 BT_ESTADO_ARGM  ,
                  0 BT_GLOSA_IVA_ARGM  ,
                  0 BT_GLOSA_INTERM_ARGM  ,
                  CTC_TUTELAS_MEDICAMENTO ,
                  REFERENCIA_CUM ,
                  REFERENCIA_INVIMA ,
                  CLAS_TERAPEU_CODIGO ,
                  CLAS_TERAPEU_NOMBRE ,
                  OBSERVACIONES ,
                  REFERENCIA_CODIGO_052 
            FROM AUDITAR_DOCU_MEDICAMENTO 
            WHERE  COD_AUDI_DOCUM_ADM = v_COD_DOCU_AUD ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;