 (define (domain laberint-simple)
    (:requirements
        :typing
        :negative-preconditions
        :conditional-effects
    )

    ; Definició de tipus d'objectes del domini
    (:types
        ubicacio color clau passadis - object
    )

    ; Predicats que defineixen l'estat del món
    (:predicates
        (grimmy-a ?loc - ubicacio)                     ; Grimmy està a una ubicació
        (connectat ?h1 ?h2 - ubicacio ?pas - passadis) ; Passadís que connecta 2 ubicacions
        (bloquejat ?pas - passadis ?col - color)       ; El passadís està bloquejat per un pany de color
        (obert ?pas - passadis)                        ; El passadís està obert
        (te-clau ?c - clau)                            ; Grimmy té una clau
        (clau-a ?c - clau ?h - ubicacio)               ; La clau es troba en una ubicació
        (color-clau ?c - clau ?col - color)            ; Una clau és d’un color determinat
    )

    ; Acció de moure al Grimmy d'una ubicació a una altra si el passadís està obert
    (:action moure
        :parameters (?des_de ?fins_a - ubicacio ?pas - passadis)
        :precondition (and
          (grimmy-a ?des_de)                   ; Grimmy està a la ubicació de sortida
          (or 
            (connectat ?des_de ?fins_a ?pas)   ; Direcció directa
            (connectat ?fins_a ?des_de ?pas)   ; Direcció inversa
          )
          (obert ?pas)                         ; El passadís ha d’estar obert
        )
        :effect (and
          (not (grimmy-a ?des_de))             ; Deixa la ubicació d'origen  
          (grimmy-a ?fins_a)                   ; Ara està a la destinació
        )
    )

    ; Acció per recollir una clau d’una ubicació
    (:action recollir
      :parameters (?h - ubicacio ?c - clau)
      :precondition (and
        (grimmy-a ?h)                              ; Grimmy està a la ubicació
        (clau-a ?c ?h)                             ; La clau està a la mateixa ubicació
      )
      :effect (and
        (te-clau ?c)                               ; Grimmy passa a tenir la clau
        (not (clau-a ?c ?h))                       ; La clau ja no està a la ubicació
        ; Si Grimmy ja tenia una altra clau diferent, la deixa a la ubicació
        (forall (?k - clau)
          (when (and (te-clau ?k) (not (= ?k ?c))) ; Si té una altra clau diferent
            (and
              (not (te-clau ?k))                   ; Deixa de tenir-la
              (clau-a ?k ?h)                       ; I la deixa a la ubicació
            )
          )
        )
      )
    )
 
    ; Acció per deixar una clau a l'ubicació actual
    (:action deixar
      :parameters (?loc - ubicacio ?c - clau)
      :precondition (and
        (grimmy-a ?loc)                           ; Grimmy és a la ubicació
        (te-clau ?c)                              ; I té la clau
      )
      :effect (and
        (not (te-clau ?c))                        ; Deixa de tenir-la
        (clau-a ?c ?loc)                          ; La clau apareix a la ubicació
      )
    )

    ; Acció per desbloquejar un passadís amb una clau d’un color concret
    (:action desbloquejar
      :parameters (?loc - ubicacio ?pas - passadis ?col - color ?c - clau ?dest - ubicacio)
      :precondition (and
        (grimmy-a ?loc)                           ; Grimmy és a la ubicació
        (or 
          (connectat ?loc ?dest ?pas)             ; La ubicació està connectada amb l’altra per aquest passadís
          (connectat ?dest ?loc ?pas)
        )
        (bloquejat ?pas ?col)                     ; El passadís està bloquejat per un pany d’aquest color
        (te-clau ?c)                              ; Grimmy té una clau
        (color-clau ?c ?col)                      ; La clau és del color correcte
      )
      :effect (and
        (obert ?pas)                              ; El passadís s’obre
        (not (bloquejat ?pas ?col))               ; Ja no està bloquejat
        ;;;(not (te-clau ?c))                     ; Si es descomenta, Grimmy perdria la clau després d’usar-la
      )
    )
)
  
