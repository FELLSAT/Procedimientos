CREATE OR REPLACE PROCEDURE SP_ACOMER_PEDIDOS_ENTREGAR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	CURSOR_PEDIDOS1 OUT SYS_REFCURSOR  -- CURSOR QUE TRAE LOS PEDIDOS QUE YA ESTAN LISTOS PARA ENTREGAR	
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
	INNER JOIN VEN0004 VEN2
	    ON VEN1.PEDNRO = VEN2.PEDNRO
	WHERE VEN2.PEDSAL = 'T'
	ORDER BY VEN1.PEDEMPC;

	IF(V_COUNT = 0) THEN
		BEGIN
			OPEN CURSOR_PEDIDOS1 FOR
				SELECT 'NO' ESTADO,
				    'NO' MESA,
				    'NO' EMPRESA,
                    'NO' DOCUMENTO,
                    'PUESTO' PUESTO
				FROM DUAL;
		END;
	ELSE
		BEGIN
			OPEN CURSOR_PEDIDOS1 FOR
				SELECT DISTINCT PEDSAL ESTADO,
                    MESCOD MESA, PEDEMPC EMPRESA, 
                    PEDNUMDOC DOCUMENTO,
                    LISTAGG(TRIM(CCOCOD),'*_') WITHIN GROUP( ORDER BY TRIM(CCOCOD)) PUESTO
                FROM (
                    SELECT VEN2.PEDSAL,
                        VEN1.MESCOD,
                        VEN1.PEDEMPC,
                        VEN1.PEDNRO,
                        VEN1.PEDNUMDOC,
                        VEN2.CCOCOD                            
                    FROM INV00018 INV1    
                    INNER JOIN VEN0104 VEN1
                        ON INV1.MESNUMREQ = VEN1.PEDNUMDOC
                        OR INV1.MESNUMREQ2 = VEN1.PEDNUMDOC
                        OR INV1.MESNUMREQ3 = VEN1.PEDNUMDOC
                        OR INV1.MESNUMREQ4 = VEN1.PEDNUMDOC
                    INNER JOIN VEN0004 VEN2
                        ON VEN1.PEDNRO = VEN2.PEDNRO
                    WHERE VEN2.PEDSAL = 'T'
                    ORDER BY TO_DATE(INV1.MESHORAPED, 'HH24:MI:SS') ASC)
                 GROUP BY PEDSAL, MESCOD, 
                    PEDEMPC, PEDNUMDOC;
		END;
	END IF;

	
END;