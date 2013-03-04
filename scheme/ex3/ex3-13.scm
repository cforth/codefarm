#!/bin/guile -s
!#


(define (last-pair x)
    (if (null? (cdr x))
        x
        (last-pair (cdr x))))

(define (make-cycle x)
    (set-cdr! (last-pair x) x)
    x)

;构成一个环
(define z (make-cycle (list 'a 'b 'c)))


;last-pair将无法求出z，因为z是一个环
(display (last-pair z))
(newline)
