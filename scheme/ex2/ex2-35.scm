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

;count-leaves
(define (count-leaves t)
    (accumulate 
                (lambda (x y) (+ 1 y))
                0
                (enumerate-tree t)))

;测试
(display (count-leaves '((1 2) ((3 4 5) 6) 7)))
(newline)
