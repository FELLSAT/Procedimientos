CREATE OR REPLACE PROCEDURE H3i_SP_CONS_CIT_ANULAR_MIHIMS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  --@FECHAINICIAL AS DATETIME,--@FECHAFINAL AS DATETIME,
  v_NUMHIST IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    IF v_NUMHIST != 'T' THEN    
        BEGIN
            OPEN  cv_1 FOR
                SELECT CD_CODI_MED_CIT ,
                    CD_CODI_SER_CIT ,
                    NU_HIST_PAC_CIT ,
                    NU_DURA_CIT ,
                    FE_ELAB_CIT ,
                    FE_FECH_CIT ,
                    NU_DIA_CIT ,
                    TO_NUMBER(NU_NUME_MOVI_CIT) NU_NUME_MOVI_CIT  ,
                    TO_NUMBER(NU_PRIM_CIT) NU_PRIM_CIT  ,
                    FE_HORA_CIT ,
                    TO_NUMBER(NU_ESTA_CIT) NU_ESTA_CIT  ,
                    TO_NUMBER(NU_NUME_CONE_CIT) NU_NUME_CONE_CIT  ,
                    NU_CONE_CALL_CIT ,
                    CD_CODI_ESP_CIT ,
                    CD_CODI_CONS_CIT ,
                    TO_NUMBER(NU_NUME_CONV_CIT) NU_NUME_CONV_CIT  ,
                    TO_NUMBER(NU_TIPO_CIT) NU_TIPO_CIT  ,
                    DE_DESC_CIT ,
                    TO_NUMBER(CITAS_MEDICAS.NU_NUME_CIT) NU_NUME_CIT  ,
                    CD_MEDI_ORDE_CIT ,
                    TO_NUMBER(NU_CONFIR_CIT) NU_CONFIR_CIT  ,
                    NO_NOMB_SER ,
                    NO_NOMB_ESP ,
                    NU_OPCI_SER ,
                    NU_NIVE_SER ,
                    NU_ESGRUPAL_SER ,
                    CASE CD_CODI_MED_EST_CIT
                        WHEN NULL THEN ' '
                        ELSE( SELECT NO_NOMB_MED 
                              FROM MEDICOS 
                              WHERE  CD_CODI_MED = CD_CODI_MED_EST_CIT )
                    END NOM_ESTUD  ,
                    NVL(CC.NU_NUME_CC, -1) CONFIRMACION ,-- Agregado

                    CITAS_MEDICAS.TX_CAUSA_INASISTENCIA ,
                    CX.USUARIO CAJERO  ,
                    --,ISNULL([NU_NUME_MIN_ESPL], 0) [NU_NUME_MIN_ESPL]
                    --,DATEDIFF(minute, GETDATE(), FE_FECH_CIT) dif 
                    --,FE_FECH_CIT f
                    ' ' NOM_ESTUD_ASIG  
                FROM CITAS_MEDICAS 
                INNER JOIN SERVICIOS    
                    ON CD_CODI_SER_CIT = CD_CODI_SER
                INNER JOIN ESPECIALIDADES    
                    ON CD_CODI_ESP = CD_CODI_ESP_CIT
                INNER JOIN CONEXIONES CX   
                    ON CX.NU_NUME_CONE = CITAS_MEDICAS.NU_NUME_CONE_CIT
                    --	INNER JOIN USUARIOS US ON US.ID_IDEN_USUA = CX.USUARIO
                LEFT JOIN CITAS_CONFIRMADAS CC   
                    ON CITAS_MEDICAS.NU_NUME_CIT = CC.NU_NUME_CIT
                LEFT JOIN ESPECIALIDAD_LIMITE    
                    ON CD_CODI_ESP_ESPL = CD_CODI_ESP
                WHERE --DATEDIFF (minute, GETDATE (), FE_FECH_CIT) >= ISNULL ([NU_NUME_MIN_ESPL], 0) -- comente y remplace por funcion de abajo
                FE_FECH_CIT >= (SYSDATE - TO_CHAR(SYSDATE,'HH') / 24) - TO_CHAR(SYSDATE,'MI') / 1440
                AND NU_HIST_PAC_CIT = NVL(v_NUMHIST, NU_HIST_PAC_CIT)
                AND FE_FECH_CIT >= SYSDATE ;       
        END;
    ELSE
   
        BEGIN
            -- MODIFICADO PARA COMPARAR TODAS LAS CITAS Y NO EXISTA DUPLICIDAD
            OPEN  cv_1 FOR
                SELECT CD_CODI_MED_CIT ,
                      CD_CODI_SER_CIT ,
                      NU_HIST_PAC_CIT ,
                      NU_DURA_CIT ,
                      FE_ELAB_CIT ,
                      FE_FECH_CIT ,
                      NU_DIA_CIT ,
                      TO_NUMBER(NU_NUME_MOVI_CIT) NU_NUME_MOVI_CIT  ,
                      TO_NUMBER(NU_PRIM_CIT) NU_PRIM_CIT  ,
                      FE_HORA_CIT ,
                      TO_NUMBER(NU_ESTA_CIT) NU_ESTA_CIT  ,
                      TO_NUMBER(NU_NUME_CONE_CIT) NU_NUME_CONE_CIT  ,
                      NU_CONE_CALL_CIT ,
                      CD_CODI_ESP_CIT ,
                      CD_CODI_CONS_CIT ,
                      TO_NUMBER(NU_NUME_CONV_CIT) NU_NUME_CONV_CIT  ,
                      TO_NUMBER(NU_TIPO_CIT) NU_TIPO_CIT  ,
                      DE_DESC_CIT ,
                      TO_NUMBER(CITAS_MEDICAS.NU_NUME_CIT) NU_NUME_CIT  ,
                      CD_MEDI_ORDE_CIT ,
                      TO_NUMBER(NU_CONFIR_CIT) NU_CONFIR_CIT  ,
                      NO_NOMB_SER ,
                      NO_NOMB_ESP ,
                      NU_OPCI_SER ,
                      NU_NIVE_SER ,
                      NU_ESGRUPAL_SER ,
                          CASE CD_CODI_MED_EST_CIT
                              WHEN NULL THEN ' '
                              ELSE( SELECT NO_NOMB_MED 
                                    FROM MEDICOS 
                                    WHERE  CD_CODI_MED = CD_CODI_MED_EST_CIT)
                         END NOM_ESTUD  ,
                      NVL(CC.NU_NUME_CC, -1) CONFIRMACION ,-- Agregado
                      CITAS_MEDICAS.TX_CAUSA_INASISTENCIA ,
                      CX.USUARIO CAJERO  ,
                      ' ' NOM_ESTUD_ASIG  
                      --,ISNULL([NU_NUME_MIN_ESPL], 0) [NU_NUME_MIN_ESPL]
                      --,DATEDIFF(minute, GETDATE(), FE_FECH_CIT) dif 

                 --,FE_FECH_CIT f
                FROM CITAS_MEDICAS 
                INNER JOIN SERVICIOS    
                    ON CD_CODI_SER_CIT = CD_CODI_SER
                INNER JOIN ESPECIALIDADES    
                    ON CD_CODI_ESP = CD_CODI_ESP_CIT
                INNER JOIN CONEXIONES CX   
                    ON CX.NU_NUME_CONE = CITAS_MEDICAS.NU_NUME_CONE_CIT
                LEFT JOIN CITAS_CONFIRMADAS CC   
                    ON CITAS_MEDICAS.NU_NUME_CIT = CC.NU_NUME_CIT
                LEFT JOIN ESPECIALIDAD_LIMITE    
                    ON CD_CODI_ESP_ESPL = CD_CODI_ESP
                WHERE --DATEDIFF (minute, GETDATE (), FE_FECH_CIT) >= ISNULL ([NU_NUME_MIN_ESPL], 0) -- comente y remplace por funcion de abajo
                 FE_FECH_CIT >= (SYSDATE - TO_CHAR(SYSDATE,'HH') / 24) - TO_CHAR(SYSDATE,'MI') / 1440
                   AND FE_FECH_CIT >= SYSDATE ;
         
        END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;