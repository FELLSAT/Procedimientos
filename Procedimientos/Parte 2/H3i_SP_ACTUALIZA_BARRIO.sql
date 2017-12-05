CREATE OR REPLACE PROCEDURE H3i_SP_ACTUALIZA_BARRIO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_DE_DESC_BAR IN VARCHAR2,
  v_CD_CODI_BAR IN VARCHAR2,
  v_CD_CODI_MUNI_BAR IN VARCHAR2,
  v_CD_CODI_DPTO_BAR IN VARCHAR2,
  v_CD_CODI_PAIS_BAR IN VARCHAR2,
  v_CD_COID_LOCA_BAR IN VARCHAR2 DEFAULT NULL ,
  v_ESTADO IN NUMBER
)
AS

BEGIN

  IF v_CD_COID_LOCA_BAR IS NULL THEN
      DECLARE
        v_temp NUMBER(1, 0) := 0;
   
      BEGIN
          BEGIN
            SELECT 1 INTO v_temp
            FROM DUAL
            WHERE EXISTS ( SELECT * 
                           FROM BARRIO 
                           WHERE  CD_CODI_BAR = v_CD_CODI_BAR
                                   AND CD_CODI_MUNI_BAR = v_CD_CODI_MUNI_BAR
                                   AND CD_CODI_DPTO_BAR = v_CD_CODI_DPTO_BAR
                                   AND CD_CODI_PAIS_BAR = v_CD_CODI_PAIS_BAR
                                   AND CD_COID_LOCA_BAR IS NULL
                                   AND --los que no utlicen localidades 
                                  CD_CODI_CONCABARRIOLOCA_BAR = 0 );
          EXCEPTION
            WHEN OTHERS THEN
                NULL;
          END;
         
          IF v_temp = 1 THEN
       
            BEGIN
              UPDATE BARRIO
              SET DE_DESC_BAR = v_DE_DESC_BAR,
                      ESTADO = v_ESTADO
              WHERE  CD_CODI_BAR = v_CD_CODI_BAR
              AND CD_CODI_MUNI_BAR = v_CD_CODI_MUNI_BAR
              AND CD_CODI_DPTO_BAR = v_CD_CODI_DPTO_BAR
              AND CD_CODI_PAIS_BAR = v_CD_CODI_PAIS_BAR;
            
            END;
          ELSE
      
            BEGIN
               INSERT INTO BARRIO
                 ( DE_DESC_BAR, CD_CODI_BAR, CD_CODI_MUNI_BAR, CD_CODI_DPTO_BAR, CD_CODI_PAIS_BAR, ESTADO, CD_CODI_CONCABARRIOLOCA_BAR )
                 VALUES ( v_DE_DESC_BAR, v_CD_CODI_BAR, v_CD_CODI_MUNI_BAR, v_CD_CODI_DPTO_BAR, v_CD_CODI_PAIS_BAR, v_ESTADO, 0 );
            
            END;
          END IF;
   
        END;
  ELSE
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
    BEGIN
        BEGIN
          SELECT 1 INTO v_temp
          FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM BARRIO 
                          WHERE  CD_CODI_BAR = v_CD_CODI_BAR
                                   AND CD_CODI_MUNI_BAR = v_CD_CODI_MUNI_BAR
                                   AND CD_CODI_DPTO_BAR = v_CD_CODI_DPTO_BAR
                                   AND CD_COID_LOCA_BAR = v_CD_COID_LOCA_BAR
                                   AND CD_CODI_PAIS_BAR = v_CD_CODI_PAIS_BAR );
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
         
      IF v_temp = 1 THEN
       
        BEGIN
          UPDATE BARRIO
          SET DE_DESC_BAR = v_DE_DESC_BAR,
                  ESTADO = v_ESTADO,
                  CD_CODI_CONCABARRIOLOCA_BAR = v_CD_COID_LOCA_BAR || '_' || v_CD_CODI_BAR
          WHERE  CD_CODI_BAR = v_CD_CODI_BAR
          AND CD_CODI_MUNI_BAR = v_CD_CODI_MUNI_BAR
          AND CD_CODI_DPTO_BAR = v_CD_CODI_DPTO_BAR
          AND CD_CODI_PAIS_BAR = v_CD_CODI_PAIS_BAR
          AND CD_COID_LOCA_BAR = v_CD_COID_LOCA_BAR;
        
        END;
      ELSE
      
        BEGIN
          INSERT INTO BARRIO
             ( DE_DESC_BAR, CD_CODI_BAR, CD_CODI_MUNI_BAR, CD_CODI_DPTO_BAR, CD_CODI_PAIS_BAR, CD_COID_LOCA_BAR, ESTADO, CD_CODI_CONCABARRIOLOCA_BAR )
          VALUES ( v_DE_DESC_BAR, v_CD_CODI_BAR, v_CD_CODI_MUNI_BAR, v_CD_CODI_DPTO_BAR, v_CD_CODI_PAIS_BAR, v_CD_COID_LOCA_BAR, v_ESTADO, v_CD_COID_LOCA_BAR || '_' || v_CD_CODI_BAR );
        
        END;
      END IF;
   
    END;
  END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_ACTUALIZA_BARRIO;