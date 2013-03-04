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

;建立共享帐户名，设置共享账户名的密码
(define (make-joint account old-password new-password)
    (lambda (password m)
        (if (eq? password new-password)
            (account old-password m)
            (error "Incorrect Password"))))


(define peter-acc (make-account 10 'open-sesame))
(display ((peter-acc 'open-sesame 'deposit) 100))
(newline)
(define paul-acc (make-joint peter-acc 'open-sesame 'rosebud))
(display ((paul-acc 'rosebud 'withdraw) 100))
(newline)
