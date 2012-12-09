#!/bin/guile -s
!#

(define (square x)
	(* x x))

(define (fast-expt b n a)
	(cond 
		((= n 0) a)
		((even? n) (fast-expt (square b) (/ n 2) a))
		(else (fast-expt b (- n 1) (* a b)))))

(display (fast-expt 2 4 1))
(newline)
