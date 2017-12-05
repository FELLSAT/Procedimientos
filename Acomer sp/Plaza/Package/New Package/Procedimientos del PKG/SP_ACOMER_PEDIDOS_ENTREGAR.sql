create or replace PROCEDURE SP_ACOMER_PEDIDOS_ENTREGAR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	CURSOR_PEDIDOS OUT SYS_REFCURSOR  -- CURSOR QUE TRAE LOS PEDIDOS QUE YA ESTAN LISTOS PARA ENTREGAR
)
AS
	V_COUNT NUMBER; -- CONTAR LOS REGISTROS 
BEGIN
	SELECT COUNT(*)
	INTO V_COUNT
	FROM INV00018 INV1    
	INNER JOIN VEN0104 VEN1
	    ON INV1.MESNUMREQ = VEN1.PEDNUMDOC
	    OR INV1.MESNUMREQ2 = VEN1.PEDNUMDOC
	    OR INV1.MESNUMREQ3 = VEN1.PEDNUMDOC
	    OR INV1.MESNUMREQ4 = VEN1.PEDNUMDOC
	INNER JOIN VEN0004 VEN2
	    ON VEN1.PEDNRO = VEN2.PEDNRO
	WHERE VEN2.PEDSAL = 'T'
	ORDER BY VEN1.PEDEMPC;

	IF(V_COUNT = 0) THEN
		BEGIN
			OPEN CURSOR_PEDIDOS FOR
				SELECT 'NO' ESTADO,
				    'NO' MESA,
				    'NO' EMPRESA
				FROM DUAL;
		END;
	ELSE
		BEGIN
			OPEN CURSOR_PEDIDOS FOR
				SELECT DISTINCT *
				FROM (
					SELECT VEN2.PEDSAL ESTADO,
					    VEN1.MESCOD MESA,
					    VEN1.PEDEMPC EMPRESA
					FROM INV00018 INV1    
					INNER JOIN VEN0104 VEN1
					    ON INV1.MESNUMREQ = VEN1.PEDNUMDOC
					    OR INV1.MESNUMREQ2 = VEN1.PEDNUMDOC
					    OR INV1.MESNUMREQ3 = VEN1.PEDNUMDOC
					    OR INV1.MESNUMREQ4 = VEN1.PEDNUMDOC
					INNER JOIN VEN0004 VEN2
					    ON VEN1.PEDNRO = VEN2.PEDNRO
					WHERE VEN2.PEDSAL = 'T'
					ORDER BY TO_DATE(INV1.MESHORAPED, 'HH24:MI:SS') ASC);
		END;
	END IF;		
END SP_ACOMER_PEDIDOS_ENTREGAR;