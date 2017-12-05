CREATE OR REPLACE PROCEDURE H3i_SP_OBT_VINCULO_ADSCRITO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGO_PROGRAMA IN NUMBER,
    v_CODIGO_DEPENDENCIA IN VARCHAR2,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    IF v_CODIGO_PROGRAMA = 0 AND v_CODIGO_DEPENDENCIA IS NULL THEN
    
        BEGIN
            OPEN  cv_1 FOR
                SELECT DISTINCT A.NU_CONSE_ADSC ,
                    A.CD_CODI_ADSC ,
                    A.DE_NOMB_ADSC ,
                    A.NU_ESTA_ADSC ,
                    A.NU_TIPCONT_ADSC ,
                    A.NU_CALI_ADSC ,
                    A.NU_TIPD_ADSC ,
                    0 CD_CODI_PRO_DEP_ADS  ,
                    0 NU_CODI_PRSA  ,
                    NULL CD_CODI_CECO  ,
                    0 VINCULADO  
                FROM ADSCRITOS A
                LEFT JOIN PROGRAMA_DEPENDENCIA_ADSCRITO PDA   
                    ON A.NU_CONSE_ADSC = PDA.NU_CODI_ADSC
                LEFT JOIN PROGRAMA_SALUD_UNAL P   
                    ON PDA.NU_CODI_PRSA = P.NU_CODI_PRSA
                LEFT JOIN CENTRO_COSTO C   
                    ON PDA.CD_CODI_CECO = C.CD_CODI_CECO ;   
        END;

    ELSE
   
        BEGIN
            OPEN  cv_1 FOR
                SELECT DISTINCT A.NU_CONSE_ADSC ,
                    A.CD_CODI_ADSC ,
                    A.DE_NOMB_ADSC ,
                    A.NU_ESTA_ADSC ,
                    A.NU_TIPCONT_ADSC ,
                    A.NU_CALI_ADSC ,
                    A.NU_TIPD_ADSC ,
                    CASE 
                        WHEN A.NU_CONSE_ADSC IN ( SELECT DISTINCT A.NU_CONSE_ADSC 
                                                  FROM ADSCRITOS A
                                                  LEFT JOIN PROGRAMA_DEPENDENCIA_ADSCRITO PDA   
                                                      ON A.NU_CONSE_ADSC = PDA.NU_CODI_ADSC
                                                  LEFT JOIN PROGRAMA_SALUD_UNAL P   
                                                      ON PDA.NU_CODI_PRSA = P.NU_CODI_PRSA
                                                  LEFT JOIN CENTRO_COSTO C   
                                                      ON PDA.CD_CODI_CECO = C.CD_CODI_CECO
                                                  WHERE  v_CODIGO_PROGRAMA = PDA.NU_CODI_PRSA
                                                      AND v_CODIGO_DEPENDENCIA = PDA.CD_CODI_CECO
                                                      AND PDA.ACTIVIDAD = 1) THEN
                            (SELECT DISTINCT PDA.CD_CODI_PRO_DEP_ADS 
                            FROM PROGRAMA_DEPENDENCIA_ADSCRITO PDA
                            WHERE  v_CODIGO_PROGRAMA = PDA.NU_CODI_PRSA
                                AND v_CODIGO_DEPENDENCIA = PDA.CD_CODI_CECO
                                AND PDA.NU_CODI_ADSC = A.NU_CONSE_ADSC
                                AND PDA.ACTIVIDAD = 1 AND ROWNUM <= 1 )
                        ELSE NULL
                    END CD_CODI_PRO_DEP_ADS,
                    CASE 
                        WHEN A.NU_CONSE_ADSC IN ( SELECT DISTINCT A.NU_CONSE_ADSC 
                                                  FROM ADSCRITOS A
                                                  LEFT JOIN PROGRAMA_DEPENDENCIA_ADSCRITO PDA   
                                                      ON A.NU_CONSE_ADSC = PDA.NU_CODI_ADSC
                                                  LEFT JOIN PROGRAMA_SALUD_UNAL P   
                                                      ON PDA.NU_CODI_PRSA = P.NU_CODI_PRSA
                                                  LEFT JOIN CENTRO_COSTO C   
                                                      ON PDA.CD_CODI_CECO = C.CD_CODI_CECO
                                                  WHERE  v_CODIGO_PROGRAMA = PDA.NU_CODI_PRSA
                                                      AND v_CODIGO_DEPENDENCIA = PDA.CD_CODI_CECO
                                                      AND PDA.ACTIVIDAD = 1 ) THEN
                            (SELECT DISTINCT P.NU_CODI_PRSA 
                            FROM PROGRAMA_DEPENDENCIA_ADSCRITO PDA
                            INNER JOIN PROGRAMA_SALUD_UNAL P   
                                ON PDA.NU_CODI_PRSA = P.NU_CODI_PRSA
                            WHERE v_CODIGO_PROGRAMA = PDA.NU_CODI_PRSA
                            AND v_CODIGO_DEPENDENCIA = PDA.CD_CODI_CECO
                                AND PDA.NU_CODI_ADSC = A.NU_CONSE_ADSC
                                AND PDA.ACTIVIDAD = 1 AND ROWNUM <= 1 )
                        ELSE NULL
                    END NU_CODI_PRSA ,
                    CASE 
                        WHEN A.NU_CONSE_ADSC IN ( SELECT DISTINCT A.NU_CONSE_ADSC 
                                                  FROM ADSCRITOS A
                                                  LEFT JOIN PROGRAMA_DEPENDENCIA_ADSCRITO PDA   
                                                      ON A.NU_CONSE_ADSC = PDA.NU_CODI_ADSC
                                                  LEFT JOIN PROGRAMA_SALUD_UNAL P   
                                                      ON PDA.NU_CODI_PRSA = P.NU_CODI_PRSA
                                                  LEFT JOIN CENTRO_COSTO C   
                                                      ON PDA.CD_CODI_CECO = C.CD_CODI_CECO
                                                  WHERE  v_CODIGO_PROGRAMA = PDA.NU_CODI_PRSA
                                                      AND v_CODIGO_DEPENDENCIA = PDA.CD_CODI_CECO
                                                      AND PDA.ACTIVIDAD = 1 ) THEN
                            (SELECT DISTINCT C.CD_CODI_CECO 
                            FROM PROGRAMA_DEPENDENCIA_ADSCRITO PDA
                            LEFT JOIN CENTRO_COSTO C   ON PDA.CD_CODI_CECO = C.CD_CODI_CECO
                            WHERE  v_CODIGO_PROGRAMA = PDA.NU_CODI_PRSA
                                AND v_CODIGO_DEPENDENCIA = PDA.CD_CODI_CECO
                                AND PDA.NU_CODI_ADSC = A.NU_CONSE_ADSC
                                AND PDA.ACTIVIDAD = 1 AND ROWNUM <= 1 )
                        ELSE NULL
                    END CD_CODI_CECO  ,
                    CASE 
                        WHEN A.NU_CONSE_ADSC IN ( SELECT DISTINCT A.NU_CONSE_ADSC 
                                                  FROM ADSCRITOS A
                                                  LEFT JOIN PROGRAMA_DEPENDENCIA_ADSCRITO PDA   
                                                      ON A.NU_CONSE_ADSC = PDA.NU_CODI_ADSC
                                                  LEFT JOIN PROGRAMA_SALUD_UNAL P   
                                                      ON PDA.NU_CODI_PRSA = P.NU_CODI_PRSA
                                                  LEFT JOIN CENTRO_COSTO C   
                                                      ON PDA.CD_CODI_CECO = C.CD_CODI_CECO
                                                  WHERE  v_CODIGO_PROGRAMA = PDA.NU_CODI_PRSA
                                                      AND v_CODIGO_DEPENDENCIA = PDA.CD_CODI_CECO
                                                      AND PDA.ACTIVIDAD = 1 )
                            THEN 1
                        ELSE 0
                    END VINCULADO  
                FROM ADSCRITOS A
                LEFT JOIN PROGRAMA_DEPENDENCIA_ADSCRITO PDA   
                    ON A.NU_CONSE_ADSC = PDA.NU_CODI_ADSC ;
   
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;