#!/bin/guile -s
!#

(define (double n)
	(* n 2))

(define (halve n)
	(/ n 2))

(define (fast-mult a b)
	(cond
		((= b 0) 0)
		((even? b) (double (fast-mult a (halve b))))
		(else (+ a (fast-mult a (- b 1))))))

(display (fast-mult 2 4))
(newline)
(display (fast-mult 6 9))
(newline)
