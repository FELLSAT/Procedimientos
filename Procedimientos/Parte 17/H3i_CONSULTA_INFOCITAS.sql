CREATE OR REPLACE PROCEDURE H3i_CONSULTA_INFOCITAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGO IN VARCHAR2 DEFAULT NULL ,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    IF v_CODIGO <> ' ' THEN
    
        BEGIN
            OPEN  cv_1 FOR
                SELECT NU_DOCU_PAC DOCUMENTO  ,
                    CASE NU_TIPD_PAC
                        WHEN 0 THEN 'CC'
                        WHEN 1 THEN 'TI'
                        WHEN 2 THEN 'RC'
                        WHEN 3 THEN 'CE'
                        WHEN 4 THEN 'PA'
                        WHEN 5 THEN 'AS'
                        WHEN 6 THEN 'MS'
                        WHEN 7 THEN 'NU'
                        ELSE 'NIT'
                    END TIPO_DOCUMENTO,
                    DE_PRAP_PAC APELLIDO_UNO,
                    DE_SGAP_PAC APELLIDO_DOS,
                    CASE 
                        WHEN NO_SGNO_PAC IS NULL THEN NO_NOMB_PAC
                        ELSE NO_NOMB_PAC || ' ' || NO_SGNO_PAC
                    END NOMBRES  ,
                    CASE NU_SEXO_PAC
                        WHEN 1 THEN 'M'
                        ELSE 'F'
                    END GENERO,
                    CASE 
                        WHEN FE_NACI_PAC IS NULL THEN NULL
                        ELSE TO_CHAR(FE_NACI_PAC,'YYYY/MM/DD')
                    END FECHA_NACIMIENTO  ,
                    CD_CODI_MUNI_NACI_PAC LUGAR_NACIMIENTO  ,
                    CASE NU_ESCI_PAC
                        WHEN 0 THEN 'S'
                        WHEN 1 THEN 'C'
                        WHEN 2 THEN 'D'
                        WHEN 3 THEN 'S'
                        WHEN 4 THEN 'S'
                        WHEN 5 THEN 'U'
                        WHEN 6 THEN 'D'
                        ELSE 'M'
                    END ESTADO_CIVIL  ,
                    TX_NOMBRESP_PAC ACUDIENTE  ,
                    DE_DIRE_PAC DIRECCION  ,
                    DE_TELE_PAC TELEFONO  ,
                    CASE NU_TIPO_PAC
                        WHEN 0 THEN 'A'
                        WHEN 1 THEN 'B'
                        ELSE 'O'
                    END TIPO_USUARIO  ,
                    '1' NIVEL_ATENCION ,--DESCONOCIDO* 
                    CD_CODI_OCUP_PAC OCUPACION  ,
                    CD_CODI_ZORE_PAC ZONA_VIVIENDA  ,
                    ' ' DOC_IDENTIDAD_COTIZANTE ,--DESCONOCIDO*
                    ' ' TIPO_DOC_IDENTIDAD_COTIZANTE ,--DESCONOCIDO*
                    ' ' POLIZA_ASEGURADO ,--DESCONOCIDO*
                    DE_CELU_PAC CELULAR  ,
                    DE_OTRO_TELE_PAC TELEFONO_FIJO_AUX  ,
                    DE_EMAIL_PAC CORREO_ELECTRONICO  ,
                    '0000' PLAN_ATENCION ,--DESCONOCIDO*
                    CD_CODI_MED_CIT ESPECIALISTA  ,
                    CD_MEDI_ORDE_CIT MEDICO  ,
                    CASE 
                        WHEN FE_FECH_CIT IS NULL THEN NULL
                        ELSE TO_CHAR(FE_FECH_CIT,'YYYY/MM/DD')
                       END FECHA_CITA  ,
                    CASE 
                        WHEN FE_HORA_CIT IS NULL THEN NULL
                        ELSE SUBSTR(TO_CHAR(FE_HORA_CIT,'YYYY/MM/DD'), -5, 5)
                       END HORA_CITA  ,
                    CASE 
                        WHEN NU_DURA_CIT IS NULL THEN NULL
                        ELSE 
                            FLOOR(NU_DURA_CIT/60)||':'||MOD(NU_DURA_CIT,60)||':'||'00';                        
                    END DURACION  ,
                    CD_CODI_CONS_CIT CONSULTORIO  ,
                    CASE NU_PRIM_CIT
                        WHEN 1 THEN 'P'
                        ELSE 'R'
                    END TIPO_CITA  ,
                    'P' FORMA_SOLICITUD_CITA ,--DESCONOCIDO*
                    DE_DESC_CIT OBSERVACION,
                    (NO_NOMB_MUNI || ' : ' || NO_NOMB_LUAT || '. ' || DE_DIRE_LUAT) SITIO_ATENCION  
                FROM CITAS_MEDICAS 
                INNER JOIN PACIENTES    
                    ON CITAS_MEDICAS.NU_HIST_PAC_CIT = PACIENTES.NU_HIST_PAC
                INNER JOIN CONSULTORIOS    
                    ON CONSULTORIOS.CD_CODI_CONS = CITAS_MEDICAS.CD_CODI_CONS_CIT
                INNER JOIN LUGAR_ATENCION    
                    ON LUGAR_ATENCION.CD_CODI_LUAT = CONSULTORIOS.CD_CODI_LUAT_CONS
                INNER JOIN MUNICIPIOS    
                    ON ( MUNICIPIOS.CD_CODI_MUNI = LUGAR_ATENCION.CD_CODI_MUNI_LUAT
                    AND MUNICIPIOS.CD_CODI_DPTO_MUNI = LUGAR_ATENCION.CD_CODI_DPTO_LUAT
                    AND MUNICIPIOS.CD_CODI_PAIS_MUNI = LUGAR_ATENCION.CD_CODI_PAIS_LUAT )
                WHERE  NU_NUME_MOVI_CIT = NVL(v_CODIGO, NU_NUME_MOVI_CIT) ;
   
        END;
    ELSE
   
        BEGIN
            OPEN  cv_1 FOR
                SELECT NU_DOCU_PAC DOCUMENTO  ,
                    CASE NU_TIPD_PAC
                        WHEN 0 THEN 'CC'
                        WHEN 1 THEN 'TI'
                        WHEN 2 THEN 'RC'
                        WHEN 3 THEN 'CE'
                        WHEN 4 THEN 'PA'
                        WHEN 5 THEN 'AS'
                        WHEN 6 THEN 'MS'
                        WHEN 7 THEN 'NU'
                        ELSE 'NIT'
                    END TIPO_DOCUMENTO  ,
                    DE_PRAP_PAC APELLIDO_UNO  ,
                    DE_SGAP_PAC APELLIDO_DOS  ,
                    CASE 
                         WHEN NO_SGNO_PAC IS NULL THEN NO_NOMB_PAC
                        ELSE NO_NOMB_PAC || ' ' || NO_SGNO_PAC
                    END NOMBRES  ,
                    CASE NU_SEXO_PAC
                        WHEN 1 THEN 'M'
                        ELSE 'F'
                    END GENERO  ,
                    CASE 
                        WHEN FE_NACI_PAC IS NULL THEN NULL
                        ELSE TO_CHAR(FE_NACI_PAC,'YYYY/MM/DD')
                    END FECHA_NACIMIENTO  ,
                    CD_CODI_MUNI_NACI_PAC LUGAR_NACIMIENTO  ,
                    CASE NU_ESCI_PAC
                        WHEN 0 THEN 'S'
                        WHEN 1 THEN 'C'
                        WHEN 2 THEN 'D'
                        WHEN 3 THEN 'S'
                        WHEN 4 THEN 'S'
                        WHEN 5 THEN 'U'
                        WHEN 6 THEN 'D'
                        ELSE 'M'
                    END ESTADO_CIVIL  ,
                    TX_NOMBRESP_PAC ACUDIENTE  ,
                    DE_DIRE_PAC DIRECCION  ,
                    DE_TELE_PAC TELEFONO  ,
                    CASE NU_TIPO_PAC
                        WHEN 0 THEN 'A'
                        WHEN 1 THEN 'B'
                        ELSE 'O'
                    END TIPO_USUARIO  ,
                    '1' NIVEL_ATENCION ,--DESCONOCIDO* 
                    CD_CODI_OCUP_PAC OCUPACION  ,
                    CD_CODI_ZORE_PAC ZONA_VIVIENDA  ,
                    ' ' DOC_IDENTIDAD_COTIZANTE ,--DESCONOCIDO*
                    ' ' TIPO_DOC_IDENTIDAD_COTIZANTE ,--DESCONOCIDO*
                    ' ' POLIZA_ASEGURADO ,--DESCONOCIDO*
                    DE_CELU_PAC CELULAR  ,
                    DE_OTRO_TELE_PAC TELEFONO_FIJO_AUX  ,
                    DE_EMAIL_PAC CORREO_ELECTRONICO  ,
                    '0000' PLAN_ATENCION ,--DESCONOCIDO*
                    CD_CODI_MED_CIT ESPECIALISTA  ,
                    CD_MEDI_ORDE_CIT MEDICO  ,
                    CASE 
                        WHEN FE_FECH_CIT IS NULL THEN NULL
                        ELSE TO_CHAR(FE_FECH_CIT,'YYYY/MM/DD')
                    END FECHA_CITA  ,
                    CASE 
                        WHEN FE_HORA_CIT IS NULL THEN NULL
                        ELSE 
                            TO_CHAR(FE_HORA_CIT,'HH')||':'||TO_CHAR(FE_HORA_CIT,'MI')||':'||TO_CHAR(FE_HORA_CIT,'SS');
                    END HORA_CITA  ,
                    CASE 
                        WHEN NU_DURA_CIT IS NULL THEN NULL
                        ELSE 
                            FLOOR(NU_DURA_CIT/60)||':'||MOD(NU_DURA_CIT,60)||':'||'00'; 
                    END DURACION  ,
                    CD_CODI_CONS_CIT CONSULTORIO  ,
                    CASE NU_PRIM_CIT
                        WHEN 1 THEN 'P'
                        ELSE 'R'
                    END TIPO_CITA  ,
                    'P' FORMA_SOLICITUD_CITA ,--DESCONOCIDO*
                    DE_DESC_CIT OBSERVACION  ,
                    (NO_NOMB_MUNI || ' : ' || NO_NOMB_LUAT || '. ' || DE_DIRE_LUAT) SITIO_ATENCION  
                FROM CITAS_MEDICAS 
                    INNER JOIN PACIENTES    
                        ON CITAS_MEDICAS.NU_HIST_PAC_CIT = PACIENTES.NU_HIST_PAC
                    INNER JOIN CONSULTORIOS    
                        ON CONSULTORIOS.CD_CODI_CONS = CITAS_MEDICAS.CD_CODI_CONS_CIT
                    INNER JOIN LUGAR_ATENCION    
                        ON LUGAR_ATENCION.CD_CODI_LUAT = CONSULTORIOS.CD_CODI_LUAT_CONS
                    INNER JOIN MUNICIPIOS    
                        ON ( MUNICIPIOS.CD_CODI_MUNI = LUGAR_ATENCION.CD_CODI_MUNI_LUAT
                    AND MUNICIPIOS.CD_CODI_DPTO_MUNI = LUGAR_ATENCION.CD_CODI_DPTO_LUAT
                    AND MUNICIPIOS.CD_CODI_PAIS_MUNI = LUGAR_ATENCION.CD_CODI_PAIS_LUAT ) ;   
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;