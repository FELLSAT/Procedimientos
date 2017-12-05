CREATE OR REPLACE PROCEDURE SP_CITAS_MAS_PROXIMASMIHIMS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_PNUMCONEX IN NUMBER,
    v_PINTERVALO IN NUMBER,
    v_PMEDICO IN VARCHAR2,
    v_PESPECIALIDAD IN VARCHAR2,
    v_PCANTTURNOS IN NUMBER,
    v_FECHACITA IN DATE,
    v_LUAT IN VARCHAR2 DEFAULT '%%' ,
    v_CODSER IN VARCHAR2 DEFAULT NULL ,
    v_CODTIPOSERV IN NUMBER DEFAULT 0 
)
AS
    v_FECHAHORAACT DATE;
    v_CODMEDICO VARCHAR2(10);
    v_FECHACITADISP DATE;
    v_HORAINICITADISP DATE;
    v_HORAFINCITADISP DATE;
    v_MINUTOSCONSULTA NUMBER(10,0);
    v_NOMBREMEDICO VARCHAR2(50);
    v_CONSULTORIO VARCHAR2(30);
    v_HORA DATE;
    v_HORAFINAL DATE;
    v_MEDICOANT VARCHAR2(10);
    v_CTTUR NUMBER(10,0);
    v_INSERTAR NUMBER(1,0);
    v_COD_ESTUDIANTE VARCHAR2(30);
    v_NOMB_ESTUDIANTE VARCHAR2(255);
    v_IDHORARIOACADEMICO NUMBER;
    v_TIPO_AGENDA_MEDICO NUMBER(10,0);
    v_NUMERO_TURNO NUMBER(10,0);
   
    CURSOR TURNOSMEDICO IS 
            SELECT 
                NU_AUTO_TIPO_TUME_TUME ,
                CD_MED_CIDI ,
                FE_FECH_CIDI ,
                FE_HOIN_CIDI ,
                FE_HOFI_CIDI ,
                CASE v_PINTERVALO
                    WHEN 0 THEN 
                      ( CASE NVL(NU_MICO_MED, 0)
                            WHEN 0 THEN NU_TIEMCIT_TUME
                            ELSE NU_MICO_MED
                        END)
                    ELSE v_PINTERVALO
                END NU_MICO_MED,
                NO_NOMB_MED ,
                CD_CODI_CONS ,
                R_TUR_ESC.CD_CODI_MED_RTE COD_ESTUDIANTE  ,
                NOM_ESTUDIANTE NOMBRE_ESTUDIANTE  ,
                TURNOS_MEDICOS.NU_AUTO_HOGR_TUME ID_HORARIO  ,
                TURNOS_MEDICOS.NU_NUME_TUME 
            FROM CITAS_DISPONIBLES 
            INNER JOIN TURNOS_MEDICOS    
                ON NU_TUME_CIDI = NU_NUME_TUME
            INNER JOIN R_TUR_ESC    
                ON NU_AUTO_RTE = NU_AUTO_RTE_CIDI
            INNER JOIN( SELECT CD_CODI_MED COD_EST  ,
                                NO_NOMB_MED NOM_ESTUDIANTE  
                        FROM MEDICOS  ) ESTUDIANTES   
                ON R_TUR_ESC.CD_CODI_MED_RTE = ESTUDIANTES.COD_EST
            INNER JOIN CONSULTORIOS    
                ON CD_CODI_CONS_RTE = CD_CODI_CONS
            INNER JOIN MEDICOS    
                ON CD_MED_TUME = CD_CODI_MED
                AND CD_MED_CIDI = CD_CODI_MED
            INNER JOIN R_MEDI_ESPE    
                ON CD_CODI_MED = CD_CODI_MED_RMP
            INNER JOIN HORARIO_GRUPO    
                ON NU_AUTO_HOGR_TUME = NU_AUTO_HOGR
            INNER JOIN GRUPO_ASIGNATURA_PERIODO    
                ON NU_AUTO_GRAP_HOGR = NU_AUTO_GRAP
            INNER JOIN ASIGNATURA    
                ON TX_CODIGO_ASIG_GRAP = TX_CODIGO_ASIG
            WHERE  Calcular_Fecha(FE_FECH_CIDI, FE_HOFI_CIDI) >= v_FECHAHORAACT
                AND FE_FECH_CIDI < TO_DATE(TO_CHAR(ADD_MONTHS(v_FECHAHORAACT,1),'DD/MM/YYYY'))
                AND NU_DURA_CIDI >= CASE v_PINTERVALO
                                        WHEN 0 THEN 
                                            (CASE NVL(NU_MICO_MED, 0)
                                                WHEN 0 THEN NU_TIEMCIT_TUME
                                                ELSE NU_MICO_MED
                                            END)
                                        ELSE v_PINTERVALO
                                    END
                AND ID_DISP_TUME = '1'
                AND CD_CODI_ESP_RMP = v_PESPECIALIDAD
                AND CD_MED_CIDI = CASE 
                                      WHEN v_PMEDICO <> ' ' OR v_PMEDICO <> ' ' 
                                          THEN v_PMEDICO
                                      ELSE CD_MED_CIDI
                                  END
                AND CD_CODI_LUAT_CONS LIKE v_LUAT
                AND CD_MED_CIDI IN( SELECT CD_CODI_MED 
                                    FROM MEDICOS 
                                    WHERE  MEDICOS.PERM_CITA_WEB = 1 )
                AND ((FE_FECH_CIDI - TO_CHAR(SYSDATE,'HH') / 24) -  TO_CHAR(FE_FECH_CIDI,'MI') / 1440) 
                    NOT IN (SELECT ((FE_FECH_CALE - TO_CHAR(SYSDATE,'HH') / 24) -  TO_CHAR(FE_FECH_CALE,'MI') / 1440) FROM CALENDARIO)
                AND ( 1 = FiltroServTurno(CD_MED_CIDI, v_CODSER, v_PESPECIALIDAD, FE_HOIN_TUME, FE_HOFI_TUME) )
                AND FE_FECH_TUME NOT IN ( SELECT FE_FECH_CALE 
                                          FROM CALENDARIO)
                AND NVL(CD_CODI_ESPE_ASIG, ' ') = (CASE 
                                                      WHEN NU_CON_ESPECI = 1 
                                                          THEN v_PESPECIALIDAD
                                                      ELSE NVL(CD_CODI_ESPE_ASIG, ' ')
                                                  END)
        UNION ALL 

            SELECT NU_AUTO_TIPO_TUME_TUME ,
                CD_MED_CIDI ,
                FE_FECH_CIDI ,
                FE_HOIN_CIDI ,
                FE_HOFI_CIDI ,
                CASE v_PINTERVALO
                    WHEN 0 THEN (
                        CASE NVL(NU_MICO_MED, 0)
                            WHEN 0 THEN 
                                NU_TIEMCIT_TUME
                            ELSE NU_MICO_MED
                        END)
                    ELSE v_PINTERVALO
                END NU_MICO_MED,
                NO_NOMB_MED ,
                CD_CODI_CONS_TUME ,
                NULL COD_ESTUDIANTE  ,
                NULL NOMBRE_ESTUDIANTE  ,
                0 ID_HORARIO  ,
                TURNOS_MEDICOS.NU_NUME_TUME 
            FROM CITAS_DISPONIBLES 
            INNER JOIN TURNOS_MEDICOS    
                ON NU_TUME_CIDI = NU_NUME_TUME
            INNER JOIN CONSULTORIOS    
                ON CD_CODI_CONS_TUME = CD_CODI_CONS
            INNER JOIN MEDICOS    
                ON CD_MED_TUME = CD_CODI_MED
                AND CD_MED_CIDI = CD_CODI_MED
            INNER JOIN R_MEDI_ESPE    
                ON CD_CODI_MED = CD_CODI_MED_RMP
            WHERE  Calcular_Fecha(FE_FECH_CIDI, FE_HOFI_CIDI) >= v_FECHAHORAACT
                AND FE_FECH_CIDI < TO_DATE(TO_CHAR(ADD_MONTHS(v_FECHAHORAACT,1),'DD/MM/YYYY'))
                AND NU_DURA_CIDI >= CASE v_PINTERVALO
                                        WHEN 0 THEN(
                                            CASE NVL(NU_MICO_MED, 0)
                                                WHEN 0 THEN 
                                                    NU_TIEMCIT_TUME
                                                ELSE NU_MICO_MED
                                            END)
                                        ELSE v_PINTERVALO
                                    END
                AND ID_DISP_TUME = '1'
                AND CD_CODI_ESP_RMP = v_PESPECIALIDAD
                AND CD_MED_CIDI = CASE 
                                      WHEN v_PMEDICO <> ' '
                                      OR v_PMEDICO <> ' ' THEN 
                                          v_PMEDICO
                                      ELSE CD_MED_CIDI
                                  END
                AND CD_CODI_LUAT_CONS LIKE v_LUAT
                AND CD_MED_CIDI IN( SELECT CD_CODI_MED 
                                    FROM MEDICOS 
                                    WHERE  MEDICOS.PERM_CITA_WEB = 1 )
                AND ((FE_FECH_CIDI - TO_CHAR(SYSDATE,'HH') / 24) -  TO_CHAR(FE_FECH_CIDI,'MI') / 1440) 
                    NOT IN ( SELECT ((FE_FECH_CALE - TO_CHAR(SYSDATE,'HH') / 24) -  TO_CHAR(FE_FECH_CALE,'MI') / 1440)  FROM CALENDARIO)
                AND ( 1 = FiltroServTurno(CD_MED_CIDI, v_CODSER, v_PESPECIALIDAD, FE_HOIN_TUME, FE_HOFI_TUME) )
                AND TURNOS_MEDICOS.NU_NUME_TUME 
                    NOT IN( SELECT TURNOS_MEDICOS.NU_NUME_TUME 
                            FROM CITAS_DISPONIBLES 
                            INNER JOIN TURNOS_MEDICOS    
                                ON NU_TUME_CIDI = NU_NUME_TUME
                            INNER JOIN R_TUR_ESC    
                                ON NU_AUTO_RTE = NU_AUTO_RTE_CIDI
                            INNER JOIN( SELECT CD_CODI_MED COD_EST  ,
                                            NO_NOMB_MED NOM_ESTUDIANTE  
                                        FROM MEDICOS) ESTUDIANTES   
                                ON R_TUR_ESC.CD_CODI_MED_RTE = ESTUDIANTES.COD_EST
                            INNER JOIN CONSULTORIOS    
                                ON CD_CODI_CONS_RTE = CD_CODI_CONS
                            INNER JOIN MEDICOS    
                                ON CD_MED_TUME = CD_CODI_MED
                                AND CD_MED_CIDI = CD_CODI_MED
                            INNER JOIN R_MEDI_ESPE    
                                ON CD_CODI_MED = CD_CODI_MED_RMP
                            WHERE  Calcular_Fecha(FE_FECH_CIDI, FE_HOFI_CIDI) >= v_FECHAHORAACT
                                AND FE_FECH_CIDI < TO_DATE(TO_CHAR(ADD_MONTHS(v_FECHAHORAACT,1),'DD/MM/YYYY'))
                                AND NU_DURA_CIDI >= CASE v_PINTERVALO
                                                        WHEN 0 THEN (
                                                            CASE NVL(NU_MICO_MED, 0)
                                                                WHEN 0 THEN 
                                                                    NU_TIEMCIT_TUME
                                                                ELSE NU_MICO_MED
                                                            END)
                                                        ELSE v_PINTERVALO
                                                    END
                                AND ID_DISP_TUME = '1'
                                AND CD_CODI_ESP_RMP = v_PESPECIALIDAD
                                AND CD_MED_CIDI = CASE 
                                                      WHEN v_PMEDICO <> ' '
                                                      OR v_PMEDICO <> ' ' THEN 
                                                          v_PMEDICO
                                                      ELSE CD_MED_CIDI
                                                  END
                                AND CD_CODI_LUAT_CONS LIKE v_LUAT
                                AND FE_FECH_CIDI NOT IN(  SELECT FE_FECH_CALE 
                                                          FROM CALENDARIO 
                                                          WHERE  NU_TIPO_CALE = 0
                                                          AND FE_FECH_CALE = FE_FECH_CIDI )
                                AND ( 1 = FiltroServTurno(CD_MED_CIDI, v_CODSER, v_PESPECIALIDAD, FE_HOIN_TUME, FE_HOFI_TUME)))
                                AND FE_FECH_TUME NOT IN ( SELECT FE_FECH_CALE 
                                                          FROM CALENDARIO )
                            ORDER BY FE_FECH_CIDI, FE_HOIN_CIDI;
