CREATE OR REPLACE PROCEDURE H3i_SP_CREA_DETALLE_ELEMENTOS1
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_COD_CARGO IN NUMBER DEFAULT NULL ,
  v_CANTIDAD IN NUMBER DEFAULT NULL ,
  v_VALOR_UNITARIO IN FLOAT DEFAULT NULL ,
  v_VAL_COPAGO IN FLOAT DEFAULT NULL ,
  v_COD_ELEMENTO IN VARCHAR2 DEFAULT NULL ,
  v_COD_ESPECIALIDAD IN VARCHAR2 DEFAULT NULL ,
  v_COD_MEDICO_REALIZA IN VARCHAR2 DEFAULT NULL ,
  v_ESTADO IN NUMBER DEFAULT 0 ,
  v_NO_AUTORIZACION IN VARCHAR2 DEFAULT NULL ,
  v_NO_CONVENIO IN NUMBER DEFAULT NULL ,
  v_FECHA_HORA IN DATE DEFAULT NULL ,
  v_NO_HISTORIA IN VARCHAR2 DEFAULT NULL ,
  v_CONEXION IN NUMBER DEFAULT NULL ,
  v_COD_DEPENDENCIA IN VARCHAR2 DEFAULT NULL ,
  v_PACIENTE_NOMBRE IN VARCHAR2 DEFAULT NULL ,
  v_NO_SOLICITUD_MED IN NUMBER DEFAULT NULL 
)
AS
   v_TIPO_INTERFAZ VARCHAR2(4000);

