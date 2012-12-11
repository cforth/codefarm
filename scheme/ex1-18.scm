#!/bin/guile -s
!#

(define (double n)
	(* n 2))

(define (halve n)
	(/ n 2))

(define (fast-mult a b)
	(define (fast-mult1 a b n)
		(cond
			((= b 0) n)
			((even? b) (fast-mult1 (double a) (halve b) n))
			(else (fast-mult1 a (- b 1) (+ a n)))))
	(fast-mult1 a b 0))

(display (fast-mult 2 4))
(newline)
(display (fast-mult 6 9))
(newline)
(display (fast-mult 6 0))
(newline)
(display (fast-mult 6 1))
(newline)
