CREATE OR REPLACE PROCEDURE H3i_SP_GUARDA_PROG_CIR
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CD_CODI_PROG IN NUMBER,
    v_CD_CODI_SOL IN NUMBER,
    v_CD_CODI_QUI IN NUMBER,
    v_FEC_INI IN DATE,
    v_FEC_FIN IN DATE,
    v_EST_REG IN NUMBER,
    v_JUST_CANC IN VARCHAR2,
    v_ATRIB_PAC IN NUMBER,
    v_ID_REGISTRO OUT NUMBER,
    cv_1 OUT SYS_REFCURSOR
)
AS

BEGIN

    IF v_CD_CODI_PROG != 0 THEN
    
        BEGIN
            UPDATE PROG_CIR
            SET CD_CODI_SOL = v_CD_CODI_SOL,
                CD_CODI_QUI = v_CD_CODI_QUI,
                FEC_INI = v_FEC_INI,
                FEC_FIN = v_FEC_FIN,
                EST_REG = v_EST_REG,
                JUST_CANC = v_JUST_CANC,
                ATRIB_PAC = v_ATRIB_PAC
            WHERE CD_CODI_PROG = v_CD_CODI_PROG;
            
            v_ID_REGISTRO := v_CD_CODI_PROG ;       
       END;

    ELSE
   
        BEGIN
            INSERT INTO PROG_CIR( 
                CD_CODI_SOL, CD_CODI_QUI, FEC_INI, FEC_FIN, EST_REG )
            VALUES( 
                v_CD_CODI_SOL, v_CD_CODI_QUI, v_FEC_INI, v_FEC_FIN, v_EST_REG );

            SELECT CD_CODI_PROG 
            INTO v_ID_REGISTRO 
            FROM PROG_CIR
            WHERE CD_CODI_PROG = (SELECT MAX(CD_CODI_PROG) FROM PROG_CIR);           
        END;

    END IF;


    OPEN  cv_1 FOR
        SELECT v_ID_REGISTRO 
        FROM DUAL;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;