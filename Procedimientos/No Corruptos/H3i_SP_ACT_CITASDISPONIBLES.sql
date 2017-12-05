CREATE OR REPLACE PROCEDURE HIMS.H3i_SP_ACT_CITASDISPONIBLES
-- =============================================      
-- Author:  Carlos Castro Agudelo
-- =============================================  
(V_NUMTURNO IN NUMERIC)
IS
    V_CODMEDICO VARCHAR2(20);
    V_FECHA DATE;
    V_HORAINICIO TIMESTAMP;
    V_HORAFIN TIMESTAMP;
    V_FECHAHORAINICIO DATE;
    V_FECHAHORAFIN DATE;
    V_IDHORACADEMICO NUMBER;
    V_IDRELACION NUMBER;
    V_CODESTUDIANTE VARCHAR2(20);
    V_CODCONSULTORIO VARCHAR2(20);
    V_CITA NUMBER;
    V_FECHACITA DATE;
    V_FECHAFINAL DATE;
    V_DURACIONCITA NUMBER;
    V_HORAFINALCD TIMESTAMP;
    V_HORAINICIALCD TIMESTAMP;
    V_TEMP NUMBER(1) := 0;
    
    CURSOR crCITAS IS
    SELECT NU_NUME_CIT, FE_FECH_CIT, NU_DURA_CIT, FETERMINA FROM TT_TMPCITA ORDER BY FE_FECH_CIT;     
