CREATE OR REPLACE FUNCTION FN_VALORCONCEPTOHC
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_HICL IN NUMBER,
  v_NU_NUME_COHI IN NUMBER,
  v_NU_INDI_RPC IN NUMBER,
  v_NU_TIPO_COHI IN NUMBER,
  v_ES_DECIMAL IN NUMBER
)
RETURN VARCHAR2
AS
   v_RTA VARCHAR2(4000);

BEGIN
   -- Modificado para que solo afecte a numericos, ya que arruino el resto de los tipos de concepto.
   IF (v_NU_TIPO_COHI) = 0 THEN
    
   BEGIN
      /* MODIFICACION JUAN CAMILO -> COMENTADA A CAUSA DE CAPTURA ERRONEA DE NUMEROS 0, ES DECIR
      		LA FUNCION OMITE LOS CEROS AÑADIDOS A LA BASE DE DATOS (SEA 0.0, 0, O 0,00)*/
      IF ( v_ES_DECIMAL = 1 ) THEN
       SELECT REPLACE(
                      RTRIM(
                            REPLACE(
                                    REPLACE(
                                            RTRIM(
                                                  LTRIM(
                                                          TO_CHAR(ROUND(NU_DESC_HINU, 3))
                                                        )
                                                  ), ' ', '0'
                                            ), '.', ' ')
                                    ), ' ', ','
                      ) 

        INTO v_RTA
        FROM HIST_NUME HN
       WHERE  HN.NU_NUME_HICL_HINU = v_NU_NUME_HICL
                AND HN.NU_INDI_HINU = v_NU_INDI_RPC;
      ELSE
         SELECT REPLACE(
                        RTRIM(
                              REPLACE(
                                      REPLACE(
                                              RTRIM(
                                                    LTRIM(
                                                            TO_CHAR(ROUND(NU_DESC_HINU, 3))
                                                          )
                                                    ), ' ', '0'
                                              ), '.', ' '
                                      )
                              ), ' ', ','
                        ) 

           INTO v_RTA
           FROM HIST_NUME HN
          WHERE  HN.NU_NUME_HICL_HINU = v_NU_NUME_HICL
                   AND HN.NU_INDI_HINU = v_NU_INDI_RPC;
      END IF;
   
   END;
   END IF;
   IF (v_NU_TIPO_COHI) IN ( 4,5,120 )
    THEN
    
   BEGIN
      SELECT REPLACE(
                      RTRIM(
                            REPLACE(
                                    REPLACE(
                                            RTRIM(
                                                  LTRIM(
                                                        REPLACE(
                                                                  TO_CHAR(ROUND(NU_DESC_HINU, 3)), '0', ' '
                                                                )
                                                        )
                                                  ), ' ', '0'
                                            ), '.', ' '
                                    )
                            ), ' ', ','
                      ) 

        INTO v_RTA

        --SELECT	@RTA = NU_DESC_HINU
        FROM HIST_NUME HN
       WHERE  HN.NU_NUME_HICL_HINU = v_NU_NUME_HICL
                AND HN.NU_INDI_HINU = v_NU_INDI_RPC;
   
   END;
   END IF;
   IF (v_NU_TIPO_COHI) IN ( 1,7,13,16,19,98,99,97,29,32,33,34,35,36 )
    THEN
    
   BEGIN
      SELECT HT.DE_DESC_HITE 

        INTO v_RTA
        FROM HIST_TEXT HT
       WHERE  HT.NU_NUME_HICL_HITE = v_NU_NUME_HICL
                AND HT.NU_INDI_HITE = v_NU_INDI_RPC;
   
   END;
   END IF;
   IF (v_NU_TIPO_COHI) = 2 THEN
    
   BEGIN
      SELECT TO_CHAR(HD.FE_DESC_HIDA,'DD') || '/' || 
                    TO_CHAR(HD.FE_DESC_HIDA,'MM') || '/' || 
                    TO_CHAR(HD.FE_DESC_HIDA,'YYYY') 

        INTO v_RTA
        FROM HIST_DATE HD
       WHERE  HD.NU_NUME_HICL_HIDA = v_NU_NUME_HICL
                AND HD.NU_INDI_HIDA = v_NU_INDI_RPC;
   
   END;
   END IF;
   IF (v_NU_TIPO_COHI) = 3 THEN
    
   BEGIN
      SELECT HM.DE_DESC_HIME 

        INTO v_RTA
        FROM HIST_MEMO HM
       WHERE  HM.NU_NUME_HICL_HIME = v_NU_NUME_HICL
                AND HM.NU_INDI_HIME = v_NU_INDI_RPC;
   
   END;
   END IF;
   RETURN v_RTA;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;