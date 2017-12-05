CREATE OR REPLACE PROCEDURE H3i_SP_ANULA_DETALLE_FACTURA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 --
 -- ANULA EL DETALLE ESPECIFICADO. SI EL DETALLE ESTA ASOCIADO CON UNA HISTORA 
 -- CLÍNICA NO SE PUEDE ANULAR. SI ES EL ÚLTIMO DETALLE DEL CARGO, SE ANULA EL 
 -- CARGO. ESTE MÉTODO SE USA DURANTE EL PROCESO DE FACTURACIÓN, POR LO CUAL SE 
 -- SUPONE QUE EL DETALLE QUE SE INTENTA ANULAR PERTENECE A UN CARGO FACTURABLE
 --
 -- =============================================
(
    V_CODIGO IN NUMBER,
    CV_1 OUT SYS_REFCURSOR
)

AS
    V_CODCARGO NUMBER;
    V_SUM_VL_UNID_LABO FLOAT;
    V_SUM_VL_COPA_LABO FLOAT;
    V_TOTAL_LAB NUMBER;
    V_TOTAL_ANU NUMBER;
BEGIN
    -- ----------------------------------------------------------------------------
    -- ANULAR EL DETALLE SI NO TIENE HISTORIAS CLÍNICAS ASOCIADAS
    -- ----------------------------------------------------------------------------
    UPDATE(
        SELECT NU_ESTA_LABO
        FROM LABORATORIO LAB
        LEFT JOIN HISTORIACLINICA HIS
            ON HIS.NU_NUME_LABO_HICL = LAB.NU_NUME_LABO
        WHERE LAB.NU_NUME_LABO = V_CODIGO
            AND HIS.NU_NUME_HICL IS NULL) T
    SET T.NU_ESTA_LABO = 2;
    --
    -- OBTENER EL IDENTIFICADOR DEL CARGO
    --
    SELECT LAB.NU_NUME_MOVI_LABO
    INTO V_CODCARGO
    FROM LABORATORIO LAB
    WHERE LAB.NU_NUME_LABO = V_CODIGO
        AND ROWNUM <= 1;



    -- ----------------------------------------------------------------------------
    -- ACTUALIZAR LOS VALORES DEL CARGO CON LA SUMA DE LOS DETALLES SIN ANULAR
    -- ----------------------------------------------------------------------------
    
    SELECT NVL(SUM(LAB.VL_UNID_LABO), 0),
        NVL(SUM(LAB.VL_COPA_LABO), 0)
    INTO V_SUM_VL_UNID_LABO,
        V_SUM_VL_COPA_LABO           
    FROM LABORATORIO LAB
    WHERE LAB.NU_NUME_MOVI_LABO = V_CODCARGO
           AND LAB.NU_ESTA_LABO <> 2;


    UPDATE (
        SELECT VL_UNID_MOVI, VL_COPA_MOVI
        FROM MOVI_CARGOS
        WHERE NU_NUME_MOVI = V_CODCARGO) T
    SET T.VL_UNID_MOVI = V_SUM_VL_UNID_LABO,
        T.VL_COPA_MOVI = V_SUM_VL_COPA_LABO;


    -- ----------------------------------------------------------------------------
    -- ANULAR EL CARGO SI TODOS LOS DETALLES ESTAN ANULADOS
    -- ----------------------------------------------------------------------------
    --
    -- CONTEO DEL TOTAL DE LABORATORIOS DEL CARGO
    --    
    SELECT COUNT(LAB.NU_NUME_LABO)
    INTO V_TOTAL_LAB
    FROM MOVI_CARGOS MOV
    INNER JOIN LABORATORIO LAB
        ON LAB.NU_NUME_MOVI_LABO = MOV.NU_NUME_MOVI
        AND MOV.NU_NUME_MOVI = V_CODCARGO;

    --          
    -- CONTEO DEL TOTAL DE LABORATORIOS ANULADOS DEL CARGO
    --    
    SELECT COUNT(LAB.NU_NUME_LABO)
    INTO V_TOTAL_ANU
    FROM MOVI_CARGOS MOV
    INNER JOIN LABORATORIO LAB
        ON LAB.NU_NUME_MOVI_LABO = MOV.NU_NUME_MOVI
        AND MOV.NU_NUME_MOVI = V_CODCARGO
        AND LAB.NU_ESTA_LABO = 2;


    --
    -- SI EL TOTAL DE DETALLES ANULADOS ES IGUAL AL TOTAL DE DETALLES DEL CARGO SE
    -- ANULA EL CARGO
    --
    IF (V_TOTAL_LAB = V_TOTAL_ANU) THEN

        BEGIN
            UPDATE (
                SELECT NU_ESTA_MOVI
                FROM MOVI_CARGOS
                WHERE NU_NUME_MOVI = V_CODCARGO) T
            SET T.NU_ESTA_MOVI= 2;
            
        END;

    END IF;

    --
    -- RETORNA EL DETALLE
    --
    OPEN CV_1 FOR 
        SELECT *
        FROM LABORATORIO LAB
        WHERE LAB.NU_NUME_LABO = V_CODIGO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;