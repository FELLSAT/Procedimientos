create or replace PROCEDURE SP_ACOMER_FACTURACION_CAB_DET
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	IN_DOC_PEDIDO IN GEN0012.DOCCOD%TYPE,   		-- DOCUMENTO PEDIDO PD
	IN_CODIGO_PAIS IN GEN0006.EMPPAIC%TYPE, 		-- CODIGO DEL PAIS
	IN_CODIGO_EMPRESA IN GEN0006.EMPCOD%TYPE, 		-- CODIGO DE LA EMPRESA
	IN_NUMERO_DOCUMENTO IN CNT00071.MOVDOCNRO%TYPE, -- CODIGO DEL PEDIDO 
	IN_CODIGO_USUARIO IN SEG0001.USUID%TYPE,		-- CODIGO DEL USUARIO
	IN_CODIGO_MESA IN INV00018.MESCOD%TYPE,			-- CODIGO DE LA MESA
	OUT_NUMERO_FACTURA OUT VEN0008.FACNRO%TYPE 		-- NUMERO DE FACTURA QUE SE LE ASUGNA A LOS PEDIDOS 
)
AS
	V_NUMERO_FACTURA VEN0008.FACNRO%TYPE;
	V_DOCUMENT_FAC GEN0012.DOCCOD%TYPE;  
BEGIN
	V_DOCUMENT_FAC := 'FV';  
	----------------------------------------------------
	-- NUMERO DE FACTURA SIGUIENTE SI NO EXISTE LE ASIGNA LA PRIMERA YA QUE NO HAY REGISTRO
	BEGIN      
		SELECT NVL(MAX(FACNRO),0) + 1 
		INTO V_NUMERO_FACTURA 
		FROM  VEN0008  
		WHERE FACPAIC = IN_CODIGO_PAIS 
		AND FACEMPC = IN_CODIGO_EMPRESA;
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			V_NUMERO_FACTURA := 1;
	END;

	-- ===================================
	-- SE ASIGNA EL NUMERO ASIGNADO A LA VARIABLE DE SALDA 
	OUT_NUMERO_FACTURA := V_NUMERO_FACTURA;

	-- ===================================
	-- INSERTAR EN LA CABECERA DE LA FACTURA
	INSERT INTO VEN0008(
		FACPAIC, FACEMPC,
		FACCODDOC,FACNRO,
		FACNUMDOC,FACFECH,
		FACMC,CPRPAIC,
		CPREMPC,FPDOCC,
		FPDOCN,FCPRNRO,
		DIRCOD,FORPAGCOD,
		FACVENCOD,FACBODC,
		FACTIPMOV,FACUSUARIO,
		FACTOTFAC1,FACOTM,      
		TOTALFACTURA,EMPPAIC,
		EMPCOD,CLICOD,
		SUCTERCOD,FACPAIS,
		FACEMPRESA,MESCOD)
	SELECT IN_CODIGO_PAIS ,IN_CODIGO_EMPRESA, 
		V_DOCUMENT_FAC, V_NUMERO_FACTURA, 
		A.PEDNUMDOC, A.PEDFECH,
		'FACTURA',IN_CODIGO_PAIS, 
		IN_CODIGO_EMPRESA,A.PEDCODDOC,
		A.PEDNUMDOC, A.PEDNRO, 
		A.PDIRCOD, A.PFPGCOD, 
		A.PEDVENCOD, A.PEDBODCOD,
		'P', IN_CODIGO_USUARIO, 
		SUM(B.PEDVALTUN),'N', 
		SUM(B.PEDVALTUN),IN_CODIGO_PAIS, 
		IN_CODIGO_EMPRESA, A.PCLICOD,
		A.PSUCCLI,IN_CODIGO_PAIS,
		IN_CODIGO_EMPRESA,IN_CODIGO_MESA
    FROM VEN0104 A 
    LEFT JOIN VEN0004 B 
		ON A.PEDPAIC=B.PEDPAIC 
		AND A.PEDEMPC=B.PEDEMPC 
		AND A.PEDCODDOC=B.PEDCODDOC 
		AND A.PEDNRO=B.PEDNRO
    WHERE A.PEDPAIC=IN_CODIGO_PAIS 
		AND A.PEDEMPC=IN_CODIGO_EMPRESA 
		AND  A.PEDCODDOC=IN_DOC_PEDIDO  
		AND A.PEDNUMDOC=IN_NUMERO_DOCUMENTO		
    GROUP BY A.PEDNUMDOC,A.PEDFECH,
		A.PEDCODDOC,A.PEDNRO, 
		A.PDIRCOD, A.PFPGCOD, 
		A.PEDVENCOD, A.PEDBODCOD, 
		A.PCLICOD,A.PSUCCLI;

	-- ===================================
	-- INSERTAR DETALLET  DE LA FACTURA
	INSERT INTO VEN00081(
		FACPAIC,FACEMPC,
		FACCODDOC,FACNRO,
		FACLIN,FPROPC,
		FPROEC,FACPROCOD,
		BODCODLIN,FUNICPR,
		FACUNI,FACUNID,
		FACVALUNI,FACDIP,
		FACVALIVA,FACVALTUN,
		FACDCP,FACSUCDET,
		FACFRANUM,FACCLICOD,
		FACFECDED,FACVENDET,
		FACNETO,FACCCO,
		FACALIAS,
		FACTIPOIVA,
		FACDETPAI,FACDETEMP)
	SELECT IN_CODIGO_PAIS FACPAIC, IN_CODIGO_EMPRESA FACEMPC,
		V_DOCUMENT_FAC FACCODDOC, V_NUMERO_FACTURA FACNRO, 
		A.PEDLIN FACLIN, IN_CODIGO_PAIS FPROPC, 
		IN_CODIGO_EMPRESA FPROEC,A.PEDPROCOD FACPROCOD,
		A.PEDBODL BODCODLIN,A.PEDFACC FUNICPR,
		A.PEDFACC FACUNI,A.PEDFACC FACUNID,
		A.PEDVAL FACVALUNI,PEDPORIVA FACDIP,
		A.PEDVALIVA FACVALIVA,A.PEDVALTUN FACVALTUN,
		A.PEDPORDC FACDCP,A.PEDSUCDET FACSUCDET,
		'5024' FACFRANUM,B.PCLICOD FACCLICOD,
		B.PEDFECH FACFECDED,PEDVENCOD FACVENDET,
		A.PEDVALIVA + A.PEDVALTUN FACNETO,A.CCOCOD FACCCO, 
		A.PEDALIAS FACALIAS, 
		CASE WHEN PEDVALIVA > 0 
			THEN 'Gravado' 
			ELSE 'SinIVA' 
		END FACTIPOIVA,  
		IN_CODIGO_PAIS FACDETPAI, IN_CODIGO_EMPRESA FACDETEMP
	FROM VEN0004 A
	LEFT JOIN VEN0104 B 
		ON A.PEDPAIC = B.PEDPAIC 
		AND A.PEDEMPC = B.PEDEMPC 
		AND A.PEDCODDOC = B.PEDCODDOC 
		AND A.PEDNRO = B.PEDNRO		
	WHERE A.PEDCODDOC = IN_DOC_PEDIDO 
		AND B.PEDNUMDOC = IN_NUMERO_DOCUMENTO;
END;