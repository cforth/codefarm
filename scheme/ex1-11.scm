#!/bin/guile -s
!#

;递归法
(define (f-r n)
	(if (< n 3)
		n
		(+ (f-r (- n 1))
			(* 2 (f-r (- n 2)))
			(* 3 (f-r (- n 3))))))

(display (f-r 3))
(newline)
(display (f-r 8))
(newline)
(display (f-r 10))
(newline)

;迭代法
(define (f-iter n)
	(define (f-inner-iter a b c count)
		(cond ((= count 0) c)
			(else (f-inner-iter (+ a (* b 2) (* c 3)) a b (- count 1)))))
	(f-inner-iter 2 1 0 n))

(display (f-iter 3))
(newline)
(display (f-iter 8))
(newline)
(display (f-iter 10))
(newline)
