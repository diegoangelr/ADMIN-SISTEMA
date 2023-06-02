select a.cod_empl CEDULA, a.cod_conc EMBARGO, b.cod_conc CONCEPTODET, b.por_conc porc , val_conc valor ,a.rmt_emba SECUENCIAL from nm_embar a, nm_conem b
where
a.rmt_emba = b.rmt_emba and
a.cod_empr = b.cod_empr and
a.est_emba ='A' AND b.cod_conc = 1106

//SCRIP VERIFICA QUE SE ESTE DESCONTANDO EMBARGO DE LA PRIMA DE PRODUCTIVIDAD //