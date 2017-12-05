CREATE OR REPLACE FUNCTION fnPAM
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_P1 IN VARCHAR2,
    v_P2 IN VARCHAR2
)
RETURN VARCHAR2
AS
    v_POS NUMBER(10,0) := INSTR(v_P1, '/');
    v_C11 VARCHAR2(4) := SUBSTR(v_P1, 1, v_POS - 1);
    v_C12 VARCHAR2(4) := SUBSTR(v_P1, v_POS + 1, LENGTH(v_P1) - v_POS);
    v_C21 VARCHAR2(4) := SUBSTR(v_P2, 1, v_POS - 1);
    v_C22 VARCHAR2(4) := SUBSTR(v_P2, v_POS + 1, LENGTH(v_P2) - v_POS);

BEGIN
    IF ( v_POS <= 0 ) THEN
        RETURN NULL;
    END IF;

    v_POS := INSTR(v_P2, '/') ;
    IF ( v_POS <= 0 ) THEN
        RETURN NULL;
    END IF;
    
    IF (  LENGTH(TRIM(TRANSLATE(v_C11, ' +-.0123456789', ' '))) IS NULL 
          AND LENGTH(TRIM(TRANSLATE(v_C12, ' +-.0123456789', ' '))) IS NULL
          AND LENGTH(TRIM(TRANSLATE(v_C21, ' +-.0123456789', ' '))) IS NULL
          AND LENGTH(TRIM(TRANSLATE(v_C22, ' +-.0123456789', ' '))) IS NULL ) THEN
        DECLARE
            v_PAM VARCHAR2(50) := TO_CHAR((TO_NUMBER(v_C11) * 2/3) + (TO_NUMBER(v_C21) * 1/3)) ||
                                  '/' ||
                                  TO_CHAR((TO_NUMBER(v_C12) * 2/3) + (TO_NUMBER(v_C22) * 1/3));                  
        BEGIN
            RETURN v_PAM;   
        END;
    END IF;

    RETURN NULL;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;