create or replace PROCEDURE SP_ACOMER_FACTURA_RESPALDO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	IN_CODIGO_MESA IN INV00018.MESCOD%TYPE, -- CODIGO DE LA MESA QUE SE SACARA RESPALDO DEL PEDIDO
	OUT_CODIGO_REVER OUT NUMBER				-- NUMERO DE REVER QUE SE LE ASIGNA
)
AS
	V_MESA_PRINCIPAL UNIONMESA.MESCOD%TYPE; -- IDENTIFICAR SI ES UNA MESA UNIDA Y DE SERLO CUAL ES LA PRINCIPAL
	V_NUMERO_REVER NUMBER;					-- NUMERO DE REVER QUE SE LE ASIGNA A LA OPERACION HECHA EN CASO DE NECESITAR LOS DATOS COMO ESTABAN
	V_NUMERO_REVER_EXT NUMBER;				-- NUMERO DE REVER QUE LA MESA TENGA SI HA DE TENERLO 
BEGIN
	BEGIN
		--CONSULTA LA MESA PRINCIPAL SI ES UNA MESA UNIDA 
		SELECT DISTINCT MESCOD
		INTO V_MESA_PRINCIPAL
		FROM UNIONMESA
		WHERE MESCOD = IN_CODIGO_MESA
		  	OR MESCODUNI = IN_CODIGO_MESA;
	EXCEPTION 
		WHEN NO_DATA_FOUND THEN 
			V_MESA_PRINCIPAL := 0;
	END;

	BEGIN
		SELECT DISTINCT NUMEROREVER
		INTO V_NUMERO_REVER_EXT
		FROM TABCOPYINV00018 A
		WHERE A.MESCOD = IN_CODIGO_MESA;

		DELETE FROM TABCOPYINV00018
		WHERE NUMEROREVER = V_NUMERO_REVER_EXT;

		DELETE FROM TABCOPYVEN0104
		WHERE NUMEROREVER = V_NUMERO_REVER_EXT;

		DELETE FROM TABCOPYVEN0004
		WHERE NUMEROREVER = V_NUMERO_REVER_EXT;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			V_NUMERO_REVER_EXT:= 0;
	END;

	-- SI LA  MESA PRINCIPAL ES 0 ES UNA MESA SOLA
	IF(V_MESA_PRINCIPAL = 0) THEN 
		BEGIN

			-- NUMERO QUE SE LE ASIGNA AL REVER
			SELECT NVL(MAX(NUMEROREVER),0) + 1 
			INTO V_NUMERO_REVER
			FROM TABCOPYVEN0104;

			-- COPIA DE RESPALDO EN VEN0104 PARA LA MESA X
			INSERT INTO TABCOPYVEN0104
			SELECT V_NUMERO_REVER, A.* 
			FROM VEN0104 A
			INNER JOIN INV00018 B
				ON B.MESNUMREQ  = A.PEDNUMDOC
				OR B.MESNUMREQ2 = A.PEDNUMDOC
				OR B.MESNUMREQ3 = A.PEDNUMDOC
				OR B.MESNUMREQ4 = A.PEDNUMDOC
			WHERE B.MESCOD  = IN_CODIGO_MESA;

			-- COPIA DE RESPALDO EN VEN0004 PARA LA MESA X
			INSERT INTO TABCOPYVEN0004
			SELECT V_NUMERO_REVER, A.* 
			FROM VEN0004 A
			INNER JOIN VEN0104 B
				ON A.PEDNRO = B.PEDNRO
				AND A.PEDEMPC = B.PEDEMPC
			INNER JOIN INV00018 C
				ON C.MESNUMREQ  = B.PEDNUMDOC
				OR C.MESNUMREQ2 = B.PEDNUMDOC
				OR C.MESNUMREQ3 = B.PEDNUMDOC
				OR C.MESNUMREQ4 = B.PEDNUMDOC
			WHERE C.MESCOD  = IN_CODIGO_MESA;

			-- COPIA DE RESPALDO EN INV00018
			INSERT INTO TABCOPYINV00018
			SELECT V_NUMERO_REVER, A.* 
			FROM INV00018 A
			WHERE A.MESCOD = IN_CODIGO_MESA;
		END;
	ELSE
		BEGIN
			-- NUMERO QUE SE LE ASIGNA AL REVER
			SELECT NVL(MAX(NUMEROREVER),0) + 1 
			INTO V_NUMERO_REVER
			FROM TABCOPYVEN0104;

			-- COPIA DE RESPALDO EN VEN0104 PARA LA MESA X
			INSERT INTO TABCOPYVEN0104
			SELECT V_NUMERO_REVER, A.* 
			FROM VEN0104 A
			INNER JOIN INV00018 B
				ON B.MESNUMREQ  = A.PEDNUMDOC
				OR B.MESNUMREQ2 = A.PEDNUMDOC
				OR B.MESNUMREQ3 = A.PEDNUMDOC
				OR B.MESNUMREQ4 = A.PEDNUMDOC
			WHERE B.MESCOD IN (V_MESA_PRINCIPAL)
				OR B.MESCOD IN (SELECT DISTINCT MESCODUNI FROM UNIONMESA WHERE MESCOD = V_MESA_PRINCIPAL);

			-- COPIA DE RESPALDO EN VEN0004 PARA LA MESA X
			INSERT INTO TABCOPYVEN0004
			SELECT V_NUMERO_REVER, A.* 
			FROM VEN0004 A
			INNER JOIN VEN0104 B
				ON A.PEDNRO = B.PEDNRO
				AND A.PEDEMPC = B.PEDEMPC
			INNER JOIN INV00018 C
				ON C.MESNUMREQ  = B.PEDNUMDOC
				OR C.MESNUMREQ2 = B.PEDNUMDOC
				OR C.MESNUMREQ3 = B.PEDNUMDOC
				OR C.MESNUMREQ4 = B.PEDNUMDOC
			WHERE B.MESCOD IN (V_MESA_PRINCIPAL)
				OR B.MESCOD IN (SELECT DISTINCT MESCODUNI FROM UNIONMESA WHERE MESCOD = V_MESA_PRINCIPAL);

			-- COPIA DE RESPALDO EN INV00018
			INSERT INTO TABCOPYINV00018
			SELECT V_NUMERO_REVER, A.* 
			FROM INV00018 A
			WHERE A.MESCOD IN (V_MESA_PRINCIPAL)
				OR A.MESCOD IN (SELECT DISTINCT MESCODUNI FROM UNIONMESA WHERE MESCOD = V_MESA_PRINCIPAL);

			-- COPIA DE RESPALDO EN UNIONMESA
			INSERT INTO COPYUNIONMESA
			SELECT V_NUMERO_REVER, A.*
			FROM UNIONMESA A
			WHERE A.MESCOD IN (V_MESA_PRINCIPAL);

		END;
	END IF;
	
	OUT_CODIGO_REVER := V_NUMERO_REVER;
	COMMIT;
END;