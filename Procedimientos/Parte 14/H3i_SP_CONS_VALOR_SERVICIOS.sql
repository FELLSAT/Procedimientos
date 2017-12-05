CREATE OR REPLACE PROCEDURE       H3i_SP_CONS_VALOR_SERVICIOS
(
  v_NU_CONVENIO IN NUMBER,
  v_COD_SERVICIO IN VARCHAR2,
  v_AMBITO_ATENCION IN NUMBER,
  v_TIPO_SERVICIO IN NUMBER,
  v_COD_ESPECIALIDAD IN VARCHAR2,
  v_COD_MEDICO IN VARCHAR2,
  v_COD_ANESTESIOLOGO IN VARCHAR2,
  v_COD_AYUDANTE IN VARCHAR2,
  v_COD_SALA IN VARCHAR2,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_CODTARIFABASE VARCHAR2(2);
   v_PORADS NVARCHAR2(10);
   v_TIPO_COBRO_POR NUMBER(3,0);
   v_PORCENTAJE_COBRO FLOAT(24);
   v_PorcRecargoAyDXUrgencias FLOAT(24);
   v_PorcRecargoAyDXHospitalizaci FLOAT(24);
   v_PORCENTAJE_INCREMENTO NUMBER(10,0);
   v_MED_ADSCRITO NUMBER(10,0);
   v_NU_CONVENIO_OBTENIDO NUMBER(10,0) := -1;
   v_temp TT_V_VALORSER_2%ROWTYPE;
   cv_ins SYS_REFCURSOR;

BEGIN

   DELETE FROM tt_tpm_3;
   SELECT CD_CODI_TARB_CONV ,
          CASE 
               WHEN ( nu_indi_med = 1
                 AND CD_PORADS_CONV = 1 ) THEN NU_PORADS_CONV
          ELSE '0' 

             END ,--MIRAR SI EL MEDICO ES ADSCRITO OPTENER EL PORCENTAJE  

          NU_FORM_CONV ,
          PR_COBR_CONV ,
          PR_LABO_CONV ,
          PR_LABHOS_CONV 

     INTO v_CODTARIFABASE,
          v_PORADS,
          v_TIPO_COBRO_POR,
          v_PORCENTAJE_COBRO,
          v_PorcRecargoAyDXUrgencias,
          v_PorcRecargoAyDXHospitalizaci
     FROM HIMS2.CONVENIOS ,
          HIMS2.MEDICOS 
    WHERE  NU_NUME_CONV = v_NU_CONVENIO
             AND CD_CODI_MED = v_COD_MEDICO AND ROWNUM <= 1;
   ------  
   cv_ins := H3i_SP_CONSULTA_VALORSERVICIO(v_COD_SERVICIO,
                                           v_CODTARIFABASE,
                                           v_NU_CONVENIO) ;
   LOOP
      FETCH cv_ins INTO v_temp;
      EXIT WHEN cv_ins%NOTFOUND;
      INSERT INTO tt_v_VALORSER_2 VALUES v_temp;
   END LOOP;
   CLOSE cv_ins;
   ------  
   IF ( ( SELECT COUNT(*)  
          FROM tt_v_VALORSER_2 
           WHERE  NU_NUME_CONV = v_NU_CONVENIO ) > 0 ) THEN
    
   BEGIN
      v_NU_CONVENIO_OBTENIDO := v_NU_CONVENIO ;
   
   END;
   END IF;
   INSERT INTO tt_tpm_4
     ( VALOR_SERVICIO, TIPO_LIQ_TARIFA, CD_CODI_ANO_TARB, VALOR_TARIFA, TIPO_TARIFARIO )
     ( SELECT CASE 
                   WHEN NU_TILI_RST = 1 THEN VL_VALO_RST * VL_BASE_TARB
              ELSE VL_VALO_RST
                 END col  ,
              NU_TILI_RST ,
              CD_CODI_ANO_TARB ,
              VL_VALO_RST ,
              NU_INLI_TARB 
       FROM tt_v_VALORSER_2 
        WHERE  CD_CODI_SER_RST = v_COD_SERVICIO
                 AND NU_NUME_CONV = v_NU_CONVENIO_OBTENIDO );
   ----------------  
   --SI EL MEDICO ES ADSCRITO  
   IF v_PORADS <> '0' THEN
    
   BEGIN
      UPDATE tt_tpm_3
         SET VALOR_SERVICIO = VALOR_SERVICIO + (VALOR_SERVICIO * UTILS.CONVERT_TO_FLOAT(v_PORADS,53)) / 100;
      ----------------  
      IF ( v_TIPO_COBRO_POR = 0 ) THEN
       
      BEGIN
         --Porcentaje de aumento  
         UPDATE tt_tpm_3
            SET VALOR_SERVICIO = VALOR_SERVICIO + (VALOR_SERVICIO * NVL(v_PORCENTAJE_COBRO, 0)) / 100;
      
      END;
      ELSE
      
      BEGIN
         --Porcentaje de decremento  
         UPDATE tt_tpm_3
            SET VALOR_SERVICIO = VALOR_SERVICIO - (VALOR_SERVICIO * NVL(v_PORCENTAJE_COBRO, 0)) / 100;
      
      END;
      END IF;
   
   END;
   END IF;
   ------------------------------------------------------------------------------------------------  
   -- VERIFICAR SI EXISTE UN PORCENTAJE DE INCREMENTO PARA LA ESPECIALIDAD QUE LLEGA POR PARAMETRO  
   ------------------------------------------------------------------------------------------------  
   IF ( SELECT COUNT(*)  
        FROM RINC_CONV_ESP 
         WHERE  NU_NUME_CONV_RCE = v_NU_CONVENIO
                  AND CD_CODI_ESP_RCE = v_COD_ESPECIALIDAD ) > 0 THEN
    DECLARE
      v_HORASNOCT VARCHAR2(100);
      v_HI NUMBER(10,0);
      v_HF NUMBER(10,0);
      v_HA NUMBER(10,0);
      v_NU_PRNN_RCE NUMBER(10,0);
      v_NU_PRFD_RCE NUMBER(10,0);
      v_NU_PRFN_RCE NUMBER(10,0);
   
   BEGIN
      v_HORASNOCT := ' ' ;
      SELECT VL_VALO_CONT 

        INTO v_HORASNOCT
        FROM HIMS2.CONTROL 
       WHERE  CD_CONC_CONT = 'HORASNOCT';
      ----------  
      SELECT NU_PRNN_RCE ,
             NU_PRFD_RCE ,
             NU_PRFN_RCE 

        INTO v_NU_PRNN_RCE,
             v_NU_PRFD_RCE,
             v_NU_PRFN_RCE
        FROM RINC_CONV_ESP 
       WHERE  NU_NUME_CONV_RCE = v_NU_CONVENIO
                AND CD_CODI_ESP_RCE = v_COD_ESPECIALIDAD AND ROWNUM <= 1;
      ----------  
      IF ( v_HORASNOCT <> '0'
        AND v_HORASNOCT <> ' '
        AND v_HORASNOCT IS NOT NULL ) THEN
       DECLARE
         v_temp NUMBER(1, 0) := 0;
      
      BEGIN
         v_HORASNOCT := LTRIM(RTRIM(v_HORASNOCT)) ;
         v_HI := UTILS.CONVERT_TO_NUMBER(SUBSTR(v_HORASNOCT, 1, 2),10,0) ;
         v_HA := utils.datepart('HOUR', SYSDATE) ;
         v_HF := CASE 
                      WHEN v_HA = 0 THEN 24
         ELSE UTILS.CONVERT_TO_NUMBER(SUBSTR(v_HORASNOCT, 4, 5),10,0)
            END ;
         BEGIN
            SELECT 1 INTO v_temp
              FROM DUAL
             WHERE ( ( SELECT COUNT(*)  
                       FROM HIMS2.CALENDARIO 
                        WHERE  utils.datepart('YEAR', FE_FECH_CALE) = utils.datepart('YEAR', SYSDATE)
                                 AND utils.datepart('MONTH', FE_FECH_CALE) = utils.datepart('MONTH', SYSDATE)
                                 AND utils.datepart('DAY', FE_FECH_CALE) = utils.datepart('DAY', SYSDATE) ) > 0 );
         EXCEPTION
            WHEN OTHERS THEN
               NULL;
         END;
            
         IF v_temp = 1 THEN
          
         BEGIN
            v_PORCENTAJE_INCREMENTO := v_NU_PRNN_RCE ;
            IF v_HI < v_HF THEN
             
            BEGIN
               v_PORCENTAJE_INCREMENTO := v_NU_PRFD_RCE ;
               IF v_HA >= v_HI
                 AND v_HA < v_HF THEN
                
               BEGIN
                  v_PORCENTAJE_INCREMENTO := v_NU_PRFN_RCE ;
               
               END;
               END IF;
            
            END;
            ELSE
            
            BEGIN
               v_PORCENTAJE_INCREMENTO := v_NU_PRFD_RCE ;
               IF v_HA >= v_HI
                 OR v_HA < v_HF THEN
                
               BEGIN
                  v_PORCENTAJE_INCREMENTO := v_NU_PRFN_RCE ;
               
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
   ----------------  
   IF ( v_PORCENTAJE_INCREMENTO > 0 ) THEN
    
   BEGIN
      UPDATE tt_tpm_3
         SET VALOR_SERVICIO = VALOR_SERVICIO + (VALOR_SERVICIO * v_PORCENTAJE_INCREMENTO) / 100;
   
   END;
   END IF;
   ----------------  
   --SI EL TIPO DE SERVICIO ES UN APOYO DX.  
   IF ( v_TIPO_SERVICIO = 2 ) THEN
    
   BEGIN
      --SI EL AMBITO DE ATENCION ES UNA URGENCIA  
      IF ( v_AMBITO_ATENCION = 3 ) THEN
       
      BEGIN
         UPDATE tt_tpm_3
            SET VALOR_SERVICIO = VALOR_SERVICIO + (VALOR_SERVICIO * v_PorcRecargoAyDXUrgencias) / 100
          WHERE  TIPO_LIQ_TARIFA IN ( 0,1 )
         ;-- TLiquTar_Valor = 0, TLiquTar_Unidades = 1  
      
      END;
      END IF;
      --SI EL AMBITO DE ATENCION ES HOSPITALIZACION  
      IF ( v_AMBITO_ATENCION = 2 ) THEN
       
      BEGIN
         UPDATE tt_tpm_3
            SET VALOR_SERVICIO = VALOR_SERVICIO + (VALOR_SERVICIO * v_PorcRecargoAyDXHospitalizaci) / 100
          WHERE  TIPO_LIQ_TARIFA IN ( 0,1 )
         ;-- TLiquTar_Valor = 0, TLiquTar_Unidades = 1  
      
      END;
      END IF;
   
   END;
   END IF;
   ----------------  
   --SI EL TIPO DE SERVICIO ES PROCEDIMIENTO QUIRURGICO  
   IF ( v_TIPO_SERVICIO = 3 ) THEN
    DECLARE
      v_VALOR FLOAT(53);
      v_VALORUVR FLOAT(53);
   
   BEGIN
      v_VALOR := 0 ;
      --------------------------------------------------------  
      --SI EL TARIFARIO ES ISS  
      --------------------------------------------------------  
      DELETE FROM tt_valoresHono_2;
      UTILS.IDENTITY_RESET('tt_valoresHono_2');
      
      INSERT INTO tt_valoresHono_2 ( 
      	SELECT U.CD_CODI_UVRP ,
              U.VL_UNID_UVRP 
      	  FROM HIMS2.UVRP U
                JOIN tt_tpm_3 T   ON U.CD_CODI_ANO_UVRP = T.CD_CODI_ANO_TARB
      	 WHERE  TIPO_TARIFARIO = 0 );
      --PORCENTAJE POR AUMENTO  
      IF ( v_TIPO_COBRO_POR = 0 ) THEN
       
      BEGIN
         -----------  
         --medico general o ciurujano  
         SELECT VL_UNID_UVRP 

           INTO v_VALORUVR
           FROM tt_valoresHono_2 
          WHERE  CD_CODI_UVRP = (CASE 
                                      WHEN v_COD_ESPECIALIDAD = ( SELECT VL_VALO_CONT 
                                                                  FROM HIMS2.CONTROL 
                                                                   WHERE  CD_CONC_CONT = 'CODMEDG' ) THEN '39145'
                 ELSE '39101'
                    END);
         UPDATE tt_tpm_3
            SET ValorHonorariosCirujano = VALOR_TARIFA * v_VALORUVR + (VALOR_TARIFA * v_VALORUVR * NVL(v_PORCENTAJE_COBRO, 0)) / 100
          WHERE  TIPO_TARIFARIO = 0;
         -----------  
         --medico anestesiologo  
         SELECT VL_UNID_UVRP 

           INTO v_VALORUVR
           FROM tt_valoresHono_2 
          WHERE  CD_CODI_UVRP = '39102';
         UPDATE tt_tpm_3
            SET valorHonorariosAnestesiologo = VALOR_TARIFA * v_VALORUVR + (VALOR_TARIFA * v_VALORUVR * NVL(v_PORCENTAJE_COBRO, 0)) / 100
          WHERE  TIPO_TARIFARIO = 0;
         -----------  
         --medico ayudante  
         SELECT VL_UNID_UVRP 

           INTO v_VALORUVR
           FROM tt_valoresHono_2 
          WHERE  CD_CODI_UVRP = '39103';
         UPDATE tt_tpm_3
            SET ValorHonorariosAyudante = VALOR_TARIFA * v_VALORUVR + (VALOR_TARIFA * v_VALORUVR * NVL(v_PORCENTAJE_COBRO, 0)) / 100
          WHERE  TIPO_TARIFARIO = 0;
         -----------  
         --honorarios de sala SI ES MAYOR A 450 UVR  
         SELECT NVL(NU_VAMU_TARB, 0) 

           INTO v_VALOR
           FROM HIMS2.TARIFA_BASE 
          WHERE  CD_CODI_TARB = v_CODTARIFABASE;
         UPDATE tt_tpm_3
            SET ValorDerechosDeSala = CASE 
                                           WHEN v_VALOR > 0 THEN (VALOR_TARIFA * v_VALOR) + (VALOR_TARIFA * v_VALOR * NVL(v_PORCENTAJE_COBRO, 0)) / 100
                ELSE (VALOR_TARIFA * 1410) + (VALOR_TARIFA * 1410 * NVL(v_PORCENTAJE_COBRO, 0)) / 100
                   END
          WHERE  VALOR_TARIFA > 450
           AND TIPO_TARIFARIO = 0;
         -----------  
         --honorarios de sala SI ES MENOR O IGUAL A 450 UVR  
         MERGE INTO tt_tpm_3 t
         USING (SELECT t.ROWID row_id, (x.VL_VALO_UVRS + (x.VL_VALO_UVRS * NVL(v_PORCENTAJE_COBRO, 0)) / 100) AS ValorDerechosDeSala
         FROM tt_tpm_3 t
                JOIN ( SELECT NVL(U.VL_VALO_UVRS, 0) VL_VALO_UVRS  ,
                              T.CD_CODI_ANO_TARB 
                       FROM HIMS2.UVRS U
                              JOIN HIMS2.SALAS S   ON U.NU_TIPO_UVRS = S.NU_TIPO_SALA
                              JOIN tt_tpm_3 T   ON T.CD_CODI_ANO_TARB = U.CD_CODI_ANO_UVRS
                              AND U.NU_UNIN_UVRS <= T.VALOR_TARIFA
                              AND U.NU_UNFI_UVRS >= T.VALOR_TARIFA
                        WHERE  S.CD_CODI_SALA = v_COD_SALA AND ROWNUM <= 1
                         GROUP BY U.VL_VALO_UVRS,T.CD_CODI_ANO_TARB ) x   ON t.CD_CODI_ANO_TARB = x.CD_CODI_ANO_TARB 
          WHERE t.VALOR_TARIFA <= 450
           AND t.TIPO_TARIFARIO = 0) src
         ON ( t.ROWID = src.row_id )
         WHEN MATCHED THEN UPDATE SET t.ValorDerechosDeSala = src.ValorDerechosDeSala;
         --------------  
         -- Liquidacion de materiañes  
         MERGE INTO tt_tpm_3 t
         USING (SELECT t.ROWID row_id, X.VL_VALO_UVRM + (X.VL_VALO_UVRM * NVL(v_PORCENTAJE_COBRO, 0)) / 100 AS ValorMaterialesSutura
         FROM tt_tpm_3 t
                JOIN ( SELECT NVL(M.VL_VALO_UVRM, 0) VL_VALO_UVRM  ,
                              T.CD_CODI_ANO_TARB 
                       FROM HIMS2.UVRM M
                              JOIN HIMS2.SALAS S   ON S.NU_TIPO_SALA = M.NU_TIPO_SALA_UVRM
                              AND M.NU_TILI_UVRM = 0
                              JOIN tt_tpm_3 T   ON T.CD_CODI_ANO_TARB = M.CD_CODI_ANO_UVRM
                              AND M.NU_UNIN_UVRM <= T.VALOR_TARIFA
                              AND M.NU_UNFI_UVRM >= T.VALOR_TARIFA
                        WHERE  S.CD_CODI_SALA = v_COD_SALA AND ROWNUM <= 1
                         GROUP BY M.VL_VALO_UVRM,T.CD_CODI_ANO_TARB ) X   ON X.CD_CODI_ANO_TARB = t.CD_CODI_ANO_TARB 
          WHERE t.VALOR_TARIFA <= 450
           AND t.TIPO_TARIFARIO = 0) src
         ON ( t.ROWID = src.row_id )
         WHEN MATCHED THEN UPDATE SET t.ValorMaterialesSutura = src.ValorMaterialesSutura;
      
      END;
      END IF;
   
   END;
   END IF;
   OPEN  cv_1 FOR
      SELECT * 
        FROM tt_tpm_3  ;

EXCEPTION WHEN OTHERS THEN utils.handleerror(SQLCODE,SQLERRM);
END;