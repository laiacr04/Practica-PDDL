(define (problem p2-sim)
  (:domain laberint-simple)

  ; Objectes utilitzats en el problema
  (:objects
    groc verd porpra arc_de_sant_marti - color
    loc-1-2 loc-2-1 loc-2-2 loc-2-3 loc-2-4 loc-3-2 - ubicacio
    clau1 clau2 clau3 clau4 - clau
    c1222 c2122 c2223 c2324 c2232 - passadis
  )

  (:init
    ; On es troba inicialment en Grimmy
    (grimmy-a loc-2-2)

    ; Connexions entre ubicacions 
    (connectat loc-1-2 loc-2-2 c1222) 
    (connectat loc-2-1 loc-2-2 c2122) 
    (connectat loc-2-2 loc-2-3 c2223) 
    (connectat loc-2-3 loc-2-4 c2324) 
    (connectat loc-2-2 loc-3-2 c2232) 

    ; Ubicacio de les claus 
    (clau-a clau1 loc-1-2)
    (clau-a clau2 loc-2-1)
    (clau-a clau3 loc-2-2)
    (clau-a clau4 loc-3-2)

    ; Colors de les claus
    (color-clau clau1 verd)
    (color-clau clau2 arc_de_sant_marti)
    (color-clau clau3 porpra)
    (color-clau clau4 groc)

    ; Passadissos bloquejats amb panys de colors 
    (bloquejat c1222 porpra) 
    (bloquejat c2122 groc)  
    (bloquejat c2223 groc)
    (bloquejat c2232 verd)
    (bloquejat c2324 arc_de_sant_marti)

  )
  (:goal
      (grimmy-a loc-2-4) 
  )
)
