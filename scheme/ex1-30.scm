#!/bin/guile -s
!#

;sum，累加器通用模板,递归实现。
;(define (sum term a next b)
;	(if (> a b)
;		0
;		(+ (term a)
;			(sum term (next a) next b))))

;sum，累加器通用模板，迭代实现。
(define (sum term a next b)
	(define (iter a result)
		(if (> a b)
			result
			(iter (next a) (+ result (term a)))))
	(iter a 0))

;inc，返回n+1。
(define (inc n) (+ n 1))

;identity，返回x。
(define (identity x) x)

;cube，返回x的立方。
(define (cube x) (* x x x))

;sum-integers，求出整数a到b的累加和。
(define (sum-integers a b)
	(sum identity a inc b))

;sum-cubes，求出整数a到b的立方和。
(define (sum-cubes a b)
	(sum cube a inc b))

;代码示例
(display "sum of 1 to 10: ") 
(display (sum-integers 1 10))
(newline)
(display "sum-cubes of 1 to 10: ") 
(display (sum-cubes 1 10))
(newline)
