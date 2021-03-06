CREATE OR REPLACE PACKAGE PKG_ACOMER_RESTAURANTES
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS

-- =============================================
-- ARRAY DE LOS PEDIDOS REALIZADOS
	TYPE TYPE_PEDIDOS_ARRAY IS TABLE OF VARCHAR(100) INDEX BY BINARY_INTEGER;  	

-- =============================================
-- INFORMACION DE TODAS LAS MESAS (ESTADO, CODIGO, EMPRESA,PUESTOS)
	PROCEDURE SP_ACOMER_MESAS
	(
		CURSOR_MESAS OUT SYS_REFCURSOR --CURSOR QUE TENDRA LOS DATOS DE LA MESA (EMP, IDENTIFICADOR, PUESTOS, COORDENADAS)
	);

-- =============================================
-- INFORMACION DE LOS PEDIDOS A ENTREGAR ACTUALMENTE
	PROCEDURE SP_ACOMER_PEDIDOS_ENTREGAR
	(
		CURSOR_PEDIDOS OUT SYS_REFCURSOR  -- CURSOR QUE TRAE LOS PEDIDOS QUE YA ESTAN LISTOS PARA ENTREGAR
	);

-- =============================================
-- INFORMACION DE LOS MENUS DE LOS RESTAURANTES
	PROCEDURE SP_ACOMER_MENU
	(
		CURSOR_CATEGORIAS OUT SYS_REFCURSOR,    -- CURSOR QUE TENDRA LOS DATOS DE  LAS CATEGORIAS DE COMIDAS
		CURSOR_SUBCATEGORIAS OUT SYS_REFCURSOR, -- CURSOR QUE TENDRA LOS DATOS DE LAS SUBCATEGORIAS DE COMIDAS
		CURSOR_TERMINOS OUT SYS_REFCURSOR,      -- CURSOR QUE TENDRA LOS DATOS DE LOS TERMINOS DE LA COMIDA EN CASO DE TENERLOS
		CURSOR_COMIDA OUT SYS_REFCURSOR			-- CRUSRO QUE TENDRA LOS DATOS DE CADA UNO DE LAS COMIDAD OFRECIDAS
	);

-- =============================================
-- INSERTAR CABECERA DE LOS PEDIDOS
	PROCEDURE SP_ACOMER_PEDIDOS_CAB
	(
		IN_CODIGO_RESTAURANTE IN  GEN0006.EMPCOD%TYPE,	   -- RESTAURANTE AL CUAL SE LE HACE EL PEDIDO
		IN_CODIGO_DOCUMENTO_PEDIDO IN GEN0012.DOCCOD%TYPE, -- VDOCUMENTO DE PEDIDO PARA SABER EL NUMERO DE PEDIDO DEPENDIENDO EL RESTAURANTE 
		IN_CODIGO_MESERO IN SEG0001.USUID%TYPE,        	   -- CEDULA DEL MESERO QUE ESTA TOMANDO EL PEDIDO 
		IN_CODIGO_MESA_USADA IN INV00018.MESCOD%TYPE,	   -- CODIGO DE LA MESA
		OUT_NUMERO_PEDIDO OUT VEN0104.PEDNRO%TYPE		   -- CODIGO DEL PEDIDO
	);

-- =============================================
-- INSERTAR DETALLE DE LOS PEDIDOS
	PROCEDURE SP_ACOMER_PEDIDOS_DET
	(
		IN_CODIGO_RESTAURANTE IN  GEN0006.EMPCOD%TYPE,	   -- RESTAURANTE AL CUAL SE LE HACE EL PEDIDO
		IN_CODIGO_DOCUMENTO_PEDIDO IN GEN0012.DOCCOD%TYPE, -- VDOCUMENTO DE PEDIDO PARA SABER EL NUMERO DE PEDIDO DEPENDIENDO EL RESTAURANTE 
		IN_CODIGO_PEDIDO IN VEN0004.PEDNRO%TYPE,		   -- NUMERO DE PEDIDO
		IN_CODIGO_ITME IN VEN0001.PROCOD%TYPE,			   -- CODIGO DEL ALIMENTO O ITEM QUE SE ESTA PIDIENDO 
		IN_CODIGO_TERMINO IN VEN0004.PEDBODL%TYPE,		   -- CODIGO DEL TERMINO DE LA COMIDAS
		IN_PUESTO_MESA IN VEN0004.CCOCOD%TYPE,			   -- PUESTO DE MESA DEL CUAL SE ESTA SOLICITANDO
		IN_CANTIDAD IN VEN0004.PEDUNI%TYPE,				   -- CANTIDAD DEL PRODUCTO
		IN_CODIGO_MESERO IN SEG0001.USUID%TYPE        	   -- CEDULA DEL MESERO QUE ESTA TOMANDO EL PEDIDO 
	);

