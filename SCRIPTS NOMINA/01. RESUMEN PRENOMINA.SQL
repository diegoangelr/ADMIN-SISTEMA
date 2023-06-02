select 
DISTINCT
NM_PRENO.COD_EMPR,
NM_PRENO.COD_CARG,
NM_PRENO.COD_EMPL,
NM_PRENO.NRO_CONT,
BI_EMPLE.NOM_EMPL,
BI_EMPLE.APE_EMPL,
GN_CCOST.NOM_CCOS,NM_PRENO.STR_RES3,
(SELECT    SUM(VAL_ACUM)
    FROM    NM_PRENO x
    WHERE     ( X.cod_empr = NM_PRENO.COD_empr) AND (X.cod_empl = NM_PRENO.cod_empl) AND (X.NRO_CONT = NM_PRENO.NRO_CONT) AND x.val_ACUM > 0 AND x.COD_CONC IN(SELECT COD_CONC FROM NM_CONCE WHERE TIP_CONC='I')) DEVENGOS,
                              
(SELECT  SUM(VAL_ACUM)
    FROM    NM_PRENO x
    WHERE     ( X.cod_empr = NM_PRENO.COD_empr) AND (X.cod_empl = NM_PRENO.cod_empl) AND (X.NRO_CONT = NM_PRENO.NRO_CONT) AND x.val_ACUM > 0 AND x.COD_CONC IN(SELECT COD_CONC FROM NM_CONCE WHERE TIP_CONC='E')) DESCUENTOS

from nm_preno,bi_emple,GN_CCOST,NM_CONTR
where 
  
  nm_preno.cod_empl=bi_emple.cod_empl and  
  NM_CONTR.COD_EMPL = bi_emple.cod_empl and  
  NM_CONTR.COD_EMPL = NM_PRENO.cod_empl and 
  NM_CONTR.NRO_CONT = NM_PRENO.NRO_CONT and 
  NM_PRENO.COD_CCOS=GN_CCOST.COD_CCOS


*/De aqui se saca las prenominas negativas y el minimo vital/*



