(define (problem p1-sim)
  (:domain laberint-simple)

  ; Objectes utilitzats en el problema
  (:objects
    vermell groc verd porpra arc_de_sant_marti - color
    loc-1-3 loc-2-1 loc-2-2 loc-2-3 loc-2-4 loc-3-2 loc-3-3 loc-4-2 loc-4-3 loc-4-4 - ubicacio
    clau1 clau2 clau3 clau4 - clau
    c1323 c2122 c2223 c2324 c2232 c2333 c3233 c3242 c3343 c4243 c4344 - passadis
  )

  (:init
    ; On es troba inicialment en Grimmy
    (grimmy-a loc-2-1)

    ; Connexions
    (connectat loc-2-3 loc-1-3 c1323) 
    (connectat loc-2-1 loc-2-2 c2122) 
    (connectat loc-2-2 loc-2-3 c2223) 
    (connectat loc-2-3 loc-2-4 c2324) 
    (connectat loc-2-2 loc-3-2 c2232) 
    (connectat loc-3-3 loc-2-3 c2333) 
    (connectat loc-3-2 loc-3-3 c3233) 
    (connectat loc-3-2 loc-4-2 c3242) 
    (connectat loc-4-3 loc-3-3 c3343) 
    (connectat loc-4-2 loc-4-3 c4243) 
    (connectat loc-4-3 loc-4-4 c4344)

    ; Ubicació de les claus
    (clau-a clau1 loc-2-2)
    (clau-a clau2 loc-4-2)
    (clau-a clau3 loc-2-4)
    (clau-a clau4 loc-4-4)

    ; Color de les claus
    (color-clau clau1 vermell)
    (color-clau clau2 groc)
    (color-clau clau3 arc_de_sant_marti)
    (color-clau clau4 porpra)

    ; Passadissos bloquejats
    (bloquejat c3242 vermell)
    (bloquejat c4243 vermell)
    (bloquejat c4344 groc)
    (bloquejat c2324 porpra)
    (bloquejat c1323 arc_de_sant_marti)

    ; Passadissos oberts inicialment
    (obert c2122)
    (obert c2223)
    (obert c2232)
    (obert c2333)
    (obert c3233)
    (obert c3343)
  )

  (:goal
    (and (grimmy-a loc-1-3)) ; L'ojectiu d'en Grimmy 
  )
)
