#!/bin/guile -s
!#

;素数检测，找出给定数n的（大于1的）最小整数因子。
;改进了算法，如果被检测数不能被2整出，则不需要检测是否能被任何偶数整除。
(define (next n)
	(if (= n 2) 3 (+ n 2)))

(define (smallest-divisor n)
	(find-divisor n 2))

(define (find-divisor n test-divisor)
	(cond	((> (square test-divisor) n) n)
			((divides? test-divisor n) test-divisor)
			(else (find-divisor n (next test-divisor)))))

(define (divides? a b)
	(= (remainder b a) 0))

(define (square n)
	(* n n))

(define (prime? n)
	(= n (smallest-divisor n)))

;打印出每次素数检测所消耗的时间，基本都是0秒，CPU速度快
(define (timed-prime-test n)
	(newline)
	(display n)
	(start-prime-test n (runtime))
	(newline))

(define (start-prime-test n start-time)
	(if (prime? n)
		(report-prime (- (runtime) start-time)))
	)

(define (report-prime elapsed-time)
	(display " *** ")
	(display elapsed-time))

(define (runtime) (current-time)) 

;
(define (search-for-primes start end)
	(if (even? start) (search-for-primes (+ start 1) end)
		(cond ((> end start) (timed-prime-test start)
			(search-for-primes (+ start 2) end)))))

;测试用例
(search-for-primes 1000000000000 1000000000100)
(newline)
