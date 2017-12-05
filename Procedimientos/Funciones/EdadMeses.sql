CREATE OR REPLACE FUNCTION EdadMeses
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
   v_FechaNacimiento IN DATE,
   v_FechaCompara IN DATE
)
RETURN NUMBER
AS
   v_AjusteMes NUMBER;
   v_AjusteDia NUMBER;
   v_Edad NUMBER;

BEGIN
   v_AjusteMes := 1 ;
   v_AjusteDia := 1 ;

   IF TO_CHAR(v_FechaCompara,'MM') >= TO_CHAR(v_FechaNacimiento,'MM') THEN    
      BEGIN
         v_AjusteMes := 0;      
      END;
   END IF;
   

   IF TO_CHAR(v_FechaCompara,'DD') >= TO_CHAR(v_FechaNacimiento,'DD') THEN    
      BEGIN
         v_AjusteDia := 0 ;   
      END;
   END IF;

   IF TO_CHAR(v_FechaCompara,'MM') >= TO_CHAR(v_FechaNacimiento) THEN    
      BEGIN
         v_Edad := ((TO_CHAR(v_FechaCompara,'YYYY') - 
                     TO_CHAR(v_FechaNacimiento,'YYYY') - 
                     v_AjusteMes) * 12) 
                  + (TO_CHAR(v_FechaCompara,'MM') - 
                     TO_CHAR(v_FechaNacimiento,'MM') - 
                     v_AjusteDia) ;      
      END;
   ELSE
   
      BEGIN
         v_Edad := ((TO_CHAR(v_FechaCompara,'YYYY') - 
                     TO_CHAR(v_FechaNacimiento,'YYYY') - 
                     v_AjusteMes) * 12) 
                  + ((12 - TO_CHAR(v_FechaNacimiento,'MM')) + 
                     TO_CHAR(v_FechaCompara,'MM') - 
                     v_AjusteDia) ;   
      END;
   END IF;

   
   RETURN v_Edad;

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;