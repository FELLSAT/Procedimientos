--===============================
--Tabla temporal que usa el procedimiento H3i_SP_HIMS_CONSULTA_ELEMENTOS
--===============================
CREATE GLOBAL TEMPORARY TABLE TABLA (
        CD_CODI_ARTI                    VARCHAR2(60),
        NO_NOMB_ARTI                    VARCHAR2(60),
        DE_UNME_ARTI                    VARCHAR2(30),
        DE_CTRA_ARTI                    VARCHAR2(60),
        DE_FOFA_ARTI                    VARCHAR2(60),
        CT_EXIS_DEAR                    FLOAT       ,
        CD_TARI_TAAR                    VARCHAR2(2) ,
        VL_PREC_TAAR                    FLOAT        DEFAULT 0,
        FORMACOBRO                      NUMBER(3)   , --PLENA(0), PORCENTAJE(1)
        TIPOPORCENTAJECOBRO             NUMBER(3)   , --AUMENTO(0), DECUENTO(1)
        PORCENTAJECOBRO                 FLOAT       ,
        COPAGOELEMENTOSPAQUETE          NUMBER(3)   , -- CopagoElementosPorPaquete 1 TRUE 0 FALSE
        TIPOLIQUIDVALRECUELEMENTOS      NUMBER(3)   , --TipoLiquidacionValRecupElementos 0(COPAGO) 1(CUOTA MODERADORA), 2(REGIMEN)
        VALORRECUPERACIONELEMENTOS      FLOAT       , --ValorRecuperacionElementos
        CANTIDADELEMENTOSPAQUETE        NUMBER(10)   DEFAULT 0
)ON COMMIT DELETE ROWS;


--NOMBRE ANTES ERA 'TABLA'
--VARIABLE ERA TIPOLIQUIDACIONVALRECUELEMENTOS AHORA TIPOLIQUIDVALRECUELEMENTOS