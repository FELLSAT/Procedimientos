CREATE OR REPLACE FUNCTION VALIDAPAQU
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_MOVSER IN NUMBER,
  v_MOVPAQ IN NUMBER,
  v_PAQUETIZA IN NUMBER
)
RETURN NUMBER
AS
    v_VALIDA VARCHAR2(4000);
    v_ESTADO NUMBER;
    v_CODPAQU VARCHAR2(20);
    v_COMPLETOSER NUMBER;
    v_FACINSER VARCHAR2(4000);
    v_FACPAQU NUMBER;

BEGIN
    v_ESTADO := 1 ;
    v_COMPLETOSER := 0 ;
    ------------------------------------------------------
    SELECT TO_CHAR(VL_VALO_CONT) 
    INTO v_VALIDA
    FROM CONTROL 
    WHERE  CD_CONC_CONT = 'VALIDAPAQU'
        AND TO_CHAR(VL_VALO_CONT) = '1';
    ------------------------------------------------------
    SELECT TO_cHAR(VL_VALO_CONT) 
    INTO v_FACINSER
    FROM CONTROL 
    WHERE  CD_CONC_CONT = 'FACINSER'
        AND TO_CHAR(VL_VALO_CONT) = '1';
    ------------------------------------------------------

    IF v_VALIDA = '1' THEN
        DECLARE
            v_temp NUMBER(1, 0) := 0;

            --MARCADO PARA VALIDAR
        BEGIN
            ------------------------------------------------------
            DECLARE
                V_EXISTE NUMBER;
            BEGIN
                ------------------------------------------------------
                SELECT DISTINCT COUNT(NU_NUME_FACO_MOVI)
                INTO V_EXISTE
                FROM MOVI_CARGOS 
                WHERE  NU_NUME_MOVI = v_MOVSER
                     AND NU_NUME_FACO_MOVI = 0
                AND v_PAQUETIZA = 1;
                ------------------------------------------------------
                SELECT 1 
                INTO v_temp
                FROM DUAL
                WHERE V_EXISTE >= 1;
            EXCEPTION
                WHEN OTHERS THEN
                    NULL;
            END;
            ------------------------------------------------------         
            IF v_temp = 1 THEN
                v_ESTADO := 0 ;
            ELSE
                ------------------------------------------------------
                DECLARE
                    v_temp NUMBER(1, 0) := 0;      
                BEGIN
                    ------------------------------------------------------
                    DECLARE
                        V_EXISTE NUMBER;
                    BEGIN
                        SELECT DISTINCT COUNT(ID_ESTA_ASIS_LABO)
                        INTO V_EXISTE
                        FROM LABORATORIO 
                        WHERE  NU_NUME_MOVI_LABO = v_MOVSER
                            AND ID_ESTA_ASIS_LABO = 0;
                        ------------------------------------------------------
                        SELECT 1 INTO v_temp
                        FROM DUAL
                        WHERE V_EXISTE >= 1
                            AND v_PAQUETIZA = 1;
                    EXCEPTION
                        WHEN OTHERS THEN
                            NULL;
                    END;
                    ------------------------------------------------------
                    IF v_temp = 1 THEN
                        v_ESTADO := 0 ;
                    ELSE
                        DECLARE
                            v_temp NUMBER(1, 0) := 0;         
                        BEGIN
                            DECLARE
                              V_EXISTE NUMBER;
                            BEGIN
                                SELECT DISTINCT COUNT(ID_ESTA_ASIS_LABO)
                                INTO V_EXISTE
                                FROM MOVI_CARGOS 
                                INNER JOIN LABORATORIO    
                                    ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
                                WHERE  NU_NUME_PAQU_MOVI = v_MOVPAQ
                                    AND ID_ESTA_ASIS_LABO = 0;
                                ------------------------------------------------------
                                SELECT 1 INTO v_temp
                                FROM DUAL
                                WHERE V_EXISTE >= 1;
                            EXCEPTION
                                WHEN OTHERS THEN
                                    NULL;
                            END;
                            ------------------------------------------------------
                            IF v_temp = 1 THEN
                                v_ESTADO := 0 ;
                            ELSE
                                DECLARE
                                    v_temp NUMBER(1, 0) := 0;            
                                BEGIN
                                    IF v_PAQUETIZA = 1 THEN
                                        DECLARE
                                            v_temp NUMBER(1, 0) := 0;               
                                        BEGIN
                                            SELECT CD_CODI_SER_PAQU 
                                            INTO v_CODPAQU
                                            FROM PAQUETES 
                                            WHERE  NU_NUME_MOVI_PAQU = v_MOVPAQ;
                                            ------------------------------------------------------
                                            DECLARE
                                                V_EXISTE NUMBER;
                                            BEGIN
                                                SELECT DISTINCT COUNT(CD_CODI_SER_LABO)
                                                INTO V_EXISTE 
                                                FROM LABORATORIO 
                                                INNER JOIN R_PAQU_SER    
                                                    ON CD_CODI_SER_RPSE = CD_CODI_SER_LABO
                                                WHERE  CD_CODI_SER_PAQ_RPSE = v_CODPAQU
                                                    AND NU_OBLI_RPSE = 1
                                                    AND NU_NUME_MOVI_LABO = v_MOVSER;
                                                ------------------------------------------------------
                                                SELECT 1 
                                                INTO v_temp
                                                FROM DUAL
                                                WHERE V_EXISTE >= 1;
                                            EXCEPTION
                                                WHEN OTHERS THEN
                                                    NULL;
                                            END;
                                            ------------------------------------------------------
                                            IF v_temp = 1 THEN
                                                v_COMPLETOSER := 1 ;
                                            END IF;               
                                        END;
                                    END IF;
                                    ------------------------------------------------------
                                    DECLARE
                                        V_EXISTE NUMBER;
                                    BEGIN
                                        SELECT DISTINCT COUNT(CD_CODI_SER_LABO )
                                        INTO V_EXISTE
                                        FROM LABORATORIO 
                                        INNER JOIN R_PAQU_SER    
                                            ON CD_CODI_SER_RPSE = CD_CODI_SER_LABO
                                        INNER JOIN MOVI_CARGOS    
                                            ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
                                        WHERE  CD_CODI_SER_PAQ_RPSE = v_CODPAQU
                                            AND NU_OBLI_RPSE = 1
                                            AND NU_NUME_PAQU_MOVI = v_MOVPAQ;
                                        ------------------------------------------------------
                                        SELECT 1 INTO v_temp
                                        FROM DUAL
                                        WHERE V_EXISTE >= 1;
                                    EXCEPTION
                                        WHEN OTHERS THEN
                                            NULL;
                                    END;
                                    ------------------------------------------------------
                                    IF v_temp = 1 THEN
                                        v_COMPLETOSER := v_COMPLETOSER + 1 ;
                                    END IF;
                                    ------------------------------------------------------
                                    IF v_COMPLETOSER <= 0 THEN
                                        v_ESTADO := 0 ;
                                    ELSE
                   
                                        BEGIN
                                            IF v_PAQUETIZA = 0 THEN
                                                DECLARE
                                                    v_temp NUMBER(1, 0) := 0;                  
                                                BEGIN
                                                    DECLARE
                                                        V_EXISTE NUMBER;
                                                    BEGIN
                                                        SELECT COUNT(NU_NUME_MOVI) 
                                                        INTO V_EXISTE 
                                                        FROM MOVI_CARGOS 
                                                        WHERE  NU_NUME_PAQU_MOVI = v_MOVPAQ
                                                            AND NU_NUME_MOVI <> v_MOVSER;

                                                        SELECT 1 INTO v_temp
                                                        FROM DUAL
                                                        WHERE V_EXISTE <= 0;
                                                    EXCEPTION
                                                        WHEN OTHERS THEN
                                                            NULL;
                                                    END;
                                                    ------------------------------------------------------                        
                                                    IF v_temp = 1 THEN
                                                        v_ESTADO := 0 ;
                                                    END IF;                  
                                                END;
                                            END IF;
                                            ------------------------------------------------------
                                            IF v_ESTADO = 1 AND v_FACINSER = '1' THEN                   
                                                BEGIN
                                                    SELECT NU_NUME_FACO_MOVI 
                                                    INTO v_FACPAQU
                                                    FROM MOVI_CARGOS 
                                                    WHERE  NU_NUME_MOVI = v_MOVPAQ;
                                                    ------------------------------------------------------
                                                    IF v_FACPAQU <> 0 THEN
                                                        DECLARE
                                                            v_temp NUMBER(1, 0) := 0;                     
                                                        BEGIN
                                                            DECLARE
                                                                V_EXISTE NUMBER;
                                                            BEGIN
                                                                SELECT DISTINCT COUNT(CD_CODI_SER_LABO )
                                                                INTO V_EXISTE
                                                                FROM LABORATORIO 
                                                                INNER JOIN R_PAQU_SER    
                                                                    ON CD_CODI_SER_RPSE = CD_CODI_SER_LABO
                                                                INNER JOIN MOVI_CARGOS    
                                                                    ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
                                                                WHERE  CD_CODI_SER_PAQ_RPSE = v_CODPAQU
                                                                    AND NU_OBLI_RPSE = 1
                                                                    AND NU_NUME_PAQU_MOVI = v_MOVPAQ
                                                                    AND NU_NUME_FACO_MOVI = v_FACPAQU;
                                                                ------------------------------------------------------
                                                                SELECT 1 INTO v_temp
                                                                FROM DUAL
                                                                WHERE V_EXISTE <= 0;
                                                            EXCEPTION
                                                                WHEN OTHERS THEN
                                                                    NULL;
                                                            END;
                                                            ------------------------------------------------------                           
                                                            IF v_temp = 1 THEN
                                                                v_ESTADO := 0 ;
                                                            END IF;                     
                                                        END;
                                                    END IF;                  
                                                END;
                                            END IF;               
                                        END;
                                    END IF;            
                                END;
                            END IF;         
                        END;
                    END IF;      
                END;
            END IF;   
        END;
    END IF;

   RETURN v_ESTADO;--END FUNCION

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;