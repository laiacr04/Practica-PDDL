(define (problem p2-lab)
  (:domain laberint-simple)

  ; Convencio de nomenclatura:
  ; - loc-{i}-{j} fa referencia a la ubicacio a la fila i i columna j (comencant des de la cantonada superior esquerra 
  ;   (que seria loc-1-1 si hi fos))
  ; - c{i}{j}{h}{k} fa referencia al passadis que connecta loc-{i}-{j} i loc-{h}-{k}

  (:objects
    groc verd porpra arc_de_sant_marti - color
    loc-1-2 loc-2-1 loc-2-2 loc-2-3 loc-2-4 loc-3-2 - ubicacio
    clau1 clau2 clau3 clau4 - clau
    c1222 c2122 c2223 c2324 c2232 - passadis
  )

  (:init

    ; Estat den Grimmy 
    (grimmy-a loc-2-2)

    ; Connexions entre ubicacions i passadissos 
    (connectat loc-1-2 loc-2-2 c1222) (connectat loc-2-2 loc-1-2 c1222)
    (connectat loc-2-1 loc-2-2 c2122) (connectat loc-2-2 loc-2-1 c2122)
    (connectat loc-2-2 loc-2-3 c2223) (connectat loc-2-3 loc-2-2 c2223)
    (connectat loc-2-3 loc-2-4 c2324) (connectat loc-2-4 loc-2-3 c2324)
    (connectat loc-2-2 loc-3-2 c2232) (connectat loc-3-2 loc-2-2 c2232)


    ; Ubicacio de les claus 
    (clau-a clau1 loc-1-2)
    (clau-a clau2 loc-2-1)
    (clau-a clau3 loc-2-2)
    (clau-a clau4 loc-3-2)

    ; Passadissos bloquejats amb panys de colors 
    (bloquejat c1222 porpra) 
    (bloquejat c2122 groc)  
    (bloquejat c2223 groc)
    (bloquejat c2232 verd)
    (bloquejat c2324 arc_de_sant_marti)

    ; Colors de les claus
    (color-clau clau1 verd)
    (color-clau clau2 arc_de_sant_marti)
    (color-clau clau3 porpra)
    (color-clau clau4 groc)

  )
  (:goal
    (and
      (grimmy-a loc-3-2) 
    )
  )

)