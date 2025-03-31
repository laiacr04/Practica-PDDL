 (define (domain laberint-simple)
  (:requirements
        :typing
        :negative-preconditions
        :conditional-effects
    )
    (:types
        ubicacio color clau passadis - object
    )

    (:predicates
    (grimmy-a ?loc - ubicacio)
    (connectat ?h1 ?h2 - ubicacio ?pas - passadis)
    (bloquejat ?pas - passadis ?col - color)
    (obert ?pas - passadis)
    (te-clau ?c - clau)
    (clau-a ?c - clau ?h - ubicacio)
    (color-clau ?c - clau ?col - color)
    )

   (:action moure
    :parameters (?des_de ?fins_a - ubicacio ?pas - passadis)
    :precondition (and
      (grimmy-a ?des_de)
      (or 
        (connectat ?des_de ?fins_a ?pas)   ; Direcció directa
        (connectat ?fins_a ?des_de ?pas)   ; Direcció inversa
      )
      (obert ?pas)
    )
    :effect (and
      (not (grimmy-a ?des_de))
      (grimmy-a ?fins_a)
    )
  )

(:action recollir
  :parameters (?h - ubicacio ?c - clau)
  :precondition (and
    (grimmy-a ?h)
    (clau-a ?c ?h)
    ; (not (exists (?k - clau) (te-clau ?k)))  Grimmy no porta cap clau
  )
  :effect (and
    (te-clau ?c)
    (not (clau-a ?c ?h))
    (forall (?k - clau)
      (when (and (te-clau ?k) (not (= ?k ?c)))
        (and
          (not (te-clau ?k))
          (clau-a ?k ?h)
        )
      )
    )
  )
)
 
  


  (:action deixar
    :parameters (?loc - ubicacio ?c - clau)
    :precondition (and
      (grimmy-a ?loc)
      (te-clau ?c)
    )
    :effect (and
      (not (te-clau ?c))
      (clau-a ?c ?loc)
    )
  )

  (:action desbloquejar
    :parameters (?loc - ubicacio ?pas - passadis ?col - color ?c - clau ?dest - ubicacio)
    :precondition (and
      (grimmy-a ?loc)
      (or 
      (connectat ?loc ?dest ?pas) 
      (connectat ?dest ?loc ?pas)  
      )
      (bloquejat ?pas ?col)
      (te-clau ?c)
      (color-clau ?c ?col)
    )
    :effect (and
      (obert ?pas)
      (not (bloquejat ?pas ?col))
      ;;;(not (te-clau ?c)) COMENTANT AQUESTA LINIA ES PERMET QUE UTILITZI UNA CLAU MÚLTIPLES VEGADES
    )
  )
)
  
