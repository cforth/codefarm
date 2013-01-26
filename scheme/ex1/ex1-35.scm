#!/bin/guile -s
!#

;找出函数的不动点
(define tolerance 0.00001)

(define (fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2)) tolerance))
	(define (try guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
				next
				(try next))))
	(try first-guess))


;求黄金分割率
(define (golden-ration)
	(fixed-point (lambda (x) (+ 1 (/ 1 x)))
					1.0))


(display (golden-ration))
(newline)
