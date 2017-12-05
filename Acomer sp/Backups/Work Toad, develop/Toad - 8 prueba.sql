DECLARE
    IN_TIPO_PRECIO GEN0024.LIPCOD%TYPE := 'PREC_SUP';
    IN_PUESTOS_ARRAY TYPE_PRUEBAS ;
    CV_PLATO VEN0004.PEDPROCOD%TYPE; -- CODIGO DE LOS PLATOS PEDIDOS EN LA MESA 
    CV_CANTIDAD VEN0004.PEDUNI%TYPE;  -- CANTIDAD PEDIDO DEL PLATO
    CV_COD_EMPRESA VEN0004.PEDEMPC%TYPE; -- CODIGO DE LA EMPRESA A LA QUE PERTENECE EL PLATO
    CV_NUM_PEDIDO VEN0004.PEDNRO%TYPE;   -- NUMERO DEL PEDIDO DE LA MESA EN RESTAURANTE
    -- CURSOR PARA CONSULTAR LOS PEDIDOS HECHOS EN LA MESA
    CURSOR C_PRECIO_PED IS 
        SELECT DISTINCT PEDPROCOD, PEDUNI, A.PEDEMPC,
            A.PEDNRO
        FROM VEN0004 A	     
        LEFT JOIN VEN0104 B
            ON A.PEDNRO = B.PEDNRO                  
        WHERE B.PEDNUMDOC = '20150128'
            OR B.PEDNUMDOC = ''
            OR B.PEDNUMDOC = '';
    V_NEW_PRECIO VEN00012.PROPRE%TYPE; -- PRECIO POR EL CUAL SE VA ACTUALIZAR
    V_PRECIO_IVA VEN0004.PEDVALIVA%TYPE; -- PRECIO DEL PLATO CON IVA INCLUIDO
    V_RFPORDTO VEN0001.RFPORDTO%TYPE;  
    V_VALDESC VEN0004.peddcval%TYPE;   -- peddcval	    
BEGIN    
    -- ===================================
    -- ABRE EL CURSOR 
    OPEN C_PRECIO_PED;
    -- CICLO PARA LEER LOS DATOS DEVUELTOS EN EL CURSOR
    LOOP
        -- OBTENER LOS DATOS FILA POR FILA 
        FETCH C_PRECIO_PED INTO CV_PLATO, CV_CANTIDAD, CV_COD_EMPRESA, CV_NUM_PEDIDO;
        -- SALE DEL CICLO CUANDO NO ENCUENTRE NINGUN DATO  EN EL CURSOR
        EXIT WHEN C_PRECIO_PED%NOTFOUND;
        --CONSULTA EL PRECIO DEL PRODUCTO PARA EL CLIENTE REGISTRADO
        SELECT PROPRE 
        INTO V_NEW_PRECIO
        FROM VEN00012
        WHERE LIPCOD = IN_TIPO_PRECIO
            AND PROCOD = CV_PLATO;
        -- CALCULA EL IVA DEL PLATO Y SE LO SUMA 
         SELECT ((CNT0014.DEDPOR / 100) * V_NEW_PRECIO) + V_NEW_PRECIO 
        INTO V_PRECIO_IVA
        FROM VEN0001 
        LEFT JOIN CNT0014  
            ON VEN0001.FDEDCOD = CNT0014.DEDCOD 
            AND VEN0001.FDEDSC = CNT0014.DEDSUBCOD
            AND VEN0001.FDEDANO = CNT0014.DEDANO 
        WHERE VEN0001.VENEMPPAI = '169' 
            AND VEN0001.VENEMPC = CV_COD_EMPRESA
            AND VEN0001.PROCOD = CV_PLATO;
        --
        SELECT RFPORDTO
        INTO V_RFPORDTO
        FROM VEN0001 A
        INNER JOIN VEN0004 B
            ON A.VENEMPPAI = B.PEDPAIC
            AND A.VENEMPC = B.PEDEMPC
            AND A.PROCOD = B.PEDPROCOD 
        WHERE A.PROCOD = CV_PLATO
            AND B.PEDNRO = CV_NUM_PEDIDO;
        --
        IF(V_RFPORDTO > 0) THEN
            BEGIN
                V_VALDESC := (V_NEW_PRECIO * CV_CANTIDAD * V_RFPORDTO) / 100;
            END;
        ELSE
            BEGIN
                V_RFPORDTO := 0;
                V_VALDESC := 0;
            END;
        END IF;
        DBMS_OUTPUT.PUT_LINE(CV_PLATO||' - '||CV_CANTIDAD||' - '||V_NEW_PRECIO
                                 ||' - '||V_PRECIO_IVA||' - '||V_RFPORDTO
                                 ||' - '||V_VALDESC);
        UPDATE VEN0004
        SET PEDVAL = V_NEW_PRECIO,-- VALOR DEL PLATO
            PEDVALIVA = V_PRECIO_IVA,-- VALOR DEL PLATO CON IVA
            PEDVALTUN = V_PRECIO_IVA * CV_CANTIDAD, -- VALOR DEL PLATO CON LA CANTIDA E IVA
            PEDPORDC = V_RFPORDTO,
            PEDDCVAL = V_VALDESC
        WHERE PEDNRO = CV_NUM_PEDIDO
            AND PEDPROCOD = CV_PLATO;
    END LOOP;
    -- CIERRA EL CURSRO
    CLOSE C_PRECIO_PED;
END;