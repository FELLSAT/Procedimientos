CREATE OR REPLACE PROCEDURE H3i_SP_ACTUALIZA_MAESTROGENERA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TIPO IN NVARCHAR2,
  v_CODIGO IN NVARCHAR2,
  v_DESCRIPCION IN NVARCHAR2,
  v_ESTADO IN NUMBER
)
AS

BEGIN

   IF v_TIPO = 'OCUPACION' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM OCUPACION 
                          WHERE  CD_CODI_OCUP = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE OCUPACION
            SET DE_DESC_OCUP = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_OCUP = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO OCUPACION
           ( CD_CODI_OCUP, DE_DESC_OCUP, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'RELIGION' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM RELIGION 
                          WHERE  CD_CODI_RELI = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE RELIGION
            SET DE_DESC_RELI = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_RELI = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO RELIGION
           ( CD_CODI_RELI, DE_DESC_RELI, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'PARENTESCO' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM PARENTESCO 
                          WHERE  CD_CODI_PARE = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE PARENTESCO
            SET DE_DESC_PARE = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_PARE = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO PARENTESCO
           ( CD_CODI_PARE, DE_DESC_PARE, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'ZONA' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM ZONARESIDENCIA 
                          WHERE  CD_CODI_ZORE = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE ZONARESIDENCIA
            SET DE_DESC_ZORE = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_ZORE = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO ZONARESIDENCIA
           ( CD_CODI_ZORE, DE_DESC_ZORE, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'ESCOLARIDAD' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM ESCOLARIDAD 
                          WHERE  CD_CODI_ESCO = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE ESCOLARIDAD
            SET NO_NOMB_ESCO = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_ESCO = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO ESCOLARIDAD
           ( CD_CODI_ESCO, NO_NOMB_ESCO, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'VIAADMINISTRACION' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM ADM_DOSIS 
                          WHERE  CD_CODI_ADO = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE ADM_DOSIS
            SET NO_NOMB_ADO = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_ADO = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO ADM_DOSIS
           ( CD_CODI_ADO, NO_NOMB_ADO, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'TIPOLENTE' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM TIPO_LENTE 
                          WHERE  NU_AUTO_TILE = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE TIPO_LENTE
            SET TX_NOMB_TILE = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  NU_AUTO_TILE = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO TIPO_LENTE
           ( TX_NOMB_TILE, ESTADO )
           VALUES ( v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'CAUSAEXTERNA' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM CAUSAEXTERNA 
                          WHERE  ID_CODI_CAEX = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE CAUSAEXTERNA
            SET DE_DESC_CAEX = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  ID_CODI_CAEX = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO CAUSAEXTERNA
           ( ID_CODI_CAEX, DE_DESC_CAEX, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'ETNIA' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM ETNIA 
                          WHERE  TX_CODIGO_ETNI = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE ETNIA
            SET TX_NOMBRE_ETNI = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  TX_CODIGO_ETNI = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO ETNIA
           ( TX_CODIGO_ETNI, TX_NOMBRE_ETNI, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'PLAN_DE_SALUD' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM PLANES 
                          WHERE  CD_CODI_PLAN = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE PLANES
            SET DE_DESC_PLAN = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_PLAN = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO PLANES
           ( CD_CODI_PLAN, DE_DESC_PLAN, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'FORMAS_DE_PAGO' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM FORMA_PAGO 
                          WHERE  NU_NUME_FOPA = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE FORMA_PAGO
            SET DE_DESC_FOPA = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  NU_NUME_FOPA = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO FORMA_PAGO
           ( NU_NUME_FOPA, DE_DESC_FOPA, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'MOTIVOS_DE_INACTIVACION' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM MOTIVO_INACTIVA 
                          WHERE  CD_CODI_MIN = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE MOTIVO_INACTIVA
            SET NO_NOMB_MIN = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_MIN = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO MOTIVO_INACTIVA
           ( CD_CODI_MIN, NO_NOMB_MIN, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'MOTIVO_NO_AUTORIZACION' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM MOTIVO_NOAUTO 
                          WHERE  CD_CODI_MNA = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE MOTIVO_NOAUTO
            SET DE_DESC_MNA = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_MNA = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO MOTIVO_NOAUTO
           ( CD_CODI_MNA, DE_DESC_MNA, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'TIPO_DE_TURNO' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM TIPO_TURNO_MED 
                          WHERE  NU_AUTO_TIPO_TUME = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE TIPO_TURNO_MED
            SET TX_DESC_TIPO_TUME = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  NU_AUTO_TIPO_TUME = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO TIPO_TURNO_MED
           ( NU_AUTO_TIPO_TUME, TX_DESC_TIPO_TUME, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'MOTIVO_ANULACION' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM MOTIVOANUL 
                          WHERE  CD_CODI_MOTI = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE MOTIVOANUL
            SET DE_DESC_MOTI = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_MOTI = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO MOTIVOANUL
           ( CD_CODI_MOTI, DE_DESC_MOTI, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'ESPECIALIDADES' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM ESPECIALIDADES 
                          WHERE  CD_CODI_ESP = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE ESPECIALIDADES
            SET NO_NOMB_ESP = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_ESP = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO ESPECIALIDADES
           ( CD_CODI_ESP, NO_NOMB_ESP, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'PROCEDIMIENTO_ESPECIALIDAD' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM SERVICIOS 
                          WHERE  CD_CODI_SER = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE SERVICIOS
            SET NO_NOMB_SER = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_SER = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO SERVICIOS
           ( CD_CODI_SER, NO_NOMB_SER, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'RECLAMOS_REEMBOLSOS' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM RECLAMOS_REEMBOLSOS 
                          WHERE  COD_REC_REE = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE RECLAMOS_REEMBOLSOS
            SET DES_REC_REE = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  COD_REC_REE = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO RECLAMOS_REEMBOLSOS
           ( COD_REC_REE, DES_REC_REE, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'POBLACION_ESPECIAL' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM POBLACION_ESPECIAL 
                          WHERE  COD_POB_ESP = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE POBLACION_ESPECIAL
            SET DES_POB_ESP = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  COD_POB_ESP = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO POBLACION_ESPECIAL
           ( COD_POB_ESP, DES_POB_ESP, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'ACTIVIDAD_POLIZA' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM ACTIVIDAD_POLIZA 
                          WHERE  COD_ACT_POLI = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE ACTIVIDAD_POLIZA
            SET DESC_ACT_POLI = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  COD_ACT_POLI = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO ACTIVIDAD_POLIZA
           ( COD_ACT_POLI, DESC_ACT_POLI, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'ACTIVIDAD_GESTION' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM ACTIVIDAD_GESTION 
                          WHERE  COD_ACT_GES = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE ACTIVIDAD_GESTION
            SET DESC_ACT_GES = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  COD_ACT_GES = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO ACTIVIDAD_GESTION
           ( COD_ACT_GES, DESC_ACT_GES, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'TIPO_DE_USUARIO_ADM' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM TIPO_USUARIO_ADM 
                          WHERE  COD_TIP_USU = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE TIPO_USUARIO_ADM
            SET NOM_TIP_USU = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  COD_TIP_USU = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO TIPO_USUARIO_ADM
           ( COD_TIP_USU, NOM_TIP_USU, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'ROLES' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM ROLES 
                          WHERE  CD_CODI_ROL = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE ROLES
            SET DE_DESC_ROL = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_ROL = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO ROLES
           ( CD_CODI_ROL, DE_DESC_ROL, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'MODALIDAD_VINCULACIÓN_PROFESIONAL_ASISTENCIAL' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM MODALIDAD_CONTRATO 
                          WHERE  TX_CODI_MOCO = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE MODALIDAD_CONTRATO
            SET TX_DESCRIBE_MOCO = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  TX_CODI_MOCO = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO MODALIDAD_CONTRATO
           ( TX_CODI_MOCO, TX_DESCRIBE_MOCO, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'TIPO_LUGAR_DE_ATENCION' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM TIPO_LUGAR_ATENCION 
                          WHERE  CD_CODI_TLUAT = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE TIPO_LUGAR_ATENCION
            SET NO_NOMB_TLUAT = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  CD_CODI_TLUAT = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO TIPO_LUGAR_ATENCION
           ( CD_CODI_TLUAT, NO_NOMB_TLUAT, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'DEPENDENCIAS' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM DEPENDENCIA 
                          WHERE  CD_CODI_DEPE = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE DEPENDENCIA
            SET DE_DESC_DEPE = v_DESCRIPCION,
                ESTADO_DEP = v_ESTADO
          WHERE  CD_CODI_DEPE = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO DEPENDENCIA
           ( CD_CODI_DEPE, DE_DESC_DEPE, ESTADO_DEP )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'CENTRO_COSTO' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM CENTRO_COSTO 
                          WHERE  CD_CODI_CECO = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE CENTRO_COSTO
            SET NO_NOMB_CECO = v_DESCRIPCION,
                ESTADO_CEC = v_ESTADO
          WHERE  CD_CODI_CECO = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO CENTRO_COSTO
           ( CD_CODI_CECO, NO_NOMB_CECO, ESTADO_CEC )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'REGIMEN' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM TIPOUSUARIO 
                          WHERE  ID_CODI_TIUS = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE TIPOUSUARIO
            SET DE_DESC_TIUS = v_DESCRIPCION,
                ESTADO_TUSR = v_ESTADO
          WHERE  ID_CODI_TIUS = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO TIPOUSUARIO
           ( ID_CODI_TIUS, DE_DESC_TIUS, ESTADO_TUSR )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'VINCULO' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM VINCULO 
                          WHERE  ID_CODI_VINC = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE VINCULO
            SET DE_DESC_VINC = v_DESCRIPCION,
                ESTADO_VINC = v_ESTADO
          WHERE  ID_CODI_VINC = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO VINCULO
           ( ID_CODI_VINC, DE_DESC_VINC, ESTADO_VINC )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'AREA_LABORATORIO_CLINICO' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM AREA_LAB 
                          WHERE  CODIGO_ARLAB = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE AREA_LAB
            SET NOMBRE_ARLAB = v_DESCRIPCION,
                ESTADO_ARLAB = v_ESTADO
          WHERE  CODIGO_ARLAB = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO AREA_LAB
           ( CODIGO_ARLAB, NOMBRE_ARLAB, ESTADO_ARLAB )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'GRUPO_ETAREO' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM GRUPO_ETAREO 
                          WHERE  TX_CODI_GPET = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE GRUPO_ETAREO
            SET TX_NOMB_GPET = v_DESCRIPCION,
                ESTADO_GPET = v_ESTADO
          WHERE  TX_CODI_GPET = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO GRUPO_ETAREO
           ( TX_CODI_GPET, TX_NOMB_GPET, ESTADO_GPET )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'MOTIVO_REPETICION_MUESTRA_LABORATORIO_CLINICO' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM REPETICIONES_LAB 
                          WHERE  CD_CODI_RELA = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE REPETICIONES_LAB
            SET NO_NOMB_RELA = v_DESCRIPCION,
                ESTADO_RELA = v_ESTADO
          WHERE  CD_CODI_RELA = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO REPETICIONES_LAB
           ( CD_CODI_RELA, NO_NOMB_RELA, ESTADO_RELA )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'CARGO_PROFES_SALUD' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM CARGO_PROFESIONAL 
                          WHERE  NU_NUME_CAR = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE CARGO_PROFESIONAL
            SET DES_CAR_PRO = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  NU_NUME_CAR = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         
         INSERT INTO CARGO_PROFESIONAL
           ( NU_NUME_CAR, DES_CAR_PRO, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
        
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'ARTICULOS' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM ARTICULO 
                          WHERE  CD_CODI_ARTI = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE ARTICULO
            SET NO_NOMB_ARTI = v_DESCRIPCION,
                NU_ESTA_ARTI = v_ESTADO
          WHERE  CD_CODI_ARTI = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO ARTICULO
           ( CD_CODI_ARTI, NO_NOMB_ARTI, NU_ESTA_ARTI )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'ComoConocioServicio' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM TIPO_CONOCESERVICIO 
                          WHERE  TX_CODIGO_TICO = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE TIPO_CONOCESERVICIO
            SET TX_NOMBRE_TICO = v_DESCRIPCION,
                ESTADO = v_ESTADO
          WHERE  TX_CODIGO_TICO = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO TIPO_CONOCESERVICIO
           ( TX_CODIGO_TICO, TX_NOMBRE_TICO, ESTADO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'GENERO' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM GENEROS 
                          WHERE  CD_CODI_GENERO = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE GENEROS
            SET NO_NOMB_GENERO = v_DESCRIPCION,
                ES_ESTA_GENERO = v_ESTADO
          WHERE  CD_CODI_GENERO = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO GENEROS
           ( CD_CODI_GENERO, NO_NOMB_GENERO, ES_ESTA_GENERO )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'RAZA' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM RAZA 
                          WHERE  CD_CODI_RAZA = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE RAZA
            SET NO_NOMB_RAZA = v_DESCRIPCION,
                ES_ESTA_RAZA = v_ESTADO
          WHERE  CD_CODI_RAZA = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO RAZA
           ( CD_CODI_RAZA, NO_NOMB_RAZA, ES_ESTA_RAZA )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;
   IF v_TIPO = 'PROGRAMA_DEPORTIVO' THEN
    DECLARE
      v_temp NUMBER(1, 0) := 0;
   
   BEGIN
      BEGIN
         SELECT 1 INTO v_temp
           FROM DUAL
          WHERE EXISTS ( SELECT * 
                         FROM PROGRAMA_DEPORTIVO 
                          WHERE  CD_CODI_PD = v_CODIGO );
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
         
      IF v_temp = 1 THEN
       
      BEGIN
         UPDATE PROGRAMA_DEPORTIVO
            SET NO_NOMB_PD = v_DESCRIPCION,
                ES_ESTA_PD = v_ESTADO
          WHERE  CD_CODI_PD = v_CODIGO;
      
      END;
      ELSE
      
      BEGIN
         INSERT INTO PROGRAMA_DEPORTIVO
           ( CD_CODI_PD, NO_NOMB_PD, ES_ESTA_PD )
           VALUES ( v_CODIGO, v_DESCRIPCION, v_ESTADO );
      
      END;
      END IF;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_ACTUALIZA_MAESTROGENERA;