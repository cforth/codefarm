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

;矩阵操作
(define (dot-product v w)
	(accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
	(map (lambda (x)
			(accumulate + 0 (map * x v)))
		 m))

(define (transpose mat)
	(accumulate-n cons '() mat))

(define (matrix-*-matrix m n)
	(let ((cols (transpose n)))
         (map (lambda (x)
                (accumulate cons '() (matrix-*-vector cols x)))
               m)))


;测试
(define m '((1 2) (3 4)))
(define v '(5 6))
(define m2 '((1 2 3) (4 5 6) (7 8 9)))

(display (dot-product v v))
(newline)
(display (matrix-*-vector m v))
(newline)
(display (transpose m2))
(newline)
(display (matrix-*-matrix m m))
(newline)
(display (matrix-*-matrix m2 m2))
(newline)
