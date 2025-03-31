(define (problem p4-sim)
  (:domain laberint-simple)

  (:objects 
    vermell verd porpra arc_de_sant_marti groc - color
    loc-1-1 loc-1-2 loc-2-1 loc-2-2 loc-2-3 loc-2-4 loc-3-2 loc-3-3 loc-3-4 - ubicacio
    clau1 clau2 clau3 clau4 clau5 - clau
    c1112 c1222 c2122 c2223 c2324 c2232 c3233 c3334 - passadis
  )

  (:init
    (grimmy-a loc-1-1)

    ;Connexions 
    (connectat loc-1-1 loc-1-2 c1112)
    (connectat loc-1-2 loc-2-2 c1222) 
    (connectat loc-2-1 loc-2-2 c2122) 
    (connectat loc-2-2 loc-2-3 c2223) 
    (connectat loc-2-3 loc-2-4 c2324) 
    (connectat loc-2-2 loc-3-2 c2232)
    (connectat loc-3-2 loc-3-3 c3233)
    (connectat loc-3-3 loc-3-4 c3334)
    

    ;Claus i ubicació
    (clau-a clau1 loc-1-1)
    (clau-a clau2 loc-1-2)
    (clau-a clau3 loc-1-2)
    (clau-a clau4 loc-2-1)
    (clau-a clau5 loc-2-4)


    ; Color de les claus
    (color-clau clau1 vermell)
    (color-clau clau2 groc)
    (color-clau clau3 arc_de_sant_marti)
    (color-clau clau4 verd)
    (color-clau clau5 porpra)

    ;Passadissos bloquejats 
    (bloquejat c1112 vermell)
    (bloquejat c2122 groc)
    (bloquejat c2223 groc)
    (bloquejat c2324 verd)
    (bloquejat c2232 porpra)
    (bloquejat c3233 arc_de_sant_marti)

    ;Passadissos oberts  
    (obert c1222)
    (obert c3334)
    
  )

  (:goal 
    (and (grimmy-a loc-3-4))
  )
)
