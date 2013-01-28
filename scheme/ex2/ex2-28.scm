#!/bin/guile -s
!#

;从左到右打印树的所有叶子
(define (fringe items)
	(cond	((null? items) 
				'())
			((list? items) 
				(append (fringe (car items)) (fringe (cdr items))))
			(else 
				(list items))))

;测试
(define x (list (list 1 2) (list 3 4)))

(display (fringe x))
(newline)
(display (fringe (list x x)))
(newline)
(display (fringe '()))
(newline)
