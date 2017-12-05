CREATE OR REPLACE TRIGGER TG_ORDEN_KARDEX 
AFTER INSERT
ON KARDEX_ARTI
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
DECLARE
  V_DEPENDENCIA VARCHAR2(11);
  V_ARTICULO VARCHAR2(16);
  V_TDOC VARCHAR2(15);
  V_NUMKARD NUMBER;
BEGIN  
    SELECT :NEW.CD_DEPE_KARD, :NEW.CD_ARTI_KARD, 
        :NEW.CD_DOCU_KARD, :NEW.CD_NUME_KARD 
    INTO V_DEPENDENCIA, V_ARTICULO,
        V_TDOC, V_NUMKARD
    FROM DUAL;
    ------------------------------------------------------
    IF (V_TDOC = 'ENTRADA') THEN
        BEGIN
            UPDATE KARDEX_ARTI 
            SET NU_ORDEN_KARD = 1
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;
    ------------------------------------------------------
    IF (V_TDOC = 'DEVOL.PROVEE') THEN
        BEGIN
            UPDATE KARDEX_ARTI 
            SET NU_ORDEN_KARD = 2
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;
    ------------------------------------------------------
    IF (V_TDOC = 'ENTRADA X AJUSTE') THEN
        BEGIN
            UPDATE KARDEX_ARTI 
            SET NU_ORDEN_KARD = 3
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;
    ------------------------------------------------------
    IF (V_TDOC = 'VENTA') THEN
        BEGIN
            UPDATE KARDEX_ARTI 
            SET NU_ORDEN_KARD = 4
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;
    ------------------------------------------------------
    IF (V_TDOC = 'DEVO. CLIENTES') THEN
        BEGIN
            UPDATE KARDEX_ARTI 
            SET NU_ORDEN_KARD = 5
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;
    ------------------------------------------------------
    IF (V_TDOC = 'DESPACHO') THEN
        BEGIN
            UPDATE KARDEX_ARTI 
            SET NU_ORDEN_KARD = 6
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IFS;
    ------------------------------------------------------
    IF (V_TDOC = 'DEVO.DEPEND') THEN
        BEGIN
            UPDATE KARDEX_ARTI 
            SET NU_ORDEN_KARD = 7
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;
    ------------------------------------------------------
    IF (V_TDOC = 'SALIDA.ALMACEN') THEN
        BEGIN
            UPDATE KARDEX_ARTI 
            SET NU_ORDEN_KARD = 8
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;
    ------------------------------------------------------
    IF (V_TDOC = 'SALIDA X AJUSTE') THEN
        BEGIN
            UPDATE KARDEX_ARTI SET NU_ORDEN_KARD = 9
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;    
    ------------------------------------------------------
    IF (v_TDOC = 'TRAS DEP ENTRAD') THEN
        BEGIN
            UPDATE KARDEX_ARTI SET NU_ORDEN_KARD = 10
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;    
    ------------------------------------------------------
    IF (V_TDOC = 'TRAS DEP SALIDA') THEN
        BEGIN
            UPDATE KARDEX_ARTI SET NU_ORDEN_KARD = 11
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;
    ------------------------------------------------------
    IF (V_TDOC = 'SALIDA.DEPEND') THEN
        UPDATE KARDEX_ARTI SET NU_ORDEN_KARD = 12
        WHERE CD_DEPE_KARD = V_DEPENDENCIA
            AND CD_ARTI_KARD = V_ARTICULO
            AND CD_DOCU_KARD = V_TDOC
            AND CD_NUME_KARD = V_NUMKARD;
    END IF;
    ------------------------------------------------------
    IF (V_TDOC = 'DEVOL.DEPEN') THEN
        BEGIN
            UPDATE KARDEX_ARTI SET NU_ORDEN_KARD = 13
            WHERE CD_DEPE_KARD = V_DEPENDENCIA
                AND CD_ARTI_KARD = V_ARTICULO
                AND CD_DOCU_KARD = V_TDOC
                AND CD_NUME_KARD = V_NUMKARD;
        END;
    END IF;
END;
    
