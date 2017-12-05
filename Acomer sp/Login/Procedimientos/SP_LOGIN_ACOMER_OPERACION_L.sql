CREATE OR REPLACE PROCEDURE SP_LOGIN_ACOMER_OPERACION_L
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_IN_USER_ID IN GEN0011.TERCOD%TYPE, -- IDENTIFICADOR CON EL QUE EL USUARIO HACE LOGIN 
	V_IN_USER_PASS IN VARCHAR2,			 -- CONTRASENA DE ACCESO 
	V_IN_ACT_PASS IN VARCHAR2,			 -- CLAVE DE ACTIVACION O CREACION DE CONTRASENA
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
	V_USER_ADMIN VARCHAR2(20);			             -- USUARIO ADMINISRADOR 	
BEGIN
	-- =============================================
	-- CONSULTA EL USUARIO ADMINISTRADOR DEL SISTEMA 
	BEGIN
		SELECT VAR_CARAC 
		INTO V_USER_ADMIN
		FROM TAB_PARAM_ACOMER
		WHERE NOM_VAR = 't_adminweb';
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			V_USER_ADMIN := NULL;
	END;
	-- =============================================
	-- SE VALIDA QUE EL USUARIO SI EXISTA EN LA BD 
	SELECT COUNT(*)
	INTO V_EXISTE
	FROM GEN0011 GN
	WHERE GN.TERCOD = V_IN_USER_ID
		AND ROWNUM = 1;
	-- =============================================
	-- SI EL USUARIO INGRESADO ES EL ADMINISTRADOR
	-- O UN USUARIO CON ACCESO	
	IF((V_EXISTE > 0) OR (TRIM(V_IN_USER_ID) = V_USER_ADMIN)) THEN
		BEGIN
			-- =============================================
			-- SI EL USUARIO INGRESADO ES EL ADMINISTRADOR	
			IF(V_IN_USER_ID = V_USER_ADMIN) THEN
				BEGIN
					V_OUT_USER_ID := V_IN_USER_ID;
				END;

			ELSE

				BEGIN
					-- =============================================
					-- BUSCA EL USUARIO EN BD Y LO ASIGNA EN VARIABLE
					SELECT TERCOD
					INTO V_OUT_USER_ID
					FROM GEN0011
					WHERE TERCOD = V_IN_USER_ID
						AND ROWNUM = 1; 
				EXCEPTION 
					WHEN NO_DATA_FOUND THEN
						V_OUT_USER_ID := NULL;
						V_OUT_COD_MESS := -20001;
						V_OUT_MESS := 'El usuario ingresado no es valido o no existe';
				END;
			END IF;
			-- =============================================
			-- VERIFICA QUE EL USUARIO INGRESADO
			-- SI ESTA EN LA BD
			IF(V_OUT_USER_ID IS NOT NULL) THEN
				BEGIN
					-- =============================================
					-- SE VALIDA QUE EL USUARIO YA ESTA REGISTRADO
					-- COMO USUARIO DE LOGIN
					SELECT COUNT(*)
					INTO V_EXISTE
					FROM TAB_LOGIN_ACOMER
					WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID);
					-- =============================================
					-- SI EL USUARIO LOGIN NO ESTA REGISTRADO
					IF(V_EXISTE = 0) THEN
						BEGIN
							V_OUT_USER_ID := V_IN_USER_ID;
							V_OUT_COD_MESS := 0;
							V_OUT_MESS := 'El usaurio '||V_IN_USER_ID||' no existe, debe crearlo y asignarle una contraseña';
						END;

					ELSE

						BEGIN
							-- =============================================
							-- SE OBTIENEN LOS DATOS DE LOG PARA EL USUARIO 
							SELECT NUM_INTENTOS,FEC_CREA_MOD,CONTRAS_LOG,ID_ACTIVACION
							INTO V_INTENTOS, V_ULTIMO_LOG, V_PASS, V_ACTIVACION
							FROM TAB_LOGIN_ACOMER
							WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID);
						EXCEPTION
							WHEN NO_DATA_FOUND THEN
								V_INTENTOS := 0;
								V_ULTIMO_LOG := NULL;
								V_PASS := NULL;
								V_ACTIVACION := NULL;
							WHEN OTHERS THEN
                               	RAISE_APPLICATION_ERROR (-20000, 'Error: '||SQLCODE||' '||SQLERRM);
						END;

						-- =============================================
						-- SI HAY UN CODIGO DE ACTIVACION, SE DEBE INGRESAR
						-- Y CONTINUAR CON EL PROCESO DE LOGIN
						IF(V_ACTIVACION IS NULL) THEN
							BEGIN
								-- =============================================
								-- SI LA CLAVE INGRESADA ES IGUAL EN BD, SI NO
								-- SE ACTUALIZARA EL NUMERO DE INTENTO Y AL TERCERO
								-- SERA BLOQUEADO Y TENDRA QUE CREAR UNA NUEVA CONTRA
								IF(V_PASS = FN_ENCRIPTAR_DATOS(V_IN_USER_PASS)) THEN
									BEGIN										
										IF(V_INTENTOS <= 3) THEN
											-- =============================================
											-- SI EL PASS FUE CREADO O ACTUALIZADO HACE 60 
											-- PEDIRA RENOVARLA 
											BEGIN
												IF(TO_DATE(V_ULTIMO_LOG, 'DD-MM-YYYY')+60 >= TO_DATE(SYSDATE,'DD-MM-YYYY')) THEN
													BEGIN
														UPDATE TAB_LOGIN_ACOMER
														SET NUM_INTENTOS = 0,
															ID_ACTIVACION = NULL
														WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID)
															AND FEC_CREA_MOD = V_ULTIMO_LOG;
														COMMIT;
													EXCEPTION
														WHEN OTHERS THEN
															RAISE_APPLICATION_ERROR (-20000, 'Error: '||SQLCODE||' '||SQLERRM);
													END;

													BEGIN
														V_OUT_USER_ID := V_IN_USER_ID;
														V_OUT_COD_MESS := 1;
														V_OUT_MESS := 'Acceso correcto';
													END;
												ELSE

													BEGIN
														V_OUT_USER_ID := V_IN_USER_ID;
														V_OUT_COD_MESS :=2;
														V_OUT_MESS := 'Su contraseña ha caducado, por favor ingrese una nueva';
													END;
												END IF;
											END;

										ELSE
											
											BEGIN
												V_OUT_USER_ID := V_IN_USER_ID;
												V_OUT_COD_MESS := 3;
												V_OUT_MESS := 'El numero de intentos fallidos a superado el limite, por favor cree una nueva contraseña';
											END;
										END IF;
									END;

								ELSE

									BEGIN
										V_INTENTOS := V_INTENTOS + 1;

										IF(V_INTENTOS <= 4) THEN
											BEGIN
												UPDATE TAB_LOGIN_ACOMER
												SET NUM_INTENTOS = V_INTENTOS,
													ID_ACTIVACION = NULL
												WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID);
												COMMIT;
											EXCEPTION
												WHEN OTHERS THEN
													RAISE_APPLICATION_ERROR (-20000, 'Error: '||SQLCODE||' '||SQLERRM);
											END;

											BEGIN
												V_OUT_USER_ID := NULL;
												V_OUT_COD_MESS := -20002;
												V_OUT_MESS := 'Clave no valida, lleva '||V_INTENTOS||' intento(s) fallido(s).';
											END;

										ELSE

											BEGIN
												V_OUT_USER_ID := V_IN_USER_ID;
												V_OUT_COD_MESS := 3;
												V_OUT_MESS := 'El numero de intentos fallidos a superado el limite, por favor cree una nueva contraseña';
											END;
										END IF;
									END;
								END IF;
							END;

						ELSE
							IF(V_IN_ACT_PASS IS NULL) THEN
								BEGIN
									V_OUT_USER_ID := V_IN_USER_ID;
									V_OUT_COD_MESS := 4;									
									V_OUT_MESS := 'Debe activar su cuenta, ingrese el codigo de validacion enviado a su correo para activar el usuario';
								END;
							ELSE

								BEGIN
									IF(V_ACTIVACION = V_IN_ACT_PASS) THEN
										BEGIN
										 	IF(V_PASS = FN_ENCRIPTAR_DATOS(V_IN_USER_PASS)) THEN
											 	BEGIN
											 		IF(V_INTENTOS <= 3) THEN
											 			BEGIN
											 				-- =============================================
													 		-- SI EL PASS FUE CREADO O ACTUALIZADO HACE 60 
															-- PEDIRA RENOVARLA 
											 				 IF(TO_DATE(V_ULTIMO_LOG,'DD-MM-YYYY')+60 >= TO_DATE(SYSDATE, 'DD-MM-YYYY')) THEN
											 				 	BEGIN
											 				 		UPDATE TAB_LOGIN_ACOMER
											 				 		SET NUM_INTENTOS = 0,
											 				 			ID_ACTIVACION = NULL
											 				 		WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID);
											 				 		COMMIT;
											 				 	EXCEPTION
											 				 		WHEN OTHERS THEN
											 				 			RAISE_APPLICATION_ERROR(-20000, 'Error: '||SQLERRM||' '||SQLERRM);
											 				 	END;

											 				 	BEGIN
											 				 		V_OUT_USER_ID := V_IN_USER_ID;
											 				 		V_OUT_COD_MESS := 1;
											 				 		V_OUT_MESS := 'Acceso correcto';
											 				 	END;

											 				 ELSE

											 				 	BEGIN
											 				 		V_OUT_USER_ID := V_IN_USER_ID;
											 				 		V_OUT_COD_MESS := 2;
											 				 		V_OUT_MESS := 'Su contraseña ha caducado, por favor cree una nueva';
											 				 	END;
											 				 END IF;
											 			END;

											 		ELSE

											 			BEGIN
											 				V_OUT_USER_ID := V_IN_USER_ID;
									 				 		V_OUT_COD_MESS := 3;
									 				 		V_OUT_MESS := 'El numero de intentos fallidos a superado el limite, por favor cree una nueva contraseña';
											 			END;
											 		END IF;
											 	END;

											ELSE

												BEGIN
													V_INTENTOS := V_INTENTOS + 1;

													IF(V_INTENTOS <= 4) THEN
														BEGIN
															UPDATE TAB_LOGIN_ACOMER
															SET NUM_INTENTOS = V_INTENTOS
															WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID);
															COMMIT;
															DBMS_OUTPUT.PUT_LINE('actualizanco la tabla login con v_intentos en: '||v_intentos);
														EXCEPTION
															WHEN OTHERS THEN
																RAISE_APPLICATION_ERROR (-20000, 'Error: '||SQLCODE||' '||SQLERRM);
														END;

														BEGIN
															V_OUT_USER_ID := NULL;
									 				 		V_OUT_COD_MESS := -20002;
									 				 		V_OUT_MESS := 'Clave no valida, llevaa '||V_INTENTOS||' intento(s) fallido(s).';
														END;

													ELSE

														BEGIN
															V_OUT_USER_ID := V_IN_USER_ID;
									 				 		V_OUT_COD_MESS := 3;
									 				 		V_OUT_MESS := 'El numero de intentos fallidos a superado el limite, por favor cree una nueva contraseña';
														END;
													END IF;
												END;
											END IF;
										END;

									ELSE

										BEGIN
											V_OUT_USER_ID := V_IN_USER_ID;
					 				 		V_OUT_COD_MESS := 5;
					 				 		V_OUT_MESS := 'El código de validación ingresado no corresponde al generado, por favor verifique';
										END;
									END IF;
								END;
							END IF;
						END IF;
					END IF;
				END;
			END IF;
		END;
	ELSE
		V_OUT_USER_ID := NULL;
 		V_OUT_COD_MESS := -20001;
 		V_OUT_MESS := 'El usuario ingresado no es valido o no existe';
	END IF;
END;