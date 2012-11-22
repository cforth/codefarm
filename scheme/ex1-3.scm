#!/bin/guile -s
!#

(define (sum-of-two-large-number a b c)
	(if (>= a b)

		(if (>= b c)
			(+ a b)
			(+ a c))
	
		(if (>= a c)
			(+ a b)
			(+ b c))))

(display (sum-of-two-large-number 1 2 4))
(newline)
(display (sum-of-two-large-number 1 4 2))
(newline)
(display (sum-of-two-large-number 2 1 4))
(newline)
(display (sum-of-two-large-number 2 4 1))
(newline)
(display (sum-of-two-large-number 4 1 2))
(newline)
(display (sum-of-two-large-number 4 2 1))
(newline)
