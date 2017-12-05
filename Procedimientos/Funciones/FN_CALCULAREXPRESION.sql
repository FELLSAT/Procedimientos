CREATE OR REPLACE FUNCTION FN_CALCULAREXPRESION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_TIPO IN NUMBER,
    v_NUMHISPAC IN VARCHAR2
)
RETURN NUMBER
AS
    v_VARIABLES VARCHAR2(2000);
    v_EXPRESION VARCHAR2(2000);
    v_VARIABLE VARCHAR2(255);
    v_Parcial NUMBER(18,4);
    v_ParmDefinition VARCHAR2(2000);
    v_RTA NUMBER(18,4);

    CURSOR CV_1 IS
      SELECT item 
      FROM TABLE(fnSplit(v_VARIABLES, ';')) ;

BEGIN
    SELECT EI.TX_VARIABLES_EXIN ,
        EI.TX_EXPRESION_EXIN 
    INTO v_VARIABLES,
        v_EXPRESION
    FROM EXPRESION_INDICADORES EI
    WHERE  EI.NU_AUTO_EXIN = v_TIPO;

    OPEN CV_1;
    FETCH CV_1 INTO v_VARIABLE;

    WHILE (CV_1%FOUND)
    LOOP       
        BEGIN
            SELECT fn_CalculaFactores(v_NUMHISPAC, v_VARIABLE) 
                INTO v_Parcial
            FROM DUAL ;
            
            v_Parcial := NVL(v_PARCIAL, 0) ;
            v_EXPRESION := REPLACE(v_EXPRESION, v_VARIABLE, TO_CHAR(v_Parcial)) ;

            FETCH CV_1 INTO v_VARIABLE;

        END;
    END LOOP;

     v_EXPRESION := ' SELECT ' || v_EXPRESION ;     
     EXECUTE IMMEDIATE v_EXPRESION INTO v_RTA;
     
   CLOSE CV_1;--Cierra el cursor.
   RETURN v_RTA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;