BEGIN
    SELECT CD_MED_TUME, FE_FECH_TUME, FE_HOIN_TUME, FE_HOFI_TUME, FE_HOIN_TUME, FE_HOFI_TUME, NU_AUTO_HOGR_TUME INTO V_CODMEDICO, V_FECHA, V_HORAINICIO, V_HORAFIN, V_FECHAHORAINICIO, V_FECHAHORAFIN, V_IDHORACADEMICO
    FROM TURNOS_MEDICOS T WHERE NU_NUME_TUME= V_NUMTURNO;

    DELETE FROM CITAS_DISPONIBLES WHERE NU_TUME_CIDI = V_NUMTURNO;

    IF  (V_IDHORACADEMICO) = 0 THEN
        BEGIN
            SELECT CD_CODI_MED_RTE, CD_CODI_CONS_RTE INTO V_CODESTUDIANTE, V_CODCONSULTORIO FROM R_TUR_ESC WHERE NU_NUME_TUME_RTE = V_NUMTURNO AND NU_AUTO_RTE = V_IDRELACION;

            INSERT INTO TT_TMPCITA (NU_NUME_CIT, FE_FECH_CIT, NU_DURA_CIT, FETERMINA)
            (SELECT NU_NUME_CIT, FE_FECH_CIT, NU_DURA_CIT, (FE_FECH_CIT + NU_DURA_CIT) FETERMINA FROM CITAS_MEDICAS WHERE CD_CODI_MED_CIT = V_CODMEDICO AND  FE_FECH_CIT BETWEEN V_FECHAHORAINICIO AND V_FECHAHORAFIN);
            
            SELECT COUNT(*) INTO V_TEMP FROM TT_TMPCITA;

            IF V_TEMP > 0 THEN          
                BEGIN
                    OPEN CrCITAS;
                    FETCH crCITAS
                    INTO V_CITA, V_FECHACITA, V_DURACIONCITA, V_FECHAFINAL;

                    V_HORAINICIALCD := V_HORAINICIO;
                    
                    LOOP
                    EXIT WHEN crCITAS%NOTFOUND;
                        BEGIN
                            V_HORAFINALCD := V_FECHACITA;
                            IF (EXTRACT(MINUTE FROM V_HORAINICIALCD) - EXTRACT(MINUTE FROM V_HORAFINALCD)) >0 THEN
                                BEGIN
                                    INSERT INTO CITAS_DISPONIBLES (NU_TUME_CIDI, CD_MED_CIDI, FE_FECH_CIDI, FE_HOIN_CIDI, FE_HOFI_CIDI, NU_DURA_CIDI, NU_AUTO_RTE_CIDI)
                                    VALUES(V_NUMTURNO, V_CODMEDICO, V_FECHA, V_HORAINICIALCD, V_HORAFINALCD, (EXTRACT(MINUTE FROM V_HORAINICIALCD) - EXTRACT(MINUTE FROM V_HORAFINALCD)), 0);
                                END;
                            END IF;                    
                            V_HORAINICIALCD := V_FECHAFINAL;
                            FETCH crCITAS INTO V_CITA, V_FECHACITA, V_DURACIONCITA, V_FECHAFINAL;
                        END;
                    END LOOP;                    

                    CLOSE crCITAS;
                                    
                    IF V_HORAINICIALCD < V_HORAFIN THEN
                        BEGIN
                            INSERT INTO CITAS_DISPONIBLES (NU_TUME_CIDI, CD_MED_CIDI, FE_FECH_CIDI, FE_HOIN_CIDI, FE_HOFI_CIDI, NU_DURA_CIDI, NU_AUTO_RTE_CIDI)
                            VALUES(V_NUMTURNO, V_CODMEDICO, V_FECHA, V_HORAINICIALCD, V_HORAFIN, (EXTRACT(MINUTE FROM V_HORAINICIALCD) - EXTRACT(MINUTE FROM V_HORAFIN)), 0);
                        END;
                    END IF;                    
                END;
            ELSE
                BEGIN
                    INSERT INTO CITAS_DISPONIBLES (NU_TUME_CIDI, CD_MED_CIDI, FE_FECH_CIDI, FE_HOIN_CIDI, FE_HOFI_CIDI, NU_DURA_CIDI, NU_AUTO_RTE_CIDI)
                    VALUES(V_NUMTURNO, V_CODMEDICO, V_FECHA, V_HORAINICIO, V_HORAFIN, (EXTRACT(MINUTE FROM V_HORAINICIO) - EXTRACT(MINUTE FROM V_HORAFIN)), 0);
                END;
            END IF;            
        END;
    ELSE
        BEGIN
            SELECT MIN (NU_AUTO_RTE) INTO V_IDRELACION FROM R_TUR_ESC WHERE NU_NUME_TUME_RTE = V_NUMTURNO;
            WHILE (V_IDRELACION IS NOT NULL)
            LOOP
                BEGIN
                    SELECT CD_CODI_MED_RTE, CD_CODI_CONS_RTE INTO V_CODESTUDIANTE, V_CODCONSULTORIO FROM R_TUR_ESC WHERE NU_NUME_TUME_RTE = V_NUMTURNO AND NU_AUTO_RTE = V_IDRELACION;

                    INSERT INTO TT_TMPCIT (NU_NUME_CIT, FE_FECH_CIT, NU_DURA_CIT, FETERMINA) (SELECT NU_NUME_CIT, FE_FECH_CIT, NU_DURA_CIT, (FE_FECH_CIT + NU_DURA_CIT) FETERMINA FROM CITAS_MEDICAS 
                    WHERE CD_CODI_MED_CIT = V_CODMEDICO AND CD_CODI_MED_EST_CIT =V_CODESTUDIANTE AND FE_FECH_CIT BETWEEN V_FECHAHORAINICIO AND V_FECHAHORAFIN);

                    SELECT COUNT(*) INTO V_TEMP FROM TT_TMPCITA;

                    IF V_TEMP > 0 THEN                    
                        BEGIN
                            OPEN crCITAS;
                            FETCH crCITAS INTO V_CITA, V_FECHACITA, V_DURACIONCITA, V_FECHAFINAL;
                            V_HORAINICIALCD := V_HORAINICIO;
                    
                            LOOP
                            EXIT WHEN crCITAS%NOTFOUND;
                                BEGIN
                                    V_HORAFINALCD := V_FECHACITA;

                                    IF (EXTRACT(MINUTE FROM V_HORAINICIALCD) - EXTRACT(MINUTE FROM V_HORAFINALCD)) > 0 THEN
                                        BEGIN
                                            INSERT INTO CITAS_DISPONIBLES (NU_TUME_CIDI, CD_MED_CIDI, FE_FECH_CIDI, FE_HOIN_CIDI, FE_HOFI_CIDI, NU_DURA_CIDI, NU_AUTO_RTE_CIDI)
                                            VALUES(V_NUMTURNO, V_CODMEDICO, V_FECHA, V_HORAINICIALCD, V_HORAFINALCD, (EXTRACT(MINUTE FROM V_HORAINICIALCD) - EXTRACT(MINUTE FROM V_HORAFINALCD)), V_IDRELACION);
                                        END;
                                    END IF;                                        
                    
                                    V_HORAINICIALCD := V_FECHAFINAL;
                                    FETCH crCITAS INTO V_CITA, V_FECHACITA, V_DURACIONCITA, V_FECHAFINAL;
                                END;

                                CLOSE crCITAS;
                            END LOOP;                                
                
                            IF V_HORAINICIALCD < V_HORAFIN THEN
                                BEGIN
                                    INSERT INTO CITAS_DISPONIBLES (NU_TUME_CIDI, CD_MED_CIDI, FE_FECH_CIDI, FE_HOIN_CIDI, FE_HOFI_CIDI, NU_DURA_CIDI, NU_AUTO_RTE_CIDI)
                                    VALUES(V_NUMTURNO, V_CODMEDICO, V_FECHA, V_HORAINICIALCD, V_HORAFIN, (EXTRACT(MINUTE FROM V_HORAINICIALCD) - EXTRACT(MINUTE FROM V_HORAFIN)), V_IDRELACION);
                                END;
                            END IF;                    
                        END;
                    ELSE
                        BEGIN
                            INSERT INTO CITAS_DISPONIBLES (NU_TUME_CIDI, CD_MED_CIDI, FE_FECH_CIDI, FE_HOIN_CIDI, FE_HOFI_CIDI, NU_DURA_CIDI, NU_AUTO_RTE_CIDI)
                            VALUES(V_NUMTURNO, V_CODMEDICO, V_FECHA, V_HORAINICIO, V_HORAFIN, (EXTRACT(MINUTE FROM V_HORAINICIO) - EXTRACT(MINUTE FROM V_HORAFIN)), V_IDRELACION);
                        END;
                    END IF;                        
            
                    SELECT MIN (NU_AUTO_RTE) INTO V_IDRELACION FROM R_TUR_ESC WHERE NU_NUME_TUME_RTE = V_NUMTURNO AND NU_AUTO_RTE > V_IDRELACION;
                END;
            END LOOP;                
        END;
    END IF;
Exception
    When Others Then
    RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
/