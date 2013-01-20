#!/bin/guile -s
!#

;找出函数的不动点,打印中间过程
(define tolerance 0.00001)

(define (printf x)
	(display x)
	(newline))

(define (fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2)) tolerance))
	(define (try guess)
		(printf guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
				next
				(try next))))
	(try first-guess))


;
(define (average x y)
	(/ (+ x y) 2))

(display (fixed-point (lambda (x) (/ (log 1000) (log x))) 10.0))
(newline)

(display "pingjun zu ni")
(newline)

(display (fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 10.0))
(newline)
