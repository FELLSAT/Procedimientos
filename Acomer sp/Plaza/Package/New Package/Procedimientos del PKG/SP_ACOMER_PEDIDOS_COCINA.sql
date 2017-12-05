create or replace PROCEDURE SP_ACOMER_PEDIDOS_COCINA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	IN_CODIGO_COCINERO IN SEG0001.USUCED%TYPE,	-- CODIGO DEL COCINERO
	OUT_CONJUNTOS OUT SYS_REFCURSOR,			-- CONJUNTOS DE LOS PEDIDOS 
	OUT_MESA OUT SYS_REFCURSOR,					-- MESAS CON PEDIDOS
	OUT_PEDIDOS OUT SYS_REFCURSOR				-- PEDIDOS DETALLADOS DE LAS MESAS
)
AS
	V_CONTADOR NUMBER;	-- IDENTIFICAR QUE HAY DATOS HAY PEDIDOS 
	V_EMPRESA_COCINERO SEG0001.EMPCOD%TYPE; -- EMPRESA A LA QUE PERTENECE EL COCINERO 
	V_NUMERO_CONJUNTO NUMBER := 0;			-- NUMERO DE CONJUNOT QUE SE LE ASIGNA A LAS MESAS
BEGIN
	-- CONSULTA EL CODIGO DE LA EMPRESA A LA QUE PERTENECE EL COCINERO
	/*SELECT EMPCOD
	INTO V_EMPRESA_COCINERO
	FROM SEG0001
	WHERE USUCED = IN_CODIGO_COCINERO;*/

	V_EMPRESA_COCINERO := '901.023.461-1';

	-- SABER SI HAY PEDIDO A ESE RESTAURANTE
	SELECT DISTINCT COUNT(B.MESCOD)
	INTO V_CONTADOR
	FROM VEN0004 A
	INNER JOIN VEN0104 B
  		ON A.PEDNRO = B.PEDNRO
      AND B.PEDEMPC = V_EMPRESA_COCINERO
	INNER JOIN INV00018 C
  		ON C.MESNUMREQ = B.PEDNUMDOC  		
  		OR C.MESNUMREQ2 = B.PEDNUMDOC  		
  		OR C.MESNUMREQ3 = B.PEDNUMDOC  		
  		OR C.MESNUMREQ4 = B.PEDNUMDOC  		
	WHERE A.PEDSAL = 'N';
	
	-- SI HAY MAS DE UN PLATO PARA LA COCINA 
	IF(V_CONTADOR > 0) THEN
		-- SE INSERTA LOS CODIGOS DE LA MESAS QUE TIENEN PEDIDOS ACTIVOS
		INSERT INTO TT_PEDIDOS_COCINA(
			CODIGO_MESA, HORA_PEDIDO)
		SELECT MESA, HORA
		FROM   (SELECT DISTINCT B.MESCOD MESA, B.PEDHORA HORA, B.PEDFECE
				FROM VEN0004 A
				INNER JOIN VEN0104 B
			  		ON A.PEDNRO = B.PEDNRO
			      AND B.PEDEMPC = V_EMPRESA_COCINERO
				INNER JOIN INV00018 C
			  		ON C.MESNUMREQ = B.PEDNUMDOC  		
			  		OR C.MESNUMREQ2 = B.PEDNUMDOC  		
			  		OR C.MESNUMREQ3 = B.PEDNUMDOC  		
			  		OR C.MESNUMREQ4 = B.PEDNUMDOC  		
				WHERE A.PEDSAL = 'N'
				ORDER BY B.PEDFECE, B.PEDHORA, B.MESCOD);

		DECLARE
			-- CURSOR DE LAS MESAS CON PEDIDOS EE COCINA
			CURSOR CURSOR1 IS
				SELECT CODIGO_MESA, CONJUNTO_PEDIDO
				FROM TT_PEDIDOS_COCINA;
			-- AVARIABLE DONDE SE ALMACENAN LOS DATOS QUE TRAE EL CURSOR
			CURSOR_DATA1 NUMBER;
			CURSOR_DATA2 NUMBER;
		BEGIN 
			-- ABRE EL CURSOR
			OPEN CURSOR1;
			-- CARGA LOS DATOS DE LA PRIMERA FILA 
			FETCH CURSOR1 INTO CURSOR_DATA1, CURSOR_DATA2;
			LOOP
				V_NUMERO_CONJUNTO := V_NUMERO_CONJUNTO + 1;
				-- SALE CUANDO YA NO HAY DATOS
				EXIT WHEN CURSOR1%NOTFOUND;
				-- CONUSULTA SI ES UNA MESA PRINCIPAL
				SELECT COUNT(*) 
				INTO V_CONTADOR
				FROM UNIONMESA
				WHERE MESCOD = CURSOR_DATA1
					OR MESCODUNI = CURSOR_DATA1;				
				-- SI ES UNA MESA UNIDA 
				IF(V_CONTADOR > 0 AND CURSOR_DATA2 = 0) THEN
					DECLARE
						-- MESAS QUE ESTAS UNIDAD A LA QUE SE ESTA ANALIZANDO 
						CURSOR CURSOR2 IS
								SELECT MESCOD MESA
								FROM UNIONMESA
								WHERE MESCOD = CURSOR_DATA1
									OR MESCODUNI = CURSOR_DATA1								
							UNION ALL
								SELECT MESCODUNI MESA
								FROM UNIONMESA
								WHERE MESCOD = CURSOR_DATA1
									OR MESCODUNI = CURSOR_DATA1;
						-- VARIABLE QUE CONTIENE LOS DATOS DEVUELTOS POR EL CURSOR
						CURSOR_DATA3 NUMBER;
					BEGIN
						-- SE ABRE EL CURSOR
						OPEN CURSOR2;
						-- SE CARGAN LOS DATOS DE LA FILA DEVUELTOS POR EL CURSOR
						FETCH CURSOR2 INTO CURSOR_DATA3;
						LOOP
							-- SALGA DEL LOOP CUANDO NO ENCUENTRE MAS DATOS
							EXIT WHEN CURSOR2%NOTFOUND;
							--
							UPDATE TT_PEDIDOS_COCINA
							SET CONJUNTO_PEDIDO = V_NUMERO_CONJUNTO
							WHERE CODIGO_MESA = CURSOR_DATA3;
							-- SE CARGAN LOS DATOS DE LA FILA DEVUELTOS POR EL CURSOR
							FETCH CURSOR2 INTO CURSOR_DATA3;
						END LOOP;
						CLOSE CURSOR2;

					END;

				ELSE
					BEGIN
						UPDATE TT_PEDIDOS_COCINA
						SET CONJUNTO_PEDIDO = V_NUMERO_CONJUNTO
						WHERE CODIGO_MESA = CURSOR_DATA1;
					END;
				END IF;
				-- VALORES SIGUIENTES DE LA CONSULTA
				FETCH CURSOR1 INTO CURSOR_DATA1, CURSOR_DATA2;
			END LOOP;
			CLOSE CURSOR1;

			COMMIT;

			-- SE CARGAN LOS DATOS DE LOS CONJUNTOS 
			OPEN OUT_CONJUNTOS FOR
				SELECT DISTINCT 'CONJUNTO #'||CONJUNTO_PEDIDO NOMBRE,
					CONJUNTO_PEDIDO CONJUNTO
				FROM TT_PEDIDOS_COCINA
				ORDER BY CONJUNTO_PEDIDO;

			-- SE CARGAN LOS DATOS DE LAS MESAS
			OPEN OUT_MESA FOR
				SELECT * 
				FROM TT_PEDIDOS_COCINA;

			-- SE CARGAN LOS PEDIDOS DE LAS MESAS
			OPEN OUT_PEDIDOS FOR
				SELECT PRODES PLATO, MESCOD MESA,
				      SUM(PEDCHECK) CANTIDAD, 
				      LISTAGG(TRIM(VENLINCDES),'*_') WITHIN GROUP( ORDER BY TRIM(VENLINCDES)) DESCRIPCION,
				      TRIM(CATIMG) IMAGEN, PEDNRO PEDIDO, 
				      PEDEMPC
				FROM (
				  	SELECT DISTINCT PRODES, MESCOD,
						PEDCHECK, VENLINCDES,
						CATIMG, PEDNRO, 
						PEDEMPC, CCOCOD
				  	FROM (
				    	SELECT D.PRODES, B.MESCOD,
				        	A.PEDCHECK, D.VENLINCDES,
				        	E.CATIMG, A.CCOCOD,
				        	A.PEDNRO, A.PEDEMPC
				    	FROM VEN0004 A
				    	INNER JOIN VEN0104 B
				      		ON A.PEDNRO = B.PEDNRO
				      		AND B.PEDEMPC = V_EMPRESA_COCINERO
				    	INNER JOIN INV00018 C
				      		ON C.MESNUMREQ = B.PEDNUMDOC  		
							OR C.MESNUMREQ2 = B.PEDNUMDOC  		
							OR C.MESNUMREQ3 = B.PEDNUMDOC  		
							OR C.MESNUMREQ4 = B.PEDNUMDOC  		
				    	INNER JOIN VEN0001 D
				        	ON D.PROCOD = A.PEDPROCOD
				    	INNER JOIN INV0013 E
				        	ON E.CATECOD = D.VENCATCOD
				    	WHERE A.PEDSAL = 'N'
				    	ORDER BY B.PEDFECE, B.PEDHORA, B.MESCOD))
				GROUP BY PRODES, MESCOD,
				      TRIM(VENLINCDES),
				      TRIM(CATIMG), PEDNRO, 
				      PEDEMPC;      
		END;

	ELSE 

		BEGIN
			-- SE INDICA QUE EL RESTAURANTE NO TIENE PEDIDOS A MESA
			OPEN OUT_CONJUNTOS FOR
				SELECT DISTINCT 'SIN PEDIDOS' NOMBRE,
					'SIN PEDIDOS' CONJUNTO
				FROM DUAL;

			-- SE INDICA QUE EL RESTAURANTE NO TIENE PEDIDOS A MESA
			OPEN OUT_MESA FOR
				SELECT 'SIN PEDIDOS' CODIGO_MESA,
					'SIN PEDIDOS' CONJUNTO_PEDIDO,
					'SIN PEDIDOS' HORA_PEDIDO
				FROM DUAL;

			-- SE INDICA QUE EL RESTAURANTE NO TIENE PEDIDOS A MESA
			OPEN OUT_PEDIDOS FOR
				SELECT 'SIN PEDIDOS' PLATO,
					'SIN PEDIDOS' MESA,
					'SIN PEDIDOS' CANTIDAD,
					'SIN PEDIDOS' DESCRIPCION,
					'SIN PEDIDOS' IMAGEN,					
				  	'SIN PEDIDOS' PEDIDO				  	
				FROM DUAL;
		END;
	END IF;
END;