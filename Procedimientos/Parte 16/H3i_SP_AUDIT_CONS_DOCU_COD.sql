CREATE OR REPLACE PROCEDURE H3i_SP_AUDIT_CONS_DOCU_COD
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_COD_DOCUMENTO IN NUMBER,
	V_TIPO_DOCUMENTO IN VARCHAR2,
	CV_1 OUT SYS_REFCURSOR
)
AS	
	V_FECHA_FILTRO DATE;
BEGIN

	SELECT TO_DATE(VL_VALO_CONT)
	INTO V_FECHA_FILTRO
	FROM CONTROL 
	WHERE CD_CONC_CONT = 'FECHA_CORTE_AUDITORIAS';

	OPEN CV_1 FOR
		SELECT DISTINCT CD_ASIG_DOCU, AUTO_REG_GLOSA,
			COD_AUDI_DOCUM_ARG, VALOR_FACTURADO_ARG,
			VALOR_GLOSADO_ARG, VALOR_PAGAR_ARG,
			NVL((	SELECT DE_OBSERVACION_RDO 
					FROM (	SELECT DE_OBSERVACION_RDO, CODIGO_DOC_OBJETADO
							FROM AUDITAR_RESPUESTA_DOCU_OBJET							
							ORDER BY NU_NUM_RESPUESTA DESC ) 
					WHERE CODIGO_DOC_OBJETADO = COD_AUDI_DOCUM_TB 
                        AND ROWNUM <= 1
				), DE_OBSERVACION_ARG) DE_OBSERVACION_ARG,
			ESTADO_ARG,	FE_FECHA_ARG,
			REPLACE(AD.DOCUMENTO_TIPO_CONSEC,'-','') ID_DOCUM_INTERFAZ,
			AD.DOCUMENTO_TIPO_CONSEC IDENTIFICADOR_ADJUNTOS,
			--Datos tipo documento
			ATD.CD_CODI_ATD, ATD.NO_NOMB_ATD,
			IDEN_USUARIO_AAD, AD.FUERZA_NOMBRE,
			IDEN_USUARIO_FARM_ARG, AD.DOCUMENTO_FECHA_TRANSACCION,
			AD.DOCUMENTO_FECHA_FORMULACION,	AD.AFILIADO_TIPO_DOCUMENTO,
			AD.AFILIADO_CODIGO, AD.AFILIADO_NOMBRE,
			AD.DOCUMENTO_VALOR_TOTAL, AD.COD_AUDI_DOCUM,
			AD.MEDICO_CODIGO, AD.MEDICO_NOMBRE,
			AD.DOCUMENTO_TIPO_REF, AD.DOCUMENTO_CONSECUTIVO_REF,
			AD.BODEGA_NOMBRE, AD.BODEGA_NOMBRE_DESTINO,
			AD.NUMERO_PEDIDO, AD.NUMERO_FORMULA
		FROM TABLE(FN_DocumentosPorCodigo(V_COD_DOCUMENTO, V_TIPO_DOCUMENTO, V_FECHA_FILTRO) )
		INNER JOIN AUDITAR_DOCUMENTO AD 
			ON COD_AUDI_DOCUM_TB = AD.COD_AUDI_DOCUM
		INNER JOIN AUDITAR_ASIGNACION_DOCUM 
			ON COD_AUDI_DOCUM = COD_AUDI_DOCUM_AAD
		INNER JOIN AUDITAR_TIPO_DOCU ATD 
			ON ATD.NU_DATO_INTER_ATD = REPLACE(DOCUMENTO_TIPO, TO_NUMBER(BODEGA_CODIGO), '') --Valores R, P, H, A
		 WHERE ESTADO_ARG = 0 
				AND CAUSA_CODIGO_CONCIL_ARG IS NULL
				AND FECHA_ASIG_AAD > V_FECHA_FILTRO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;