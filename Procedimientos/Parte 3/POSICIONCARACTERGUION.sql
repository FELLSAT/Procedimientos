CREATE OR REPLACE FUNCTION POSICIONCARACTERGUION
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- Esta funcion captura la posicion del primer GUION
 -- =============================================
(
   IN_CADENA VARCHAR2
)
RETURN NUMBER
AS
   V_POSICION NUMBER := 0; --VARIABLE QUE CONTIENE LA POSCION DEL PRIMER CARACTER NO NUMERICO 
   V_CADENA VARCHAR2(200) := IN_CADENA; --VARIABLE QUE CONTIENE LA CADENA DE CARACTERES
   V_CARACTER VARCHAR2(1); -- VARIABLE QUE CONTIENE EL CARACTER DE LA PRIMERA POSICION
   V_CODIGO_ASCII NUMBER; -- VARIABLE QUE CONTIENE CODIGO ASCII DEL PRIMER CARACTER
BEGIN
   LOOP
      -- PRIMER CARACTER DE LA CADENA
      V_CARACTER := SUBSTR(V_CADENA,1,1);
      -- CODIGO ASCII DEL CARACTER
      V_CODIGO_ASCII := ASCII(V_CARACTER);
      -- ITERACION INCREMENTA
      V_POSICION := V_POSICION+1; 
      -- SI ES VACIA LA CADENA sE SALE DEL LOOP Y LA POSICION ES 0
      IF(NVL('','###')<>NVL(V_CADENA,'###')) THEN 
         --SI EL CODIGO ASCII ESTA ENTRE ESTOS VALORES SE SALE DEL LOOP 
         IF(V_CODIGO_ASCII = 45) THEN

            EXIT;
         ELSE
            V_CADENA := SUBSTR(V_CADENA,2);
         END IF;

      ELSE

         V_POSICION := 0;
         EXIT;

      END IF;
    
   END LOOP;
   
   RETURN V_POSICION;
END;