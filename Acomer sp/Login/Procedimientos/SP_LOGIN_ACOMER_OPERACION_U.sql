CREATE OR REPLACE PROCEDURE SP_LOGIN_ACOMER_OPERACION_U
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
 	V_IN_USER_ID IN GEN0011.TERCOD%TYPE, -- IDENTIFICADOR CON EL QUE EL USUARIO HACE LOGIN 
	--V_IN_USER_PASS IN VARCHAR2,			 -- CONTRASENA DE ACCESO 
	--V_IN_ACT_PASS IN VARCHAR2,			 -- CLAVE DE ACTIVACION O CREACION DE CONTRASENA
	V_OUT_USER_ID OUT GEN0011.TERCOD%TYPE, -- IDENTIFICACION DEL USUARIO QUE SE HIZO LOGIN
	V_OUT_MESS OUT VARCHAR2,			   -- MENSAJE DE SALIDA
	V_OUT_COD_MESS OUT NUMBER			   -- CODIGO DE MENSAJE
)
AS
	V_EXISTE NUMBER; 							-- VALIDA EXISTENCIA DEL USUARIO
	V_ULTIMO_LOG DATE; 							-- FECHA DE CREACION O CAMBIO DE CONTRASENA
	V_INTENTOS TAB_LOGIN_ACOMER.NUM_INTENTOS%TYPE; 	 -- NUMERO DE INTENTOS DE LOGIN
	V_PASS TAB_LOGIN_ACOMER.CONTRAS_LOG%TYPE;		 -- CONTRASENA REGISTRADA PARA EL USUAIRO
	V_ACTIVACION TAB_LOGIN_ACOMER.ID_ACTIVACION%TYPE;-- CODIGO DE ACTIVACION
	V_USER_ADMIN TAB_PARAM_ACOMER.VAR_CARAC%TYPE;     -- USUARIO ADMINISRADOR 	
	V_DESCRIPCION TAB_PARAM_ACOMER.DESCRIPCION%TYPE; -- CORREO DEL USUARIO
	V_BODY_MAIL VARCHAR2(32676);						 -- CUERPO DEL MENSAJE QUE SE LE ENVIA AL USUAIRO
