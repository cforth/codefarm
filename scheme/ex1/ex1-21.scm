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

;测试用例
;(display (smallest-divisor 199))
;(newline)
;(display (smallest-divisor 1999))
;(newline)
;(display (smallest-divisor 19999))
;(newline)


;打印出区间范围内所有的素数
(define (print-prime start end)
	(if (even? start) (print-prime (+ start 1) end)
		(cond ((> end start) 
				(if (prime? start)
					(display-p start))
				(print-prime (+ start 2) end)))))

(define (display-p n)
	(display n)
	(display " "))

;测试用例
(print-prime 9999900 10000000)
(newline)
