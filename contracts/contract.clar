;; Networking Event Check-In Contract
;; A minimal smart contract to track attendance at networking events.

;; Error if already checked in
(define-constant err-already-checked-in (err u100))

;; Map to store attendance: (event-id, attendee) → bool
(define-map attendance (tuple (event-id uint) (attendee principal)) bool)

;; Check-in function
(define-public (check-in (event-id uint))
  (let ((key (tuple (event-id event-id) (attendee tx-sender))))
    (begin
      (asserts! (is-none (map-get? attendance key)) err-already-checked-in)
      (map-set attendance key true)
      (ok true))))

;; Check if user attended an event
(define-read-only (has-attended (event-id uint) (user principal))
  (ok (is-some (map-get? attendance (tuple (event-id event-id) (attendee user))))))
