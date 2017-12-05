CREATE OR REPLACE PROCEDURE H3i_SP_INGRESAORDENMEDICAMENTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_HICL_HMED IN NUMBER,
  v_NU_NUME_HEVO_HMED IN NUMBER,
  v_CD_CODI_ARTI_HMED IN VARCHAR2,
  v_NO_NOMB_ARTI_HMED IN VARCHAR2,
  v_NU_POSI_HMED IN NUMBER,
  v_DE_UNME_HMED IN VARCHAR2,
  v_DE_CTRA_HMED IN VARCHAR2,
  v_DE_DOSIS_HMED IN VARCHAR2,
  v_NU_CANT_HMED IN NUMBER,
  v_NU_ORDE_HMED IN NUMBER,
  v_DE_VIA_ADMIN_HMED IN VARCHAR2,
  v_DE_FREC_ADMIN_HMED IN VARCHAR2,
  v_NU_NUME_DUR_TRAT_HMED IN VARCHAR2,
  v_NU_UNFRE_HMED IN VARCHAR2,
  v_TX_OBSERV_HED IN VARCHAR2,
  v_NU_TIPO_HMED IN NUMBER,
  v_FE_FECH_FORM_HMED IN VARCHAR2,
  v_NU_LABO_EVOL IN NUMBER DEFAULT NULL 
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   -- Se crea grupo articulo en caso de no existir para las formulas
    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE ( 
                (
                  SELECT COUNT(CD_CODI_GRUP)  
                  FROM GRUP_ARTICULO 
                  WHERE  CD_CODI_GRUP = 'FORMGP' 
                ) = 0 
              );
    EXCEPTION
      WHEN OTHERS THEN
         NULL;
    END;
      

    IF v_temp = 1 THEN    
        BEGIN
            INSERT INTO GRUP_ARTICULO( 
                CD_CODI_GRUP, DE_DESC_GRUP)
            VALUES ( 'FORMGP', 'Grupo Fórmula - Ordenes Médicas' );   
        END;
    END IF;

   -- Se crea Usos en caso de no existir para las formulas de ordenes medicas
    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE ( 
                ( 
                  SELECT COUNT(CD_CODI_USOS)  
                  FROM USOS 
                  WHERE  CD_CODI_USOS = 'FORMUSO' 
                ) = 0 
              );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      

    IF v_temp = 1 THEN
    
        BEGIN
            INSERT INTO USOS( 
                CD_CODI_USOS, DE_DESC_USOS )
            VALUES ( 'FORMUSO', 'Uso Fórmula - Ordenes Médicas' );   
        END;
    END IF;
   

   -- Se agrega en la tabla articulos, en caso de ser de tipo formula y que no exista, ORDENES MEDICAS MEDICAMENTOS
    BEGIN
        SELECT 1 INTO v_temp
        FROM DUAL
        WHERE ( v_NU_TIPO_HMED = 1
        AND (
              SELECT COUNT(CD_CODI_ARTI)  
              FROM ARTICULO 
              WHERE  CD_CODI_ARTI = v_CD_CODI_ARTI_HMED 
            ) = 0 );
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
      

    IF v_temp = 1 THEN
    
        BEGIN
            INSERT INTO ARTICULO( 
                CD_CODI_ARTI, NO_NOMB_ARTI, 
                DE_DESC_ARTI, CD_GRUP_ARTI, 
                CD_USOS_ARTI, DE_UNME_ARTI, --Presentacion Generica (Unidad de medida)
                CT_CNVR_ARTI,
                 --DE_UNCO_ARTI,--
                DE_CTRA_ARTI, --Concentracion
                CT_MAXI_ARTI, --
                CT_MINI_ARTI, --
                FE_VENC_ARTI, --
                ID_GRAV_ARTI, PR_IMPU_ARTI, --
                VL_ULCO_ARTI, --
                VL_COPR_ARTI, --
                CT_EXIS_ARTI, --
                DE_OBSE_ARTI, --
                ID_TIPO_ARTI, --
                 --DE_FOFA_ARTI,--
                 --CD_RIPS_ARTI,--
                 --DE_UBIC_ARTI,--
                NU_INDPYP_ARTI, --
                --CD_ALT2_ARTI,--
                NU_ESLIQ_ARTI, --
                NU_CONF_GRUP_USOS, VL_AJUVAL_ARTI, --
                 --ID_ARTI_DESCR,--
                TX_FEVENC_ARTI, NU_ESTA_ARTI, CD_NUME_CARI_ARTI, --
                 --NU_INDDONA_ARTI,--
                NU_ES_CONTROLADO, NU_ES_RESTRINGIDO )
            VALUES ( 
                v_CD_CODI_ARTI_HMED, v_NO_NOMB_ARTI_HMED, 
                v_NO_NOMB_ARTI_HMED, 'FORMGP', 
                'FORMUSO', v_DE_UNME_HMED, 
                0, v_DE_CTRA_HMED, 0, 
                0, TO_DATE(SYSDATE,'dd/mm/yyyy'), 
                0, 0, 
                0, 0, 
                0, 0, 
                v_NU_TIPO_HMED, 0, 
                0, 0, 
                0, 'N', 
                1, 0, 
                0, 0 );
       
        END;
    END IF;


    INSERT INTO HIST_MEDI( 
        NU_NUME_HICL_HMED, NU_NUME_HEVO_HMED, 
        CD_CODI_ARTI_HMED, NO_NOMB_ARTI_HMED, 
        NU_POSI_HMED, DE_UNME_HMED, 
        DE_CTRA_HMED, DE_DOSIS_HMED, 
        NU_CANT_HMED, NU_ORDE_HMED, 
        DE_VIA_ADMIN_HMED, DE_FREC_ADMIN_HMED, 
        NU_NUME_DUR_TRAT_HMED, NU_UNFRE_HMED, 
        TX_OBSERV_HED, NU_TIPO_HMED, 
        FE_FECH_FORM_HMED, NU_ESTA_HMED, 
        NU_LABO_EVOL )
    VALUES ( 
        v_NU_NUME_HICL_HMED, v_NU_NUME_HEVO_HMED, 
        v_CD_CODI_ARTI_HMED, v_NO_NOMB_ARTI_HMED, 
        v_NU_POSI_HMED, v_DE_UNME_HMED, 
        v_DE_CTRA_HMED, v_DE_DOSIS_HMED, 
        v_NU_CANT_HMED, v_NU_ORDE_HMED, 
        v_DE_VIA_ADMIN_HMED, v_DE_FREC_ADMIN_HMED, 
        v_NU_NUME_DUR_TRAT_HMED, v_NU_UNFRE_HMED, 
        v_TX_OBSERV_HED, v_NU_TIPO_HMED, 
        v_FE_FECH_FORM_HMED, 1, 
        v_NU_LABO_EVOL );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;