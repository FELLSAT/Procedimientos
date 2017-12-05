CREATE OR REPLACE PROCEDURE H3i_SP_CITASPROXIMAS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_PNUMCONEX IN NUMBER,
    v_PINTERVALO IN NUMBER,
    v_PMEDICO IN VARCHAR2,
    v_PESPECIALIDAD IN VARCHAR2,
    v_PCANTTURNOS IN NUMBER,
    iv_FECHACITA IN DATE,
    v_LUAT IN VARCHAR2 DEFAULT '%%' ,
    v_CODSER IN VARCHAR2 DEFAULT NULL ,
    v_CODTIPOSERV IN NUMBER DEFAULT 0 ,
    --PARA CITAS GRUPALES
    v_CODSER_GRUPAL IN NUMBER,
    v_NUM_CAN_MAX_GRUP IN NUMBER,
    --PARA CITAS DOCENTES GRUPALES
    v_ES_DOCENTE IN NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS
    v_FECHACITA DATE := iv_FECHACITA;
    v_FECHA1 VARCHAR2(10);

BEGIN

   
    v_FECHA1 := TO_CHAR(v_FECHACITA,'DD/MM/YYYY') ;
    DBMS_OUTPUT.PUT_LINE(v_FECHA1);
    -- Se aumenta para setear la fecha a YYYY-mm-dd
    IF v_FECHACITA <> NULL
      OR v_FECHACITA <> ' ' THEN
    
        BEGIN
            v_FECHACITA := TO_DATE(TO_CHAR(v_FECHACITA,'yyyy-mm-dd hh24:mi:ss'));   
        END;

    ELSE
   
        BEGIN
            v_FECHACITA := TO_DATE(TO_CHAR(SYSDATE,'yyyy-mm-dd hh24:mi:ss'));
        END;

    END IF;

   
    IF v_CODSER_GRUPAL = 1 THEN
    
        BEGIN
            DELETE FROM tt_TMP_CITASMASPROXIMAS_GRU;
      
            INSERT INTO tt_TMP_CITASMASPROXIMAS_GRU( 
                TX_CODI_MEDI_CIPR, TX_NOMB_MEDI_CIPR, 
                FE_HOIN_CIPR, FE_HOFI_CIPR, 
                CD_CODI_CONS_CIPR, NU_CIT_REST_CIPR, 
                NU_NUME_CONE_CIPR)
            (
                SELECT CD_CODI_MED_CIT TX_CODI_MEDI_CIPR  ,
                    NO_NOMB_MED TX_NOMB_MEDI_CIPR  ,
                    FE_FECH_CIT FE_HOIN_CIPR  ,
                    (FE_FECH_CIT + v_PINTERVALO / 1440) FE_HOFI_CIPR  ,
                    CD_CODI_CONS_CIT CD_CODI_CONS_CIPR ,
                    (v_NUM_CAN_MAX_GRUP - COUNT(FE_FECH_CIT)) NU_CIT_REST_CIPR  ,
                    v_PNUMCONEX 
                FROM CITAS_MEDICAS 
                INNER JOIN MEDICOS    
                    ON CD_CODI_MED_CIT = CD_CODI_MED
                WHERE  CD_CODI_SER_CIT = v_CODSER
                    AND CD_CODI_MED_CIT = v_PMEDICO
                    AND FE_FECH_CIT >= v_FECHACITA
                GROUP BY CD_CODI_MED_CIT,NO_NOMB_MED,FE_FECH_CIT,CD_CODI_CONS_CIT,NU_NUME_CONE_CIT );

      -------------------------------------------------------------------------------
            INSERT INTO tt_TMP_CITASMASPROXIMAS_GRU( 
                TX_CODI_MEDI_CIPR, TX_NOMB_MEDI_CIPR, 
                FE_HOIN_CIPR, FE_HOFI_CIPR, 
                CD_CODI_CONS_CIPR, NU_CIT_REST_CIPR, 
                NU_NUME_CONE_CIPR )
            ( 
                SELECT TX_CODI_MEDI_CIPR ,
                    TX_NOMB_MEDI_CIPR ,
                    FE_HOIN_CIPR ,
                    FE_HOFI_CIPR ,
                    CD_CODI_CONS_CIPR ,
                    v_NUM_CAN_MAX_GRUP NU_CIT_REST  ,
                    NU_NUME_CONE_CIPR 
                FROM TMP_CITASMASPROXIMAS);


            OPEN  cv_1 FOR
                SELECT TX_CODI_MEDI_CIPR, 
                    TX_NOMB_MEDI_CIPR, 
                    FE_HOIN_CIPR, 
                    FE_HOFI_CIPR, 
                    CD_CODI_CONS_CIPR,
                    NU_CIT_REST_CIPR,
                    '' COD_ESTUDIANTE,
                    ''  NOMB_ESTUDIANTE,
                    0 ID_HORACAD
                FROM tt_TMP_CITASMASPROXIMAS_GRU
                WHERE NU_NUME_CONE_CIPR = v_PNUMCONEX
                    AND NU_CIT_REST_CIPR > 0
                    AND ROWNUM <= v_PCANTTURNOS
                ORDER BY FE_HOIN_CIPR;
        END;

    ELSE
   
        BEGIN     
            OPEN  cv_1 FOR
                SELECT TIPO_AGENDA_MEDICO ,
                    TX_CODI_MEDI_CIPR ,
                    TX_NOMB_MEDI_CIPR ,
                    FE_HOIN_CIPR ,
                    FE_HOFI_CIPR ,
                    CD_CODI_CONS_CIPR ,
                    1 NU_CIT_REST_CIPR  ,
                    COD_ESTUDIANTE ,
                    NOMB_ESTUDIANTE ,
                    ID_HORACAD 
                FROM TMP_CITASMASPROXIMAS 
                WHERE NU_NUME_CONE_CIPR = v_PNUMCONEX
                    AND TIPO_AGENDA_MEDICO IN ( 7,v_CODTIPOSERV) -- condicion agregada
                    AND FE_HOIN_CIPR >= v_FECHACITA
                    AND FE_HOIN_CIPR >= SYSDATE-- SE FILTRA PARA LISTAR = o > A LA FECHA ACTUAL O DEL FILTRO                     
              ORDER BY FE_HOIN_CIPR ;      
        END;
 
   END IF;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;