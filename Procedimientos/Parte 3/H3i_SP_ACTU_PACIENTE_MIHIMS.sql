CREATE OR REPLACE PROCEDURE H3i_SP_ACTU_PACIENTE_MIHIMS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_DOCU_PAC IN VARCHAR2,
  v_CODIGOETNIA IN VARCHAR2,
  v_NU_ISDESPLAZADO_PAC IN NUMBER,
  v_DE_TELE_PAC IN VARCHAR2,
  v_DE_CELU_PAC IN VARCHAR2,
  v_DE_DIRE_PAC IN VARCHAR2,
  v_NU_ESCI_PAC IN NUMBER,
  v_CD_CODI_DPTO_PAC IN VARCHAR2,--CodigoDepto
  v_CD_CODI_MUNI_PAC IN VARCHAR2,-- CodigoMpio  
  v_CD_CODI_DPTO_TRAB_PAC IN VARCHAR2,-- CodigoDepto_Trabajo
  v_CD_CODI_MUNI_TRAB_PAC IN VARCHAR2,--CodigoMpio_Trabajo
  v_TX_DIRTRAB_PAC IN VARCHAR2,-- Direccion_Trabajo
  v_TX_TELTRAB_PAC IN VARCHAR2,-- Telefono_Trabajo
  v_DE_OTRO_TELE_PAC IN VARCHAR2,-- OtroTelefono
  v_CD_CODI_ESCO_PAC IN VARCHAR2,-- Escolaridad
  v_CD_CODI_RELI_PAC IN VARCHAR2
)
AS
   v_CD_CODI_PAIS_PAC VARCHAR2(3);
   v_CD_CODI_PAIS_TRAB_PAC VARCHAR2(3);

 -- Religion
BEGIN

   SELECT PAISES.CD_CODI_PAIS 

     INTO v_CD_CODI_PAIS_PAC
     FROM ( MUNICIPIOS MUNICIPIOS
            JOIN PAISES PAISES   ON ( MUNICIPIOS.CD_CODI_PAIS_MUNI = PAISES.CD_CODI_PAIS )
             ) 
            JOIN DEPARTAMENTOS DEPARTAMENTOS   ON ( DEPARTAMENTOS.CD_CODI_PAIS_DPTO = PAISES.CD_CODI_PAIS )
            AND ( MUNICIPIOS.CD_CODI_DPTO_MUNI = DEPARTAMENTOS.CD_CODI_DPTO )
            AND ( MUNICIPIOS.CD_CODI_PAIS_MUNI = DEPARTAMENTOS.CD_CODI_PAIS_DPTO )
    WHERE  DEPARTAMENTOS.CD_CODI_DPTO = v_CD_CODI_DPTO_PAC
             AND MUNICIPIOS.CD_CODI_MUNI = v_CD_CODI_MUNI_PAC AND ROWNUM <= 1;
   SELECT PAISES.CD_CODI_PAIS 

     INTO v_CD_CODI_PAIS_TRAB_PAC
     FROM ( MUNICIPIOS MUNICIPIOS
            JOIN PAISES PAISES   ON ( MUNICIPIOS.CD_CODI_PAIS_MUNI = PAISES.CD_CODI_PAIS )
             ) 
            JOIN DEPARTAMENTOS DEPARTAMENTOS   ON ( DEPARTAMENTOS.CD_CODI_PAIS_DPTO = PAISES.CD_CODI_PAIS )
            AND ( MUNICIPIOS.CD_CODI_DPTO_MUNI = DEPARTAMENTOS.CD_CODI_DPTO )
            AND ( MUNICIPIOS.CD_CODI_PAIS_MUNI = DEPARTAMENTOS.CD_CODI_PAIS_DPTO )
    WHERE  DEPARTAMENTOS.CD_CODI_DPTO = v_CD_CODI_DPTO_TRAB_PAC
             AND MUNICIPIOS.CD_CODI_MUNI = v_CD_CODI_MUNI_TRAB_PAC AND ROWNUM <= 1;
   UPDATE PACIENTES
      SET CD_CODI_DPTO_PAC = v_CD_CODI_DPTO_PAC,
          CD_CODI_MUNI_PAC = v_CD_CODI_MUNI_PAC,
          DE_DIRE_PAC = v_DE_DIRE_PAC,
          TX_CODIGO_ETNI_PACI = v_CODIGOETNIA,
          NU_ISDESPLAZADO_PAC = v_NU_ISDESPLAZADO_PAC,
          DE_TELE_PAC = v_DE_TELE_PAC,
          DE_CELU_PAC = v_DE_CELU_PAC,
          NU_ESCI_PAC = v_NU_ESCI_PAC,
          CD_CODI_PAIS_TRAB_PAC = v_CD_CODI_PAIS_TRAB_PAC,
          CD_CODI_DPTO_TRAB_PAC = v_CD_CODI_DPTO_TRAB_PAC,
          CD_CODI_MUNI_TRAB_PAC = v_CD_CODI_MUNI_TRAB_PAC,
          TX_DIRTRAB_PAC = v_TX_DIRTRAB_PAC,
          DE_OTRO_TELE_PAC = v_DE_OTRO_TELE_PAC,
          TX_TELTRAB_PAC = v_TX_TELTRAB_PAC,
          CD_CODI_ESCO_PAC = v_CD_CODI_ESCO_PAC,
          CD_CODI_RELI_PAC = v_CD_CODI_RELI_PAC,
          ES_MIHIMS = 1
    WHERE  NU_DOCU_PAC = v_NU_DOCU_PAC;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_ACTU_PACIENTE_MIHIMS;