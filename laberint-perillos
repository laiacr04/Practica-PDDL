(define (domain laberint-perillos)
  (:requirements
    :typing
    :negative-preconditions
    :conditional-effects
  )
  
  (:types
    ubicacio color clau passadis - object
    tipus_clau - object  ; Tipos de claves: un_ús, dos_usos, infinit
  )

  (:predicates
    ;; Predicados existentes
    (grimmy-a ?loc - ubicacio)
    (connectat ?h1 ?h2 - ubicacio ?pas - passadis)
    (bloquejat ?pas - passadis ?col - color)
    (obert ?pas - passadis)
    (te-clau ?c - clau)
    (clau-a ?c - clau ?h - ubicacio)
    (color-clau ?c - clau ?col - color)
    
    ;; Nuevos predicados para peligros
    (col-lapsat ?pas - passadis)  ; Pasillo derrumbado (para pasillos rojos)
    (tesoro-a ?h - ubicacio)      ; Ubicación del tesoro
    (tesoro-trobat)               ; Objetivo cumplido
    
    ;; Gestión de usos de claves
    (tipus-clau ?c - clau ?t - tipus_clau)
    (usos-restants ?c - clau ?n - int)
  )

  (:constants
    ;; Tipos de claves
    un_ús dos_usos infinit - tipus_clau
    vermell - color  ; Color especial para pasillos peligrosos
  )

  ;; ---- ACCIONES MODIFICADAS ----

  (:action moure
    :parameters (?from ?to - ubicacio ?pas - passadis)
    :precondition (and
      (grimmy-a ?from)
      (or 
        (connectat ?from ?to ?pas)
        (connectat ?to ?from ?pas)
      )
      (obert ?pas)
      (not (col-lapsat ?pas))  ; No se puede pasar por pasillos derrumbados
    )
    :effect (and
      (not (grimmy-a ?from))
      (grimmy-a ?to)
      (when (bloquejat ?pas vermell)  ; Si es un pasillo rojo peligroso
        (col-lapsat ?pas)  ; Se derrumba después de usarse
      )
      (when (tesoro-a ?to)  ; Si llegamos al tesoro
        (tesoro-trobat)
      )
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
      ;; Gestión de usos de claves
      (or 
        (tipus-clau ?c infinit)
        (and (usos-restants ?c ?n) (> ?n 0))
      )
    )
    :effect (and
      (obert ?pas)
      (not (bloquejat ?pas ?col))
      (when (not (tipus-clau ?c infinit))  ; Si no es infinita
        (decrease (usos-restants ?c) 1)    ; Reduce usos
        (when (and (usos-restants ?c 1) (not (tipus-clau ?c un_ús)))
          (not (te-clau ?c))  ; Elimina la llave si era de dos usos y se gastó
        )
      )
    )
  )

  (:action recollir
    :parameters (?h - ubicacio ?c - clau)
    :precondition (and
      (grimmy-a ?h)
      (clau-a ?c ?h)
      (forall (?k - clau) (not (te-clau ?k)))  ; Solo una llave
    )
    :effect (and
      (te-clau ?c)
      (not (clau-a ?c ?h))
      ;; Inicializa usos si no estaba establecido
      (when (tipus-clau ?c un_ús) (usos-restants ?c 1))
      (when (tipus-clau ?c dos_usos) (usos-restants ?c 2))
    )
  )

  ;; Resto de acciones (deixar) se mantienen igual
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