BEGIN

    IF v_FECHACITA <> NULL
      OR v_FECHACITA <> ' ' THEN
    
        BEGIN
            v_FECHAHORAACT := TO_DATE(TO_CHAR(v_FECHACITA,'YYYY-MM-DD HH24:MI:SS')) ;   
        END;
    ELSE
   
        BEGIN
            v_FECHAHORAACT := TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')) ;    
        END;
    END IF;
   -- Aumentando para cuando se tiene ESPECIALIDAD asignada a ASIGNATURA
   -- Aumentamos filtro para solo consultar de profesionales que si permitan citaWeb
   -- Filtrando que no devuelva resultados de días que no sean laborales.
   -- Filtrando que no devuelva resultados de días que no sean laborales.
   -- Condicion para cuando se tiene ESPECIALIDAD asignada a ASIGNATURA
   -- Aumentamos filtro para solo consultar de profesionales que si permitan citaWeb
   -- Filtrando que no devuelva resultados de días que no sean laborales.
   -- Mejora para agendas academicas y carga de citas, para que solo cargue o busque en caso de no encontrar en agendas academicas
   -- Filtrando que no devuelva resultados de días que no sean laborales.
    DELETE TMP_CITASMASPROXIMAS
    WHERE  NU_NUME_CONE_CIPR = v_PNUMCONEX;


    v_CTTUR := 0 ;

    OPEN TURNOSMEDICO;
        FETCH TURNOSMEDICO 
        INTO  v_TIPO_AGENDA_MEDICO,v_CODMEDICO,
              v_FECHACITADISP,v_HORAINICITADISP,
              v_HORAFINCITADISP,v_MINUTOSCONSULTA,
              v_NOMBREMEDICO,v_CONSULTORIO,
              v_COD_ESTUDIANTE,v_NOMB_ESTUDIANTE,
              v_IDHORARIOACADEMICO,v_NUMERO_TURNO;

    
    LOOP       
        BEGIN
            v_HORA := v_HORAINICITADISP ;
            DBMS_OUTPUT.PUT_LINE(v_HORA);
            DBMS_OUTPUT.PUT_LINE(v_HORAINICITADISP);
            DBMS_OUTPUT.PUT_LINE(v_HORAFINCITADISP);

            WHILE v_HORA < v_HORAFINCITADISP 
            LOOP             
                BEGIN
                    v_INSERTAR := 0 ;
                    v_HORAFINAL := v_HORA + v_MINUTOSCONSULTA / 1440;

                    IF v_HORAFINAL <= v_HORAFINCITADISP THEN
                
                        BEGIN
                            DBMS_OUTPUT.PUT_LINE(ADD_MONTHS(ADD_MONTHS(v_HORA,12*(TO_NUMBER(TO_CHAR(v_FECHACITADISP,'YYYY'))-1900)),TO_CHAR(v_FECHACITADISP,'MM')-1) + (TO_CHAR(v_FECHACITADISP,'DD') - 1));
                            DBMS_OUTPUT.PUT_LINE(ADD_MONTHS(ADD_MONTHS(v_HORAFINAL,12*(TO_NUMBER(TO_CHAR(v_FECHACITADISP,'YYYY'))-1900)),TO_CHAR(v_FECHACITADISP,'MM')-1) + (TO_CHAR(v_FECHACITADISP,'DD') - 1));

                            IF ( v_FECHAHORAACT = v_FECHACITADISP ) THEN
                   
                                BEGIN
                                    IF (v_FECHACITADISP || v_HORA) >= v_FECHACITA THEN
                                        v_INSERTAR := 1 ;
                                    ELSE
                                        v_INSERTAR := 0 ;
                                    END IF;                                    
                                END;

                            ELSE                     
                                v_INSERTAR := 1 ;
                            END IF;


                            IF v_INSERTAR = 1 THEN
                           
                                  BEGIN
                                      IF (ADD_MONTHS( ADD_MONTHS(v_HORA,12*(TO_NUMBER(TO_CHAR(v_FECHACITADISP,'YYYY'))-1900)),
                                                      TO_CHAR(v_FECHACITADISP,'MM')-1) + (TO_CHAR(v_FECHACITADISP,'DD') - 1) >= SYSDATE ) THEN
                              
                                          BEGIN
                                              v_CTTUR := v_CTTUR + 1 ;
                                              --PRINT @CTTUR   

                                              INSERT INTO TMP_CITASMASPROXIMAS( 
                                                  TX_CODI_MEDI_CIPR, TX_NOMB_MEDI_CIPR, 
                                                  FE_HOIN_CIPR, FE_HOFI_CIPR, 
                                                  NU_NUME_CONE_CIPR, CD_CODI_CONS_CIPR, 
                                                  COD_ESTUDIANTE, NOMB_ESTUDIANTE, 
                                                  ID_HORACAD, TIPO_AGENDA_MEDICO )
                                              VALUES ( 
                                                  v_CODMEDICO, v_NOMBREMEDICO, 
                                                  ADD_MONTHS(ADD_MONTHS(v_HORA,12*(TO_NUMBER(TO_CHAR(v_FECHACITADISP,'YYYY'))-1900)),TO_CHAR(v_FECHACITADISP,'MM')-1) + (TO_CHAR(v_FECHACITADISP,'DD') - 1),
                                                  ADD_MONTHS(ADD_MONTHS(v_HORAFINAL,12*(TO_NUMBER(TO_CHAR(v_FECHACITADISP,'YYYY'))-1900)),TO_CHAR(v_FECHACITADISP,'MM')-1) + (TO_CHAR(v_FECHACITADISP,'DD') - 1),
                                                  v_PNUMCONEX, v_CONSULTORIO, 
                                                  v_COD_ESTUDIANTE, v_NOMB_ESTUDIANTE, 
                                                  v_IDHORARIOACADEMICO, v_TIPO_AGENDA_MEDICO );                     
                                          END;

                                      END IF;
                          
                                  END;

                            END IF;
               
                         END;
                    END IF;

                    v_HORA := v_HORAFINAL ;

                    IF v_CTTUR >= v_PCANTTURNOS THEN
                        EXIT;
                    END IF;
            
                END;
            END LOOP;

            IF v_CTTUR >= v_PCANTTURNOS THEN
                EXIT;
            END IF;

            FETCH TURNOSMEDICO 
            INTO v_TIPO_AGENDA_MEDICO,v_CODMEDICO,
              v_FECHACITADISP,v_HORAINICITADISP,
              v_HORAFINCITADISP,v_MINUTOSCONSULTA,
              v_NOMBREMEDICO,v_CONSULTORIO,
              v_COD_ESTUDIANTE,v_NOMB_ESTUDIANTE,
              v_IDHORARIOACADEMICO,v_NUMERO_TURNO;

            EXIT WHEN TURNOSMEDICO%NOTFOUND;
      
        END;
    END LOOP;

    CLOSE TURNOSMEDICO;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;