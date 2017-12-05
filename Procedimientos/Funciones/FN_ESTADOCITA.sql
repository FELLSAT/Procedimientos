CREATE OR REPLACE FUNCTION FN_ESTADOCITA
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
   v_NU_ESTA_CIT IN NUMBER
)
RETURN VARCHAR2
AS
   v_ESTADO VARCHAR2(50);

BEGIN
   v_ESTADO := 'N/A' ;
   ----------------------------------------
   IF ( v_NU_ESTA_CIT = 0 ) THEN    
      BEGIN
         v_ESTADO := 'Asignada' ;   
      END;
   END IF;
   ----------------------------------------
   IF ( v_NU_ESTA_CIT = 1 ) THEN    
      BEGIN
         v_ESTADO := 'Asistio' ;   
      END;
   END IF;
   ----------------------------------------
   IF ( v_NU_ESTA_CIT = 2 ) THEN    
      BEGIN
         v_ESTADO := 'No Asistio' ;   
      END;
   END IF;
   ----------------------------------------
   IF ( v_NU_ESTA_CIT = 3 ) THEN    
      BEGIN
         v_ESTADO := 'Asignada normal' ;   
      END;
   END IF;
   ----------------------------------------
   IF ( v_NU_ESTA_CIT = 4 ) THEN    
      BEGIN
         v_ESTADO := 'Asignada prioritaria' ;   
      END;
   END IF;
   ----------------------------------------
   IF ( v_NU_ESTA_CIT = 5 ) THEN    
      BEGIN
         v_ESTADO := 'Asignada reasignada' ;   
      END;
   END IF;
   ----------------------------------------
   IF ( v_NU_ESTA_CIT = 6 ) THEN    
      BEGIN
         v_ESTADO := 'Asistio puntual' ;   
      END;
   END IF;
   ----------------------------------------
   IF ( v_NU_ESTA_CIT = 7 ) THEN    
      BEGIN
         v_ESTADO := 'Asistio retardo' ;   
      END;
   END IF;
   ----------------------------------------
   IF ( v_NU_ESTA_CIT = 8 ) THEN    
      BEGIN
         v_ESTADO := 'Anulado' ;   
      END;
   END IF;
   ----------------------------------------
   IF ( v_NU_ESTA_CIT = 9 ) THEN    
      BEGIN
         v_ESTADO := 'Atentida' ;   
      END;
   END IF;
   ----------------------------------------
   RETURN v_ESTADO;


EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;