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

;accumulate-n
(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        '()
        (cons (accumulate op init (map car seqs))
              (accumulate-n op init (map cdr seqs)))))

;测试
(display (accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12))))
(newline)
