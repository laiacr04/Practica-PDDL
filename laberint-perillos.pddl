(define (domain laberint-perillos)
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
    (perillos ?p - passadis)
    (ensorrat ?p - passadis)
    (color-clau ?c - clau ?col - color)
    (clau-un-us ?c - clau)
    (clau-dos-usos ?c - clau)
    (clau-multi-usos ?c - clau)
  )

  (:action moure
    :parameters (?des_de ?fins_a - ubicacio ?pas - passadis)
    :precondition (and
      (grimmy-a ?des_de)
      (or 
        (connectat ?des_de ?fins_a ?pas)
        (connectat ?fins_a ?des_de ?pas)
      )
      (obert ?pas)
      (not (ensorrat ?pas))
    )
    :effect (and
      (not (grimmy-a ?des_de))
      (grimmy-a ?fins_a)
      (when (perillos ?pas)
        (ensorrat ?pas)
      )
    )
  )

  (:action recollir
    :parameters (?loc - ubicacio ?c - clau)
    :precondition (and
      (grimmy-a ?loc)
      (clau-a ?c ?loc)
      (not (exists (?k - clau) (te-clau ?k)))
    )
    :effect (and
      (te-clau ?c)
      (not (clau-a ?c ?loc))
    )
  )

  (:action deixar
  :parameters (?loc - ubicacio ?c - clau)
  :precondition (and
    (grimmy-a ?loc)
    (te-clau ?c)
    ;; només pot deixar la clau si NO hi ha cap passadís adjacent bloquejat amb el seu color
    (forall (?dest - ubicacio ?pas - passadis ?col - color)
      (or
        (not (connectat ?loc ?dest ?pas))
        (not (bloquejat ?pas ?col))
        (not (color-clau ?c ?col))
      )
    )
  )
  :effect (and
      (not (te-clau ?c))
      (clau-a ?c ?loc)
    )
  )

  (:action deixar
  :parameters (?loc - ubicacio ?c - clau)
  :precondition (and
    (grimmy-a ?loc)
    (te-clau ?c)
    ;; Solo permite dejar la clave si:
    ;; 1 No hay pasillos adyacentes bloqueados con su color O
    ;; 2 La clave ya no tiene usos restantes
    (or
      (not (exists (?pas - passadis ?col - color ?dest - ubicacio)
            (and
              (connectat ?loc ?dest ?pas)
              (bloquejat ?pas ?col)
              (color-clau ?c ?col)
              (not (ensorrat ?pas))
              (or (clau-un-us ?c) (clau-dos-usos ?c) (clau-multi-usos ?c))
            )
          ))
      (not (or (clau-un-us ?c) (clau-dos-usos ?c) (clau-multi-usos ?c)))
    )
  )
  :effect (and
    (not (te-clau ?c))
    (clau-a ?c ?loc)
    ;; Efecto adicional: Marcar como "ya revisado" para evitar bucles
    (forall (?pas - passadis ?col - color ?dest - ubicacio)
      (when (and (connectat ?loc ?dest ?pas)
                 (bloquejat ?pas ?col)
                 (color-clau ?c ?col))
        (not (bloquejat ?pas ?col))  ; Fuerza el desbloqueo implícito
      )
    )
  )
)
)
