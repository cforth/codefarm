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

;定义基本操作
(define (map1 p sequence)
    (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(define (append1 seq1 seq2)
    (accumulate cons seq2 seq1))

(define (length1 sequence)
    (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

;测试
(display (map (lambda (x) (* x x)) (list 1 2 3 4 5 6)))
(newline)
(display (map1 (lambda (x) (* x x)) (list 1 2 3 4 5 6)))
(newline)
(display (append '(1 2) '(3 4)))
(newline)
(display (append1 '(1 2) '(3 4)))
(newline)
(display (length '(1 2 3 4 5)))
(newline)
(display (length1 '(1 2 3 4 5)))
(newline)
