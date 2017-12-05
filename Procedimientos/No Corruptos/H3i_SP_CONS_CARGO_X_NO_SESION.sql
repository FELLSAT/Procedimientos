CREATE OR REPLACE PROCEDURE HIMS.H3i_SP_CONS_CARGO_X_NO_SESION
-- =============================================      
-- Author:  Carlos Castro Agudelo
-- =============================================  
(v_NO_SESION IN NUMBER, cv_1 OUT SYS_REFCURSOR)
IS
    v_A VARCHAR2(20);
    v_B NUMBER(10,0);
BEGIN
   v_A := TO_CHAR(v_NO_SESION,20) || '%' ;
   
   SELECT MAX(NU_NUME_MOVI)  NuRegistro INTO v_B FROM MOVI_CARGOS WHERE  NU_NUME_MOVI LIKE v_A;
    
    OPEN  cv_1 FOR
    SELECT * FROM MOVI_CARGOS WHERE  NU_NUME_MOVI = v_B;
Exception
    When Others Then
    RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;