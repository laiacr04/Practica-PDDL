(define (problem p3-perill)
  (:domain laberint-perillos)

  (:objects
    vermell verd porpra arc_de_sant_marti - color
    loc-1-2 loc-2-1 loc-2-2 loc-2-3 loc-3-1 loc-3-2 loc-3-3 loc-3-4 loc-4-1 loc-4-2 loc-4-3 loc-4-4 loc-5-2 loc-5-3 loc-5-4 - ubicacio
    clau1 clau2 clau3 clau4 clau5 clau6 - clau
    c1222 c2122 c2131 c2132 c2223 c2233 c2333 c2332 c3132 c3141 c3233 c3241 c3242 c3243 c3343 c4142 c4243 c4252 c5253 c5354 c5444 c4434 - passadis
  )

  (:init
    (grimmy-a loc-1-2)

    ; Connexions
    (connectat loc-1-2 loc-2-2 c1222) 
    (connectat loc-2-1 loc-2-2 c2122) 
    (connectat loc-2-1 loc-3-1 c2131) 
    (connectat loc-2-1 loc-3-2 c2132)
    (connectat loc-2-2 loc-2-3 c2223) 
    (connectat loc-2-2 loc-3-3 c2233) 
    (connectat loc-2-3 loc-3-3 c2333)  
    (connectat loc-2-3 loc-3-2 c2332)
    (connectat loc-3-1 loc-3-2 c3132) 
    (connectat loc-3-1 loc-4-1 c3141) 
    (connectat loc-3-2 loc-3-3 c3233) 
    (connectat loc-3-2 loc-4-1 c3241)
    (connectat loc-3-2 loc-4-2 c3242)
    (connectat loc-3-2 loc-4-3 c3243)
    (connectat loc-3-3 loc-4-3 c3343) 
    (connectat loc-4-1 loc-4-2 c4142)
    (connectat loc-4-2 loc-4-3 c4243) 
    (connectat loc-4-2 loc-5-2 c4252)
    (connectat loc-5-2 loc-5-3 c5253)
    (connectat loc-5-3 loc-5-4 c5354)
    (connectat loc-5-4 loc-4-4 c5444)
    (connectat loc-4-4 loc-3-4 c4434)

    ; Passadissos perillosos (que s'ensorren després d'usar-los)
    (perillos c2132)  ; Vermell
    (perillos c2232)  ; Vermell
    (perillos c2332)  ; Vermell
    (perillos c3132)  ; Vermell
    (perillos c3233)  ; Vermell
    (perillos c3241)  ; Vermell
    (perillos c3242)  ; Vermell
    (perillos c3243)  ; Vermell

    ; Ubicació de les claus
    (clau-a clau1 loc-1-2)  ; Vermell (multiús)
    (clau-a clau2 loc-3-2)  ; Verd (1 ús)
    (clau-a clau3 loc-3-2)  ; Verd (1 ús)
    (clau-a clau4 loc-3-2)  ; Porpra (1 ús)
    (clau-a clau5 loc-3-2)  ; Porpra (1 ús)
    (clau-a clau6 loc-4-4)  ; Arc de Sant Martí (1 ús)

    ; Tipus d'usos de les claus
    (clau-multi-usos clau1)  ; Vermell (usos infinits)
    (clau-un-us clau2)       ; Verd (1 ús)
    (clau-un-us clau3)       ; Verd (1 ús)
    (clau-un-us clau4)       ; Porpra (1 ús)
    (clau-un-us clau5)       ; Porpra (1 ús)
    (clau-un-us clau6)       ; Arc de Sant Martí (1 ús)

    ; Colors de les claus
    (color-clau clau1 vermell)
    (color-clau clau2 verd)
    (color-clau clau3 verd)
    (color-clau clau4 porpra)
    (color-clau clau5 porpra)
    (color-clau clau6 arc_de_sant_marti)

    ; Passadissos bloquejats
    (bloquejat c2132 vermell)
    (bloquejat c2232 vermell)
    (bloquejat c2332 vermell)
    (bloquejat c3132 vermell)
    (bloquejat c3233 vermell)
    (bloquejat c3241 vermell)
    (bloquejat c3242 vermell)
    (bloquejat c3243 vermell)
    (bloquejat c4252 porpra)
    (bloquejat c5253 verd)
    (bloquejat c5354 porpra)
    (bloquejat c5444 verd)
    (bloquejat c4434 arc_de_sant_marti)

    ; Passadissos oberts inicialment
    (obert c1222)
    (obert c2122)
    (obert c2223)
    (obert c2131)
    (obert c2333)
    (obert c3141)
    (obert c3343)
    (obert c4142)
    (obert c4243)
  )

  (:goal 
    (grimmy-a loc-3-4)
  )
)