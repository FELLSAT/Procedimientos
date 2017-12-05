CREATE OR REPLACE TRIGGER HIMS.DETALLE_PAGO_ABONO_CD_CODI_D_1 BEFORE INSERT ON HIMS.DETALLE_PAGO_ABONO FOR EACH ROW
DECLARE

BEGIN
  SELECT DETALLE_PAGO_ABONO_CD_CODI_DPA.NEXTVAL
  INTO :NEW.CD_CODI_DPA
  FROM DUAL;
END;
/