SELECT C.COD_EMPL, C.COD_CARG,G.NOM_CARG, C.FEC_SUEL , A.CON_FIJ6 BJACARGO, G.SUE_BASI  , H.VAL_CONC BJHOCOF, U.NOM_AREA, 
H.FEC_NOVE FECNOVHOCOF, H.FEC_FINA FECFINHOCOF, C.IND_ACTI, C.cOD_TNOM TIPONOMINA, H.EST_NOVE, H.NUM_CONC
FROM NM_CONTR C
LEFT JOIN SO_AREAS U ON C.COD_AREA = U.COD_AREA
LEFT JOIN BI_CARGO G ON C.COD_CARG = G.COD_CARG
LEFT JOIN BI_ACARG A ON C.COD_CARG = A.COD_CARG  
 LEFT JOIN NM_HOCOF H ON C.COD_EMPL = H.COD_EMPL  
 WHERE C.IND_ACTI = 'A' AND A.CON_FIJ5  <> H.VAL_CONC
AND H.NUM_CONC = 5 AND H.FEC_NOVE >='01/01/2022' AND C.NRO_CONT = H.NRO_CONT
AND H.EST_NOVE = 'A' AND C.COD_TNOM = 1
ORDER BY C.COD_EMPL