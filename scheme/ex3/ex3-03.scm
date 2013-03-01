#!/bin/guile -s
!#

(define (make-account balance password)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                   balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (define (dispatch p m)
        (if (eq? p password)
            (cond ((eq? m 'withdraw) withdraw)
                  ((eq? m 'deposit) deposit)
                  (else (error "Unknown request -- MAKE-ACCOUNT"
                                m)))
            (lambda (value) "Incorrect password")))

    dispatch)


(define acc (make-account 100 '123456))

(display ((acc '123456 'withdraw) 40))
(newline)
(display ((acc '123456 'deposit) 40))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '123456 'deposit) 40))
(newline)
