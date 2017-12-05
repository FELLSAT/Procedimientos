CREATE OR REPLACE FUNCTION Calcular_Fecha(Pfecha_cita timestamp ,Pfecha_hora_fin timestamp)
RETURN timestamp
Is
    VResultado character(100);       VHorIni Numeric(2);     VMinIni Numeric(2);       VHorFin Numeric(2);     VMinFin Numeric(2);      VResul timestamp;                                                                                                                            
Begin                                                   
    VHorIni := Extract(Hour from Pfecha_cita);              VMinIni := Extract(Minute from Pfecha_cita);
    VHorFin := Extract(Hour from Pfecha_hora_fin);      VMinFin := Extract(Minute from Pfecha_hora_fin);    
    --DBMS_OUTPUT.PUT_LINE('Hora Inicial: '|| VHorIni || ' Minuto Inicial: '|| VMinIni || ' Hora Final: '|| VHorFin || ' Minuto Final: '|| VMinFin);                                                                                             
     VResultado := Extract(Day from Pfecha_cita) || '/' || Extract(Month from Pfecha_cita)  || '/' || Extract(Year from Pfecha_cita) || ' ' || VHorFin || ':' || VMinFin;  
     VResul := TO_TIMESTAMP(VResultado,'DD-MM-YYYY HH24:MI');
    --DBMS_OUTPUT.PUT_LINE('Rado: '|| VResultado) ;
Return VResul;
End Calcular_Fecha;