(define (domain laberint-perillos)
  (:requirements
    :typing
    :negative-preconditions
    :conditional-effects
  )
  
  (:types
    ubicacio color clau passadis - object
    tipus_clau - object  ; Tipos de claves
  )

  (:predicates
    ;; Estado del laberinto
    (grimmy-a ?loc - ubicacio)
    (connectat ?h1 ?h2 - ubicacio ?pas - passadis)
    (bloquejat ?pas - passadis ?col - color)
    (obert ?pas - passadis)
    (col-lapsat ?pas - passadis)  ; Pasillo derrumbado

    ;; Gestión de claves
    (te-clau ?c - clau)
    (clau-a ?c - clau ?h - ubicacio)
    (color-clau ?c - clau ?col - color)
    (tipus-clau ?c - clau ?t - tipus_clau)  ; un_ús/dos_usos/infinit
    (usos-restants ?c - clau ?n - int)

    ;; Tesoro
    (tesoro-a ?h - ubicacio)
    (tesoro-trobat)

    ;; Predicados para tipos de clave (sustituyen a las constantes)
    (es_un_us ?t - tipus_clau)
    (es_dos_usos ?t - tipus_clau)
    (es_infinit ?t - tipus_clau)
    (es_vermell ?c - color)  ; Para pasillos peligrosos
  )

  ;; ---- ACCIONES ----

  (:action moure
    :parameters (?from ?to - ubicacio ?pas - passadis ?col - color)
    :precondition (and
      (grimmy-a ?from)
      (or 
        (connectat ?from ?to ?pas)
        (connectat ?to ?from ?pas)
      )
      (obert ?pas)
      (not (col-lapsat ?pas))
    )
    :effect (and
      (not (grimmy-a ?from))
      (grimmy-a ?to)
      (when (and (bloquejat ?pas ?col) (es_vermell ?col))
        (col-lapsat ?pas)
      )
      (when (tesoro-a ?to)
        (tesoro-trobat)
      )
    )
  )

  (:action desbloquejar
    :parameters (?loc - ubicacio ?pas - passadis ?col - color ?c - clau ?dest - ubicacio ?t - tipus_clau)
    :precondition (and
      (grimmy-a ?loc)
      (or 
        (connectat ?loc ?dest ?pas)
        (connectat ?dest ?loc ?pas)
      )
      (bloquejat ?pas ?col)
      (te-clau ?c)
      (color-clau ?c ?col)
      (tipus-clau ?c ?t)
      (or
        (es_infinit ?t)
        (and (es_dos_usos ?t) (usos-restants ?c 2))
        (and (es_un_us ?t) (usos-restants ?c 1))
      )
    )
    :effect (and
      (obert ?pas)
      (not (bloquejat ?pas ?col))
      (when (es_dos_usos ?t)
        (decrease (usos-restants ?c) 1)
        (when (usos-restants ?c 1)
          (not (tipus-clau ?c ?t))
          (tipus-clau ?c un_ús)  ; Convertimos a un_ús
        )
      )
      (when (es_un_us ?t)
        (not (te-clau ?c))
      )
    )
  )

  (:action recollir
    :parameters (?h - ubicacio ?c - clau ?t - tipus_clau)
    :precondition (and
      (grimmy-a ?h)
      (clau-a ?c ?h)
      (forall (?k - clau) (not (te-clau ?k)))
      (tipus-clau ?c ?t)
    )
    :effect (and
      (te-clau ?c)
      (not (clau-a ?c ?h))
      (when (es_dos_usos ?t) (usos-restants ?c 2))
      (when (es_un_us ?t) (usos-restants ?c 1))
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
)
