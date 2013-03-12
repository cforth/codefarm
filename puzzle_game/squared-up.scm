#!/bin/guile -s
!#

;构造矩阵
(define (make-matrix wide)
    (define (make-list start end)
        (define (make-list-iter start end result)
            (if (> start end)
                result
                (make-list-iter start (- end 1) (cons end result))))
        (make-list-iter start end '()))
    (define (make-matrix-iter wide high result)
        (let ((start (+ (* (- high 1) wide) 1))
              (end (* high wide)))
             (if (< high 1)
                 result
                 (make-matrix-iter wide (- high 1) (cons (make-list start end) result)))))
    (make-matrix-iter wide wide '()))


;测试
(display (list-ref (list-ref '((1 2) 2 3 4) 0) 0))
(newline)
(define x (make-matrix 4))
(display x)
(newline)
