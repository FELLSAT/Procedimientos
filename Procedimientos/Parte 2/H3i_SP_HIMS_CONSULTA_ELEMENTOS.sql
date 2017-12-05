CREATE OR REPLACE PROCEDURE H3i_SP_HIMS_CONSULTA_ELEMENTOS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  V_CD_DEPE_DEAR IN VARCHAR2,
  V_NU_NUME_CONV IN NUMBER,
  V_INCLUIR_PAQUETE IN NUMBER DEFAULT 0 ,
  V_NU_NUME_PAQU IN NUMBER,
  V_FILTRAR_POR_NOMBRE IN NUMBER DEFAULT 1 ,
  V_FILTRO IN VARCHAR2,
  V_NU_REGIMEN IN VARCHAR2,
  V_AMBITO_ATENCION IN NUMBER
)
AS   
   V_SQL VARCHAR2(32767);
   V_PAR VARCHAR2(32767);

BEGIN

    IF(V_AMBITO_ATENCION = 2) THEN           
        BEGIN
            V_SQL := 'SELECT 
                        ART.CD_CODI_ARTI,
                        ART.NO_NOMB_ARTI,
                        ART.DE_UNME_ARTI,
                        ART.DE_CTRA_ARTI,
                        ART.DE_FOFA_ARTI,
                        RDA.CT_EXIS_DEAR,
                        RTA.CD_TARI_TAAR,
                        RTA.VL_PREC_TAAR,
                        CON.NU_COBR_ELE_CONV AS FORMACOBRO,
                        CON.NU_FORM_ELE_CONV AS TIPOPORCENTAJECOBRO,
                        CON.PR_COBR_ELE_CONV AS PORCENTAJECOBRO,
                        EPS.NU_COEL_EPS AS COPAGOELEMENTOSPAQUETE,
                        RRE.NU_ELEM_RRE AS TIPOLIQUIDACIONVALRECUELEMENTOS,
                        RRE.VL_ELEM_RRE AS VALORRECUPERACIONELEMENTOS,
                        CON.CT_ELEPAQ_CONV AS CANTIDADELEMENTOSPAQUETE
                      FROM R_ELE_PLAN REP
                      INNER JOIN CONVENIOS CON
                          ON REP.CD_CODI_PLAN_REP = CON.CD_CODI_PLAN_CONV
                          AND CON.NU_NUME_CONV = :V_NU_NUME_CONV                
                      INNER JOIN R_DEPE_ARTI RDA
                          ON REP.CD_CODI_ELE_REP = RDA.CD_ARTI_DEAR
                          AND REP.CD_CODI_CECO_REP = RDA.CD_DEPE_DEAR
                          AND RDA.CD_DEPE_DEAR = :V_CD_DEPE_DEAR         
                          AND RDA.CT_EXIS_DEAR > 0
                      INNER JOIN ARTICULO ART
                          ON RDA.CD_ARTI_DEAR = ART.CD_CODI_ARTI
                      INNER JOIN R_TARI_ARTI RTA
                          ON RTA.CD_ARTI_TAAR = ART.CD_CODI_ARTI
                          AND CON.CD_CODI_TARI_CONV = RTA.CD_TARI_TAAR
                      INNER JOIN EPS EPS
                          ON CON.CD_NIT_EPS_CONV = EPS.CD_NIT_EPS
                      INNER JOIN R_REG_EPS_H RRE
                          ON RRE.CD_NIT_EPS_RRE = EPS.CD_NIT_EPS
                          AND RRE.CD_CODI_REG_RRE = :V_NU_REGIMEN';


            -- INCLUIR LAS TABLAS DE PAQUETE
            IF V_INCLUIR_PAQUETE = 1 THEN       
                BEGIN
                   V_SQL := V_SQL || 'INNER JOIN R_PAQU_ELE RPE
                                      ON ART.CD_CODI_ARTI = RPE.CD_CODI_ELE_RPEL
                                      INNER JOIN PAQUETES PAQ
                                      ON RPE.CD_CODI_SER_PAQ_RPEL = PAQ.CD_CODI_SER_PAQU' ;                
                END;
            END IF;
      

            -- INCLUIR EL FILTRO POR NOMBRE O CÓDIGO DE ACUERDO AL PARAMETRO
            V_FILTRO := '%' || V_FILTRO || '%' ;

            IF V_FILTRAR_POR_NOMBRE = 1 THEN             
              BEGIN
                 V_SQL := V_SQL || 'WHERE ART.NO_NOMB_ARTI LIKE :V_FILTRO';              
              END;
            ELSE        
                BEGIN
                   V_SQL := V_SQL || 'WHERE ART.CD_CODI_ARTI LIKE :V_FILTRO';                
                END;
            END IF;


            -- INCLUIR EL FILTRO POR EL NÚMERO DEL PAQUETE
            IF V_INCLUIR_PAQUETE = 1 THEN         
                BEGIN
                   V_SQL := V_SQL || 'AND PAQ.NU_NUME_PAQU = :V_NU_NUME_PAQU' ;                
                END;
            END IF;


            --PRINT @SQL; 
            DECLARE
                V_SQL2 VARCHAR2(2000) := 'INSERT INTO TABLA '||V_SQL;
            BEGIN
                EXECUTE IMMEDIATE V_SQL2 USING :V_NU_NUME_CONV, V_CD_DEPE_DEAR, V_NU_REGIMEN, V_FILTRO, V_NU_NUME_PAQU;
            END;    
        END;
    ELSE
   
        BEGIN
            --SI EL AMBITO ES URGENCIAS
            IF ( V_AMBITO_ATENCION = 3 ) THEN     
                BEGIN
                    v_SQL := 'SELECT                                 
                                ART.CD_CODI_ARTI,
                                ART.NO_NOMB_ARTI,
                                ART.DE_UNME_ARTI,
                                ART.DE_CTRA_ARTI,
                                ART.DE_FOFA_ARTI,
                                RDA.CT_EXIS_DEAR,
                                RTA.CD_TARI_TAAR,
                                RTA.VL_PREC_TAAR,
                                CON.NU_COBR_ELE_CONV AS FORMACOBRO,
                                CON.NU_FORM_ELE_CONV AS TIPOPORCENTAJECOBRO,
                                CON.PR_COBR_ELE_CONV AS PORCENTAJECOBRO,
                                EPS.NU_COEL_EPS AS COPAGOELEMENTOSPAQUETE,
                                RRE.NU_ELEM_RRE AS TIPOLIQUIDACIONVALRECUELEMENTOS,
                                RRE.VL_ELEM_RRE AS VALORRECUPERACIONELEMENTOS,
                                CON.CT_ELEPAQ_CONV AS CANTIDADELEMENTOSPAQUETE
                              FROM R_ELE_PLAN REP
                              INNER JOIN CONVENIOS CON
                                  ON REP.CD_CODI_PLAN_REP = CON.CD_CODI_PLAN_CONV
                                  AND CON.NU_NUME_CONV = :V_NU_NUME_CONV            
                              INNER JOIN R_DEPE_ARTI RDA
                                  ON REP.CD_CODI_ELE_REP = RDA.CD_ARTI_DEAR
                                     AND REP.CD_CODI_CECO_REP = RDA.CD_DEPE_DEAR
                                     AND RDA.CD_DEPE_DEAR = :V_CD_DEPE_DEAR              
                                     AND RDA.CT_EXIS_DEAR > 0
                              INNER JOIN ARTICULO ART
                                  ON RDA.CD_ARTI_DEAR = ART.CD_CODI_ARTI
                              INNER JOIN R_TARI_ARTI RTA
                                  ON RTA.CD_ARTI_TAAR = ART.CD_CODI_ARTI
                                     AND CON.CD_CODI_TARI_CONV = RTA.CD_TARI_TAAR
                              INNER JOIN EPS EPS
                                  ON CON.CD_NIT_EPS_CONV = EPS.CD_NIT_EPS
                              INNER JOIN R_REG_EPS_U RRE
                                  ON RRE.CD_NIT_EPS_RRE = EPS.CD_NIT_EPS
                                  AND RRE.CD_CODI_REG_RRE = :V_NU_REGIMEN' ;

                    -- INCLUIR LAS TABLAS DE PAQUETE
                    IF V_INCLUIR_PAQUETE = 1 THEN          
                        BEGIN
                            V_SQL := V_SQL ||'INNER JOIN R_PAQU_ELE RPE
                                                  ON ART.CD_CODI_ARTI = RPE.CD_CODI_ELE_RPEL
                                              INNER JOIN PAQUETES PAQ
                                                  ON CD_CODI_SER_PAQ_RPEL = PAQ.CD_CODI_SER_PAQU' ;         
                        END;
                    END IF;

                    -- INCLUIR EL FILTRO POR NOMBRE O CÓDIGO DE ACUERDO AL PARAMETRO
                    V_FILTRO := '%' || V_FILTRO || '%' ;

                    IF v_FILTRAR_POR_NOMBRE = 1 THEN
            
                       BEGIN
                          V_SQL := V_SQL || 'WHERE ART.NO_NOMB_ARTI LIKE :V_FILTRO' ;                       
                       END;
                    ELSE
           
                       BEGIN
                          V_SQL := V_SQL || 'WHERE ART.CD_CODI_ARTI LIKE :V_FILTRO' ;                       
                       END;
                    END IF;


                    -- INCLUIR EL FILTRO POR EL NÚMERO DEL PAQUETE
                    IF V_INCLUIR_PAQUETE = 1 THEN
            
                      BEGIN
                          V_SQL := V_SQL || 'AND PAQ.NU_NUME_PAQU = :V_NU_NUME_PAQU' ;
                       
                      END;
                    END IF;


                     --PRINT @SQL;
                    DECLARE
                        V_SQL2 VARCHAR2(2000) := 'INSERT INTO TABLA '||V_SQL;
                    BEGIN
                        EXECUTE IMMEDIATE V_SQL2 USING :V_NU_NUME_CONV, V_CD_DEPE_DEAR, V_NU_REGIMEN, V_FILTRO;
                    END;            
                END;
            ELSE
                BEGIN
                     --SI NO ES NINGUNA DE LAS ANTERIORES TOMA POR DEFECTO AMBULATORIO
                    V_SQL := 'SELECT 
                                ART.CD_CODI_ARTI,
                                ART.NO_NOMB_ARTI,
                                ART.DE_UNME_ARTI,
                                ART.DE_CTRA_ARTI,
                                ART.DE_FOFA_ARTI,
                                RDA.CT_EXIS_DEAR,
                                RTA.CD_TARI_TAAR,
                                RTA.VL_PREC_TAAR,
                                CON.NU_COBR_ELE_CONV AS FORMACOBRO,
                                CON.NU_FORM_ELE_CONV AS TIPOPORCENTAJECOBRO,
                                CON.PR_COBR_ELE_CONV AS PORCENTAJECOBRO,
                                EPS.NU_COEL_EPS AS COPAGOELEMENTOSPAQUETE,
                                RRE.NU_ELEM_RRE AS TIPOLIQUIDACIONVALRECUELEMENTOS,
                                RRE.VL_ELEM_RRE AS VALORRECUPERACIONELEMENTOS,
                                CON.CT_ELEPAQ_CONV AS CANTIDADELEMENTOSPAQUETE
                              FROM R_ELE_PLAN REP
                              INNER JOIN CONVENIOS CON
                                  ON REP.CD_CODI_PLAN_REP = CON.CD_CODI_PLAN_CONV
                                  AND CON.NU_NUME_CONV = :V_NU_NUME_CONV           
                              INNER JOIN R_DEPE_ARTI RDA
                                  ON REP.CD_CODI_ELE_REP = RDA.CD_ARTI_DEAR
                                  AND REP.CD_CODI_CECO_REP = RDA.CD_DEPE_DEAR
                                  AND RDA.CD_DEPE_DEAR = :V_CD_DEPE_DEAR            
                                  AND RDA.CT_EXIS_DEAR > 0
                              INNER JOIN ARTICULO ART
                                  ON RDA.CD_ARTI_DEAR = ART.CD_CODI_ARTI
                              INNER JOIN R_TARI_ARTI RTA
                                  ON RTA.CD_ARTI_TAAR = ART.CD_CODI_ARTI
                                  AND CON.CD_CODI_TARI_CONV = RTA.CD_TARI_TAAR
                              INNER JOIN EPS EPS
                                  ON CD_NIT_EPS_CONV = EPS.CD_NIT_EPS
                              INNER JOIN R_REG_EPS RRE
                                  ON RRE.CD_NIT_EPS_RRE = EPS.CD_NIT_EPS
                                  AND RRE.CD_CODI_REG_RRE = :V_NU_REGIMEN' ;

                    -- INCLUIR LAS TABLAS DE PAQUETE
                    IF V_INCLUIR_PAQUETE = 1 THEN
          
                        BEGIN
                            V_SQL := V_SQL ||'INNER JOIN R_PAQU_ELE RPE
                                                  ON ART.CD_CODI_ARTI = RPE.CD_CODI_ELE_RPEL
                                              INNER JOIN PAQUETES PAQ
                                                  ON RPE.CD_CODI_SER_PAQ_RPEL = PAQ.CD_CODI_SER_PAQU';                         
                        END;
                    END IF;


                    -- INCLUIR EL FILTRO POR NOMBRE O CÓDIGO DE ACUERDO AL PARAMETRO
                    V_FILTRO := '%' || V_FILTRO || '%' ;
                    IF V_FILTRAR_POR_NOMBRE = 1 THEN
                      
                        BEGIN
                            V_SQL := V_SQL ||'WHERE ART.NO_NOMB_ARTI LIKE :V_FILTRO';
                        END;
                    ELSE
         
                        BEGIN
                            V_SQL := V_SQL ||'WHERE ART.CD_CODI_ARTI LIKE :V_FILTRO';
                        END;
                    END IF;


                    -- INCLUIR EL FILTRO POR EL NÚMERO DEL PAQUETE
                    IF V_INCLUIR_PAQUETE = 1 THEN
          
                        BEGIN
                            V_SQL := V_SQL ||'AND PAQ.NU_NUME_PAQU = :V_NU_NUME_PAQU';
                        END;
                    END IF;


                    --PRINT @SQL;
                    DECLARE
                        V_SQL2 VARCHAR2(2000) := 'INSERT INTO TABLA '||V_SQL;
                    BEGIN
                        EXECUTE IMMEDIATE V_SQL2 USING :V_NU_NUME_CONV, V_CD_DEPE_DEAR, V_NU_REGIMEN, V_FILTRO;
                    END;       
                END;
            END IF;
   
        END;
    END IF;

    --SELECT * FROM tt_tabla_2

    BEGIN
        DECLARE
            V_SQL2 VARCHAR(200) := 'ALETER TABLE TABLA ADD VALOR_COPAGO FLOAT DEFAULT 0 NOT NULL';
        BEGIN
            EXECUTE IMMEDIATE V_SQL2;
        END;
    END;                       
    
    --1. Calcular el valor del elemento, teniendo en cuenta la forma de cobro que sea porcentaje, si la forma de pago el plena no hay que
    --actualizar el valor del elemento
    BEGIN
        DECLARE
            V_SQL2 VARCHAR (2000) :='UPDATE TABLA SET VL_PREC_TAAR = CASE 
                                                                        WHEN TIPOPORCENTAJECOBRO = 0 
                                                                            THEN (VL_PREC_TAAR - VL_PREC_TAAR * PORCENTAJECOBRO) / 100
                                                                        ELSE (VL_PREC_TAAR + (VL_PREC_TAAR * PORCENTAJECOBRO) / 100)
                                                                    END
                                    WHERE  FORMACOBRO = 1';
        BEGIN
            EXECUTE IMMEDIATE V_SQL2;
        END;
    BEGIN;

    --porcentaje

    --2. Calcular el valor del copago de los elementos, teniendo en cuenta si es por paquete
    BEGIN
        DECLARE
            V_SQL2 VARCHAR2(2000) := 'UPDATE TABLA
                                      SET VALOR_COPAGO = CASE 
                                                              WHEN TIPOLIQUIDACIONVALRECUELEMENTO = 0 
                                                                  THEN (VL_PREC_TAAR * VALORRECUPERACIONELEMENTOS) / 100
                                                              ELSE (CASE 
                                                                          WHEN TIPOLIQUIDACIONVALRECUELEMENTO = 1 AND CANTIDADELEMENTOSPAQUETE > 0 
                                                                              THEN ((1 / CANTIDADELEMENTOSPAQUETE) * VALORRECUPERACIONELEMENTOS)
                                                                          ELSE VALORRECUPERACIONELEMENTOS
                                                                    END)
                                                         END
                                      WHERE  COPAGOELEMENTOSPAQUETE = 1';
        BEGIN 
            EXECUTE IMMEDIATE V_SQL2;
        END;
    END;

    --3. Calcular el valor del copago de los elementos, teniendo en cuenta si es por elemento
        DECLARE
            V_SQL2 VARCHAR2(2000) := 'UPDATE TABLA
                                      SET VALOR_COPAGO = CASE 
                                                            WHEN TIPOLIQUIDACIONVALRECUELEMENTO = 0 
                                                                THEN (VL_PREC_TAAR * VALORRECUPERACIONELEMENTOS) / 100
                                                            ELSE VALORRECUPERACIONELEMENTOS
                                                         END
                                      WHERE  COPAGOELEMENTOSPAQUETE = 0';
        BEGIN
            EXECUTE IMMEDIATE V_SQL2;
        END;
    -- por elemento

    --4.Mostrar el resultado de los elementos
    BEGIN
        DECLARE 
             V_SQL2 VARCHAR2(2000) := 'INSERT INTO RESULTADO
                                          SELECT CD_CODI_ARTI ,
                                              NO_NOMB_ARTI ,
                                              DE_UNME_ARTI ,
                                              DE_CTRA_ARTI ,
                                              DE_FOFA_ARTI ,
                                              CT_EXIS_DEAR ,
                                              CD_TARI_TAAR ,
                                              VL_PREC_TAAR ,
                                              VALOR_COPAGO ,
                                              TIPOLIQUIDACIONVALRECUELEMENTO 
                                          FROM TABLA 
                                          ORDER BY NO_NOMB_ARTI';
        BEGIN
            EXECUTE IMMEDIATE V_SQL2;
        END;
    END;
    

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;