#!/bin/guile -s
!#

;count-leaves
(define (count-leaves x)
	(cond	((null? x) 0)
			((not (pair? x)) 1)
			(else
				(+	(count-leaves (car x))
					(count-leaves (cdr x))))))

;测试
(display (count-leaves (list 1 (list 2 (list 3 4)))))
(newline)
(display (list 1 (list 2 (list 3 4))))
(newline)
