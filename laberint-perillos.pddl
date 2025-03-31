(define (domain laberint-perillos)
  (:requirements
    :typing
    :negative-preconditions
    :conditional-effects
  )
  (:types
    ubicacio color clau passadis tipus_clau - object
  )

  (:predicates
    (grimmy-a ?loc - ubicacio)
    (connectat ?h1 ?h2 - ubicacio ?pas - passadis)
    (bloquejat ?pas - passadis ?col - color)
    (obert ?pas - passadis)
    (te-clau ?c - clau)
    (clau-a ?c - clau ?h - ubicacio)
    (tipus-clau ?c - clau ?t - tipus_clau)  ; Fusionem els predicats de tipus de clau
    (usos-restants ?c - clau ?n - number)
    (perillos ?p - passadis)
    (ensorrat ?p - passadis)
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
      (not (ensorrat ?pas))  ; El passadís no ha d'estar col·lapsat prèviament
    )
    :effect (and
      (not (grimmy-a ?des_de))
      (grimmy-a ?fins_a)
      ;; Si el passadís és perillós, col·lapsa'l després de passar per ell
      (when (perillos ?pas) (ensorrat ?pas))
    )
  )

  (:action recollir
    :parameters (?loc - ubicacio ?c - clau)
    :precondition (and
      (grimmy-a ?loc)
      (clau-a ?c ?loc)
      (not (exists (?k - clau) (te-clau ?k)))  ; Grimmy no porta cap clau
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
      (connectat ?loc ?dest ?pas)
      (bloquejat ?pas ?col)
      (te-clau ?c)
      (tipus-clau ?c ?t)  ; Tipus de clau (un_us, dos_usos, multius)
      (not (ensorrat ?pas))
      (usos-restants ?c ?n)  ; Hi ha un nombre d'usos restants
      (>= ?n 1)  ; La clau encara té usos disponibles
    )
    :effect (and
      (not (bloquejat ?pas ?col))
      (obert ?pas)
      (not (te-clau ?c))  ; Grimmy deixa la clau després de desbloquejar
      (when (eq ?t un_us) (not (te-clau ?c)))  ; Si és una clau d'un sol ús, la deixa
      (when (eq ?t dos_usos)
        (and
          (not (te-clau ?c))
          ;; Reduïm el nombre d'usos restants de la clau de dos usos
          (usos-restants ?c (- ?n 1))
        )
      )
    )
  )
)
