CREATE OR REPLACE FUNCTION EdadPaciente
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
  v_NumHist IN VARCHAR2,
  v_TipoSal IN NUMBER
)
RETURN NUMBER
AUTHID DEFINER
AS
   v_DIAS NUMBER(10,0);
   v_EDAD NUMBER(10,0);
   v_UME NUMBER(10,0);

BEGIN
    SELECT TO_CHAR(SYSDATE,'DD') - TO_CHAR(FE_NACI_PAC,'DD')
    INTO v_DIAS
    FROM PACIENTES 
    WHERE  NU_HIST_PAC = v_NumHist;
   

    IF ( v_DIAS < 30 ) THEN
    
        BEGIN
            v_EDAD := v_DIAS ;
            v_UME := 3 ;   
        END;
    ELSE
   
        BEGIN
            IF ( v_DIAS < 365 ) THEN       
                BEGIN
                    v_EDAD := v_DIAS / 30 ;
                    v_UME := 2 ;                
                END;
            ELSE          
                BEGIN
                    v_EDAD := v_DIAS / 365 ;
                    v_UME := 1 ;
                
                END;
            END IF;   
        END;
    END IF;


    IF v_TipoSal = 1 THEN
        RETURN v_EDAD;
    ELSE
        RETURN v_UME;
    END IF;

   RETURN NULL;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;