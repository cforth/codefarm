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

;sum-odd-squares
(define (sum-odd-squares tree)
    (accumulate +
                0
                (map square
                     (filter1 odd?
                              (enumerate-tree tree)))))

;even-fibs
(define (even-fibs n)
    (accumulate cons
                '()
                (filter1 even?
                         (map fib
                              (enumerate-interval 0 n)))))

(define (fib n)
    (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
    (cond   ((= count 0 ) b)
            ((even? count) 
                (fib-iter  a
                           b
                           (+ (* p p) (* q q))
                           (+ (* q q) (* 2 p q))
                           (/ count 2)))
            (else (fib-iter (+ (* b q) (* a q) (* a p))
                            (+ (* b p) (* a q))
                            p
                            q
                            (- count 1)))))
                            

