#!/bin/guile -s
!#

;定义可选用的combiner过程
(define (add x y)
	(+ x y))

(define (mult x y)
	(* x y))

;定义可选用的term过程
(define (identity n)
	n)

;定义可选用的next过程
(define (inc n)
	(+ n 1))

;定义一般性的累积函数组合起一系列项
;递归法
;(define (accumulate combiner null-value term a next b)
;	(if (> a b)
;		null-value
;		(combiner (term a)
;			(accumulate combiner null-value term (next a) next b))))

;迭代法
(define (accumulate combiner null-value term a next b)
	(define (iter a result)
		(if (> a b)
			result
			(iter (next a) (combiner result (term a)))))
	(iter a null-value))

;定义一般性的累加器与累积器
(define (sum term a next b)
	(accumulate add 0 term a next b))

(define (product term a next b)
	(accumulate mult 1 term a next b))

;定义具体的累加器和累积器
(define (sum-integers a b)
	(sum identity a inc b))

(define (product-integers a b)
	(product identity a inc b))


;测试用例
(display (sum-integers 1 10))
(newline)
(display (product-integers 1 10))
(newline)
