CREATE OR REPLACE PROCEDURE H3i_SP_DIREVENTOADV_INS /*PROCEDIMIENTO PARA REGISTRAR EL DIRECCIONAMIENTO DE EVENTOS ADVERSOS*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_AUTO_EVAD_DIEV IN NUMBER,
  v_TX_RESPONSABLE_DIEV IN VARCHAR2,
  v_TX_CARGO_DIEV IN VARCHAR2,
  v_TX_DEPENDENCIA_DIEV IN VARCHAR2
)
AS

BEGIN

   UPDATE DIRECCIONAMIENTO_EVENTO
      SET NU_ESTADO_DIEV = 0
    WHERE  NU_AUTO_EVAD_DIEV = v_NU_AUTO_EVAD_DIEV;
   INSERT INTO DIRECCIONAMIENTO_EVENTO
     ( NU_AUTO_EVAD_DIEV, TX_RESPONSABLE_DIEV, TX_CARGO_DIEV, TX_DEPENDENCIA_DIEV )
     VALUES ( v_NU_AUTO_EVAD_DIEV, v_TX_RESPONSABLE_DIEV, v_TX_CARGO_DIEV, v_TX_DEPENDENCIA_DIEV );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_DIREVENTOADV_INS;