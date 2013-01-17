#!/bin/guile -s
!#


;处理被组合项的过滤器
(define (filtered-accumulate combiner null-value term a next b pred)
	(define (iter k result)
		(if (> k b)
			result
			(cond ((pred k) (iter (next k) (combiner result (term k))))
					(else (iter (next k) result)))))
	(iter a null-value))

;a
;素数检测，找出给定数n的（大于1的）最小整数因子。
(define (square n)
	(* n n))

(define (identity x)
	x)

(define (inc x)
	(+ x 1))

(define (prime? n)
	(define (smallest-divisor )
		(define (divides? a b)
			(= (remainder b a) 0))
		(define (find-divisor  test-divisor)
			(cond	((> (square test-divisor) n) n)
					((divides? test-divisor n) test-divisor)
					(else (find-divisor (+ test-divisor 1)))))
			(find-divisor  2))
	(= n (smallest-divisor)))

;求a到b范围内的所有素数之和
(define (sum-prime a b)
	(filtered-accumulate + 0 identity a inc b prime?))


;测试用例
(display (sum-prime 0 100))
(newline)
(display (= (sum-prime 0 20) (+ 0 1 2 3 5 7 11 13 17 19)))
(newline)
