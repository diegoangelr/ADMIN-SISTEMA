SELECT NM_ACUMU.cod_empl,NM_ACUMU.cod_ccos,NM_ACUMU.COD_CONC,NM_ACUMU.can_ACUM,NM_ACUMU.fec_acum 
from nm_acumu where NM_ACUMU.fec_acum >= '01/01/2021'
and NM_ACUMU.cod_conc in(1046,1047) 
UNION ALL (select nm_preno.cod_empl,nm_preno.cod_ccos,nm_preno.COD_CONC,nm_preno.can_ACUM,nm_preno.fec_acum 
from nm_preno where nm_preno.cod_conc in(1046,1047))