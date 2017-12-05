CREATE OR REPLACE FUNCTION ProcedimientoUnicaEspe
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    v_CodProc IN VARCHAR2,
    v_Operacion IN NUMBER
)
RETURN VARCHAR2
AS
    v_Rta VARCHAR2(50);
    v_Cuantos NUMBER(10,0);

BEGIN
    SELECT COUNT(*)  
    INTO v_Cuantos
    FROM R_ESP_SER 
    WHERE  CD_CODI_SER_RES = v_CodProc;
    
    IF v_Operacion = 1 THEN
    
        BEGIN
            IF v_Cuantos = 0 THEN 
       
                BEGIN
                    v_Rta := '-1' ;      
                END;
            ELSE
                IF v_Cuantos = 1 THEN
          
                    BEGIN
                        v_Rta := '1' ;         
                    END;
                ELSE         
                    BEGIN
                        v_Rta := '0' ;         
                    END;
                END IF;
            END IF;
   
        END;
   END IF;


    --SET @Rta = CAST(@CUANTOS AS NVARCHAR(10))
    IF v_Operacion = 2 THEN    
        BEGIN
            IF v_CUANTOS > 1
              OR v_CUANTOS = 0 THEN
           
                BEGIN
                    v_RTA := NULL ;
                END;

            ELSE
          
                BEGIN
                    SELECT CD_CODI_ESP_RES 
                    INTO v_RTA
                    FROM R_ESP_SER 
                    WHERE  CD_CODI_SER_RES = v_CodProc;      
                END;
            END IF;
       
        END;
    END IF;


    IF v_Operacion = 3 THEN
    
        BEGIN
            IF v_CUANTOS > 1 OR v_CUANTOS = 0 THEN
       
                BEGIN
                    v_RTA := NULL ;      
                END;
            ELSE
      
                BEGIN
                    SELECT NO_NOMB_ESP 
                    INTO v_RTA
                    FROM R_ESP_SER 
                    INNER JOIN ESPECIALIDADES    
                        ON CD_CODI_ESP_RES = CD_CODI_ESP
                    WHERE  CD_CODI_SER_RES = v_CodProc;
                END;
            END IF;
   
        END;  
    END IF;
    

    RETURN v_Rta;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;