SELECT DISTINCT DEPENDENCIA, CEDULA, SERVIDOR, COD_CARG, CARGO,  INGRESO,  AREA_RIESGO, ENCARGO,PENSIONES, CODENCARGO,NOM_ENCARGO,  IENC,FENC, ALTO_RIESGO, PROTOTIPO                             
FROM (SELECT P.RMT_PLAN ID_PLANTA,  SUBSTR(L1.NOM_TIPO,5,14) AREA_DCTO, D.NOM_NIVE NIVEL, T.COD_CCOS COD_SECCIONAL, TRIM(T.NOM_CCOS) SECCIONAL, P.COD_NIV1 || '' ||
                P.COD_NIV2 || '' ||
                P.COD_NIV3 || '' ||
                P.COD_NIV4 || '' ||
                P.COD_NIV5 || '' ||
                P.COD_NIV6 || '' ||
                P.COD_NIV7 COD_DEP, P.RMT_NIVE, L.NOM_NIVE DEPENDENCIA, P.COD_EMPL CEDULA, E.NOM_EMPL || ' ' ||
                E.APE_EMPL SERVIDOR, P.COD_CARG, G.NOM_CARG CARGO, E.FEC_NACI NACIMIENTO, C.FEC_INGR INGRESO,
              
                AR.NOM_AREA AREA_RIESGO, TRIM(CL1.NOM_NIVE) UBIC_DEP_H, C.COD_CENP ARL,
                
                CASE
                WHEN B.TIP_ENCA = 'D' THEN
                  'SI'
                ELSE
                  'NO'
              END AS ENCARGO,B.COD_CARR CODENCARGO,GE.NOM_CARG NOM_ENCARGO,B.FEC_IENC IENC,B.FEC_FENC FENC,
              CASE
                WHEN K.COD_ENTI = 45 THEN
                  'COLPENSIONES'
                  WHEN K.COD_ENTI = 44 THEN
                  'COLFONDOS'
                  WHEN K.COD_ENTI = 41 THEN
                  'PORVENIR'                   
                  WHEN K.COD_ENTI = 40 THEN
                  'PROTECCION'
                  WHEN K.COD_ENTI = 42 THEN
                  'OLDMUTUAL'
                  WHEN K.COD_ENTI = 43 THEN
                  'SKANDIA'
                  WHEN K.COD_ENTI = 51 THEN
                  'ISS'                   
                ELSE
                  'NO'
              END AS PENSIONES,

                CASE
                WHEN C.COD_GPRO < 0 THEN
                  0                
                ELSE
                  C.COD_GPRO
              END AS PROTOTIPO,

              CASE
                WHEN C.TIP_PENS = 'C' THEN
                  'SI'
                ELSE
                  'NO'
              END ALTO_RIESGO
              
                      
          FROM AC_PLANT P
          LEFT JOIN NM_CONTR C
            ON P.COD_EMPR = C.COD_EMPR
          AND P.COD_EMPL = C.COD_EMPL
          AND P.RMT_PLAN = C.RMT_PLAN
          AND C.IND_ACTI = 'A'
        INNER JOIN BI_EMPLE E
            ON P.COD_EMPR = E.COD_EMPR
          AND P.COD_EMPL = E.COD_EMPL
          LEFT JOIN BI_CARGO G
            ON P.COD_EMPR = G.COD_EMPR
          AND P.COD_CARG = G.COD_CARG
          
          LEFT JOIN AC_NIVEL D
            ON G.COD_EMPR = D.COD_EMPR
          AND G.COD_NIVE = D.COD_NIVE
          LEFT JOIN NM_ESCAR S
            ON P.COD_EMPR = S.COD_EMPR
          AND P.COD_ESCA = S.COD_ESCA
        INNER JOIN GN_ANIVE V
            ON P.COD_EMPR = V.COD_EMPR
          AND P.IDE_ARBO = V.IDE_ARBO
          AND P.RMT_NIVE = V.RMT_ANIV
        INNER JOIN GN_NIVEL L
            ON P.COD_EMPR = L.COD_EMPR
          AND P.IDE_ARBO = L.IDE_ARBO
          AND P.COD_ARBO = L.COD_ARBO
          AND V.IDE_NIVE = L.IDE_NIVE
          AND V.NUM_NIVE = L.NUM_NIVE
          LEFT JOIN GN_CCOST T
            ON P.COD_EMPR = T.COD_EMPR
          AND P.COD_CCOS = T.COD_CCOS
        INNER JOIN AC_TIPLA L1
            ON P.COD_EMPR = L1.COD_EMPR
          AND P.TIP_PLAN = L1.TIP_PLAN
          AND P.COD_TIPO = L1.COD_TIPO
          LEFT JOIN NM_ESCAR A
            ON P.COD_EMPR = A.COD_EMPR
          AND P.TIP_VINC = A.COD_ESCA
          LEFT JOIN SO_AREAS AR
            ON P.COD_EMPR = AR.COD_EMPR
          AND C.COD_AREA = AR.COD_AREA
          LEFT JOIN GN_INFSC F1
            ON F1.COD_EMPR = P.COD_EMPR
          AND P.COD_CCOS = F1.COD_SECC
          LEFT JOIN GN_NIVEL Z
            ON Z.COD_ARBO = F1.COD_ARBO
          AND Z.IDE_ARBO = F1.IDE_ARBO
          AND Z.IDE_ARBO = 'BI'
          AND Z.COD_ARBO = 1
          AND Z.NUM_NIVE = 1
          AND Z.COD_NIVE = F1.COD_NIVE
          LEFT JOIN NM_ENCAR B
            ON P.COD_EMPR = B.COD_EMPR
          AND P.COD_EMPL = B.COD_EMPL
          AND B.TIP_ENCA = 'D' 
          AND B.FEC_FENC >= CONCAT('20/',TO_CHAR((SELECT TO_DATE(sysdate) FROM DUAL),'MM/YYYY')) -- 20 del mes vigente
          AND P.RMT_PLAN = B.RMT_PLAN
    --       and B.IND_ESTA = 'A'
          LEFT JOIN BI_CARGO GE
            ON B.COD_EMPR = GE.COD_EMPR
          AND B.COD_CARR = GE.COD_CARG
          
          
          LEFT JOIN AC_MRENO X
            ON P.COD_EMPR = X.COD_EMPR
          AND P.COD_EMPL = X.COD_EMPL
          AND X.TIP_REGI = 'R'
          AND P.COD_ESCA = 3
          AND P.RMT_PLAN = X.RMT_PLAN
          AND X.ACT_ESTA = 'A'
          LEFT JOIN AC_PLANT PL
            ON B.COD_EMPR = PL.COD_EMPR
          AND B.RMT_PLAR = PL.RMT_PLAN
          LEFT JOIN GN_ANIVE NLI
            ON PL.RMT_NIVE = NLI.RMT_ANIV
          LEFT JOIN GN_NIVEL VLI
            ON NLI.COD_NIVE = VLI.COD_NIVE
          AND NLI.IDE_NIVE = VLI.IDE_NIVE
          AND NLI.NUM_NIVE = VLI.NUM_NIVE
          LEFT JOIN GN_ANIVE CV1
            ON C.RMT_NIVE = CV1.RMT_ANIV
          LEFT JOIN GN_NIVEL CL1
            ON CV1.COD_ARBO = CL1.COD_ARBO
          AND CV1.IDE_ARBO = CL1.IDE_ARBO
          AND CV1.NUM_NIVE = CL1.NUM_NIVE
          AND CV1.COD_NIVE = CL1.COD_NIVE
          AND CV1.IDE_NIVE = CL1.IDE_NIVE
        

          LEFT JOIN NM_CUENT K
            ON P.COD_EMPR    = K.COD_EMPR
          AND P.COD_EMPL = K.COD_EMPL
          AND K.TIP_ENTI = 'AFP'
          WHERE P.COD_ESCA IN(5,23,35)
        
        )

GROUP BY  DEPENDENCIA, CEDULA, SERVIDOR, COD_CARG, CARGO, INGRESO,  AREA_RIESGO, ENCARGO, CARGO, NOM_ENCARGO ,PENSIONES,CODENCARGO,IENC,FENC, ALTO_RIESGO, PROTOTIPO