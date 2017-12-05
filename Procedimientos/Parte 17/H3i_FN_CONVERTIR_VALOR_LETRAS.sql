CREATE OR REPLACE FUNCTION H3i_FN_CONVERTIR_VALOR_LETRAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_Numero IN NUMBER
)
RETURN VARCHAR2
AS
    v_lnEntero NUMBER(10,0);
    v_lcRetorno VARCHAR2(512);
    v_lnTerna NUMBER(10,0);
    v_lcMiles VARCHAR2(512);
    v_lcCadena VARCHAR2(512);
    v_lnUnidades NUMBER(10,0);
    v_lnDecenas NUMBER(10,0);
    v_lnCentenas NUMBER(10,0);
    v_lnFraccion NUMBER(10,0);

BEGIN
    v_lnEntero := TO_NUMBER(v_Numero) ;
    v_lnFraccion := (v_Numero - v_lnEntero) * 100 ;
    v_lcRetorno := ' ' ;
    v_lnTerna := 1 ;

    WHILE v_lnEntero > 0 
    LOOP 
      
        BEGIN
            -- Recorro terna por terna
            v_lcCadena := ' ' ;
            v_lnUnidades := MOD(v_lnEntero, 10);
            v_lnEntero := TO_NUMBER(v_lnEntero / 10);
            v_lnDecenas := MOD(v_lnEntero, 10);
            v_lnEntero := TO_NUMBER(v_lnEntero / 10);
            v_lnCentenas := MOD(v_lnEntero, 10);
            v_lnEntero := TO_NUMBER(v_lnEntero / 10);

            -- Analizo las unidades
            v_lcCadena := CASE
                              WHEN v_lnUnidades = 1 AND v_lnTerna = 1 
                                  THEN 'UNO ' || v_lcCadena
                              WHEN v_lnUnidades = 1 AND v_lnTerna <> 1 
                                  THEN 'UN ' || v_lcCadena
                              WHEN v_lnUnidades = 2 
                                  THEN 'DOS ' || v_lcCadena
                              WHEN v_lnUnidades = 3 
                                  THEN 'TRES ' || v_lcCadena
                              WHEN v_lnUnidades = 4 
                                  THEN 'CUATRO ' || v_lcCadena
                              WHEN v_lnUnidades = 5 
                                  THEN 'CINCO ' || v_lcCadena
                              WHEN v_lnUnidades = 6 
                                  THEN 'SEIS ' || v_lcCadena
                              WHEN v_lnUnidades = 7 
                                  THEN 'SIETE ' || v_lcCadena
                              WHEN v_lnUnidades = 8 
                                  THEN 'OCHO ' || v_lcCadena
                              WHEN v_lnUnidades = 9 
                                  THEN 'NUEVE ' || v_lcCadena
                              ELSE v_lcCadena
                          END ;

            /* UNIDADES */
            -- Analizo las decenas
            v_lcCadena := CASE 
                              WHEN v_lnDecenas = 1 THEN 
                                  CASE v_lnUnidades
                                      WHEN 0 
                                          THEN 'DIEZ '
                                      WHEN 1 
                                          THEN 'ONCE '
                                      WHEN 2 
                                          THEN 'DOCE '
                                      WHEN 3 
                                          THEN 'TRECE '
                                      WHEN 4 
                                          THEN 'CATORCE '
                                      WHEN 5 
                                          THEN 'QUINCE '
                                      ELSE 'DIECI' || v_lcCadena
                                  END
                              WHEN v_lnDecenas = 2 AND v_lnUnidades = 0 
                                  THEN 'VEINTE ' || v_lcCadena
                              WHEN v_lnDecenas = 2 AND v_lnUnidades <> 0 
                                  THEN 'VEINTI' || v_lcCadena
                              WHEN v_lnDecenas = 3 AND v_lnUnidades = 0 
                                  THEN 'TREINTA ' || v_lcCadena
                              WHEN v_lnDecenas = 3 AND v_lnUnidades <> 0 
                                  THEN 'TREINTA Y ' || v_lcCadena
                              WHEN v_lnDecenas = 4 AND v_lnUnidades = 0 
                                  THEN 'CUARENTA ' || v_lcCadena
                              WHEN v_lnDecenas = 4 AND v_lnUnidades <> 0 
                                  THEN 'CUARENTA Y ' || v_lcCadena
                              WHEN v_lnDecenas = 5 AND v_lnUnidades = 0 
                                  THEN 'CINCUENTA ' || v_lcCadena
                              WHEN v_lnDecenas = 5 AND v_lnUnidades <> 0 
                                  THEN 'CINCUENTA Y ' || v_lcCadena
                              WHEN v_lnDecenas = 6 AND v_lnUnidades = 0 
                                  THEN 'SESENTA ' || v_lcCadena
                              WHEN v_lnDecenas = 6 AND v_lnUnidades <> 0 
                                  THEN 'SESENTA Y ' || v_lcCadena
                              WHEN v_lnDecenas = 7 AND v_lnUnidades = 0 
                                  THEN 'SETENTA ' || v_lcCadena
                              WHEN v_lnDecenas = 7 AND v_lnUnidades <> 0 
                                  THEN 'SETENTA Y ' || v_lcCadena
                              WHEN v_lnDecenas = 8 AND v_lnUnidades = 0 
                                  THEN 'OCHENTA ' || v_lcCadena
                              WHEN v_lnDecenas = 8 AND v_lnUnidades <> 0 
                                  THEN 'OCHENTA Y ' || v_lcCadena
                              WHEN v_lnDecenas = 9 AND v_lnUnidades = 0 
                                  THEN 'NOVENTA ' || v_lcCadena
                              WHEN v_lnDecenas = 9 AND v_lnUnidades <> 0 
                                  THEN 'NOVENTA Y ' || v_lcCadena
                              ELSE v_lcCadena
                          END ;

            /* DECENAS */
            -- Analizo las centenas
            v_lcCadena := CASE
                              WHEN v_lnCentenas = 1 AND v_lnUnidades = 0 AND v_lnDecenas = 0 
                                  THEN 'CIEN ' || v_lcCadena
                              WHEN v_lnCentenas = 1 AND NOT ( v_lnUnidades = 0 AND v_lnDecenas = 0 ) 
                                  THEN 'CIENTO ' || v_lcCadena
                              WHEN v_lnCentenas = 2 
                                  THEN 'DOSCIENTOS ' || v_lcCadena
                              WHEN v_lnCentenas = 3 
                                  THEN 'TRESCIENTOS ' || v_lcCadena
                              WHEN v_lnCentenas = 4 
                                  THEN 'CUATROCIENTOS ' || v_lcCadena
                              WHEN v_lnCentenas = 5 
                                  THEN 'QUINIENTOS ' || v_lcCadena
                              WHEN v_lnCentenas = 6 
                                  THEN 'SEISCIENTOS ' || v_lcCadena
                              WHEN v_lnCentenas = 7 
                                  THEN 'SETECIENTOS ' || v_lcCadena
                              WHEN v_lnCentenas = 8 
                                  THEN 'OCHOCIENTOS ' || v_lcCadena
                              WHEN v_lnCentenas = 9 
                                  THEN 'NOVECIENTOS ' || v_lcCadena
                              ELSE v_lcCadena
                          END ;

            /* CENTENAS */
            -- Analizo la terna
            v_lcCadena := CASE 
                              WHEN v_lnTerna = 1 
                                  THEN v_lcCadena
                              WHEN v_lnTerna = 2 AND ( v_lnUnidades + v_lnDecenas + v_lnCentenas <> 0 ) 
                                  THEN v_lcCadena || ' MIL '
                              WHEN v_lnTerna = 3 AND ( v_lnUnidades + v_lnDecenas + v_lnCentenas <> 0 )
                                  AND v_lnUnidades = 1 AND v_lnDecenas = 0 AND v_lnCentenas = 0 
                                      THEN v_lcCadena || ' MILLÓN '
                              WHEN v_lnTerna = 3 AND ( v_lnUnidades + v_lnDecenas + v_lnCentenas <> 0 )
                                  AND NOT ( v_lnUnidades = 1 AND v_lnDecenas = 0 AND v_lnCentenas = 0 ) 
                                      THEN v_lcCadena || ' MILLONES '
                              WHEN v_lnTerna = 4 AND ( v_lnUnidades + v_lnDecenas + v_lnCentenas <> 0 ) 
                                  THEN v_lcCadena || ' MIL MILLONES '
                              ELSE ' '
                          END ;

            /* TERNA */
            -- Armo el retorno terna a terna
            v_lcRetorno := v_lcCadena + v_lcRetorno ;
            v_lnTerna := v_lnTerna + 1 ;
      
        END;

    /* WHILE */
    END LOOP;

    IF v_lnTerna = 1 THEN
        v_lcRetorno := 'CERO' ;
    END IF;


      RETURN v_lcRetorno;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;