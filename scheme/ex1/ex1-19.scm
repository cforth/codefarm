#!/bin/guile -s
!#

(define (fib n)
	(fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
	(cond	((= count 0 ) b)
			((even? count) 
			 (fib-iter	a
			 			b
						(+ (* p p) (* q q))
						(+ (* q q) (* 2 p q))
						(/ count 2)))
			(else (fib-iter	(+ (* b q) (* a q) (* a p))
							(+ (* b p) (* a q))
							p
							q
							(- count 1)))))

(display (fib 1))
(newline)
(display (fib 2))
(newline)
(display (fib 3))
(newline)
(display (fib 4))
(newline)
(display (fib 5))
(newline)
(display (fib 6))
(newline)
(display (fib 7))
(newline)
(display (fib 8))
(newline)
(display (fib 9))
(newline)

