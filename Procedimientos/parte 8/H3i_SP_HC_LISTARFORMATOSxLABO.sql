CREATE OR REPLACE PROCEDURE H3i_SP_HC_LISTARFORMATOSxLABO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NumHist IN VARCHAR2,
  v_NumLabo IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_Edad NUMBER(10,0);
   v_UME NUMBER(10,0);
   v_CodEsp VARCHAR2(10);
   v_CodServ VARCHAR2(20);
   v_Sexo NUMBER(10,0);
   v_Gestante NUMBER(10,0);
   v_TipoAtencion NUMBER(10,0);
   v_TipoServ NVARCHAR2(1);

BEGIN

    SELECT CD_CODI_ESP_LABO ,
        CD_CODI_SER_LABO ,
        ES_GESTANTE ,
        NU_TIAT_MOVI ,
        (
          CASE NU_TIPO_MOVI
              WHEN 4 
                THEN 'C'
              ELSE 'P'
          END) 
    INTO v_CodEsp,
        v_CodServ,
        v_Gestante,
        v_TipoAtencion,
        v_TipoServ
    FROM LABORATORIO 
    INNER JOIN MOVI_CARGOS    
        ON NU_NUME_MOVI = NU_NUME_MOVI_LABO
    WHERE  NU_NUME_LABO = v_NumLabo;


    v_EDAD := EdadPaciente(v_NumHist, 1) ;
    v_UME := EdadPaciente(v_NumHist, 2) ;

    SELECT (
            CASE NU_SEXO_PAC
                WHEN 0 
                    THEN 2
                ELSE NU_SEXO_PAC -- mejorado para error de sexo en formatos disponibles
            END) 
    INTO v_Sexo
    FROM PACIENTES 
    WHERE  NU_HIST_PAC = v_NumHist;


    OPEN  cv_1 FOR
        SELECT CD_NOMB_FIN ,
             CD_CODI_FIN ,
             NU_NUME_PLHI ,
             NU_SERV_PLHI ,
             NU_AUTO_ENPL_PLHI ,
             NU_PERMADJARCHIVO_PLHI ,
             ES_PSICOACTIVO ,
             ES_CONTRAREFERENCIA 
        FROM PLANTILLA_HIST ,
             R_PLANTILLA_HIST ,
             FINALIDAD_HIST ,
             R_ESPE_PLHI 
       WHERE  NU_NUME_PLHI = NU_NUME_PLHI_R
                AND NU_FINA_PLHI = CD_CODI_FIN
                AND NU_NUME_PLHI = NU_PLHI
                AND NU_ESPE = v_CodEsp
                
                --AND		NU_TIAT_PLHI = @TipoAtencion
                AND NU_PRCO_PLHI = v_TipoServ
                AND ( NVL(NU_SERV_PLHI, ' ') = ' '
                OR NVL(NU_SERV_PLHI, ' ') = v_CodServ )
                AND NU_ESTA_PLHI = 1
                AND CD_NOMB_FIN != 'NOTA DE EVOLUCION'
                AND NU_NUME_PLHI NOT IN ( SELECT NU_NUME_PLHI_CLAP 
                                          FROM CONFIGURA_CLAP -- CLAP PRINCIPAL
                                                 WHERE ROWNUM <= 1 )

                AND NU_NUME_PLHI NOT IN ( SELECT NU_INGRE_PLHI_CLAP 
                                          FROM CONFIGURA_CLAP -- CLAP INGRESO
                                                 WHERE ROWNUM <= 1 )

                AND NU_NUME_PLHI NOT IN ( SELECT NU_SEGUI_PLHI_CLAP 
                                          FROM CONFIGURA_CLAP -- CLAP EGRESO
                                                 WHERE ROWNUM <= 1 )

                AND NU_NUME_PLHI != NVL(( SELECT NU_PLHI_ANTES 
                                          FROM CONFIGURA_FORM_CIR  WHERE ROWNUM <= 1 ), 0 -- CIRUGIA ANTES
              )
                AND NU_NUME_PLHI != NVL(( SELECT NU_PLHI_DURANTE 
                                          FROM CONFIGURA_FORM_CIR  WHERE ROWNUM <= 1 ), 0 -- CIRUGIA DURANTE
              )
                AND NU_NUME_PLHI != NVL(( SELECT NU_PLHI_DESPUES 
                                          FROM CONFIGURA_FORM_CIR  WHERE ROWNUM <= 1 ), 0 -- CIRUGIA DESPUES
              )
                AND NU_NUME_PLHI != NVL(( SELECT NU_PLHI_PREQUIRURGICO 
                                          FROM CONFIGURA_FORM_ANESTESIA  WHERE ROWNUM <= 1 ), 0 -- ANESTESIA PREQUIRURGICO
              )
                AND NU_NUME_PLHI != NVL(( SELECT NU_PLHI_TRANSQUIRURGICO 
                                          FROM CONFIGURA_FORM_ANESTESIA  WHERE ROWNUM <= 1 ), 0 -- ANESTESIA TRANSQUIRURGICO
              )
                AND NU_NUME_PLHI != NVL(( SELECT NU_PLHI_POSTQUIRURGICO 
                                          FROM CONFIGURA_FORM_ANESTESIA  WHERE ROWNUM <= 1 ), 0 -- ANESTESIA POSTQUIRURGICO
              )
                AND NU_NUME_PLHI != NVL(( SELECT NU_PLHI_NOTAQUIRURGICO 
                                          FROM CONFIGURA_FORM_ANESTESIA  WHERE ROWNUM <= 1 ), 0 -- NOTA QUIRURGICA
              )
                
                ----	AMBOS=0, HOMBRE=1, MUJER=2
                AND ( NU_GENE_PLHI = 0
                OR NU_GENE_PLHI = v_Sexo )
                
                --AND		NU_CGES_PLHI = @Gestante 
                AND v_EDAD BETWEEN NU_REDI_PLHI AND NU_REDF_PLHI
        ORDER BY NU_SERV_PLHI DESC,
                 CD_NOMB_FIN ;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;