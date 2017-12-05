CREATE OR REPLACE PROCEDURE SP_LOGIN_ACOMER_OPERACION_C
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
	V_BODY_MAIL VARCHAR2(6000);						 -- CUERPO DEL MENSAJE QUE SE LE ENVIA AL USUAIRO
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
	--CONSLTA SSI EL USUARIO SI EXSTE EN DB 
	SELECT COUNT(*)
	INTO V_EXISTE
	FROM GEN0011 GN
	WHERE GN.TERCOD = V_IN_USER_ID
		AND ROWNUM = 1;
	-- =============================================
	-- DETERMINA SI EL USUARIO INGRESADO SI EXISTE O
	-- ES EL ADMINISTRADOR
	IF(V_EXISTE > 0) OR (TRIM(V_IN_USER_ID) = V_USER_ADMIN) THEN
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
						V_OUT_MESS := 'El usuario ingresado no es valido o no existe';
					WHEN OTHERS THEN
						RAISE_APPLICATION_ERROR(-20000, 'Error: '||SQLCODE||' '||SQLERRM);
				END;
			END IF;

			IF(V_OUT_USER_ID IS NOT NULL) THEN
				BEGIN
					-- =============================================
					-- SE VALIDA QUE EL USUARIO YA ESTA REGISTRADO
					-- COMO USUARIO DE LOGIN
					SELECT COUNT(*)
					INTO V_EXISTE
					FROM TAB_LOGIN_ACOMER
					WHERE USUARIO_LOG = FN_ENCRIPTAR_DATOS(V_OUT_USER_ID);

					IF(V_EXISTE = 0) THEN
						BEGIN
							-- =============================================
							-- SE GENERA UN CODIGO ALFANUMERICO  ALEATORIO
							-- COMO CODIGO DE ACTIVACION DE USUARIO
							-- Y SE INSERTA EN LA TABLA DE LOGIN
							V_ACTIVACION := DBMS_RANDOM.STRING('X',20);

							BEGIN
								INSERT INTO TAB_LOGIN_ACOMER
								VALUES (
									FN_ENCRIPTAR_DATOS(V_OUT_USER_ID),
									FN_ENCRIPTAR_DATOS(V_OUT_USER_ID),
									SYSDATE,
									V_ACTIVACION,
									0);
							EXCEPTION
								WHEN OTHERS THEN 
									RAISE_APPLICATION_ERROR(-20000, 'Error: '||SQLCODE||' '||SQLERRM);
							END;

							BEGIN
								-- =================================
								-- CORREO DE PRUEBA 
								V_DESCRIPCION := 'vladimir.bello@talentsw.com';
								-- CORREO DE PRUEBA
								-- =================================

								
								SP_LOGIN_ACOMER_ACTIVAR_CUENTA (V_ACTIVACION,V_IN_USER_ID,'C',V_BODY_MAIL);
								-- =============================================
								-- ENVIA EL CORREO AL USUARIO CON EL LINK DE ACTIVACION
								EMAIL(sender 	=> 'vladimir.bello@talentsw.com',
                                   sender_name  => 'Talentos y Tecnología SAS',
                                   recipients   => V_DESCRIPCION,
                                   subject      => 'ACOMER - Activación de Clave',
                                   message      => V_BODY_MAIL);
							END;

							BEGIN
								V_OUT_USER_ID := V_IN_USER_ID;
								V_OUT_COD_MESS := 6;
								V_OUT_MESS := 'Hemos enviado las instrucciones de activaci'||CHR(38)||'oacute;n al correo electronico que tienes registrado en n'||CHR(38)||'oacute;mina, por favor revisa tu bandeja de entrada.';
							END;
						END;

					ELSE

						BEGIN
							V_OUT_USER_ID := V_IN_USER_ID;
							V_OUT_COD_MESS := 7;
							V_OUT_MESS := 'El usuario '||V_OUT_USER_ID||' ya existe, si lo requiere recupere su contraseña';
						END;
					END IF;
				END;

			ELSE

				BEGIN
					V_OUT_USER_ID := NULL;
					V_OUT_COD_MESS := -20001;
					V_OUT_MESS := 'El usuario ingresado no es valido o no existe';
				END;
			END IF;
		END;

	ELSE

		BEGIN
			V_OUT_USER_ID := NULL;
			V_OUT_COD_MESS := -20001;
			V_OUT_MESS := 'El usuario ingresado no es valido o no existe';
		END;
	END IF;
END;