#!/bin/guile -s
!#

;牛顿法求立方根
(define (curt-iter guess x)
	(if (good-enough? guess x)
		guess
		(curt-iter (improve guess x) x)))

(define (improve guess x)
	(/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? guess x)
	(< (abs (- (cube guess) x)) 0.001))

(define (square x)
	(* x x))

(define (cube x)
	(* x x x))

(define (curt x)
	(curt-iter 1.0 x))


;代码测试
(display (curt 1))
(newline)
(display (curt 0))
(newline)
(display (curt 27))
(newline)
(display (curt 10000))
(newline)
