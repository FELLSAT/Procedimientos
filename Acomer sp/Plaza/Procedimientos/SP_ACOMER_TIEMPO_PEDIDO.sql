create or replace PROCEDURE SP_ACOMER_TIEMPO_PEDIDO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
 (/*
 	OUT_CURSOR_TIEMPOS OUT SYS_REFCURSOR	-- CURSOR CON LOS TIEMPOS DE CADA MESA
 )*/
 AS
 	-- CODIGO DE TODAS LAS MESAS QUE ESTAN DISPONIBLES EN PLAZA
 	DATACURSOR NUMBER; -- DATOS QUE TRAIGA EL CURSOR
 	CURSOR CURSOR1 IS	-- CURSOR QUE TRAE TODOS LOS CODIGOS DE LAS MESAS
 		SELECT MESCOD 
 		FROM INV00018;

 	V_CANTIDAD_PEDIDO NUMBER;	-- CANTIDAD DE PEDIDO QUE HAY EN UNA MESA POR RESTAURANTE
 	V_CODIGO_CONTAINER PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY; -- ARRAY CON LOS CODIGOS DE LOS CONTAINERS
 	V_CAPACIDAD_CONTAINER PKG_ACOMER_PROCEDURES.TYPE_CAPACIDAD_CONTAINER; -- ARRRAY DE LA CAPACIDAD DE CADA CONTAINER 	
 	V_TIEMPO_MAX NUMBER; -- TIEMPO MAXIMO DE UN PLATO DE LA MESA
 	V_CONSECUTIVO NUMBER; -- CONSECUTIVO DE LA TABLA PEDIDOS  	
 	V_IDENTIFICADOR_TIMEACU NUMBER;	
 BEGIN 	
 	-- LLENA EL ARRAY  CON LOS CODIGOS RESPECTIVOS
 	V_CODIGO_CONTAINER(1) := PKG_ACOMER_PROCEDURES.PKG_CONTAINER1;
 	V_CODIGO_CONTAINER(2) := PKG_ACOMER_PROCEDURES.PKG_CONTAINER2;
 	V_CODIGO_CONTAINER(3) := PKG_ACOMER_PROCEDURES.PKG_CONTAINER3;
 	V_CODIGO_CONTAINER(4) := PKG_ACOMER_PROCEDURES.PKG_CONTAINER4;
 	-- LLENA EL ARAY CON LAS CAPACIDADE CORRESPONDIENTES
 	V_CAPACIDAD_CONTAINER(PKG_ACOMER_PROCEDURES.PKG_CONTAINER1) := PKG_ACOMER_PROCEDURES.PKG_CAPACIDAD_CONTAINER1;
 	V_CAPACIDAD_CONTAINER(PKG_ACOMER_PROCEDURES.PKG_CONTAINER2) := PKG_ACOMER_PROCEDURES.PKG_CAPACIDAD_CONTAINER2;
 	V_CAPACIDAD_CONTAINER(PKG_ACOMER_PROCEDURES.PKG_CONTAINER3) := PKG_ACOMER_PROCEDURES.PKG_CAPACIDAD_CONTAINER3;
 	V_CAPACIDAD_CONTAINER(PKG_ACOMER_PROCEDURES.PKG_CONTAINER4) := PKG_ACOMER_PROCEDURES.PKG_CAPACIDAD_CONTAINER4;

 	-- LLENA LA TABLA CON LAS MESAS DISPONIBLES DE LA PLAZA
 	OPEN CURSOR1;
 	FETCH CURSOR1 INTO DATACURSOR;
 	LOOP
 		-- CUANDO NO ENCUENTRE DATOS EN CURSOR SALE
 		EXIT WHEN CURSOR1%NOTFOUND;

 		-- INSERTA LOS VALORES CORRESPONDIENTES
 		INSERT INTO TT_TIME_MESA_CONTAINER(
 			CODIGO_MESA)
 		VALUES(
 			DATACURSOR);

 		FETCH CURSOR1 INTO DATACURSOR;
 	END LOOP;
 	CLOSE CURSOR1;

 	-- CALCULAN LOS TIEMPOS DE CADA MESA EN CADA CONTAINER 
	FOR I IN V_CODIGO_CONTAINER.FIRST..V_CODIGO_CONTAINER.LAST
	LOOP
		-- CONSECUTIVO SE REINCIA CUANDO CAMBIA DE EMPRESA			
		V_CONSECUTIVO := 0;

 		DECLARE 			
 			-- PEDIDOS QUE HAY PARA CADA RESTAURANTE
 			DATACURSOR21 VEN0001.PRODES%TYPE;   -- NOMBRE DEL PLATO
 			DATACURSOR22 VEN0104.MESCOD%TYPE;   -- CODIGO DE LA MESA
 			DATACURSOR23 VEN0104.PEDFECE%TYPE;  -- FECHA DEL PEDIDO 
 			DATACURSOR24 VEN0104.PEDHORA%TYPE;	-- HORA DEL PEDIDO
 			DATACURSOR25 VEN0004.PEDCHECK%TYPE;	-- CANTIDAD
 			DATACURSOR26 VEN0104.PEDEMPC%TYPE;	-- EMPRESA
 			DATACURSOR27 VEN0001.STMARCAS%TYPE;	-- TIEMPO DE DEMORA

 			CURSOR CURSOR2 (IN_CURSOR CHAR)IS
 				SELECT PLATO, MESA,
				    FECHA, HORA,	
				    CANTIDAD, EMPRESA,
				    TIEMPO
				FROM(					
				        SELECT PRODES PLATO, MESCOD MESA,
				            PEDFECE FECHA, PEDHORA HORA,
				            SUM(PEDCHECK) CANTIDAD, 			
				            PEDEMPC EMPRESA, STMARCAS TIEMPO
				        FROM(
				                SELECT DISTINCT PRODES, MESCOD,
				                    PEDFECE, PEDHORA,
				                    PEDCHECK, CCOCOD,
				                    PEDEMPC, STMARCAS
				                FROM(
				                        SELECT D.PRODES, B.MESCOD,
				                            B.PEDFECE, B.PEDHORA,
				                            A.PEDCHECK, A.CCOCOD,
				                            A.PEDEMPC, D.STMARCAS
				                        FROM VEN0004 A
				                        INNER JOIN VEN0104 B
				                            ON A.PEDNRO = B.PEDNRO
				                            AND B.PEDEMPC = IN_CURSOR
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
				                        ORDER BY B.PEDFECE, B.PEDHORA, B.MESCOD
				                    )
				            )				
				        GROUP BY PRODES, MESCOD,
				            PEDFECE, PEDHORA,
				            PEDEMPC, STMARCAS
				        ORDER BY PEDFECE, PEDHORA, MESCOD					
				    )
				ORDER BY FECHA, HORA, MESA;
 		BEGIN

 			OPEN CURSOR2(V_CODIGO_CONTAINER(I));
 			FETCH CURSOR2 INTO DATACURSOR21, DATACURSOR22, DATACURSOR23, DATACURSOR24, DATACURSOR25, DATACURSOR26, DATACURSOR27;
 			LOOP
 				EXIT WHEN CURSOR2%NOTFOUND;	 				

 				FOR J IN 1..DATACURSOR25
 				LOOP	 
 					-- INCREMENTA EN UNO EL CONSECUTIVO
 					V_CONSECUTIVO := V_CONSECUTIVO + 1;					
 					-- SE INSERTA LAS N VECES QUE SE PIDIO EL PLATO PARA ARAMAR LA COLA DEL PEDIDO
 					INSERT INTO TT_PEDIDOS_TIEMPOS(
 						CONSECUTIVO, PLATO, 
 						MESA, FECHA, 
 						HORA, EMPRESA, 
 						TIEMPO)
 					VALUES (
 						V_CONSECUTIVO, DATACURSOR21, 
 						DATACURSOR22, DATACURSOR23, 
 						DATACURSOR24, DATACURSOR26, 
 						DATACURSOR27);                    
 				END LOOP;

 				FETCH CURSOR2 INTO DATACURSOR21, DATACURSOR22, DATACURSOR23, DATACURSOR24, DATACURSOR25, DATACURSOR26, DATACURSOR27;

 			END LOOP;
 			CLOSE CURSOR2;

 		END;
	END LOOP;

	FOR I IN V_CODIGO_CONTAINER.FIRST..V_CODIGO_CONTAINER.LAST
	LOOP        
		DECLARE			
			-- VARIABLES LOGICAS
			V_TIEMPO_MENOR NUMBER := 60; 
			V_CANTIDAD_CEROS NUMBER := 0; -- CANTIDAD DE PEDIDOS TERMINADOS EN SERVIDORES
			V_CANTIDAD_COLA NUMBER := 0;  -- CANTIDAD DE PEDIDO EN COLA 	
            V_TIEMPO_TRANS NUMBER := 0;
			-- ARRAY DE LOS SERVIDORES
			CONSECUTIVO_ARRAY_SERVIDOR NUMBER := 0; 
			ARRAY_SERVIDORES_CONSECUTIVO PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY;
			ARRAY_SERVIDORES_TIEMPO PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY;
			ARRAY_SERVIDORES_EMPRESA PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY;
			-- ARRAY DE LAS COLAS
			CONSECUTIVO_ARRAY_COLAS NUMBER := 0; 
			ARRAY_COLAS_CONSECUTIVO PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY;			
			ARRAY_COLAS_TIEMPO  PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY;
			ARRAY_COLAS_EMPRESA PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY;
			-- ARRAY DE LAS COLAS
			CONSECUTIVO_ARRAY_CEROS NUMBER := 0; 
			ARRAY_COLAS_CEROS_CON PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY;		
			ARRAY_COLAS_CEROS_POS PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY;	
			-- ARRAY DE LAS COLAS QUE PASAN A LOS SERVIDORES
			CONSECUTIVO_ARRAY_TOSERV NUMBER := 0;
			ARRAY_TO_SERVIDORES PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY;
			-- CURSOR DE LOS PEDIDOS 
			DATACURSOR31 NUMBER; 		-- CARGA DE DATOS QUE TRAE EL CURSOR CONSECUTIVO			
			DATACURSOR32 NUMBER; 		-- CARGA DE DATOS QUE TRAE EL CURSOR TIEMPO 			
			CURSOR CURSOR3 (IN_CURSOR31 CHAR, IN_CURSOR32 NUMBER, IN_CURSOR33 NUMBER) IS
				SELECT CONSECUTIVO, TIEMPO 
				FROM TT_PEDIDOS_TIEMPOS
				WHERE CONSECUTIVO BETWEEN IN_CURSOR32 AND IN_CURSOR33
					AND EMPRESA = IN_CURSOR31;		

		BEGIN
			-- LLENAR EL ARRAY DE LOS SERVIDORES
			OPEN CURSOR3(V_CODIGO_CONTAINER(I), 1, V_CAPACIDAD_CONTAINER(V_CODIGO_CONTAINER(I)));
			FETCH CURSOR3 INTO DATACURSOR31, DATACURSOR32;
			LOOP
				EXIT WHEN CURSOR3%NOTFOUND;
				-- AUMENTO EL CONSECUTIVO EN 1
				CONSECUTIVO_ARRAY_SERVIDOR := CONSECUTIVO_ARRAY_SERVIDOR + 1;
				-- LLENA EL ARRAY CON  EL TIEMPO DE CADA PLATO Y SU CONSECUTIVO
				ARRAY_SERVIDORES_CONSECUTIVO(CONSECUTIVO_ARRAY_SERVIDOR) := DATACURSOR31;
				ARRAY_SERVIDORES_TIEMPO(CONSECUTIVO_ARRAY_SERVIDOR) := DATACURSOR32;				
				ARRAY_SERVIDORES_EMPRESA(CONSECUTIVO_ARRAY_SERVIDOR) := V_CODIGO_CONTAINER(I);                
				-- 
				UPDATE TT_PEDIDOS_TIEMPOS
				SET TIEMPOACUMU = DATACURSOR32
				WHERE CONSECUTIVO = DATACURSOR31
					AND EMPRESA = CAST(V_CODIGO_CONTAINER(I) AS CHAR(13));

				FETCH CURSOR3 INTO DATACURSOR31, DATACURSOR32;
			END LOOP;
			CLOSE CURSOR3;

			-- CANTIDAD DE PEDIDOS POR CONTAINER
			SELECT COUNT(*)
			INTO V_CANTIDAD_PEDIDO
			FROM TT_PEDIDOS_TIEMPOS
			WHERE EMPRESA = CAST(V_CODIGO_CONTAINER(I) AS CHAR(13));
			-- LLENAR EL ARAY DE LA COLA 	
			OPEN CURSOR3(V_CODIGO_CONTAINER(I), V_CAPACIDAD_CONTAINER(V_CODIGO_CONTAINER(I))+1, V_CANTIDAD_PEDIDO);
			FETCH CURSOR3 INTO DATACURSOR31, DATACURSOR32;
			LOOP
				EXIT WHEN CURSOR3%NOTFOUND;
				-- AUMENTO EL CONSECUTIVO EN 1
				CONSECUTIVO_ARRAY_COLAS := CONSECUTIVO_ARRAY_COLAS + 1;
				-- LLENA EL ARRAY CON  EL TIEMPO DE CADA PLATO Y SU CONSECUTIVO
				ARRAY_COLAS_CONSECUTIVO(CONSECUTIVO_ARRAY_COLAS) := DATACURSOR31;
				ARRAY_COLAS_TIEMPO(CONSECUTIVO_ARRAY_COLAS) := DATACURSOR32;
				ARRAY_COLAS_EMPRESA(CONSECUTIVO_ARRAY_COLAS) := V_CODIGO_CONTAINER(I);
               
				-- 
				FETCH CURSOR3 INTO DATACURSOR31, DATACURSOR32;
			END LOOP;
			CLOSE CURSOR3;

			-- CICLO PARA CALCULO DE TIEMPOS EN COLA
			LOOP                
				CONSECUTIVO_ARRAY_TOSERV := 0;
                V_TIEMPO_MENOR := 60;
                V_CANTIDAD_CEROS := 0;

				IF(ARRAY_SERVIDORES_TIEMPO.COUNT <> 0) THEN 
					-- CICLO PARA CALCULAR LOS TIEMPOS DE CADA PLATO 
					FOR J IN ARRAY_SERVIDORES_TIEMPO.FIRST..ARRAY_SERVIDORES_TIEMPO.LAST
					LOOP

						-- IDENTIFICAR EL MENOR DE LOS SERVIDORES
						IF(ARRAY_SERVIDORES_TIEMPO(J) < V_TIEMPO_MENOR) THEN
							V_TIEMPO_MENOR := ARRAY_SERVIDORES_TIEMPO(J);
						END IF;

					END LOOP;
                    
                    V_TIEMPO_TRANS := V_TIEMPO_TRANS + V_TIEMPO_MENOR;

					-- CICLO RESTAR EL MENOR TIEMPO A TODOS 
					FOR J IN ARRAY_SERVIDORES_TIEMPO.FIRST..ARRAY_SERVIDORES_TIEMPO.LAST
					LOOP
						-- IDENTIFICAR EL MENOR DE LOS SERVIDORES
						ARRAY_SERVIDORES_TIEMPO(J) := ARRAY_SERVIDORES_TIEMPO(J) - V_TIEMPO_MENOR;

					END LOOP;

					-- CONTAR TIEMPOS YA TERMINADOS
					FOR J IN ARRAY_SERVIDORES_TIEMPO.FIRST..ARRAY_SERVIDORES_TIEMPO.LAST
					LOOP
						-- IDENTIFICAR EL MENOR DE LOS SERVIDORES
						IF(ARRAY_SERVIDORES_TIEMPO(J) = 0) THEN 
							V_CANTIDAD_CEROS := V_CANTIDAD_CEROS + 1;
							CONSECUTIVO_ARRAY_CEROS := CONSECUTIVO_ARRAY_CEROS + 1;
							ARRAY_COLAS_CEROS_CON(CONSECUTIVO_ARRAY_CEROS) := ARRAY_SERVIDORES_CONSECUTIVO(J);
							ARRAY_COLAS_CEROS_POS(CONSECUTIVO_ARRAY_CEROS) := J;
						END IF;
					END LOOP;


					-- CANTIDAD DE PEDIDOS EN COLA 
					IF(ARRAY_COLAS_TIEMPO.COUNT <> 0) THEN
						V_CANTIDAD_COLA := ARRAY_COLAS_TIEMPO.COUNT;
					ELSE 
						V_CANTIDAD_COLA := 0;
					END IF;
                    
					-- SI ES NEGATIVO HAY MAS ESPACIO QUE COLAS
					IF((V_CANTIDAD_COLA - V_CANTIDAD_CEROS) < 0) THEN 
						FOR J IN 1..V_CANTIDAD_COLA
						LOOP
							-- 									
							CONSECUTIVO_ARRAY_TOSERV := CONSECUTIVO_ARRAY_TOSERV + 1;
							ARRAY_TO_SERVIDORES(CONSECUTIVO_ARRAY_TOSERV) := J;
							--
							ARRAY_SERVIDORES_CONSECUTIVO(ARRAY_COLAS_CEROS_POS(J)) := ARRAY_COLAS_CONSECUTIVO(J);
							ARRAY_SERVIDORES_TIEMPO(ARRAY_COLAS_CEROS_POS(J)) 	   := ARRAY_COLAS_TIEMPO(J);
							ARRAY_SERVIDORES_EMPRESA(ARRAY_COLAS_CEROS_POS(J)) 	   := ARRAY_COLAS_EMPRESA(J);                           

						END LOOP;
					-- HAY MAS COLA QUE ESPACIO ENSERVIDORES
					ELSIF((V_CANTIDAD_COLA - V_CANTIDAD_CEROS) > 0) THEN 
						FOR J IN 1..V_CANTIDAD_CEROS
						LOOP
							-- 									
							CONSECUTIVO_ARRAY_TOSERV := CONSECUTIVO_ARRAY_TOSERV + 1;
							ARRAY_TO_SERVIDORES(CONSECUTIVO_ARRAY_TOSERV) := J;
							--
							ARRAY_SERVIDORES_CONSECUTIVO(ARRAY_COLAS_CEROS_POS(J)) := ARRAY_COLAS_CONSECUTIVO(J);
							ARRAY_SERVIDORES_TIEMPO(ARRAY_COLAS_CEROS_POS(J)) 	   := ARRAY_COLAS_TIEMPO(J);
							ARRAY_SERVIDORES_EMPRESA(ARRAY_COLAS_CEROS_POS(J)) 	   := ARRAY_COLAS_EMPRESA(J);                            

						END LOOP;
					-- LA CANTIDAD EN SERVIDORES ES IGUAL A LA COLA
					ELSE
						FOR J IN 1..V_CANTIDAD_CEROS
						LOOP
							-- 									
							CONSECUTIVO_ARRAY_TOSERV := CONSECUTIVO_ARRAY_TOSERV + 1;
							ARRAY_TO_SERVIDORES(CONSECUTIVO_ARRAY_TOSERV) := J;
							--
							ARRAY_SERVIDORES_CONSECUTIVO(ARRAY_COLAS_CEROS_POS(J)) := ARRAY_COLAS_CONSECUTIVO(J);
							ARRAY_SERVIDORES_TIEMPO(ARRAY_COLAS_CEROS_POS(J)) 	   := ARRAY_COLAS_TIEMPO(J);
							ARRAY_SERVIDORES_EMPRESA(ARRAY_COLAS_CEROS_POS(J)) 	   := ARRAY_COLAS_EMPRESA(J);
                            
						END LOOP;
					END IF;

					-- ACOMODAR NUEVAMENTE LAS COLAS
					DECLARE
						--
						V_CONTADOR_POSCION NUMBER := 0;
						V_CONSECUTIVO_NUEVO NUMBER := 0;
						--
						COPY_ARRAY_COLAS_CONSECUTIVO PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY := ARRAY_COLAS_CONSECUTIVO;
						COPY_ARRAY_COLAS_TIEMPO PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY := ARRAY_COLAS_TIEMPO;
						COPY_ARRAY_COLAS_EMPRESA PKG_ACOMER_PROCEDURES.TYPE_PEDIDOS_ARRAY := ARRAY_COLAS_EMPRESA;
					BEGIN
						-- SE ELIMINAN LOS DATOS DE LAS COLAS
						ARRAY_COLAS_CONSECUTIVO.DELETE();
						ARRAY_COLAS_TIEMPO.DELETE();
						ARRAY_COLAS_EMPRESA.DELETE();
						-- SE REACOMODAN LAS COLAS
						IF(V_CANTIDAD_COLA > ARRAY_TO_SERVIDORES.COUNT) THEN
							FOR J IN COPY_ARRAY_COLAS_CONSECUTIVO.FIRST..COPY_ARRAY_COLAS_CONSECUTIVO.LAST
							LOOP
								--
								FOR K IN ARRAY_TO_SERVIDORES.FIRST..ARRAY_TO_SERVIDORES.LAST
								LOOP
									-- SI LA POSICION ES LA MISMA NO SE AGREGA
									IF(J = ARRAY_TO_SERVIDORES(K)) THEN
										V_CONTADOR_POSCION := V_CONTADOR_POSCION + 1;
									END IF;																
								END LOOP;

								IF(V_CONTADOR_POSCION = 0) THEN 
									-- AUMENTA UNO EN LA POSICION
									V_CONSECUTIVO_NUEVO := V_CONSECUTIVO_NUEVO + 1;
									--LLENA LA NUEVA COLA 
									ARRAY_COLAS_CONSECUTIVO(V_CONSECUTIVO_NUEVO) := COPY_ARRAY_COLAS_CONSECUTIVO(J);
									ARRAY_COLAS_TIEMPO(V_CONSECUTIVO_NUEVO) := COPY_ARRAY_COLAS_TIEMPO(J);
									ARRAY_COLAS_EMPRESA(V_CONSECUTIVO_NUEVO) := COPY_ARRAY_COLAS_EMPRESA(J);
								END IF;

								V_CONTADOR_POSCION := 0;
							END LOOP;
						END IF;
					END;

					--ACTUALIZAN LOS TIEMPOS
					IF(ARRAY_TO_SERVIDORES.COUNT > 0) THEN
						FOR J IN ARRAY_SERVIDORES_CONSECUTIVO.FIRST..ARRAY_SERVIDORES_CONSECUTIVO.LAST
						LOOP
							-- CONSULTA EL ESTADO DEL TIEMPO ACUMULADO DEL PLATO 
							SELECT 
								CASE
									WHEN TIEMPOACUMU = 0 THEN 
										0
									ELSE
										1
								END
							INTO V_IDENTIFICADOR_TIMEACU
							FROM TT_PEDIDOS_TIEMPOS
							WHERE CONSECUTIVO = CAST(ARRAY_SERVIDORES_CONSECUTIVO(J) AS NUMBER)
								AND EMPRESA = CAST(ARRAY_SERVIDORES_EMPRESA(J) AS CHAR(13));
							
							-- SI ES CERO SE ACTUALIZA EL TIEMPO ACUMULADO PARA EL PLATO INDICADO								
							IF(V_IDENTIFICADOR_TIMEACU = 0) THEN                                 
								UPDATE TT_PEDIDOS_TIEMPOS
								SET TIEMPOACUMU = CAST(ARRAY_SERVIDORES_TIEMPO(J) AS NUMBER) + V_TIEMPO_TRANS
								WHERE CONSECUTIVO = CAST(ARRAY_SERVIDORES_CONSECUTIVO(J) AS NUMBER)
									AND EMPRESA = CAST(ARRAY_SERVIDORES_EMPRESA(J) AS CHAR(13));
							END IF;


						END LOOP;

					END IF;

				END IF;

				-- CUANDO NO HAY MAS PEDIDOS EN COLA SALE DE CICLO
				IF(ARRAY_COLAS_TIEMPO.COUNT = 0) THEN 
					EXIT;
				END IF;

			END LOOP;
		END;
	END LOOP;

	-- ACTUALIZA EL TIEMPO DE CADA MESA EN CADA CONTAINER
	DECLARE
		V_TIEMPO_MESA_CONTAINER NUMBER; -- TIEMPO MAXIMO DE LA MESA EN EL CONTAINER
		DATACURSOR41 NUMBER; 			-- NUMERO DE LA MESA
		CURSOR CURSOR4 IS 
			SELECT CODIGO_MESA
			FROM TT_TIME_MESA_CONTAINER;
	BEGIN
		FOR I IN V_CODIGO_CONTAINER.FIRST..V_CODIGO_CONTAINER.LAST
		LOOP

			OPEN CURSOR4;
			FETCH CURSOR4 INTO DATACURSOR41;
			LOOP
				EXIT WHEN CURSOR4%NOTFOUND;
				-- CONSULTA EL TIEMPO MAYO DE LA MESA
				SELECT NVL(MAX(TIEMPOACUMU),0)
				INTO V_TIEMPO_MESA_CONTAINER
				FROM TT_PEDIDOS_TIEMPOS
				WHERE MESA = DATACURSOR41
					AND EMPRESA = CAST(V_CODIGO_CONTAINER(I) AS CHAR(13));

				CASE V_CODIGO_CONTAINER(I)
					WHEN PKG_ACOMER_PROCEDURES.PKG_CONTAINER1 THEN
						UPDATE TT_TIME_MESA_CONTAINER
						SET TIEMPO_CONTAINER1 = V_TIEMPO_MESA_CONTAINER
						WHERE CODIGO_MESA =DATACURSOR41;
					WHEN PKG_ACOMER_PROCEDURES.PKG_CONTAINER2 THEN
						UPDATE TT_TIME_MESA_CONTAINER
						SET TIEMPO_CONTAINER2 = V_TIEMPO_MESA_CONTAINER
						WHERE CODIGO_MESA = DATACURSOR41;
					WHEN PKG_ACOMER_PROCEDURES.PKG_CONTAINER3 THEN
						UPDATE TT_TIME_MESA_CONTAINER
						SET TIEMPO_CONTAINER3 = V_TIEMPO_MESA_CONTAINER
						WHERE CODIGO_MESA = DATACURSOR41;
					WHEN PKG_ACOMER_PROCEDURES.PKG_CONTAINER4 THEN
						UPDATE TT_TIME_MESA_CONTAINER
						SET TIEMPO_CONTAINER4 = V_TIEMPO_MESA_CONTAINER
						WHERE CODIGO_MESA = DATACURSOR41;
				END CASE;

				FETCH CURSOR4 INTO DATACURSOR41;
			END LOOP;
			CLOSE CURSOR4;

		END LOOP;
	END;

 	-- CONFIRMACION DE LOS CAMBIOS Y SE CARGAN LOS DATOS EN EL CURSOR 
 	COMMIT;

 	/*OPEN OUT_CURSOR_TIEMPOS FOR
 		SELECT CODIGO_MESA MESA,
 			GREATEST(TIEMPO_CONTAINER1, TIEMPO_CONTAINER2, TIEMPO_CONTAINER3, TIEMPO_CONTAINER4) TIEMPO
 		FROM TT_TIME_MESA_CONTAINER;*/
 END;