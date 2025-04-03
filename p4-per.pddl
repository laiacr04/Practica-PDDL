(define (problem p4-per)
  (:domain laberint-perillos)

  (:objects 
    vermell verd porpra arc_de_sant_marti groc - color
    loc-1-1 loc-1-2 loc-2-1 loc-2-2 loc-2-3 loc-2-4 loc-3-2 loc-3-3 loc-3-4 - ubicacio
    clau1 clau2 clau3 clau4 clau5 - clau
    c1112 c1222 c2122 c2223 c2324 c2232 c3233 c3334 - passadis
  )

  (:init
    (grimmy-a loc-1-1)

    ; Connexions 
    (connectat loc-1-1 loc-1-2 c1112)
    (connectat loc-1-2 loc-2-2 c1222) 
    (connectat loc-2-1 loc-2-2 c2122) 
    (connectat loc-2-2 loc-2-3 c2223) 
    (connectat loc-2-3 loc-2-4 c2324) 
    (connectat loc-2-2 loc-3-2 c2232)
    (connectat loc-3-2 loc-3-3 c3233)
    (connectat loc-3-3 loc-3-4 c3334)

    ; Passadissos perillosos (que s'ensorren després d'usar-los)
    (perillos c1112)  ; Vermell


    ; Ubicació de les claus
    (clau-a clau1 loc-1-1)  ; Vermell (multiús)
    (clau-a clau2 loc-1-2)  ; Groc (2 usos)
    (clau-a clau3 loc-1-2)  ; Arc de Sant Martí (1 ús)
    (clau-a clau4 loc-2-1)  ; Verd (1 ús)
    (clau-a clau5 loc-2-4)  ; Porpra (1 ús)

    ; Tipus d'usos de les claus
    (clau-multi-usos clau1)  ; Vermell (usos infinits)
    (clau-dos-usos clau2)    ; Groc (2 usos)
    (clau-un-us clau3)       ; Arc de Sant Martí (1 ús)
    (clau-un-us clau4)       ; Verd (1 ús)
    (clau-un-us clau5)       ; Porpra (1 ús)

    ; Colors de les claus
    (color-clau clau1 vermell)
    (color-clau clau2 groc)
    (color-clau clau3 arc_de_sant_marti)
    (color-clau clau4 verd)
    (color-clau clau5 porpra)

    ; Passadissos bloquejats
    (bloquejat c1112 vermell)
    (bloquejat c2122 groc)
    (bloquejat c2223 groc)
    (bloquejat c2324 verd)
    (bloquejat c2232 porpra)
    (bloquejat c3233 arc_de_sant_marti)

    ; Passadissos oberts inicialment
    (obert c1222)
    (obert c3334)
  )

  (:goal 
    (grimmy-a loc-3-4)
  )
)