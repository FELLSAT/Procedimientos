CREATE OR REPLACE PROCEDURE H3i_SP_CONSULTA_MESTROGENERAL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_TIPO IN VARCHAR2 DEFAULT NULL ,
  v_BUSCARPOR IN NUMBER DEFAULT 0 ,
  v_CRITERIO IN VARCHAR2 DEFAULT NULL ,
  cv_1 OUT SYS_REFCURSOR,
  cv_2 OUT SYS_REFCURSOR,
  cv_3 OUT SYS_REFCURSOR,
  cv_4 OUT SYS_REFCURSOR,
  cv_5 OUT SYS_REFCURSOR,
  cv_6 OUT SYS_REFCURSOR,
  cv_7 OUT SYS_REFCURSOR,
  cv_8 OUT SYS_REFCURSOR,
  cv_9 OUT SYS_REFCURSOR,
  cv_10 OUT SYS_REFCURSOR,
  cv_11 OUT SYS_REFCURSOR,
  cv_12 OUT SYS_REFCURSOR,
  cv_13 OUT SYS_REFCURSOR,
  cv_14 OUT SYS_REFCURSOR,
  cv_15 OUT SYS_REFCURSOR,
  cv_16 OUT SYS_REFCURSOR,
  cv_17 OUT SYS_REFCURSOR,
  cv_18 OUT SYS_REFCURSOR,
  cv_19 OUT SYS_REFCURSOR,
  cv_20 OUT SYS_REFCURSOR,
  cv_21 OUT SYS_REFCURSOR,
  cv_22 OUT SYS_REFCURSOR,
  cv_23 OUT SYS_REFCURSOR,
  cv_24 OUT SYS_REFCURSOR,
  cv_25 OUT SYS_REFCURSOR,
  cv_26 OUT SYS_REFCURSOR,
  cv_27 OUT SYS_REFCURSOR,
  cv_28 OUT SYS_REFCURSOR,
  cv_29 OUT SYS_REFCURSOR,
  cv_30 OUT SYS_REFCURSOR,
  cv_31 OUT SYS_REFCURSOR,
  cv_32 OUT SYS_REFCURSOR,
  cv_33 OUT SYS_REFCURSOR,
  cv_34 OUT SYS_REFCURSOR,
  cv_35 OUT SYS_REFCURSOR,
  cv_36 OUT SYS_REFCURSOR,
  cv_37 OUT SYS_REFCURSOR,
  cv_38 OUT SYS_REFCURSOR,
  cv_39 OUT SYS_REFCURSOR,
  cv_40 OUT SYS_REFCURSOR
)
AS

