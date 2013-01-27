#!/bin/guile -s
!#

;same-parity
;以一个或多个整数为参数，返回所有与其第一个参数有着同样奇偶性的参数形成的表
(define (same-parity . lst)
	(define (same-parity-inner predicate lst2)
		(if	(null? lst2)
			'()
			(let (	(el (car lst2)))
				(if	(predicate (car lst2))
					(cons el (same-parity-inner predicate (cdr lst2)))
					(same-parity-inner predicate (cdr lst2))))))
	(if	(null? lst)
		'()
		(if	(even? (car lst))
			(same-parity-inner even? lst)
			(same-parity-inner odd? lst))))


;测试
(display (same-parity ))
(newline)
(display (same-parity 1))
(newline)
(display (same-parity 1 2 3 4 5 6 7 8 9))
(newline)
(display (same-parity 2 3 4 5 6 7 8 9))
(newline)

