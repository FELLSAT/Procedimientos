SELECT NVL(MESNUMREQ,''), 
		NVL(MESNUMREQ2,''), 
		NVL(MESNUMREQ3,'')
	FROM INV00018
	WHERE MESCOD = '4';
	
-- A = 20150132 
-- B = 20150031
-- C = 
------------------------------------------------------
	
SELECT DISTINCT A.PEDEMPC
FROM VEN0004 A	     
LEFT JOIN VEN0104 B
    ON A.PEDNRO = B.PEDNRO                  
    AND A.CCOCOD = '01'         -- PUESTO
WHERE B.PEDNUMDOC  = '20150132' -- A
    OR B.PEDNUMDOC = '20150031' -- B
    OR B.PEDNUMDOC = '';        -- C

-- RESULTADOS DE LA CONSULTA VARIAN DEPENDIENDO LOS PEDIDOS QUE SE TENGAN EN REST POR PUESTO
-- D = 901.023.461-2, 901.023.461-1 


------------------------------------------------------    

SELECT TO_NUMBER(GEN0012.DOCNRO + 1)
--INTO V_CODIGO_PEDIDO
FROM GEN0012
WHERE GEN0012.DOCCOD = 'PD'
    AND GEN0012.EMPPAIC = '169'
    AND GEN0012.EMPCOD = '901.023.461-2'; -- D	 
    
-- RESULTADOS CON CADA UNO DE LOS CODIGOS DE LOS RESTAURANTES A LOS QUE PERTENENCEN LOS PEDIDOS   
-- E = 901.023.461-2 .... 20150133
-- F = 901.023.461-1 .... 20150032

------------------------------------------------------

--VERIFICAR SI ES EL UNICO PEDIDO DE LOS PUESTOS AL RESTAURANTE 


------------------------------------------------------
    
SELECT * FROM VEN0004 ORDER BY PEDNRO, CCOCOD;

SELECT * FROM VEN0104;

select * from ven00012 order by lipcod, venempc-- lista de precios;

45200
25500

--

32000
23500