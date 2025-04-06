(define (domain laberint-perillos)
  (:requirements
    :typing                       
    :negative-preconditions       
    :quantified-preconditions     
    :conditional-effects          
    :disjunctive-preconditions    
    :numeric-fluents              
  )

  ; Tipus d'objectes
  (:types
    ubicacio color clau passadis - object  
  )

  ; Predicats del domini
  (:predicates
    (grimmy-a ?loc - ubicacio)                      ; Grimmy és en una ubicació
    (connectat ?loc1 - ubicacio ?loc2 - ubicacio ?pas - passadis) ; Passadís que connecta 2 ubicacions
    (bloquejat ?pas - passadis ?col - color)        ; El passadís està bloquejat per un pany de color
    (obert ?pas - passadis)                         ; El passadís està obert
    (te-clau ?c - clau)                             ; Grimmy té una clau
    (clau-a ?c - clau ?loc - ubicacio)              ; La clau es troba en una ubicació
    (color-clau ?c - clau ?col - color)             ; Una clau és d’un color determinat
    (perillos ?p - passadis)                        ; El passadís és perillós (pot col·lapsar)
    (collapsat ?p - passadis)                       ; El passadís ja ha col·lapsat
  )

  ; Funció per controlar els usos restants d'una clau
  (:functions
    (usos-restants ?c - clau)                       ; Número d'usos restants d'una clau
  )

  ; Acció de moure Grimmy per un passadís
  (:action moure
    :parameters (?loc1 ?loc2 - ubicacio ?pas - passadis)
    :precondition (and
      (grimmy-a ?loc1)                              ; Grimmy és a la ubicació d’origen
      (or 
          (connectat ?loc1 ?loc2 ?pas)              ; Dirrecio directa
          (connectat ?loc2 ?loc1 ?pas)              ; Direcció inversa
      )
      (obert ?pas)                                  ; El passadís ha d’estar obert
      (not (collapsat ?pas))                        ; I no pot haver col·lapsat
    )                       
    :effect (and
      (grimmy-a ?loc2)                              ; Grimmy arriba a la nova ubicació
      (not (grimmy-a ?loc1))                        ; Ja no està a l’anterior
      (when (perillos ?pas)                         ; Si el passadís és perillós
        (collapsat ?pas))                           ; Col·lapsa després del pas
    )                          
  )

  ; Acció per recollir una clau d’una ubicació
  (:action recollir
    :parameters (?loc - ubicacio ?c - clau)
    :precondition (and
      (grimmy-a ?loc)                               ; Grimmy està a la ubicació
      (clau-a ?c ?loc)                              ; La clau és en aquesta ubicació
      (not (exists (?k - clau) (te-clau ?k)))       ; Grimmy no té cap altra clau
    )      
    :effect (and
      (te-clau ?c)                                  ; Ara té la clau
      (not (clau-a ?c ?loc)))                       ; La clau desapareix de l’ubicació
    )                     

  ; Acció per deixar una clau a la ubicació actual
  (:action deixar
    :parameters (?loc - ubicacio ?c - clau)
    :precondition (and
      (grimmy-a ?loc)                               ; Grimmy és a la ubicació
      (te-clau ?c))                                 ; I porta la clau
    :effect (and
      (clau-a ?c ?loc)                              ; La clau apareix a la ubicació
      (not (te-clau ?c))))                          ; Grimmy deixa de tenir-la

  ; Acció per desbloquejar un passadís amb una clau de color
  (:action desbloquejar
    :parameters (?loc1 ?loc2 - ubicacio ?pas - passadis ?col - color ?c - clau)
    :precondition (and
      (grimmy-a ?loc1)                              ; Grimmy és a la ubicació inicial
      (or (connectat ?loc1 ?loc2 ?pas)              ; Passadís connecta les ubicacions
          (connectat ?loc2 ?loc1 ?pas))
      (bloquejat ?pas ?col)                         ; El passadís està bloquejat per aquest color
      (te-clau ?c)                                  ; Grimmy té la clau
      (color-clau ?c ?col)                          ; La clau és del color del pany
      (> (usos-restants ?c) 0))                     ; La clau encara té usos disponibles
    :effect (and
      (obert ?pas)                                  ; El passadís s’obre
      (not (bloquejat ?pas ?col))                   ; El pany desapareix
      (assign (usos-restants ?c)                    ; Es redueix el nombre d'usos restants
         (- (usos-restants ?c) 1)
      )
      (when (= (usos-restants ?c) 0)                ; Si ja no queden usos
        (not (te-clau ?c))                          ; Grimmy perd la clau
      )
    )
  )
)
