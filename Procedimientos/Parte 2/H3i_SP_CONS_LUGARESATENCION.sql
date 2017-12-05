CREATE OR REPLACE PROCEDURE H3i_SP_CONS_LUGARESATENCION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CODIGOENTIDAD IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS
   v_conteo NUMBER(10,0);

BEGIN

    OPEN  cv_1 FOR
      SELECT CD_CODI_LUAT ,
          NO_NOMB_LUAT ,
          DE_DIRE_LUAT ,
          DE_TELE_LUAT ,
          TO_NUMBER(NVL(NU_RANG_MIN, 0)) NU_RANG_MIN  ,
          TO_NUMBER(NVL(NU_RANG_MAX, 0)) NU_RANG_MAX  ,
          DE_UPGD_LUAT ,
          CD_CODI_DPTO_LUAT ,
          CD_CODI_MUNI_LUAT ,
          CD_CODI_PAIS_LUAT ,
          CD_CODI_LUAT_PADRE ,
          CD_CODI_TLUAT 
      FROM LUGAR_ATENCION 
      WHERE NU_AUTO_ENTI_LUAT = v_CODIGOENTIDAD;

    SELECT COUNT(*)  
    INTO v_conteo
    FROM LUGAR_ATENCION 
    WHERE  NU_AUTO_ENTI_LUAT = v_CODIGOENTIDAD;
    DBMS_OUTPUT.PUT_LINE('Lugares de atencion: ' || TO_CHAR(v_conteo));--AND (CD_CODI_LUAT_PADRE IS NULL OR CD_CODI_LUAT_PADRE = '')  Se comenta para que cargue todos los lugares de atencion en los paciente

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONS_LUGARESATENCION;