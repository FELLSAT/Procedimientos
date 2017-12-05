CREATE OR REPLACE PROCEDURE H3i_SP_VALID_ASIG_CITAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_COD_MED IN VARCHAR2,
    v_COD_SERV IN VARCHAR2,
    v_DUR_CITA IN NUMBER,
    v_FECHA_CITA IN DATE,
    v_COD_ESPEC IN VARCHAR2,
    v_COD_CONSUL IN VARCHAR2,
    v_NUM_CONEX IN NUMBER,
    cv_1 OUT SYS_REFCURSOR,
    cv_2 OUT SYS_REFCURSOR
)
AS
    v_ESGRUPAL NUMBER(1,0);
    v_NUM_CAN_MAX_GRUP NUMBER(10,0);
    v_NUM_RESULTS NUMBER(10,0);

BEGIN

    SELECT NU_ESGRUPAL_SER ,
        NU_MAXPACGRU_SER 
    INTO v_ESGRUPAL,
        v_NUM_CAN_MAX_GRUP
    FROM SERVICIOS 
    WHERE CD_CODI_SER = v_COD_SERV;


    SELECT COUNT(FE_FECH_CIT) 
    INTO v_NUM_RESULTS
    FROM CITAS_MEDICAS 
    WHERE  CD_CODI_MED_CIT = v_COD_MED
        AND CD_CODI_SER_CIT = v_COD_SERV
        AND NU_DURA_CIT = v_DUR_CITA
        AND FE_FECH_CIT = v_FECHA_CITA
        AND CD_CODI_CONS_CIT = v_COD_CONSUL
        AND CD_CODI_ESP_CIT = v_COD_ESPEC;


   -- SERVICIOS QUE PERMITE CITAS GRUPALES
    IF ( v_ESGRUPAL = 1 ) THEN
    
        BEGIN
            IF ( v_NUM_RESULTS > 0 AND v_NUM_RESULTS < v_NUM_CAN_MAX_GRUP ) THEN
       
                BEGIN
                    OPEN  cv_1 FOR
                        SELECT CD_CODI_MED_CIT TX_CODI_MEDI_CIPR  ,
                            NO_NOMB_MED TX_NOMB_MEDI_CIPR  ,
                            FE_FECH_CIT FE_HOIN_CIPR  ,
                            CD_CODI_CONS_CIT CD_CODI_CONS_CIPR  ,
                            (v_NUM_CAN_MAX_GRUP - COUNT(FE_FECH_CIT) ) NU_CIT_REST_CIPR  ,
                            v_NUM_CONEX 
                        FROM CITAS_MEDICAS 
                        INNER JOIN MEDICOS    
                            ON CD_CODI_MED_CIT = CD_CODI_MED
                        WHERE  CD_CODI_SER_CIT = v_COD_SERV
                            AND CD_CODI_MED_CIT = v_COD_MED
                            AND FE_FECH_CIT >= v_FECHA_CITA
                            AND FE_FECH_CIT >= SYSDATE -- SE FILTRA PARA LISTAR = o > A LA FECHA ACTUAL O DEL FILTRO                
                        GROUP BY CD_CODI_MED_CIT,NO_NOMB_MED,FE_FECH_CIT,CD_CODI_CONS_CIT,NU_NUME_CONE_CIT ;      
                END;

            ELSE
          
                BEGIN
                    OPEN  cv_1 FOR
                        SELECT TX_CODI_MEDI_CIPR ,
                            FE_HOIN_CIPR ,
                            FE_HOFI_CIPR ,
                            CD_CODI_CONS_CIPR 
                        FROM TMP_CITASMASPROXIMAS 
                        WHERE  TX_CODI_MEDI_CIPR = v_COD_MED
                            AND FE_HOIN_CIPR = v_FECHA_CITA
                            AND CD_CODI_CONS_CIPR = v_COD_CONSUL
                            AND NU_NUME_CONE_CIPR = v_NUM_CONEX
                        GROUP BY TX_CODI_MEDI_CIPR,FE_HOIN_CIPR,FE_HOFI_CIPR,CD_CODI_CONS_CIPR ;      
                END;
            END IF;
        END;

    ELSE
   
        BEGIN
            -- PARA CITAS NO GRUPALES
            IF ( v_NUM_RESULTS = 0 ) THEN
       
                BEGIN
                    OPEN  cv_2 FOR
                        SELECT TX_CODI_MEDI_CIPR ,
                            FE_HOIN_CIPR ,
                            FE_HOFI_CIPR ,
                            CD_CODI_CONS_CIPR 
                        FROM TMP_CITASMASPROXIMAS 
                        WHERE  TX_CODI_MEDI_CIPR = v_COD_MED
                            AND FE_HOIN_CIPR = v_FECHA_CITA
                            AND CD_CODI_CONS_CIPR = v_COD_CONSUL
                            AND NU_NUME_CONE_CIPR = v_NUM_CONEX
                        GROUP BY TX_CODI_MEDI_CIPR,FE_HOIN_CIPR,FE_HOFI_CIPR,CD_CODI_CONS_CIPR ;      
                END;

            ELSE

                BEGIN
                    -- NO DEVOLVER RESULTADOS
                    OPEN  cv_2 FOR
                        SELECT  NULL 
                        FROM DUAL  ;      
                END;
            END IF;   
        END;

    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;