BEGIN
	-- =============================================
	-- CONSULTA EL USUARIO ADMINISTRADOR DEL SISTEMA 
	BEGIN
		SELECT VAR_CARAC, DESCRIPCION
		INTO V_USER_ADMIN, V_DESCRIPCION
		FROM TAB_PARAM_ACOMER
		WHERE NOM_VAR = 't_adminweb';
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN
			V_USER_ADMIN := NULL;
	END;
	
	-- =============================================
	-- CONSULTA SI EL USAUIRO EXISTE EN DB
	SELECT COUNT(*)
	INTO V_EXISTE
	FROM GEN0011 GN
	WHERE GN.TERCOD = V_IN_USER_ID
		AND ROWNUM = 1;

	-- =============================================
	-- DETERMINA SI EL USUAIRO INGRESADO EXISTE O
	-- SI ES EL ADMIN
	IF(V_EXISTE > 0) OR (V_IN_USER_ID = V_USER_ADMIN) THEN
		BEGIN
			-- =============================================
			-- DETERMINA SI ES EL ADMINISTRADOR Y RETORNA SU 
			-- IDENTIFICADOR, DE LO CONTRATIO SE DETEMINA SI 
			-- EXISTE EL USER EN DB
			IF(TRIM(V_IN_USER_ID) = V_USER_ADMIN) THEN
				BEGIN
					V_OUT_USER_ID := V_IN_USER_ID;
				END;

			ELSE

				BEGIN
					SELECT GN.TERCOD, GN.TERMAI
					INTO V_OUT_USER_ID, V_DESCRIPCION
					FROM GEN0011 GN
					WHERE GN.TERCOD = V_IN_USER_ID;
				EXCEPTION
					WHEN NO_DATA_FOUND THEN
						V_OUT_USER_ID := NULL;
						V_OUT_COD_MESS := -20001;
						V_OUT_MESS := 'El usuaio ingresado no es valido o no existe';
					WHEN OTHERS THEN
						RAISE_APPLICATION_ERROR (-20000, 'Error: '||SQLCODE||' '||SQLERRM);
				END;
			END IF;

			IF(V_OUT_USER_ID IS NOT NULL) THEN
				BEGIN
					-- =============================================
					-- SE VALIDA QUE EXISTA EL USUARIO QUE QUIERE
					-- CAMBIAR LA CONTRASENA 
					SELECT COUNT(*)
					INTO V_EXISTE
					FROM TAB_LOGIN_ACOMER
					WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID);

					SELECT COUNT(ID_ACTIVACION)
					INTO V_ACTIVACION
					FROM TAB_LOGIN_ACOMER
						WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID);

					IF(V_ACTIVACION > 0) THEN
						BEGIN
							V_OUT_USER_ID := V_IN_USER_ID;
							V_OUT_COD_MESS := 4;
							V_OUT_MESS := 'Señor usuario, con el codigo enviado al correo active la cuenta o contacte al administrador';
						END;

					ELSE

						BEGIN
							IF(V_EXISTE > 0) THEN
								BEGIN
									-- =============================================
									-- SE GUARDA LA CONTRASENA EXISTENTE EN EL HISTORIAL
									BEGIN
										INSERT INTO TAB_HIST_LOGIN_ACOMER (FEC_CREA_MOD, USUARIO_LOG, CONTRAS_LOG)
					                        SELECT FEC_CREA_MOD, USUARIO_LOG, CONTRAS_LOG 
					                        FROM TAB_LOGIN_ACOMER
					                        WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID);
					                EXCEPTION
					                	WHEN OTHERS THEN
					                		RAISE_APPLICATION_ERROR (-20000, 'Error: '||SQLCODE||' '||SQLERRM);
									END;
									-- =============================================
									-- SE CREA UNA CALVE DE ACTIVACION Y SE ACTUALIZZAN
									-- LOS DATOS DEL USUARIO
									BEGIN
										V_ACTIVACION :=DBMS_RANDOM.STRING('X',20);

										UPDATE TAB_LOGIN_ACOMER
										SET CONTRAS_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID),
											FEC_CREA_MOD = SYSDATE,
											NUM_INTENTOS = 0,
											ID_ACTIVACION = V_ACTIVACION
										WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID);
									EXCEPTION
			                            WHEN OTHERS THEN
			                                RAISE_APPLICATION_ERROR (-20000, 'Error: '||SQLCODE||' '||SQLERRM);
									END;

									BEGIN		                        
				                        -- =================================
										-- CORREO DE PRUEBA 
										V_DESCRIPCION := 'vladimir.bello@talentsw.com';
										-- CORREO DE PRUEBA
										-- =================================

					                    SP_LOGIN_ACOMER_ACTIVAR_CUENTA (V_ACTIVACION,V_IN_USER_ID,'U',V_BODY_MAIL);
										-- =============================================
										-- ENVIA EL CORREO AL USUARIO CON EL LINK DE ACTIVACION
				                        EMAIL(sender  => 'vladimir.bello@talentsw.com',
		                                   sender_name => 'Talentos y Tecnología SAS',
		                                   recipients  => V_DESCRIPCION,
		                                   subject     => 'ACOMER - Activación de Clave',
		                                   message     => V_BODY_MAIL);
				                    END;

				                    BEGIN
										V_OUT_USER_ID := V_IN_USER_ID;
										V_OUT_COD_MESS := 9;
										V_OUT_MESS := 'Hemos enviado un  link de activacion a su correo';
									END;
								END;

							ELSE

								BEGIN
									V_OUT_USER_ID := NULL;
				                    V_OUT_COD_MESS := 0;
				                    V_OUT_MESS := 'El usuario '||V_IN_USER_ID||' no existe, debe crearlo y asignar una contraseña segura';
								END;
							END IF;
						END;
					END IF;					
				END;

			ELSE

				BEGIN
					V_OUT_USER_ID := NULL;
	                V_OUT_COD_MESS := -20001;
	                V_OUT_MESS := 'El usuaio ingresado no es valido o no existe';
				END;
			END IF;
		END;

	ELSE

		BEGIN
			V_OUT_USER_ID := NULL;
            V_OUT_COD_MESS := -20001;
            V_OUT_MESS := 'El usuaio ingresado no es valido o no existe';
		END;
	END IF;
END;