#!/bin/guile -s
!#

;以一个数值表为参数，返回每个数的平方构成的表
(define (square-list items)
	(if	(null? items)
		'()
		(cons ((lambda (x) (* x x)) (car items))
			(square-list (cdr items)))))

(define (square-list2 items)
	(map (lambda (x) (* x x))
		items))

;测试
(display (square-list (list 1 2 3 4)))
(newline)
(display (square-list2 (list 1 2 3 4)))
(newline)
