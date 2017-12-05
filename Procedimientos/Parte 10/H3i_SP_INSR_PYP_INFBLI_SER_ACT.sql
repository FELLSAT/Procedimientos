CREATE OR REPLACE PROCEDURE H3i_SP_INSR_PYP_INFBLI_SER_ACT
 -- =============================================      
 -- Author:  FELIPE SATIZABAL
 -- =============================================
(
    V_NU_CONS_RSA_PIOSA IN NUMBER,
    V_NU_AUTO_PYPINFOBLI_PIOSA IN NUMBER,
    V_NU_NUME_PLHI_RPC_PIOSA IN NUMBER,
    V_NU_NUME_COHI_RPC_PIOSA IN NUMBER,
    V_NU_NUME_GRHI_RPC_PIOSA IN NUMBER
)

AS
BEGIN

    INSERT INTO PYP_INFOBLI_SER_ACT(
        NU_CONS_RSA_PIOSA,
        NU_AUTO_PYPINFOBLI_PIOSA,
        NU_NUME_PLHI_RPC_PIOSA,
        NU_NUME_COHI_RPC_PIOSA,
        NU_NUME_GRHI_RPC_PIOSA)
    VALUES(
        V_NU_CONS_RSA_PIOSA, 
        V_NU_AUTO_PYPINFOBLI_PIOSA, 
        V_NU_NUME_PLHI_RPC_PIOSA, 
        V_NU_NUME_COHI_RPC_PIOSA, 
        V_NU_NUME_GRHI_RPC_PIOSA);

EXCEPTION 
    WHEN OTHERS 
        THEN RAISE_APPLICATION_ERROR(SQLCODE,SQLERRM);
END;