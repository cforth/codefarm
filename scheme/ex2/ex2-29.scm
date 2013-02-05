#!/bin/guile -s
!#

;构造二叉活动体
(define (make-mobile left right)
	(cons left right))

(define (make-branch length structure)
	(cons length structure))

(define (left-branch mobile)
	(car mobile))

(define (right-branch mobile)
	(cdr mobile))

(define (branch-length branch)
	(car branch))

(define (branch-structure branch)
	(cdr branch))

(define (total-weight m)
	(define (mobile? mo)
		(pair? (cdr mo)))
	(cond	((null? m) 0)
			((mobile? m)
				(+	(total-weight (left-branch m))
					(total-weight (right-branch m))))
			(else (branch-structure m))))


;测试
(define mobile
	(make-mobile 
		(make-mobile (make-branch 1 1)
			(make-branch 2 2))
		(make-mobile 
			(make-mobile (make-branch 3 3)
				(make-branch 4 4))
			(make-branch 5 5))))


(define mobile2 
	(make-mobile (make-branch 10 1)
		(make-mobile (make-branch 10 2)
			(make-branch 10 3))))

(define mobile3
	'())

(display (total-weight mobile3))
(newline)
(display (total-weight mobile2))
(newline)
(display (total-weight mobile))
(newline)
