(define-map checkins
  {user: principal}
  bool) ;; true means checked in

(define-data-var total-checkins uint u0)

(define-constant err-already-checked-in (err u100))

;; Function: User checks into the event
(define-public (check-in)
  (begin
    (match (map-get? checkins {user: tx-sender})
      some true (err err-already-checked-in)
      none
        (begin
          (map-set checkins {user: tx-sender} true)
          (var-set total-checkins (+ (var-get total-checkins) u1))
          (ok true)))))

;; Function: View total number of check-ins
(define-read-only (get-total-checkins)
  (ok (var-get total-checkins)))
