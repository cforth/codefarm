#!/bin/guile -s
!#

;用过程构造序对
(define (cons-new x y)
	(lambda (m) (m x y)))

(define (car-new z)
	(z (lambda (p q) p)))

(define (cdr-new z)
	(z (lambda (p q) q)))

;	(car-new (cons-new a b))	;->
;	(car-new (lambda (m) (m a b)))	;->
;	((lambda (m) (m a b)) (lambda (p q) p))	;-> 
;	((lambda (p q) p) a b)	;->
;	a

;	(cdr-new (cons-new a b))	;->
;	(cdr-new (lambda (m) (m a b)))	;->
;	((lambda (m) (m a b)) (lambda (p q) q))	;->
;	((lambda (p q) q) a b)	;->
;	b


;测试
(display (car-new (cons-new 1 2)))
(newline)
(display (cdr-new (cons-new 1 2)))
(newline)

