#!/bin/guile -s
!#

;带密码保护的银行账户，连续输错7次后自动报警
(define (make-account balance password)
    (define (withdraw amount)
        (if (>= balance amount)
            (begin (set! balance (- balance amount))
                   balance)
            "Insufficient funds"))
    (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
    (let ((wrong-times 0))
        (define (dispatch p m)
            (if (eq? p password)
                (begin 
                    (set! wrong-times 0)
                    (cond ((eq? m 'withdraw) withdraw)
                          ((eq? m 'deposit) deposit)
                          (else (error "Unknown request -- MAKE-ACCOUNT"
                                       m))))
                (begin 
                    (set! wrong-times (+ wrong-times 1))
                    (if (> wrong-times 7)
                        (lambda (value) "Call-the-caps")
                        (lambda (value) "Incorrect password")))))

        dispatch))



(define acc (make-account 100 '123456))

(display ((acc '123456 'withdraw) 40))
(newline)
(display ((acc '123456 'deposit) 40))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '123456 'deposit) 40))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '456789 'deposit) 60))
(newline)
(display ((acc '123456 'deposit) 60))
(newline)
