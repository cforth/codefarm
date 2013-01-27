#!/bin/guile -s
!#

;for-each
;以一个过程和一个元素为参数，将这一过程从左到右应用到各个元素
;但不返回结果的表
(define (for-each2 proc items)
	(if	(null? items)
		'()
		(begin
			(proc (car items))
			(for-each2 proc (cdr items)))))


;
(for-each2 (lambda (x) (newline) (display x))
	(list 58 321 88))
