#!/bin/guile -s
!#

(define (mystery x)
    (define (loop x y)
        (if (null? x)
            y
            (let ((temp (cdr x)))
                 (set-cdr! x y)
                 (loop temp x))))
    (loop x '()))


(define v (list 'a 'b 'c 'd))

(define v2 (cons 'a (cons 'b (cons 'c (cons 'd '())))))

(define w (mystery v))

(define x '(1 2 3 4))

(display (list 'a 'b 'c 'd))
(newline)
(display v)
(newline)
(display w)
(newline)
(display v)
(newline)
(display x)
(newline)
(display v2)
(newline)
