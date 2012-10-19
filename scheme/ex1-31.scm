#!/bin/guile -s
!#

(define (product term a next b)
	(if (> a b)
		1
		(* (term a)
			(product term (next a) next b))))

(define (inc n) (+ n 1))

(define (identity x) x)

(define (product-integers a b)
	(product identity a inc b))

(display (product-integers 1 9))
(newline)