BEGIN

    -- DETERMINAR EL TIPO DE INTERFAZ DE INVENTARIO QUE SE ESTA USANDO
    SELECT NVL(CON.VL_VALO_CONT, 'HIMS') 
    INTO v_TIPO_INTERFAZ
    FROM CONTROL CON
    WHERE  CON.CD_CONC_CONT = 'TIPO_INTERFAZ_INVENTARIO';

    -- INVOCAR EL PROCEDIMIENTO ALMACENADO DE ACUERDO AL TIPO DE INTERFAZ DE INVENTARIO QUE MANEJA EL SISTEMA
    IF v_TIPO_INTERFAZ = 'HIMS' THEN
    
        DECLARE
            v_NUMERO_FORMULA NUMBER(10,0);
            --Si el convenio en PyP debe ingresar registro el la tabla R_MOVICA_ARTIAC
            v_esPyP NUMBER(3,0);
            v_NU_AUTO_RARA NUMBER(10,0);
            --validadar si el medico que ordena es adscrito y si la el valor del parametro ADSCRAUT es (1). 
            --Liquida los elementos automaticamente al adscrito
            v_ADSCRAUT VARCHAR2(4000);
            v_EsMedicoAdscrito NUMBER(10,0);
            v_NU_CONSE_AUTDOR NUMBER(10,0);
            v_NU_CONSE_AUTOR_DETAUT NUMBER(10,0);
   
        BEGIN
            --Ingresar en la tabla de formulas
            INSERT INTO FORMULAS( 
                NU_NUME_MOVI_FORM, CD_CODI_UNF_FORM, 
                CD_CODI_ELE_FORM, CT_CANT_FORM, 
                VL_UNID_FORM, VL_COPA_FORM, 
                CD_CODI_MED_FORM, NU_AUTO_FORM, 
                CD_CODI_ESP_FORM, NU_CTCONS_FORM, 
                NU_ESTA_FORM)
            VALUES(v_COD_CARGO ,
                v_COD_DEPENDENCIA ,
                v_COD_ELEMENTO ,
                v_CANTIDAD ,
                v_VALOR_UNITARIO ,
                v_VAL_COPAGO ,
                v_COD_MEDICO_REALIZA ,
                v_NO_AUTORIZACION ,
                v_COD_ESPECIALIDAD ,
                v_CANTIDAD ,
                v_ESTADO );

            SELECT NU_NUME_FORM 
            INTO v_NUMERO_FORMULA 
            FROM FORMULAS
            WHERE NU_NUME_FORM = (SELECT MAX(NU_NUME_FORM) FROM FORMULAS);

            v_NU_AUTO_RARA := 0 ;
            

            SELECT NU_INDPYP_CONV 
            INTO v_esPyP
            FROM CONVENIOS con
            INNER JOIN MOVI_CARGOS mca   
                ON mca.NU_NUME_CONV_MOVI = con.NU_NUME_CONV
            WHERE  mca.NU_NUME_MOVI = v_COD_CARGO;


            IF ( v_esPyP = 1 ) THEN
       
                BEGIN
                    SELECT raa.NU_AUTO_RARA 
                    INTO v_NU_AUTO_RARA
                    FROM R_ARTI_ACTI raa
                    JOIN ARTICULO art   ON raa.CD_CODI_ARTI_RARA = art.CD_CODI_ARTI
                    AND NU_INDPYP_ARTI = 1
                    WHERE  CD_CODI_ARTI_RARA = v_COD_ELEMENTO;

                    IF ( v_NU_AUTO_RARA > 0 ) THEN
          
                        BEGIN
                            INSERT INTO R_MOVICA_ARTIAC( 
                                NU_AUTO_RARA_RRMA, 
                                NU_NUME_MOVI_RRMA, 
                                CD_CODI_EST_RRMA)
                            VALUES( 
                                v_NU_AUTO_RARA ,
                                v_COD_CARGO ,
                                '??');

                            --select * FROM ESTRATEGIA
                            INSERT INTO R_MOVICA_CAMP( 
                                CD_CODI_CAMP_RMC, 
                                NU_NUME_MOVI_RMC)
                            VALUES( 
                                '??' ,
                                v_COD_CARGO);
             
                        END;
                    END IF;
      
                END;
            END IF;


            SELECT NVL(VL_VALO_CONT, '0') 
            INTO v_ADSCRAUT
            FROM CONTROL 
            WHERE  CD_CONC_CONT = 'ADSCRAUT';


            SELECT NVL(NU_INDI_MED, 0) 
            INTO v_EsMedicoAdscrito
            FROM MEDICOS 
            WHERE  CD_CODI_MED = v_COD_MEDICO_REALIZA;


            SELECT MAX(NU_CONSE_AUTDOR)
            INTO v_NU_CONSE_AUTDOR
            FROM AUTORIZADOR ;


            IF ( v_ADSCRAUT = 1
                AND v_EsMedicoAdscrito = 1 ) THEN
       
                BEGIN
                    INSERT INTO AUTORIZACION( 
                        NU_REFE_AUTOR, NU_ESTA_AUTOR, 
                        DE_OBSER_AUTOR, FE_INIC_AUTOR, 
                        FE_FINA_AUTOR, NU_CONSE_AUTDOR_AUTOR, 
                        NU_NUME_CONV_AUTOR, NU_HIST_PAC_AUTOR, 
                        NU_NUME_CONE_AUTOR, CD_CODI_MED_AUTOR, 
                        NU_NUME_ORDE_AUTOR )
                    VALUES(
                        v_NO_AUTORIZACION, 1 ,
                        'Liquidacion automatica', v_FECHA_HORA ,
                        v_FECHA_HORA, v_NU_CONSE_AUTDOR ,
                        v_NO_CONVENIO, v_NO_HISTORIA ,
                        v_CONEXION, v_COD_MEDICO_REALIZA ,
                        v_NO_AUTORIZACION);
                    ------
                    SELECT MAX(NU_CONSE_AUTOR)  
                    INTO v_NU_CONSE_AUTOR_DETAUT
                    FROM AUTORIZACION ;
                    ------
                    DELETE FROM tt_tmp_5;
         
                    INSERT INTO tt_tmp_5( 
         	              SELECT  CASE 
                                    WHEN PR_POCOBELE_CAPI > 0 THEN 
                                        (CASE 
                                            WHEN rta.CD_TARI_TAAR = '1' THEN 
                                                (rta.VL_PREC_TAAR * (1 + (rta.VL_PREC_TAAR / 100)))
                                            ELSE 
                                                (rta.VL_PREC_TAAR * (1 - (rta.VL_PREC_TAAR / 100)))
                                        END)
                                    ELSE rta.VL_PREC_TAAR
                                END valor ,
                            cad.NU_NUME_COAD ,
                            cap.NU_CONSE_CAPI 
                    FROM CAPITULO cap
                    INNER JOIN CONVENIO_ADSC cad   
                        ON cap.NU_NUME_COAD_CAPI = cad.NU_NUME_COAD
                    INNER JOIN R_ELE_PLAN rel   
                        ON cap.CD_CODI_PLAN_CAPI = rel.CD_CODI_PLAN_REP
                    INNER JOIN R_TARI_ARTI rta   
                        ON cap.CD_CODI_TARI_CAPI = rta.CD_TARI_TAAR
                        AND rta.CD_ARTI_TAAR = rel.CD_CODI_ELE_REP
                    INNER JOIN ARTICULO art   
                        ON rel.CD_CODI_ELE_REP = art.CD_CODI_ARTI
                    INNER JOIN ADSCRITOS ads   
                        ON ads.NU_CONSE_ADSC = cad.NU_CONSE_ADSC_COAD
                    INNER JOIN MEDICOS med   
                        ON ads.CD_CODI_ADSC = med.NU_DOCU_MED
                    WHERE  cad.NU_VIGEN_COAD = 1
                        AND SYSDATE BETWEEN cad.FE_INIC_COAD 
                        AND cad.FE_FINA_COAD
                        AND art.CD_CODI_ARTI = v_COD_ELEMENTO
                        AND med.CD_CODI_MED = v_COD_MEDICO_REALIZA );

                    --Ingresar el detalle de autorizaciones de los elementos adscritos                
                    INSERT INTO DETAUT( 
                        NU_INDIC_DETAUT, CD_CODI_DETAUT, 
                        NU_CANT_DETAUT, VL_VALORXP_DETAUT, 
                        NU_CONSE_AUTOR_DETAUT, NU_NUME_COAD_DETAUT, 
                        NU_CONSE_CAPI_DETAUT)
                        ( SELECT 0 ,
                              v_COD_ELEMENTO ,
                              v_CANTIDAD ,
                              t.valor ,
                              v_NU_CONSE_AUTOR_DETAUT ,
                              t.NU_NUME_COAD ,
                              t.NU_CONSE_CAPI 
                          FROM tt_tmp_5 t );

                    -- Insertar en la tabla CARGOS_ADSCRITO
                    INSERT INTO CARGOS_ADSCRITO( 
                        NU_NUME_MOVI_CAAD, NU_TIPO_CAAD, 
                        CD_CODI_ARTI_CAAD, NU_NUME_COAD_CAAD, 
                        NU_AUTO_CAAD, CT_CANT_CAAD, 
                        VL_UNID_CAAD )
                        ( SELECT v_COD_CARGO ,
                              1 ,
                              v_COD_CARGO ,
                              t.NU_NUME_COAD ,
                              v_NO_AUTORIZACION ,
                              v_CANTIDAD ,
                              t.valor 
                          FROM tt_tmp_5 t );      
                END;
            END IF;
   
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;