CREATE OR REPLACE PROCEDURE HIMS.H3i_SP_CITASPROXIMASMIHIMS
-- =============================================      
-- Author:  Nelson Galeano
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
IS
   v_FECHACITA DATE := iv_FECHACITA;
   v_FECHA1 VARCHAR2(10);

BEGIN

    /*TODO:SQLDEV SET  DATEFORMAT DMY /*END:SQLDEV*/
    v_FECHA1 := TO_CHAR(TO_DATE(v_FECHACITA,'DD-MM-YYYY'),10) ;
    DBMS_OUTPUT.PUT_LINE(v_FECHA1);
    -- Se aumenta para setear la fecha a YYYY-mm-dd
    
    IF v_FECHACITA <> NULL  OR v_FECHACITA <> ' ' THEN        
        BEGIN
            v_FECHACITA := TO_DATE(v_FECHACITA,'DD-MM-YYYY') ;       
        END;
    ELSE       
        BEGIN
        v_FECHACITA := TO_DATE(SYSDATE,'DD-MM-YYYY') ;       
        END;
    END IF;

    IF v_CODSER_GRUPAL = 1 THEN
    
        BEGIN
            DELETE FROM tt_TMP_CITASMASPROXIMAS_GRU_2;          
            
            INSERT INTO tt_TMP_CITASMASPROXIMAS_GRU_2 ( TX_CODI_MEDI_CIPR, TX_NOMB_MEDI_CIPR, FE_HOIN_CIPR, FE_HOFI_CIPR, CD_CODI_CONS_CIPR, NU_CIT_REST_CIPR, NU_NUME_CONE_CIPR )
            ( SELECT CD_CODI_MED_CIT TX_CODI_MEDI_CIPR, NO_NOMB_MED TX_NOMB_MEDI_CIPR, FE_FECH_CIT FE_HOIN_CIPR,(FE_FECH_CIT + v_PINTERVALO / 1440), CD_CODI_CONS_CIT CD_CODI_CONS_CIPR,
            (v_NUM_CAN_MAX_GRUP - ( SELECT COUNT(FE_FECH_CIT)  
            FROM CITAS_MEDICAS CM
            WHERE  CD_CODI_MED_CIT = v_PMEDICO
            AND CD_CODI_SER_CIT = v_CODSER
            AND NU_DURA_CIT = v_PINTERVALO
            AND FE_FECH_CIT >= v_FECHACITA
            AND FE_FECH_CIT >= SYSDATE
            AND CD_CODI_ESP_CIT = v_PESPECIALIDAD
            AND CITAS_MEDICAS.FE_FECH_CIT = CM.FE_FECH_CIT )) NU_CIT_REST_CIPR, v_PNUMCONEX 
            FROM CITAS_MEDICAS 
            JOIN MEDICOS    ON CD_CODI_MED_CIT = CD_CODI_MED
            WHERE  CD_CODI_SER_CIT = v_CODSER
            AND CD_CODI_MED_CIT = v_PMEDICO
            AND FE_FECH_CIT >= v_FECHACITA
            AND FE_FECH_CIT >= SYSDATE
            GROUP BY CD_CODI_MED_CIT,NO_NOMB_MED,FE_FECH_CIT,CD_CODI_CONS_CIT,NU_NUME_CONE_CIT );
            INSERT INTO tt_TMP_CITASMASPROXIMAS_GRU_2
            ( TX_CODI_MEDI_CIPR, TX_NOMB_MEDI_CIPR, FE_HOIN_CIPR, FE_HOFI_CIPR, CD_CODI_CONS_CIPR, NU_CIT_REST_CIPR, NU_NUME_CONE_CIPR )
            ( SELECT TX_CODI_MEDI_CIPR , TX_NOMB_MEDI_CIPR , FE_HOIN_CIPR , FE_HOFI_CIPR , CD_CODI_CONS_CIPR , v_NUM_CAN_MAX_GRUP NU_CIT_REST, NU_NUME_CONE_CIPR 
            FROM TMP_CITASMASPROXIMAS 
            WHERE  FE_HOIN_CIPR >= v_FECHACITA
            AND FE_HOIN_CIPR >= SYSDATE );-- SE FILTRA PARA LISTAR = o > A LA FECHA ACTUAL O DEL FILTRO
            OPEN  cv_1 FOR
            SELECT * 
            FROM ( SELECT 1 TIPO_AGENDA_MEDICO, TX_CODI_MEDI_CIPR , TX_NOMB_MEDI_CIPR , FE_HOIN_CIPR , FE_HOFI_CIPR , CD_CODI_CONS_CIPR , NU_CIT_REST_CIPR , ' ' COD_ESTUDIANTE, ' ' NOMB_ESTUDIANTE  ,
            0 ID_HORACAD  
            FROM tt_TMP_CITASMASPROXIMAS_GRU_2 
            WHERE  NU_NUME_CONE_CIPR = v_PNUMCONEX
            AND NU_CIT_REST_CIPR > 0
            ORDER BY FE_HOIN_CIPR )
            WHERE ROWNUM <= v_PCANTTURNOS;   
        END;
    ELSE       
        BEGIN
            OPEN  cv_1 FOR
            SELECT TIPO_AGENDA_MEDICO , TX_CODI_MEDI_CIPR , TX_NOMB_MEDI_CIPR , FE_HOIN_CIPR , FE_HOFI_CIPR , CD_CODI_CONS_CIPR , 1 NU_CIT_REST_CIPR  , COD_ESTUDIANTE ,
            NOMB_ESTUDIANTE , ID_HORACAD 
            FROM TMP_CITASMASPROXIMAS 
            WHERE  NU_NUME_CONE_CIPR = v_PNUMCONEX
            AND TIPO_AGENDA_MEDICO IN ( 7,v_CODTIPOSERV)
            AND FE_HOIN_CIPR >= v_FECHACITA
            AND FE_HOIN_CIPR >= SYSDATE
            ORDER BY FE_HOIN_CIPR ;       
        END;
    END IF;

EXCEPTION 
    WHEN OTHERS THEN 
        RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;
/