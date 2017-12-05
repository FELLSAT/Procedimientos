CREATE OR REPLACE TRIGGER TG_ACT_RIPS 
AFTER UPDATE
ON LABORATORIO
FOR EACH ROW
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
DECLARE
    V_ANTERIOR NUMBER;
    V_NUEVO NUMBER;
    V_MOVIMIENTO NUMBER;  
    V_FECHACARGO DATE;
BEGIN

    IF (:OLD.ID_ESTA_ASIS_LABO <> :NEW.ID_ESTA_ASIS_LABO) THEN
          BEGIN
              SELECT :NEW.ID_ESTA_ASIS_LABO, :NEW.NU_NUME_MOVI_LABO
              INTO V_NUEVO, V_MOVIMIENTO
              FROM DUAL;
              ------------------------------------------------------
              SELECT :OLD.ID_ESTA_ASIS_LABO 
              INTO V_ANTERIOR
              FROM DUAL;
              ------------------------------------------------------
              IF(V_NUEVO = 1) THEN
                  BEGIN
                      SELECT FE_FECH_MOVI 
                      INTO V_FECHACARGO
                      FROM MOVI_CARGOS 
                          WHERE NU_NUME_MOVI = V_MOVIMIENTO;
                      ------------------------------------------------------    
                      IF (TO_CHAR(V_FECHACARGO,'DD') - TO_CHAR(SYSDATE,'DD') ) > 0 THEN
                          BEGIN 
                                RAISE_APPLICATION_ERROR(16,'NO PUEDE GENERAR RIPS CON FECHA POSTERIOR A LA ACTUAL');
                                ROLLBACK;
                          END;
                      END IF;
                  END;
              END IF;
          END;
    END IF;
END;