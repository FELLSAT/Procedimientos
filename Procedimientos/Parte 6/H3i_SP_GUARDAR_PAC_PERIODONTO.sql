CREATE OR REPLACE PROCEDURE H3i_SP_GUARDAR_PAC_PERIODONTO
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_INS_UP_PACIENTE OUT NUMBER,
  v_CD_PACIENTE IN NUMBER,
  v_APELLIDOS_PAC IN VARCHAR2,
  v_NOMBRES_PAC IN VARCHAR2,
  v_NU_NUME_HCLI IN VARCHAR2
)
AS

BEGIN

    IF ( v_CD_PACIENTE = 0 ) THEN
    
        BEGIN
            INSERT INTO HIST_PERIODONTO_PACIENTE( 
                APELLIDOS_PAC, NOMBRES_PAC, 
                NU_NUME_HCLI)
            VALUES ( 
                v_APELLIDOS_PAC, v_NOMBRES_PAC, 
                v_NU_NUME_HCLI );

            SELECT CD_PAC_PERIODONTO 
            INTO v_CD_INS_UP_PACIENTE 
            FROM HIST_PERIODONTO_PACIENTE
            WHERE CD_PAC_PERIODONTO = (SELECT MAX(CD_PAC_PERIODONTO) FROM HIST_PERIODONTO_PACIENTE);
       
        END;
    ELSE
   
        BEGIN
            UPDATE HIST_PERIODONTO_PACIENTE
            SET APELLIDOS_PAC = v_APELLIDOS_PAC,
                NOMBRES_PAC = v_NOMBRES_PAC,
                NU_NUME_HCLI = v_NU_NUME_HCLI
            WHERE  NU_NUME_HCLI = v_NU_NUME_HCLI;

            v_CD_INS_UP_PACIENTE := v_CD_PACIENTE ;
         
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;