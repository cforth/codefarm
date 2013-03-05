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

(define w (mystery v))

(display (list 'a 'b 'c 'd))
(newline)
(display v)   ;;你一定奇怪为什么打印出v的值是(a),因为(mystery v)破坏了v的结构。
(newline)
(display w)
(newline)
