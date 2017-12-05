CREATE OR REPLACE PROCEDURE H3i_SP_GUARDAR_IMAG_CONV_HIST -- PROCEDIMIENTO ENCARGADO DE GUARDAR LAS IMAGENES DE CONVENCION CORRESPONDIENTE A UNA HISTORIA CLINICA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_NUME_LABO IN NUMBER,
  v_NU_NUME_IMAGEN IN NUMBER,
  v_POS_X IN NUMBER,
  v_POS_Y IN NUMBER
)
AS

BEGIN

   INSERT INTO R_HIST_IMAGEN_CONV
     ( NU_NUME_LABO, NU_NUME_IMAGEN, POS_X, POS_Y )
     VALUES ( v_NU_NUME_LABO, v_NU_NUME_IMAGEN, v_POS_X, v_POS_Y );

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;