CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTAR_VACUNAS_PACIE /*PROCEDIMIENTO ALMACENADO QUE PERMITE RECUPERAR LAS ASIGNACIONES DE ESPECIALIDADES DE UN USUARIO*/
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NU_EDFI_SER IN NUMBER,
  v_NU_EDFI_MES_SER IN NUMBER,
  v_NU_EDFI_DIA_SER IN NUMBER,
  iv_NU_APLI_SER IN NUMBER,
  v_NU_ESPYP IN NUMBER,
  v_NU_GEST_PAC IN NUMBER,
  cv_1 OUT SYS_REFCURSOR
)
AS
   v_NU_APLI_SER NUMBER(10,0) := iv_NU_APLI_SER;

BEGIN

   -- para servicios 0 = ambos, 1 = Hombre, 2 = mujer... por lo tanto se condiciona de la siguiente manera
   -- carga todas las vacunas que sean pai(pyp) y no pai(pyp)
   IF ( v_NU_ESPYP = 0 ) THEN
    
   BEGIN
      IF ( v_NU_APLI_SER = 0 ) THEN
       
      BEGIN
         v_NU_APLI_SER := 2 ;
      
      END;
      END IF;
      OPEN  cv_1 FOR
         SELECT CD_CODI_SER ,
                NO_NOMB_SER ,
                NU_OPCI_SER ,
                NU_NUME_IND_SER 
           FROM SERVICIOS 
          WHERE  CASE MEDIDA_TIEMPO
                                   WHEN 1 THEN v_NU_EDFI_SER
                                   WHEN 2 THEN v_NU_EDFI_MES_SER
                                   WHEN 3 THEN v_NU_EDFI_DIA_SER   END BETWEEN NU_EDIN_SER AND NU_EDFI_SER
                   AND NU_APLI_SER IN ( 0,v_NU_APLI_SER )

                   AND NU_VACU_SER = 1
                   AND NU_NUME_IND_SER = 0 ;
   
   END;

   -- carga solo las vacunas que sean pai(PyP)
   ELSE
   
   BEGIN
      OPEN  cv_1 FOR
         SELECT DISTINCT CD_CODI_SER ,
                         NO_NOMB_SER ,
                         NU_OPCI_SER ,
                         NU_NUME_IND_SER 
           FROM SERVICIOS S
          WHERE  S.NU_VACU_SER = 1
                   AND S.NU_NUME_IND_SER = 1
                   AND S.NU_APLI_SER IN ( 0,v_NU_APLI_SER )

                   AND S.NU_NUME_IND_SER = v_NU_ESPYP
                   
                   --AND @NU_EDFI_MES_SER BETWEEN S.NU_EDIN_SER AND S.NU_EDFI_SER
                   AND CASE S.MEDIDA_TIEMPO
                                           WHEN 1 THEN v_NU_EDFI_SER
                                           WHEN 2 THEN v_NU_EDFI_MES_SER
                                           WHEN 3 THEN v_NU_EDFI_DIA_SER   END BETWEEN S.NU_EDIN_SER AND S.NU_EDFI_SER ;-- en la tabla servicios la fecha inicial final debe ser manejada en meses.
      --AND CP.NU_GEST_CP = @NU_GEST_PAC pendiente agregar en la tabla servicios si es gestante
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTAR_VACUNAS_PACIE;