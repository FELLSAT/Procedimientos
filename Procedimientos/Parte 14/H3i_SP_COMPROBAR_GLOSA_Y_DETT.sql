CREATE OR REPLACE PROCEDURE H3i_SP_COMPROBAR_GLOSA_Y_DETT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_IDGLOSA IN NUMBER
)
AS
   v_COUN_DETT NUMBER(10,0);

BEGIN

    SELECT COUNT(*)
    INTO v_COUN_DETT
    FROM GLOSA3i gl
    JOIN DETALLE_GLOSA3i de   ON de.nu_auto_glos_degl = gl.nu_auto_glos
    WHERE  gl.nu_auto_glos = v_IDGLOSA;


    IF v_COUN_DETT = 0 THEN  
    
        BEGIN
            DELETE GLOSA3i
            WHERE  NU_AUTO_GLOS = v_IDGLOSA;
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;