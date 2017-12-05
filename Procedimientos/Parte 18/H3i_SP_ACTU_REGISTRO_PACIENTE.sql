CREATE OR REPLACE PROCEDURE H3i_SP_ACTU_REGISTRO_PACIENTE
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
	V_NU_DOCU_PAC IN VARCHAR2
)

AS
BEGIN	
    UPDATE PACIENTES
    SET NU_NUME_REG_PAC = 0
    WHERE NU_DOCU_PAC = V_NU_DOCU_PAC;
    
EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;