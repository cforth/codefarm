#!/bin/guile -s
!#

;用scheme写的重排九宫游戏
;构造顺序矩阵
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

;打印顺序矩阵
(define (print-matrix matrix)
    (define (print-list lst)
        (if (null? lst)
            #f
            (begin
                (display (car lst))
                (display "\t")
                (print-list (cdr lst)))))
    (if (null? matrix)
        #f
        (begin
            (print-list (car matrix))
            (newline)
            (print-matrix (cdr matrix)))))

;求顺序矩阵第X行，第Y列的数值，行列数以1为初始值
(define (value-matrix matrix x y)
    (list-ref (list-ref matrix (- x 1)) (- y 1)))


;测试，因编码水平不够，暂且搁置 2013-3-19
(display (list-ref (list-ref '((1 2) 2 3 4) 0) 0))
(newline)
(define x (make-matrix 4))
(display x)
(newline)
(print-matrix x)
(display (value-matrix x 3 2))
(newline)