-- =============================================
-- MANEJO DE LOS PEDIDOS
	PROCEDURE SP_ACOMER_PEDIDOS
	(
		IN_PUESTOS_ARRAY IN OUT TYPE_PEDIDOS_ARRAY, 	 -- LOS PUESTOS DE DONDE FUERON SOLICITADOS LOS PEDIDOS
		IN_PRODUCTOS_ARRAY IN  OUT TYPE_PEDIDOS_ARRAY,   -- LOS CODIGOS DE LOS PRODUCTOS QUE SE ESTA PIDIENDO 
		IN_CANTIDAD_ARRAR IN OUT TYPE_PEDIDOS_ARRAY,	 -- LA CANTIDAD PEDIDA POR PRODDUCTO
		IN_TERMINO_ARRAY IN OUT TYPE_PEDIDOS_ARRAY,		 -- TERMINO DE LA COMIDA SI HA DE TENERLA 
		IN_CODIGO_MESERO IN SEG0001.USUCED%TYPE,		 -- CODIGO DEL MESERO 
		IN_CODIGO_MESA IN INV00018.MESCOD%TYPE      	 -- CODIGO DE LA MESA DONDE SE ESTA REALIZANDO DEL PEDIDO 	
	);

-- =============================================
-- ACTUALIZAR LOS PEDIDOS DE LA MESA
	PROCEDURE SP_ACOMER_PEDIDOS_ACT
	(
		IN_CODIGO_PRODUCTO IN VEN0001.PROCOD%TYPE, -- CODIGO DEL ITEM QUE SE ADICIONARA
		IN_CODIGO_PEDIDO IN VEN0104.PEDNRO%TYPE,   -- CODIGO DEL PEDIDO QUE YA TIENE EN LA MESA
		IN_CODIGO_PUESTO IN VEN0004.CCOCOD%TYPE,   -- PUESTO DESDE DONDE SE ESTA PIDIENDO
		IN_CANTIDAD IN VEN0004.PEDUNI%TYPE		   -- CANTIDD DEL PRODUCTO QUE SE ESTA PIDIENDO 
	);

-- ============================================
-- ADICIONAR PEDIDOS A LA MESA
	PROCEDURE SP_ACOMER_PEDIDOS_ADD
	(	
		IN_PUESTOS_ARRAY IN OUT TYPE_PEDIDOS_ARRAY, 	 -- LOS PUESTOS DE DONDE FUERON SOLICITADOS LOS PEDIDOS
		IN_PRODUCTOS_ARRAY IN  OUT TYPE_PEDIDOS_ARRAY,   -- LOS CODIGOS DE LOS PRODUCTOS QUE SE ESTA PIDIENDO 
		IN_CANTIDAD_ARRAR IN OUT TYPE_PEDIDOS_ARRAY,	 -- LA CANTIDAD PEDIDA POR PRODDUCTO
		IN_TERMINO_ARRAY IN OUT TYPE_PEDIDOS_ARRAY,		 -- TERMINO DE LA COMIDA SI HA DE TENERLA 
		IN_CODIGO_MESERO IN SEG0001.USUCED%TYPE,		 -- CODIGO DEL MESERO 
		IN_CODIGO_MESA IN INV00018.MESCOD%TYPE      	 -- CODIGO DE LA MESA DONDE SE ESTA REALIZANDO DEL PEDIDO 	
	);

-- ============================================
-- CANCELAR PEDIDOS YA REALIZADOS Y NO ENTREGADOS
	PROCEDURE SP_ACOMER_PEDIDOS_CANCEL
	(
		IN_TIPO_CANCELAR IN NUMBER,			 		  -- MODO QUE SE CANCELA EL PEIDO
		IN_CODIGO_MESA IN INV00018.MESCOD%TYPE, 	  -- CODIGO DE LA MESA DONDE SE VA A CANCELAR EL PEDIDO
		IN_PLATOS_CANCELAR IN OUT PKG_ACOMER_RESTAURANTES.TYPE_PEDIDOS_ARRAY, -- CODIGO DE LOS PLATOS QUE SE CANCELAN
		IN_CANTIDAD IN OUT PKG_ACOMER_RESTAURANTES.TYPE_PEDIDOS_ARRAY,        -- CANTIDAD POR PLATO QUE SE CANCELAN 
		IN_PUESTO IN OUT PKG_ACOMER_RESTAURANTES.TYPE_PEDIDOS_ARRAY 		  -- PUESTO DONDE CANCELAN EL PEDIDO
	);

-- ============================================
-- TIEMPO QUE DEMORA CADA PLATO
	PROCEDURE SP_ACOMER_TIEMPO_PEDIDO;
END;