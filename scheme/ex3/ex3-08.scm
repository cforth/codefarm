#!/bin/guile -s
!#

;求值顺序不同导致结果不同的例子
(define f
    (let ((state 0))
         (lambda (n)
            (let ((old state))
                 (set! state (+ n state))
                 old))))


;(display (+ (f 0) (f 1)))
;(newline)
(display (+ (f 1) (f 0)))
(newline)
