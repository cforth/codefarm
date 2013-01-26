#!/bin/guile -s
!#

;make-rat
;构造有理数
(define (make-rat n d)
	(let ((g (gcd n d)))
		(let ((g-n (/ n g))
			(g-d (/ d g)))
			(cond ((> (* g-n g-d) 0)
					(cons (abs g-n) (abs g-d)))
				(else
					(cons(- (abs g-n)) (abs g-d)))))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
	(newline)
	(display (numer x))
	(display "/")
	(display (denom x)))


;测试
(print-rat (make-rat 1 2))
(print-rat (make-rat -1 2))
(print-rat (make-rat 1 -2))
(print-rat (make-rat -1 -2))
(newline)
