#!/bin/guile -s
!#

;兑换零钱方式计数程序
(define us-coins (list 50 25 10 5 1))

(define uk-coins (list 100 50 20 10 5 2 1))

(define cn-coins (list 50 20 10 5 1))

(define (cc amount coin-values)
	(cond	((= amount 0) 1)
			((or (< amount 0) (no-more? coin-values)) 0)
			(else
				(+	(cc amount
						(except-first-denomination coin-values))
					(cc (- amount
							(first-denomination coin-values))
						coin-values)))))

(define (first-denomination coin-values)
	(car coin-values))

(define (except-first-denomination coin-values)
	(cdr coin-values))

(define (no-more? coin-values)
	(null? coin-values))

;测试
(display (cc 100 us-coins))
(newline)
(display (cc 100 uk-coins))
(newline)
(display (cc 100 cn-coins))
(newline)
(display (cc 100 (reverse cn-coins)))
(newline)