BEGIN

   -- 1   
   IF v_TIPO = 'OCUPACION' THEN
    
   BEGIN
      OPEN  cv_1 FOR
         SELECT CD_CODI_OCUP ,
                DE_DESC_OCUP ,
                ESTADO 
           FROM OCUPACION 
          WHERE  CD_CODI_OCUP = (CASE v_BUSCARPOR
                                                 WHEN 0 THEN NVL(v_CRITERIO, CD_CODI_OCUP)
                 ELSE CD_CODI_OCUP
                    END)
                   AND DE_DESC_OCUP LIKE (CASE v_BUSCARPOR
                                                          WHEN 1 THEN '%' || NVL(v_CRITERIO, DE_DESC_OCUP) || '%'
                 ELSE DE_DESC_OCUP
                    END) ;
   
   END;
   END IF;
   -- 2 
   IF v_TIPO = 'RELIGION' THEN
    
   BEGIN
      OPEN  cv_2 FOR
         SELECT CD_CODI_RELI ,
                DE_DESC_RELI ,
                ESTADO 
           FROM RELIGION 
          WHERE  CD_CODI_RELI = (CASE v_BUSCARPOR
                                                 WHEN 0 THEN NVL(v_CRITERIO, CD_CODI_RELI)
                 ELSE CD_CODI_RELI
                    END)
                   AND DE_DESC_RELI LIKE (CASE v_BUSCARPOR
                                                          WHEN 1 THEN '%' || NVL(v_CRITERIO, DE_DESC_RELI) || '%'
                 ELSE DE_DESC_RELI
                    END) ;
   
   END;
   END IF;
   -- 3    
   IF v_TIPO = 'PARENTESCO' THEN
    
   BEGIN
      OPEN  cv_3 FOR
         SELECT CD_CODI_PARE ,
                DE_DESC_PARE ,
                ESTADO 
           FROM PARENTESCO 
          WHERE  CD_CODI_PARE = (CASE v_BUSCARPOR
                                                 WHEN 0 THEN NVL(v_CRITERIO, CD_CODI_PARE)
                 ELSE CD_CODI_PARE
                    END)
                   AND DE_DESC_PARE LIKE (CASE v_BUSCARPOR
                                                          WHEN 1 THEN '%' || NVL(v_CRITERIO, DE_DESC_PARE) || '%'
                 ELSE DE_DESC_PARE
                    END) ;
   
   END;
   END IF;
   --4    
   IF v_TIPO = 'ZONA' THEN
    
   BEGIN
      OPEN  cv_4 FOR
         SELECT CD_CODI_ZORE ,
                DE_DESC_ZORE ,
                ESTADO 
           FROM ZONARESIDENCIA 
          WHERE  CD_CODI_ZORE = (CASE v_BUSCARPOR
                                                 WHEN 0 THEN NVL(v_CRITERIO, CD_CODI_ZORE)
                 ELSE CD_CODI_ZORE
                    END)
                   AND DE_DESC_ZORE LIKE (CASE v_BUSCARPOR
                                                          WHEN 1 THEN '%' || NVL(v_CRITERIO, DE_DESC_ZORE) || '%'
                 ELSE DE_DESC_ZORE
                    END) ;
   
   END;
   END IF;
   --5    
   IF v_TIPO = 'ESCOLARIDAD' THEN
    
   BEGIN
      OPEN  cv_5 FOR
         SELECT CD_CODI_ESCO ,
                NO_NOMB_ESCO ,
                ESTADO 
           FROM ESCOLARIDAD 
          WHERE  CD_CODI_ESCO = (CASE v_BUSCARPOR
                                                 WHEN 0 THEN NVL(v_CRITERIO, CD_CODI_ESCO)
                 ELSE CD_CODI_ESCO
                    END)
                   AND NO_NOMB_ESCO LIKE (CASE v_BUSCARPOR
                                                          WHEN 1 THEN '%' || NVL(v_CRITERIO, NO_NOMB_ESCO) || '%'
                 ELSE NO_NOMB_ESCO
                    END) ;
   
   END;
   END IF;
   -- 6    
   IF v_TIPO = 'VIAADMINISTRACION' THEN
    
   BEGIN
      OPEN  cv_6 FOR
         SELECT CD_CODI_ADO ,
                NO_NOMB_ADO ,
                ESTADO 
           FROM ADM_DOSIS 
          WHERE  CD_CODI_ADO = (CASE v_BUSCARPOR
                                                WHEN 0 THEN NVL(v_CRITERIO, CD_CODI_ADO)
                 ELSE CD_CODI_ADO
                    END)
                   AND NO_NOMB_ADO LIKE (CASE v_BUSCARPOR
                                                         WHEN 1 THEN '%' || NVL(v_CRITERIO, NO_NOMB_ADO) || '%'
                 ELSE NO_NOMB_ADO
                    END)
           ORDER BY 2 ;
   
   END;
   END IF;
   -- 7    
   IF v_TIPO = 'TIPOLENTE' THEN
    
   BEGIN
      OPEN  cv_7 FOR
         SELECT TO_CHAR(NU_AUTO_TILE,30) NU_AUTO_TILE  ,
                TX_NOMB_TILE ,
                ESTADO 
           FROM TIPO_LENTE 
          WHERE  NU_AUTO_TILE = (CASE v_BUSCARPOR
                                                 WHEN 0 THEN NVL(v_CRITERIO, NU_AUTO_TILE)
                 ELSE TO_CHAR(NU_AUTO_TILE)
                    END)
                   AND TX_NOMB_TILE LIKE (CASE v_BUSCARPOR
                                                          WHEN 1 THEN '%' || NVL(v_CRITERIO, TX_NOMB_TILE) || '%'
                 ELSE TX_NOMB_TILE
                    END)
           ORDER BY 2 ;
   
   END;
   END IF;
   -- 8  
   IF v_TIPO = 'CAUSAEXTERNA' THEN
    
   BEGIN
      OPEN  cv_8 FOR
         SELECT ID_CODI_CAEX ,
                DE_DESC_CAEX ,
                ESTADO 
           FROM CAUSAEXTERNA  ;
   
   END;
   END IF;
   -- 9  
   IF v_TIPO = 'ETNIA' THEN
    
   BEGIN
      OPEN  cv_9 FOR
         SELECT TX_CODIGO_ETNI ,
                TX_NOMBRE_ETNI ,
                ESTADO 
           FROM ETNIA  ;
   
   END;
   END IF;
   -- 10 
   IF v_TIPO = 'PLAN_DE_SALUD' THEN
    
   BEGIN
      OPEN  cv_10 FOR
         SELECT CD_CODI_PLAN ,
                DE_DESC_PLAN ,
                ESTADO 
           FROM PLANES  ;
   
   END;
   END IF;
   -- 11 
   IF v_TIPO = 'FORMAS_DE_PAGO' THEN
    
   BEGIN
      OPEN  cv_11 FOR
         SELECT NU_NUME_FOPA ,
                DE_DESC_FOPA ,
                ESTADO 
           FROM FORMA_PAGO  ;
   
   END;
   END IF;
   -- 12 
   IF v_TIPO = 'MOTIVOS_DE_INACTIVACION' THEN
    
   BEGIN
      OPEN  cv_12 FOR
         SELECT CD_CODI_MIN ,
                NO_NOMB_MIN ,
                ESTADO 
           FROM MOTIVO_INACTIVA  ;
   
   END;
   END IF;
   -- 13  
   IF v_TIPO = 'MOTIVO_NO_AUTORIZACION' THEN
    
   BEGIN
      OPEN  cv_13 FOR
         SELECT CD_CODI_MNA ,
                DE_DESC_MNA ,
                ESTADO 
           FROM MOTIVO_NOAUTO  ;
   
   END;
   END IF;
   -- 14  
   IF v_TIPO = 'TIPO_DE_TURNO' THEN
    
   BEGIN
      OPEN  cv_14 FOR
         SELECT TO_CHAR(NU_AUTO_TIPO_TUME,30) NU_AUTO_TIPO_TUME  ,
                TX_DESC_TIPO_TUME ,
                ESTADO 
           FROM TIPO_TURNO_MED  ;
   
   END;
   END IF;
   -- 15 
   IF v_TIPO = 'MOTIVO_ANULACION' THEN
    
   BEGIN
      OPEN  cv_15 FOR
         SELECT CD_CODI_MOTI ,
                DE_DESC_MOTI ,
                ESTADO 
           FROM MOTIVOANUL  ;
   
   END;
   END IF;
   -- 16  
   IF v_TIPO = 'ESPECIALIDADES' THEN
    
   BEGIN
      OPEN  cv_16 FOR
         SELECT CD_CODI_ESP ,
                NO_NOMB_ESP ,
                ESTADO 
           FROM ESPECIALIDADES  ;
   
   END;
   END IF;
   -- 17
   IF v_TIPO = 'PROCEDIMIENTO_ESPECIALIDAD' THEN
    
   BEGIN
      OPEN  cv_17 FOR
         SELECT CD_CODI_SER ,
                NO_NOMB_SER ,
                ESTADO 
           FROM SERVICIOS  ;
   
   END;
   END IF;
   -- 18 
   IF v_TIPO = 'ComoConocioServicio' THEN
    
   BEGIN
      OPEN  cv_18 FOR
         SELECT TX_CODIGO_TICO ,
                TX_NOMBRE_TICO ,
                ESTADO 
           FROM TIPO_CONOCESERVICIO  ;
   
   END;
   END IF;
   -- 19  
   IF v_TIPO = 'RECLAMOS_REEMBOLSOS' THEN
    
   BEGIN
      OPEN  cv_19 FOR
         SELECT COD_REC_REE ,
                DES_REC_REE ,
                ESTADO 
           FROM RECLAMOS_REEMBOLSOS  ;
   
   END;
   END IF;
   -- 20  
   IF v_TIPO = 'POBLACION_ESPECIAL' THEN
    
   BEGIN
      OPEN  cv_20 FOR
         SELECT COD_POB_ESP ,
                DES_POB_ESP ,
                ESTADO 
           FROM POBLACION_ESPECIAL  ;
   
   END;
   END IF;
   -- 21 
   IF v_TIPO = 'ACTIVIDAD_POLIZA' THEN
    
   BEGIN
      OPEN  cv_21 FOR
         SELECT COD_ACT_POLI ,
                DESC_ACT_POLI ,
                ESTADO 
           FROM ACTIVIDAD_POLIZA  ;
   
   END;
   END IF;
   -- 22
   IF v_TIPO = 'ACTIVIDAD_GESTION' THEN
    
   BEGIN
      OPEN  cv_22 FOR
         SELECT COD_ACT_GES ,
                DESC_ACT_GES ,
                ESTADO 
           FROM ACTIVIDAD_GESTION  ;
   
   END;
   END IF;
   -- 23  
   IF v_TIPO = 'TIPO_DE_USUARIO_ADM' THEN
    
   BEGIN
      OPEN  cv_23 FOR
         SELECT COD_TIP_USU ,
                NOM_TIP_USU ,
                ESTADO 
           FROM TIPO_USUARIO_ADM  ;
   
   END;
   END IF;
   -- 24  
   IF v_TIPO = 'ROLES' THEN
    
   BEGIN
      OPEN  cv_24 FOR
         SELECT CD_CODI_ROL ,
                DE_DESC_ROL ,
                ESTADO 
           FROM ROLES  ;
   
   END;
   END IF;
   -- 25 
   IF v_TIPO = 'MODALIDAD_VINCULACIÓN_PROFESIONAL_ASISTENCIAL' THEN
    
   BEGIN
      OPEN  cv_25 FOR
         SELECT TX_CODI_MOCO ,
                TX_DESCRIBE_MOCO ,
                ESTADO 
           FROM MODALIDAD_CONTRATO  ;
   
   END;
   END IF;
   IF v_TIPO = 'TIPO_LUGAR_DE_ATENCION' THEN
    
   BEGIN
      OPEN  cv_26 FOR
         SELECT CD_CODI_TLUAT ,
                NO_NOMB_TLUAT ,
                ESTADO 
           FROM TIPO_LUGAR_ATENCION  ;
   
   END;
   END IF;
   IF v_TIPO = 'SINIESTRO_AMPARADO' THEN
    
   BEGIN
      OPEN  cv_27 FOR
         SELECT COD_SIN_AMP ,
                DES_SIN_AMP ,
                ESTADO 
           FROM SINIESTRO_AMPARADO  ;
   
   END;
   END IF;
   IF v_TIPO = 'APOYO_ECONOMICO' THEN
    
   BEGIN
      OPEN  cv_28 FOR
         SELECT CD_CODI_APEC ,
                DE_DESCRIP_APEC ,
                NU_ESTADO_APEC ESTADO  
           FROM APOYO_ECONOMICO  ;
   
   END;
   END IF;
   IF v_TIPO = 'DEPENDENCIAS' THEN
    
   BEGIN
      OPEN  cv_29 FOR
         SELECT CD_CODI_DEPE ,
                DE_DESC_DEPE ,
                ESTADO_DEP ESTADO  
           FROM DEPENDENCIA  ;
   
   END;
   END IF;
   IF v_TIPO = 'CENTRO_COSTO' THEN
    
   BEGIN
      OPEN  cv_30 FOR
         SELECT CD_CODI_CECO ,
                NO_NOMB_CECO ,
                ESTADO_CEC ESTADO  
           FROM CENTRO_COSTO  ;
   
   END;
   END IF;
   IF v_TIPO = 'REGIMEN' THEN
    
   BEGIN
      OPEN  cv_31 FOR
         SELECT ID_CODI_TIUS ,
                DE_DESC_TIUS ,
                ESTADO_TUSR ESTADO  
           FROM TIPOUSUARIO  ;
   
   END;
   END IF;
   IF v_TIPO = 'VINCULO' THEN
    
   BEGIN
      OPEN  cv_32 FOR
         SELECT ID_CODI_VINC ,
                DE_DESC_VINC ,
                ESTADO_VINC ESTADO  
           FROM VINCULO  ;
   
   END;
   END IF;
   IF v_TIPO = 'AREA_LABORATORIO_CLINICO' THEN
    
   BEGIN
      OPEN  cv_33 FOR
         SELECT CODIGO_ARLAB ,
                NOMBRE_ARLAB ,
                ESTADO_ARLAB ESTADO  
           FROM AREA_LAB  ;
   
   END;
   END IF;
   IF v_TIPO = 'GRUPO_ETAREO' THEN
    
   BEGIN
      OPEN  cv_34 FOR
         SELECT TX_CODI_GPET ,
                TX_NOMB_GPET ,
                ESTADO_GPET ESTADO  
           FROM GRUPO_ETAREO  ;
   
   END;
   END IF;
   IF v_TIPO = 'MOTIVO_REPETICION_MUESTRA_LABORATORIO_CLINICO' THEN
    
   BEGIN
      OPEN  cv_35 FOR
         SELECT CD_CODI_RELA ,
                NO_NOMB_RELA ,
                ESTADO_RELA ESTADO  
           FROM REPETICIONES_LAB  ;
   
   END;
   END IF;
   IF v_TIPO = 'CARGO_PROFES_SALUD' THEN
    
   BEGIN
      OPEN  cv_36 FOR
         SELECT NU_NUME_CAR ,
                DES_CAR_PRO ,
                ESTADO 
           FROM CARGO_PROFESIONAL  ;
   
   END;
   END IF;
   IF v_TIPO = 'ARTICULOS' THEN
    
   BEGIN
      OPEN  cv_37 FOR
         SELECT CD_CODI_ARTI ,
                NO_NOMB_ARTI ,
                NU_ESTA_ARTI ESTADO  
           FROM ARTICULO 
           ORDER BY NO_NOMB_ARTI ;
   
   END;
   END IF;
   IF v_TIPO = 'RAZA' THEN
    
   BEGIN
      OPEN  cv_38 FOR
         SELECT CD_CODI_RAZA ,
                NO_NOMB_RAZA ,
                ES_ESTA_RAZA ESTADO  
           FROM RAZA  ;
   
   END;
   END IF;
   IF v_TIPO = 'GENERO' THEN
    
   BEGIN
      OPEN  cv_39 FOR
         SELECT CD_CODI_GENERO ,
                NO_NOMB_GENERO ,
                ES_ESTA_GENERO ESTADO  
           FROM GENEROS  ;
   
   END;
   END IF;
   IF v_TIPO = 'PROGRAMA_DEPORTIVO' THEN
    
   BEGIN
      OPEN  cv_40 FOR
         SELECT CD_CODI_PD ,
                NO_NOMB_PD ,
                ES_ESTA_PD ESTADO  
           FROM PROGRAMA_DEPORTIVO  ;
   
   END;
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END H3i_SP_CONSULTA_MESTROGENERAL;