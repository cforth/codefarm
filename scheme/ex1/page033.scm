#!/bin/guile -s
!#

;素数检测，找出给定数n的（大于1的）最小整数因子。
(define (smallest-divisor n)
	(find-divisor n 2))

(define (find-divisor n test-divisor)
	(cond	((> (square test-divisor) n) n)
			((divides? test-divisor n) test-divisor)
			(else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
	(= (remainder b a) 0))

(define (square n)
	(* n n))

(define (prime? n)
	(= n (smallest-divisor n)))

(display (prime? 2047))
(newline)
(display (prime? 2089))
(newline)
(display (prime? 3600031))
(newline)
