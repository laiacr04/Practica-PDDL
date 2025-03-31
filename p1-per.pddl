(define (problem p1-perill)
  (:domain laberint-perillos)

  (:objects
    vermell groc verd porpra arc_de_sant_marti - color
    loc-1-3 loc-2-1 loc-2-2 loc-2-3 loc-2-4 loc-3-2 loc-3-3 loc-4-2 loc-4-3 loc-4-4 - ubicacio
    clau1 clau2 clau3 clau4 - clau
    c1323 c2122 c2223 c2324 c2232 c2333 c3233 c3242 c3343 c4243 c4344 - passadis
  )

  (:init
    (grimmy-a loc-2-1)

    ;; Connexions amb simetria
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

    ;; Passadissos perillosos (amb pany vermell)
    (perillos c3242)
    (perillos c4243)

    ;; Ubicació de les claus
    (clau-a clau1 loc-2-2)
    (clau-a clau2 loc-4-2)
    (clau-a clau3 loc-2-4)
    (clau-a clau4 loc-4-4)

    ;; Passadissos bloquejats amb panys de colors
    (bloquejat c1323 arc_de_sant_marti)
    (bloquejat c2324 porpra)
    (bloquejat c3242 vermell)
    (bloquejat c4243 vermell)
    (bloquejat c4344 groc)

    ;; Tipus de clau i usos restants
    (info-clau clau1 vermell 99) 
    (info-clau clau2 groc 2)     ;; 2 usos
    (info-clau clau3 arc_de_sant_marti 1)  ;; 1 ús
    (info-clau clau4 porpra 1)  
  )

  (:goal
    (and
      (grimmy-a loc-1-3)
    )
  )
)
