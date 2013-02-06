#!/bin/guile -s
!#

;序列操作
(define (filter1 predicate sequence)
    (cond   ((null? sequence) nil)
            ((predicate (car sequence))
                (cons   (car sequence)
                        (filter1 predicate (cdr sequence))))
            (else (filter1 predicate (cdr sequence)))))

(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
    (if (> low high)
        '()
        (cons low (enumerate-interval (+ low 1) high))))

(define (enumerate-tree tree)
    (cond   ((null? tree) '())
            ((not (pair? tree)) (list tree))
            (else (append   (enumerate-tree (car tree))
                            (enumerate-tree (cdr tree))))))

;Horner规则求多项式值
(define (horner-eval x coefficient-sequence)
    (accumulate (lambda (this-coeff higher-terms)
                    (+ this-coeff
                       (* x higher-terms)))
                 0
                 coefficient-sequence))


;测试
(display (horner-eval 2 (list 1 3 0 5 0 1)))
(newline)
