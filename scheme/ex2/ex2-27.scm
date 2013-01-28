#!/bin/guile -s
!#

;反转树操作
(define (deep-reverse items)
	(cond	((null? items) '())
  			((list? items) (reverse (map deep-reverse items)))
			(else items)))

;测试
(define x (list (list 1 2) (list 3 4)))

(display (reverse x))
(newline)
(display (deep-reverse x))
(newline)
