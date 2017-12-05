CREATE OR REPLACE PROCEDURE H3i_SP_ACTUALIZA_PERFIL
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_CD_CODI_PERF IN VARCHAR2,
  v_NO_NOMB_PERF IN VARCHAR2,
  v_TX_SERV_PERF IN VARCHAR2,
  v_TX_ELEM_PERF IN VARCHAR2,
  v_NU_ESTADO_PERF IN NUMBER,
  v_ENTIDAD IN NUMBER,
  v_NIVEL IN NUMBER
)
AS
   v_temp NUMBER(1, 0) := 0;

BEGIN

   BEGIN
      SELECT 1 INTO v_temp
        FROM DUAL
       WHERE ( SELECT COUNT(CD_CODI_PERF)  
               FROM PERFILES 
                WHERE  CD_CODI_PERF = v_CD_CODI_PERF ) = 0;
   EXCEPTION
      WHEN OTHERS THEN
         NULL;
   END;
      
   IF v_temp = 1 THEN
      
      --NUEVO PERFIL
     BEGIN
        INSERT INTO PERFILES
          ( CD_CODI_PERF, NO_NOMB_PERF, TX_SERV_PERF, TX_ELEM_PERF, NU_ESTADO_PERF, NU_AUTO_ENTI_PERF, NU_NIVEL_SEG )
          VALUES ( v_CD_CODI_PERF, v_NO_NOMB_PERF, v_TX_SERV_PERF, v_TX_ELEM_PERF, v_NU_ESTADO_PERF, v_ENTIDAD, v_NIVEL );
        --CREANDO LOS PERMISOS DE SEGURIDAD (POR DEFECTO NO TIENE NINGUN PERMISO)
        INSERT INTO PERMISOS
          ( SELECT DISTINCT v_CD_CODI_PERF ,
                            CD_CODI_OPCI ,
                            'N' ,
                            'N' ,
                            'N' ,
                            'N' ,
                            'N' ,
                            'N' 
            FROM OPCIONES  );
     
     END;
   ELSE
   
     BEGIN
        UPDATE PERFILES
           SET NO_NOMB_PERF = v_NO_NOMB_PERF,
               TX_SERV_PERF = v_TX_SERV_PERF,
               TX_ELEM_PERF = v_TX_ELEM_PERF,
               NU_ESTADO_PERF = v_NU_ESTADO_PERF,
               NU_AUTO_ENTI_PERF = v_ENTIDAD,
               NU_NIVEL_SEG = v_NIVEL
         WHERE  CD_CODI_PERF = v_CD_CODI_PERF;
     
     END;
   END IF;

EXCEPTION
  WHEN OTHERS 
      THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;