(define (domain laberint-perillos)
  (:requirements
    :typing
    :negative-preconditions
    :quantified-preconditions
    :conditional-effects
    :disjunctive-preconditions
    :numeric-fluents
  )

  (:types
    ubicacio color clau passadis - object  ; Eliminat tipus-clau que no s'utilitza
  )

  (:predicates
    (grimmy-a ?loc - ubicacio)
    (connectat ?loc1 - ubicacio ?loc2 - ubicacio ?pas - passadis)
    (bloquejat ?pas - passadis ?col - color)
    (obert ?pas - passadis)  ; Afegit predicat que faltava
    (te-clau ?c - clau)
    (clau-a ?c - clau ?loc - ubicacio)
    (color-clau ?c - clau ?col - color)
    (perillos ?p - passadis)
    (collapsat ?p - passadis)
  )

  (:functions
    (usos-restants ?c - clau)
  )

  (:action moure
    :parameters (?loc1 ?loc2 - ubicacio ?pas - passadis)
    :precondition (and
      (grimmy-a ?loc1)
      (or (connectat ?loc1 ?loc2 ?pas) (connectat ?loc2 ?loc1 ?pas))
      (obert ?pas)  ; Canviat de (not (bloquejat)) a (obert) per consistència
      (not (collapsat ?pas)))
    :effect (and
      (grimmy-a ?loc2)
      (not (grimmy-a ?loc1))
      (when (perillos ?pas) 
        (collapsat ?pas)))
  )

  (:action recollir
    :parameters (?loc - ubicacio ?c - clau)
    :precondition (and
      (grimmy-a ?loc)
      (clau-a ?c ?loc)
      (not (exists (?k - clau) (te-clau ?k))))
    :effect (and
      (te-clau ?c)
      (not (clau-a ?c ?loc))))
  
  (:action deixar
    :parameters (?loc - ubicacio ?c - clau)
    :precondition (and
      (grimmy-a ?loc)
      (te-clau ?c))
    :effect (and
      (clau-a ?c ?loc)
      (not (te-clau ?c))))

  (:action desbloquejar
    :parameters (?loc1 ?loc2 - ubicacio ?pas - passadis ?col - color ?c - clau)
    :precondition (and
      (grimmy-a ?loc1)
      (or (connectat ?loc1 ?loc2 ?pas) (connectat ?loc2 ?loc1 ?pas))
      (bloquejat ?pas ?col)
      (te-clau ?c)
      (color-clau ?c ?col)
      (> (usos-restants ?c) 0))
    :effect (and
      (obert ?pas)
      (not (bloquejat ?pas ?col))
      (assign (usos-restants ?c) (- (usos-restants ?c) 1))
      (when (= (usos-restants ?c) 0) 
        (not (te-clau ?c)))))
)