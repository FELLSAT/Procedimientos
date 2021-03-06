	CREATE OR REPLACE PROCEDURE SP_ACOMER_PEDIDOS_CANCEL
	 -- =============================================      
	 -- Author:  FELIPE SATIZABAL
	 -- =============================================
	(
		IN_TIPO_CANCELAR IN NUMBER,			 		  -- MODO QUE SE CANCELA EL PEIDO
		IN_CODIGO_MESA IN INV00018.MESCOD%TYPE, 	  -- CODIGO DE LA MESA DONDE SE VA A CANCELAR EL PEDIDO
		IN_PLATOS_CANCELAR IN OUT PKG_ACOMER_RESTAURANTES.TYPE_PEDIDOS_ARRAY, -- CODIGO DE LOS PLATOS QUE SE CANCELAN
		IN_CANTIDAD IN OUT PKG_ACOMER_RESTAURANTES.TYPE_PEDIDOS_ARRAY,        -- CANTIDAD POR PLATO QUE SE CANCELAN 
		IN_PUESTO IN OUT PKG_ACOMER_RESTAURANTES.TYPE_PEDIDOS_ARRAY, 		  -- PUESTO DONDE CANCELAN EL PEDIDO
		OUT_CODIGO_MENSAJE OUT NUMBER -- CODIGO DE MENSAJE
	)
	AS
		V_PEDIDO1 INV00018.MESNUMREQ%TYPE;   	-- CODIGO DE LOS PEDISO QUE HAY SOBRE LA MESA
		V_PEDIDO2 INV00018.MESNUMREQ2%TYPE;  	-- CODIGO DE LOS PEDISO QUE HAY SOBRE LA MESA
		V_PEDIDO3 INV00018.MESNUMREQ3%TYPE;  	-- CODIGO DE LOS PEDISO QUE HAY SOBRE LA MESA
		V_CONTADOR NUMBER;
		V_NUM_PEDIDO VEN0004.PEDNRO%TYPE;	 	-- NUMERO DEL PEDIDO AL QUE PERTENCE EL PLATO A CANCELAR
		V_CANT_PEDIDO NUMBER;				 	-- CANTIDAD DE LO QUE YA SE HABIA PEDIDO
		V_CANT_FALTAN NUMBER;				 	-- CANTIDAD DE PLATOS QUE FALTA POR ENTREGAR 
		V_CODIGO_EMPRESA VEN0004.PEDEMPC%TYPE;	-- CODIGO DE LA MESA AL QUE PERTENCE EL NUMERO DE PEDIDO 
		V_CANTIDAD VEN0004.PEDUNI%TYPE;   			-- CANTIDAD TOTAL DE LO PEDIDO
		V_VALOR_ITEM_IVA VEN0004.PEDVALIVA%TYPE;	-- VALOR DEL ITEM CON IVA
		V_PRECIO_ITEM VEN0004.PEDVALIVA%TYPE;		-- VALOR DEL ITEM CON IVA
		V_RFPORDTO VEN0001.RFPORDTO%TYPE;			-- RFPORDTO 
		V_VALDESC VEN0004.peddcval%TYPE;			-- peddcval
		V_ESTADO_PED VEN0004.PEDSAL%TYPE;			-- ESTADO DEL PEDIDO
	BEGIN
		OUT_CODIGO_MENSAJE := 0;

		-- ==============================================
		-- CONSULTO LOS PEDIDOS QUE ESTAN EN  
		SELECT MESNUMREQ, MESNUMREQ2, MESNUMREQ3
		INTO V_PEDIDO1, V_PEDIDO2, V_PEDIDO3
		FROM INV00018
		WHERE MESCOD = IN_CODIGO_MESA;

		-- TIPO DE CANCELACION
		-- 1 = CANCELA TODO EL PEIDO
		-- 0 = CANCELA PARTE DEL PEDIDO
		IF (IN_TIPO_CANCELAR = 1) THEN		
			BEGIN			
				DECLARE 					
					ARRAY_CODIGOS_EMP TYPE_PEDIDOS_ARRAY; -- ARRAY DE LOS CODIGOS DE LOS CONTAINER
					ARRAY_NUMEROS_PED TYPE_PEDIDOS_ARRAY; -- ARRAY DE LOS NUMEROS DE LOS PEDIDOS
					V_CONTADOR_ENTREGADOS NUMBER := 0;	  -- IDENTIFICAR SI YA SE HA ENTREGADO UN PEDIDO
				BEGIN
					-- ==========================================
					-- LLENA EL ARRAY CON LOS CODIGOS DE LOS CONTAINER
					ARRAY_CODIGOS_EMP(1) := PKG_CONTAINER1;
					ARRAY_CODIGOS_EMP(2) := PKG_CONTAINER2;
					ARRAY_CODIGOS_EMP(3) := PKG_CONTAINER3;
					ARRAY_CODIGOS_EMP(4) := PKG_CONTAINER4;

					-- ==========================================
					-- SE LLENA EL ARRAY CON LOS NUMEROS DE PEDIDOS DE LA MESA
					SELECT MESNUMREQ, MESNUMREQ2,
    					MESNUMREQ3, MESNUMREQ4
    				INTO ARRAY_NUMEROS_PED(1), ARRAY_NUMEROS_PED(2),
    					ARRAY_NUMEROS_PED(3), ARRAY_NUMEROS_PED(4)
    				FROM INV00018
    				WHERE MESCOD = CAST(IN_CODIGO_MESA AS NUMBER);

    				-- ==========================================
    				-- SE HACE EL CONTEO DE CUANTOS PEDIDOS HAN SIDO ENTREGADOS 
    				FOR I IN ARRAY_NUMEROS_PED.FIRST..ARRAY_NUMEROS_PED.LAST
    				LOOP
    					BEGIN
    						SELECT NVL(SUM(PEDUNI),0) - NVL(SUM(PEDCHECK),0) + V_CONTADOR_ENTREGADOS TOTAL_ENTREGADOS
	    					INTO V_CONTADOR_ENTREGADOS
							FROM VEN0004 A
							INNER JOIN VEN0104 B
							    ON A.PEDNRO = B.PEDNRO
							    AND B.PEDEMPC = CAST(ARRAY_CODIGOS_EMP(I) AS CHAR(13))
							    AND B.PEDNUMDOC = CAST(ARRAY_NUMEROS_PED(I) AS CHAR(10));						
    					END;
    				END LOOP;

    				-- ==========================================
    				-- SI NO HAY PEDIDOS ENTREGADOS DE LA MESA SE CANCEL EL PEDIDO
    				IF(V_CONTADOR_ENTREGADOS = 0) THEN 
    					BEGIN
    						FOR I IN ARRAY_NUMEROS_PED.FIRST..ARRAY_NUMEROS_PED.LAST
		    				LOOP
		    					IF (ARRAY_NUMEROS_PED(I) <> ' ') THEN 
		    						-- ==========================================
									-- SE ACTUALIZA EL PEDIDO CANCELADO PARA CAMBIAR LUEGO DE TABLA
		    						UPDATE VEN0104
									SET PEDMODCOD = 'CANCEL'
									WHERE PEDEMPC = CAST(ARRAY_CODIGOS_EMP(I) AS CHAR(13))
							    		AND PEDNUMDOC = CAST(ARRAY_NUMEROS_PED(I) AS CHAR(10));

							    	-- SE ACTUALIZA EL DETALLE DEL PEDIDO CANCELADO 
							    	UPDATE VEN0004
									SET PEDSAL = 'C'
									WHERE PEDNRO IN (	SELECT DISTINCT A.PEDNRO 
														FROM VEN0004 A
														INNER JOIN VEN0104 B
															ON A.PEDNRO = B.PEDNRO
															AND B.PEDEMPC = CAST(ARRAY_CODIGOS_EMP(I) AS CHAR(13))
							    							AND B.PEDNUMDOC = CAST(ARRAY_NUMEROS_PED(I) AS CHAR(10))
							    					)
										AND PEDEMPC = CAST(ARRAY_CODIGOS_EMP(I) AS CHAR(13));

									-- ==========================================
							    	-- SE CAMBIA A LA TABLA CANCELADOS
							    	INSERT INTO PEDCAN
							    	SELECT * 
							    	FROM VEN0104
							    	WHERE PEDEMPC = CAST(ARRAY_CODIGOS_EMP(I) AS CHAR(13))
							    		AND PEDNUMDOC = CAST(ARRAY_NUMEROS_PED(I) AS CHAR(10));

							    	-- SE CAMBIA A LA TABLA CANCELADOS 
							    	INSERT INTO PEDDETCAN
							    	SELECT * 
							    	FROM VEN0004
							    	WHERE PEDNRO IN (	SELECT DISTINCT A.PEDNRO 
														FROM VEN0004 A
														INNER JOIN VEN0104 B
															ON A.PEDNRO = B.PEDNRO
															AND B.PEDEMPC = CAST(ARRAY_CODIGOS_EMP(I) AS CHAR(13))
							    							AND B.PEDNUMDOC = CAST(ARRAY_NUMEROS_PED(I) AS CHAR(10))
							    					)
										AND PEDEMPC = CAST(ARRAY_CODIGOS_EMP(I) AS CHAR(13));

									-- ==========================================
							    	-- SE ELIINAN LOS PLATOS QUE SE CANCELAN DE LA TABLA
							    	DELETE 
									FROM VEN0004
									WHERE PEDNRO IN (	SELECT DISTINCT A.PEDNRO 
														FROM VEN0004 A
														INNER JOIN VEN0104 B
															ON A.PEDNRO = B.PEDNRO
															AND B.PEDEMPC = CAST(ARRAY_CODIGOS_EMP(I) AS CHAR(13))
							    							AND B.PEDNUMDOC = CAST(ARRAY_NUMEROS_PED(I) AS CHAR(10))
							    					)
										AND PEDEMPC = CAST(ARRAY_CODIGOS_EMP(I) AS CHAR(13));
		    					END IF;
		    				END LOOP;

		    				-- SE LIBERA LA MESA 
		    				UPDATE INV00018
							SET MESNUMREQ = '',
								MESNUMREQ2 = '',
								MESNUMREQ3 = '',
								MESNUMREQ4 = '',
								MESUSUREQ = '',
								MESDOCREQ = '',
								MESESTADO = 'Activo',
								MESHORAPED = ''
							WHERE MESCOD = IN_CODIGO_MESA;
    					END;
    				ELSE 
    					BEGIN
    						-- SE INFORMA DE QUE HAY PEDIDOS YA ENTREGADOS QUE NO PUEDEN SER CANCELADOS
    						OUT_CODIGO_MENSAJE := 1;
    					END;
    				END IF;
				END;				
			END;
		ELSE		
			BEGIN
				-- ==============================================
				-- RECORRE LOS PLATOS QUE SE VAN A CANCELAR
				FOR I IN IN_PLATOS_CANCELAR.FIRST..IN_PLATOS_CANCELAR.LAST
				LOOP
					-- NUMERO DE PEDIDO DEL PLATO QUE SE CANCELA 
					SELECT PEDNRO
					INTO V_NUM_PEDIDO
					FROM VEN0004
					WHERE PEDPROCOD = CAST(IN_PLATOS_CANCELAR(I) AS CHAR(20))
					    AND CCOCOD =  CAST(IN_PUESTO(I) AS CHAR(3))
					    AND PEDSAL != 'C'
					    AND PEDSAL != 'F';
					-- CANTIDAD DE LO PEDIDO, LA CANTIDAD QUE FALTA POR ENTREGAR
					SELECT TO_NUMBER(PEDUNI), PEDCHECK
					INTO V_CANT_PEDIDO, V_CANT_FALTAN
					FROM VEN0004
					INNER JOIN VEN0104 
	    				ON VEN0004.PEDNRO = VEN0104.PEDNRO    
					WHERE CCOCOD = CAST(IN_PUESTO(I) AS CHAR(3))
						AND PEDPROCOD = CAST(IN_PLATOS_CANCELAR(I) AS CHAR(20))
						AND MESCOD = CAST(IN_CODIGO_MESA AS NUMBER)
						AND PEDSAL != 'C'
						AND PEDSAL != 'F';
					-- CANTIDAD DE PEDIDOS CON ESE NUMERO DE PEDIDO 
					SELECT COUNT(*)
					INTO V_CONTADOR
					FROM VEN0004 
					WHERE PEDNRO = V_NUM_PEDIDO
						AND PEDSAL IN ('N','E','T');
					-- ==============================================
					-- SI ES EL UNICO PEDIDO AL RESTAURATE ES CANCELADO, SE CANCELA EL DETALLE Y LA CABECERA
					IF (IN_CANTIDAD(I) = V_CANT_FALTAN AND V_CONTADOR = 1 AND V_CANT_PEDIDO = V_CANT_FALTAN) THEN
						BEGIN							
							-- SE ACTUALIZA EL DETALLE DEL PEDIDO COLOCANDOLO CANCELADO
							UPDATE VEN0004
							SET PEDSAL = 'C'
							WHERE PEDNRO = V_NUM_PEDIDO
								AND CCOCOD =  CAST(IN_PUESTO(I) AS CHAR(3));
							-- SE ACTUALIZA LA CABECERA DEL PEDIDO COLOCANDOLO CANCELADO
							UPDATE VEN0104
							SET PEDMODCOD = 'CANCEL'
							WHERE PEDNRO = V_NUM_PEDIDO;
							-- CONSULTO EL CODIGO DE LA EMPRESA QUE TIENE EL PEDIDO QUE SE VA A CANCELAR
							SELECT DISTINCT PEDEMPC 
							INTO V_CODIGO_EMPRESA
							FROM VEN0004
							WHERE PEDNRO = V_NUM_PEDIDO;
							-- QUITA EL NUMERO DEL PEDIO DE LA MESA
							CASE V_CODIGO_EMPRESA
								WHEN '901.023.461-1' THEN
									BEGIN
										UPDATE INV00018
										SET MESNUMREQ = ''
										WHERE MESCOD = IN_CODIGO_MESA;
									END;

								WHEN '901.023.461-2' THEN
									BEGIN
										UPDATE INV00018										
										SET MESNUMREQ2 = ''
										WHERE MESCOD = IN_CODIGO_MESA;
									END;

								ELSE 
									BEGIN
										UPDATE INV00018
										SET MESNUMREQ3 = ''
										WHERE MESCOD = IN_CODIGO_MESA;
									END;
							END CASE;							
							--SE GUARDAN LOS DATOS DEL PEDIDO EN TABLA DE CANCELADOS
							INSERT INTO PEDCAN
							SELECT * 
							FROM VEN0104
							WHERE PEDNRO = V_NUM_PEDIDO;
							--SE ELIMINAN LOS REGISTROS DE LOS PEDIDOS 
							DELETE 
							FROM VEN0004
							WHERE PEDNRO = V_NUM_PEDIDO
								AND CCOCOD =  CAST(IN_PUESTO(I) AS CHAR(3));							
							
						END;
					-- ==============================================
					-- SI LA CANTIDAD A CANCELAR ES MAYOS A LA CANTIDAD DE PEDIDOS POR ENTREGAR
					ELSIF (V_CANT_FALTAN < IN_CANTIDAD(I)) THEN 
						BEGIN
							OUT_CODIGO_MENSAJE := 1;
						END;
					-- ==============================================
					-- SI LA CANTIDAD A CANCELAR ES MENOR A LA CANTIDAD DE PEDIDOS POR ENTREGAR
					ELSIF (IN_CANTIDAD(I) <= V_CANT_FALTAN) THEN						
						BEGIN
							-- ==============================================
							-- ACTUALIZAR PEDIDO CON LA CANTIDAD QUITADA CON PRECIOS INCLUIDOS 							
							--CONSULTA LA CANTIDAD DEL PEDIDO RESTANDOLE LO QUE SE VA A CANCELAR
							SELECT PEDUNI - CAST(IN_CANTIDAD(I) AS NUMBER)
							INTO V_CANTIDAD
							FROM VEN0004
							WHERE CCOCOD = CAST(IN_PUESTO(I) AS NUMBER)
								AND PEDNRO = V_NUM_PEDIDO
								AND PEDPROCOD = CAST(IN_PLATOS_CANCELAR(I) AS CHAR(20));

							-- SI LA CANTIDAD FALTANTE ES CERO EN COMPARACION A LO TOTAL PEDIDO
							IF(V_CANTIDAD = 0) THEN 
								BEGIN
									-- SE ELIMINA EL PLATO DEL PEDIDO 
									--RAISE_APPLICATION_ERROR(-20001, 'CANTIDAD RESTANTE ='||V_CANTIDAD);
									DELETE FROM VEN0004
									WHERE CCOCOD = CAST(IN_PUESTO(I) AS NUMBER)
										AND PEDNRO = V_NUM_PEDIDO
										AND PEDPROCOD = CAST(IN_PLATOS_CANCELAR(I) AS CHAR(20));
								END;
							ELSE
								BEGIN									
									-- CONSULTA EL VALOR DEL PRODUCTO CON IVA INCLUIDO JUNTO CON LA CANTIDAD PEDIDA
									SELECT PEDVALIVA * V_CANTIDAD, PEDVAL
									INTO V_VALOR_ITEM_IVA, V_PRECIO_ITEM
									FROM VEN0004
									WHERE CCOCOD = CAST(IN_PUESTO(I) AS NUMBER)
										AND PEDNRO = V_NUM_PEDIDO
										AND PEDPROCOD = CAST(IN_PLATOS_CANCELAR(I) AS CHAR(20));
									--
									SELECT RFPORDTO
									INTO V_RFPORDTO
								    FROM VEN0001 A
								    INNER JOIN VEN0004 B
										ON A.VENEMPPAI = B.PEDPAIC
										AND A.VENEMPC = B.PEDEMPC
										AND A.PROCOD = B.PEDPROCOD 
								    WHERE A.PROCOD = CAST(IN_PLATOS_CANCELAR(I) AS CHAR(20))
								      	AND B.PEDNRO = V_NUM_PEDIDO;
								    --
								    IF(V_RFPORDTO > 0) THEN
										BEGIN
											V_VALDESC := (V_PRECIO_ITEM * V_CANTIDAD * V_RFPORDTO) / 100;
										END;
									ELSE
										BEGIN
											V_RFPORDTO := 0;
											V_VALDESC := 0;
										END;
									END IF;

									
									-- ==============================================
									-- SI LA CANTIDAD A CANCELAR MENOS LA CANTIDAD POR ENTREGAR DA CERO 
									IF((V_CANT_FALTAN - IN_CANTIDAD(I)) = 0) THEN 
										BEGIN
											V_ESTADO_PED := 'T';
										END;
									ELSE 
										BEGIN
											V_ESTADO_PED := 'N';
										END;
									END IF;
									-- ACTUALIZA EL PEDIDO 
									UPDATE VEN0004
									SET PEDUNI = V_CANTIDAD,
										PEDPORDC = V_RFPORDTO,
										PEDDCVAL = V_VALDESC,
										PEDVALTUN = V_CANTIDAD * V_VALOR_ITEM_IVA,
										PEDCHECK = V_CANT_FALTAN - IN_CANTIDAD(I),
										PEDSAL = V_ESTADO_PED
									WHERE CCOCOD = CAST(IN_PUESTO(I) AS NUMBER)
										AND PEDNRO = V_NUM_PEDIDO
										AND PEDPROCOD = CAST(IN_PLATOS_CANCELAR(I) AS CHAR(20));
								END;
							END IF;

						END;
					END IF;

				END LOOP;
			END;
		END IF;

	END;