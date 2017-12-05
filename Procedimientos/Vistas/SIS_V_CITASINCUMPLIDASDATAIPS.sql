CREATE OR REPLACE VIEW SIS_V_CITASINCUMPLIDASDATAIPS
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
AS 
     SELECT ' ' IdCita  ,
          ' ' IPS  ,
          ' ' Medico  ,
          ' ' fechahora  ,
          ' ' fe_fech_cit  ,
          ' ' Eps  ,
          '0' TipoId  ,
          ' ' Identificacion  ,
          ' ' NombreCompleto  ,
          ' ' TipoCita  ,
          ' ' Especialidad  ,
          0 Saldo  
     FROM DUAL 
     WHERE  0 = 1;