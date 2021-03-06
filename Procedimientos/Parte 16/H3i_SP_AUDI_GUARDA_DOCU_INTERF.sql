CREATE OR REPLACE PROCEDURE H3i_SP_AUDI_GUARDA_DOCU_INTERF
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGO_DOCU_OUTPUT OUT NUMBER,
    v_DOCUMENTO_TIPO IN VARCHAR2,
    v_DOCUMENTO_CONSEC IN NUMBER,
    v_NUMERO_RADICADO IN NUMBER,
    v_FECHA_RADICADO IN DATE,
    v_DOCUMENTO_FECHA_FORMULACION IN DATE,
    v_DOCUMENTO_FECHA_TRANSACCION IN DATE,
    v_DEPARTAMENTO_CODIGO IN VARCHAR2,
    v_DEPARTAMENTO_NOMBRE IN VARCHAR2,
    v_CIUDAD_CODIGO IN VARCHAR2,
    v_CIUDAD_NOMBRE IN VARCHAR2,
    v_BODEGA_CODIGO IN NUMBER,
    v_BODEGA_NOMBRE IN VARCHAR2,
    v_DOCUMENTO_VALOR_IVA IN NUMBER,
    v_DOCUMENTO_VALOR_TOTAL IN NUMBER,
    v_DOCUMENTO_INTERMEDIAC IN NUMBER,
    v_DOCUMENTO_IVA_INTERMED IN NUMBER,
    v_USUARIO_ALISTADOR IN VARCHAR2,
    v_USUARIO_VALIDADOR IN VARCHAR2,
    v_USUARIO_DIGITACION IN VARCHAR2,
    v_AFILIADO_TIPO_DOCUMENTO IN VARCHAR2,
    v_AFILIADO_CODIGO IN VARCHAR2,
    v_AFILIADO_NOMBRE IN VARCHAR2,
    v_MEDICO_TIPO_DOCUMENTO IN VARCHAR2,
    v_MEDICO_CODIGO IN NUMBER,
    v_MEDICO_NOMBRE IN VARCHAR2,
    v_MEDICO_ESPECIALIDAD_CODIGO IN VARCHAR2,
    v_MEDICO_ESPECIALIDAD_NOMBRE IN VARCHAR2,
    v_DIAGNOSTICO_CODIGO IN VARCHAR2,
    v_DIAGNOSTICO_NOMBRE IN VARCHAR2,
    v_ESM_ATEN_CODIGO IN VARCHAR2,
    v_ESM_ATEN_NOMBRE IN VARCHAR2,
    v_ESM_ADS_CODIGO IN VARCHAR2,
    v_ESM_ADS_NOMBRE IN VARCHAR2,
    v_TIPO_VINCULACION_CODIGO IN VARCHAR2,
    v_TIPO_VINCULACION_NOMBRE IN VARCHAR2,
    v_NUMERO_FORMULA IN VARCHAR2,
    v_FUERZA_CODIGO IN VARCHAR2,
    v_FUERZA_NOMBRE IN VARCHAR2,
    v_TIPO_DOCU_NOMBRE IN VARCHAR2,
    v_DOCUMENTO_CONSECUTIVO_REF IN NUMBER,
    v_DOCUMENTO_TIPO_REF IN VARCHAR2,
    v_BODEGA_CODIGO_DESTINO IN NUMBER,
    v_BODEGA_NOMBRE_DESTINO IN VARCHAR2,
    v_DOCUMENTO_TIPO_SIGLA IN VARCHAR2,
    v_NUMERO_PEDIDO IN NUMBER
)
AS

