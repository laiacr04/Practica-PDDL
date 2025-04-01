(define (problem p2-perill)
  (:domain laberint-perillos)

  (:objects
    groc verd porpra arc_de_sant_marti - color
    loc-1-2 loc-2-1 loc-2-2 loc-2-3 loc-2-4 loc-3-2 - ubicacio
    clau1 clau2 clau3 clau4 - clau
    c1222 c2122 c2223 c2324 c2232 - passadis
  )

  (:init
    ; Estat inicial de Grimmy
    (grimmy-a loc-2-2)

    ; Connexions entre ubicacions
    (connectat loc-1-2 loc-2-2 c1222)
    (connectat loc-2-1 loc-2-2 c2122)
    (connectat loc-2-2 loc-2-3 c2223)
    (connectat loc-2-3 loc-2-4 c2324)
    (connectat loc-2-2 loc-3-2 c2232)

    ; Passadissos perillosos (que s'ensorren després d'usar-los)
    (perillos c2122)  ; Passadís groc que s'ensorrarà després del primer ús
    (perillos c2223)  ; Passadís groc que s'ensorrarà després del segon ús

    ; Ubicació de les claus
    (clau-a clau1 loc-1-2)
    (clau-a clau2 loc-2-1)
    (clau-a clau3 loc-2-2)
    (clau-a clau4 loc-3-2)

    ; Tipus d'usos de les claus
    (clau-un-us clau1)     ; Verd - 1 ús
    (clau-un-us clau2)     ; Arc de Sant Martí - 1 ús
    (clau-un-us clau3)     ; Porpra - 1 ús
    (clau-dos-usos clau4)  ; Groc - 2 usos

    ; Colors de les claus
    (color-clau clau1 verd)
    (color-clau clau2 arc_de_sant_marti)
    (color-clau clau3 porpra)
    (color-clau clau4 groc)

    ; Passadissos bloquejats
    (bloquejat c1222 porpra)   ; Requereix clau3 (porpra)
    (bloquejat c2122 groc)     ; Requereix clau4 (groc)
    (bloquejat c2223 groc)     ; Requereix clau4 (groc)
    (bloquejat c2232 verd)     ; Requereix clau1 (verd)
    (bloquejat c2324 arc_de_sant_marti) ; Requereix clau2 (arc_de_sant_marti)

    ; Passadissos inicialment oberts (cap en aquest problema)
  )

  (:goal
    (grimmy-a loc-2-4)
  )
)