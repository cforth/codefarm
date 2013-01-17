#!/bin/guile -s
!#

;利用John Wallis的方法近似求pi的值
(define (inc n) (+ n 1))

;(define (inc2 n) (+ n 2))

(define (pi-factor x)
	(/ (* (- x 1) (+ x 1)) (* x x)))

;递归实现
;(define (product term a next b)
;	(if (> a b)
;		1
;		(* (term a)
;			(product term (next a) next b))))

;迭代实现
(define (product term a next b)
	(define (product-i a result)
		(if (> a b)
			result
			(product-i (next a) (* result (term a)))))
	(product-i a 1))

;(define (johnwallis-pi n)
;	(* (product pi-factor 3 inc2 (+ 3 (* n 2))) 4.0))

(define (johnwallis-pi n)
	(define (term k)
		(/	(+ k (if (odd? k) 1 2))
			(+ k (if (odd? k) 2 1))))
	(* 4.0 (product term 1 inc n)))


;测试用例，随着n的增加，guile占用的运行内存增大很快
(display (johnwallis-pi 1000))
(newline)