BEGIN

    INSERT INTO AUDITAR_DOCUMENTO( 
        DOCUMENTO_TIPO, DOCUMENTO_CONSECUTIVO, 
        NUMERO_RADICADO, FECHA_RADICACION, 
        DOCUMENTO_FECHA_FORMULACION, DOCUMENTO_FECHA_TRANSACCION, 
        DEPARTAMENTO_CODIGO, DEPARTAMENTO_NOMBRE, 
        CIUDAD_CODIGO, CIUDAD_NOMBRE, 
        BODEGA_CODIGO, BODEGA_NOMBRE, 
        DOCUMENTO_VALOR_IVA, DOCUMENTO_VALOR_TOTAL, 
        DOCUMENTO_INTERMEDIAC, DOCUMENTO_IVA_INTERMED, 
        USUARIO_ALISTADOR, USUARIO_VALIDADOR, 
        USUARIO_DIGITACION, AFILIADO_TIPO_DOCUMENTO, 
        AFILIADO_CODIGO, AFILIADO_NOMBRE, 
        MEDICO_TIPO_DOCUMENTO, MEDICO_CODIGO, 
        MEDICO_NOMBRE, MEDICO_ESPECIALIDAD_CODIGO, 
        MEDICO_ESPECIALIDAD_NOMBRE, DIAGNOSTICO_CODIGO, 
        DIAGNOSTICO_NOMBRE, ESM_ADSCRITO_CODIGO, 
        ESM_ADSCRITO_NOMBRE, ESM_ATENCION_CODIGO, 
        ESM_ATENCION_NOMBRE, TIPO_VINCULACION_CODIGO, 
        TIPO_VINCULACION_NOMBRE, NUMERO_FORMULA, 
        FUERZA_CODIGO, FUERZA_NOMBRE, 
        TIPO_DOCU_NOMBRE, DOCUMENTO_CONSECUTIVO_REF, 
        DOCUMENTO_TIPO_REF, BODEGA_CODIGO_DESTINO, 
        BODEGA_NOMBRE_DESTINO, DOCUMENTO_TIPO_SIGLA, 
        NUMERO_PEDIDO )
    VALUES ( 
        v_DOCUMENTO_TIPO, v_DOCUMENTO_CONSEC, 
        v_NUMERO_RADICADO, TO_DATE(v_FECHA_RADICADO,'dd/mm/yyyy'), 
        TO_DATE(v_DOCUMENTO_FECHA_FORMULACION,'dd/mm/yyyy'), TO_DATE(v_DOCUMENTO_FECHA_TRANSACCION,'dd/mm/yyyy'), 
        v_DEPARTAMENTO_CODIGO, v_DEPARTAMENTO_NOMBRE, 
        v_CIUDAD_CODIGO, v_CIUDAD_NOMBRE, 
        v_BODEGA_CODIGO, v_BODEGA_NOMBRE, 
        v_DOCUMENTO_VALOR_IVA, v_DOCUMENTO_VALOR_TOTAL, 
        v_DOCUMENTO_INTERMEDIAC, v_DOCUMENTO_IVA_INTERMED, 
        v_USUARIO_ALISTADOR, v_USUARIO_VALIDADOR, 
        v_USUARIO_DIGITACION, v_AFILIADO_TIPO_DOCUMENTO, 
        v_AFILIADO_CODIGO, v_AFILIADO_NOMBRE,
        v_MEDICO_TIPO_DOCUMENTO, v_MEDICO_CODIGO, 
        v_MEDICO_NOMBRE, v_MEDICO_ESPECIALIDAD_CODIGO, 
        v_MEDICO_ESPECIALIDAD_NOMBRE, v_DIAGNOSTICO_CODIGO, 
        v_DIAGNOSTICO_NOMBRE, v_ESM_ADS_CODIGO, 
        v_ESM_ADS_NOMBRE, v_ESM_ATEN_CODIGO, 
        v_ESM_ATEN_NOMBRE, v_TIPO_VINCULACION_CODIGO, 
        v_TIPO_VINCULACION_NOMBRE, v_NUMERO_FORMULA, 
        v_FUERZA_CODIGO, v_FUERZA_NOMBRE, 
        v_TIPO_DOCU_NOMBRE, v_DOCUMENTO_CONSECUTIVO_REF, 
        v_DOCUMENTO_TIPO_REF, v_BODEGA_CODIGO_DESTINO, 
        v_BODEGA_NOMBRE_DESTINO, v_DOCUMENTO_TIPO_SIGLA, 
        v_NUMERO_PEDIDO );

    SELECT COD_AUDI_DOCUM 
    INTO v_CODIGO_DOCU_OUTPUT 
    FROM AUDITAR_DOCUMENTO
    WHERE COD_AUDI_DOCUM = (SELECT MAX(COD_AUDI_DOCUM) FROM AUDITAR_DOCUMENTO);

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;